package com.readle.readlebackend.domain.training.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.domain.training.dto.response.TodayQuestionsResponse;
import com.readle.readlebackend.domain.training.entity.Answer;
import com.readle.readlebackend.domain.training.enums.ResultStatus;
import com.readle.readlebackend.domain.training.enums.SkillCategory;
import com.readle.readlebackend.domain.training.exception.AnswerErrorCode;
import com.readle.readlebackend.domain.training.repository.AnswerRepository;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.auth.AuthErrorCode;
import com.readle.readlebackend.global.exception.CustomException;
import com.readle.readlebackend.global.exception.GlobalErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class AnswerService {

    private final UserRepository userRepository;
    private final QuestionRepository questionRepository;
    private final NewsRepository newsRepository;
    private final AnswerRepository answerRepository;
    private final ObjectMapper objectMapper;

    // 오늘의 문제 조회
    public TodayQuestionsResponse getTodayQuestions(Long userId) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));

        // 오늘(00:00~24:00) 생성된 daily_solo 문제 조회
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1);
        List<Question> todayQuestions = questionRepository
                .findByGameModeAndCreatedAtBetween(GameMode.daily_solo, startOfDay, endOfDay);

        // 오늘의 문제가 존재하는지 확인
        if (todayQuestions.isEmpty()) {
            log.warn("[AnswerService] 오늘의 문제가 아직 준비되지 않았습니다: userId={}", userId);
            throw new CustomException(AnswerErrorCode.TODAY_QUESTIONS_NOT_FOUND);
        }

        // 오늘 문제를 이미 다 풀었는지 확인
        List<Long> questionIds = new ArrayList<>();
        for (Question q : todayQuestions) {
            questionIds.add(q.getId());
        }
        List<Answer> submittedAnswers = answerRepository.findByUserIdAndQuestionIdIn(userId, questionIds);
        if (submittedAnswers.size() >= questionIds.size()) {
            log.warn("[AnswerService] 오늘 문제풀이를 이미 완료했습니다: userId={}", userId);
            throw new CustomException(AnswerErrorCode.TODAY_ALREADY_COMPLETED);
        }

        // 문제가 속한 기사 조회
        News news = newsRepository.findById(todayQuestions.get(0).getNewsId())
                .orElseThrow(() -> new CustomException(GlobalErrorCode.RESOURCE_NOT_FOUND));

        // 문제 목록 응답 변환 (정답/근거/힌트 제외)
        List<TodayQuestionsResponse.QuestionResponse> questionResponses = new ArrayList<>();
        int order = 1;
        for (Question q : todayQuestions) {
            questionResponses.add(TodayQuestionsResponse.QuestionResponse.builder()
                    .questionId(q.getId())
                    .order(order++)
                    .questionFormat(q.getQuestionFormat().name())
                    .mainCategory(q.getMainCategory().name())
                    .subCategory(q.getSubCategory() != null ? q.getSubCategory().name() : null)
                    .content(q.getContent())
                    .choices(parseChoices(q.getChoices()))
                    .level(q.getLevel())
                    .requireReason(q.getQuestionFormat() == QuestionFormat.OX)
                    .build());
        }

        // 로그 출력
        log.info("[AnswerService] 오늘의 문제 조회 성공: userId={}, questionCount={}", userId, questionResponses.size());

        // 응답 세팅
        return TodayQuestionsResponse.builder()
                .userLevel(user.getLevel())
                .article(TodayQuestionsResponse.ArticleResponse.builder()
                        .newsId(news.getId())
                        .title(news.getTitle())
                        .publisher(news.getPublisher())
                        .publishedAt(news.getPublishedAt().toLocalDate().toString())
                        .category(news.getCategory().name())
                        .content(news.getContent())
                        .level(news.getLevel())
                        .build())
                .questionCount(questionResponses.size())
                .questions(questionResponses)
                .build();
    }

    // Question.choices(JSON 문자열)를 List<String>으로 파싱
    private List<String> parseChoices(String choicesJson) {
        if (choicesJson == null || choicesJson.isBlank()) {
            return null;
        }
        try {
            return objectMapper.readValue(choicesJson, new TypeReference<List<String>>() {});
        } catch (Exception e) {
            log.warn("[AnswerService] 선택지 파싱 실패: choicesJson={}", choicesJson, e);
            throw new CustomException(GlobalErrorCode.INTERNAL_SERVER_ERROR);
        }
    }

    // ===== AI 피드백(정오답 판정 + 5개 능력치 평가) 프롬프트/스키마 =====

    /**
     * 문제와 정답 근거를 채점 기준으로 주고, 사용자가 제출한 답/근거 글을 보고
     * (1) 정오답 판정(resultStatus), (2) 종합 점수(overallScore), (3) 전반 피드백,
     * (4) 어휘력/독해력/추론력/비판적 사고력/표현력 5개 능력치 점수(0~100)+코멘트를
     * 한 번에 생성하도록 요청하는 프롬프트. answer_evaluations/user_answers 테이블 구조에 맞춘 출력을 요구한다.
     */
    private String buildFeedbackPrompt(Question question, String selectedAnswer, String justification) {
        StringBuilder sb = new StringBuilder();
        sb.append("너는 한국 대학생 문해력 학습 앱 'Readle'의 전문 첨삭관이야. ");
        sb.append("아래 문제와 정답 근거를 기준으로, 사용자가 제출한 답과 근거 글을 채점해줘.\n\n");

        sb.append("[문제]\n").append(question.getContent()).append("\n\n");
        sb.append("[정답]\n").append(question.getAnswer()).append("\n\n");
        sb.append("[정답 근거 (채점 기준으로만 참고하고, 사용자에게 그대로 노출하지 말 것)]\n")
                .append(question.getExplanation() != null ? question.getExplanation() : "")
                .append("\n\n");

        sb.append("[사용자가 제출한 답]\n").append(selectedAnswer).append("\n\n");
        sb.append("[사용자가 작성한 근거]\n")
                .append(justification != null && !justification.isBlank() ? justification : "(근거 미작성)")
                .append("\n\n");

        sb.append("[1단계: 정오답 판정 (resultStatus)]\n");
        sb.append("- correct: 답이 정답과 일치하고, 근거도 정답 근거의 핵심 논리를 스스로의 말로 타당하게 설명한 경우\n");
        sb.append("- incorrect: 답이 정답과 다르거나, 근거가 명백히 틀린 논리를 담고 있는 경우\n");
        sb.append("- insufficient_reasoning: 답 자체는 맞았지만 근거가 없거나 너무 짧거나 정답과 무관해서, ")
                .append("실제로 이해하고 맞혔다고 보기 어려운 경우\n\n");

        sb.append("[2단계: 종합 점수 (overallScore, 0~100)]\n");
        sb.append("정답 여부와 근거의 논리적 타당성·완성도를 종합해서 0~100 사이 정수로 매겨라.\n\n");

        sb.append("[3단계: 피드백]\n");
        sb.append("- mistakeFeedback: resultStatus가 incorrect 또는 insufficient_reasoning일 때만 채워라. ")
                .append("어디가 왜 틀렸는지/부족한지 구체적으로 짚어주고, correct면 빈 문자열로 둬라.\n");
        sb.append("- feedback: 정오답과 무관하게 항상 채워야 하는 전반적인 코멘트다. ")
                .append("전문 첨삭관처럼 잘한 점과 보완할 점을 함께 짚어주는 격려하는 톤으로 작성해라.\n\n");

        sb.append("[4단계: 5개 능력치 평가 (skillScores) - 반드시 5개 전부, 각각 0~100점]\n");
        sb.append("사용자가 작성한 근거 글에서 드러나는 수준만 보고 아래 5개 항목을 각각 평가해라. ")
                .append("근거 글에 특정 능력을 판단할 단서가 부족하면 그 사실을 feedback에 적고 중간 수준 점수를 줘라.\n");
        sb.append("- vocab(어휘력): 근거 글에서 사용한 단어 선택이 정확하고 문맥에 적절한가\n");
        sb.append("- reading(독해력): 지문/문제 내용을 실제로 정확히 이해했다는 근거가 글에 드러나는가\n");
        sb.append("- inference(추론력): 명시되지 않은 내용을 논리적으로 추론해서 근거를 폈는가\n");
        sb.append("- critical_thinking(비판적 사고력): 근거를 뒷받침하는 논리 전개가 타당하고 다른 가능성도 고려했는가\n");
        sb.append("- expression(표현력): 자신의 생각을 명확하고 조리 있는 문장으로 표현했는가\n\n");

        sb.append("[출력 규칙]\n");
        sb.append("1. 정답을 새로 알려주는 방식이 아니라, 사용자가 이미 제출한 내용을 근거로 평가하고 설명해라.\n");
        sb.append("2. skillScores는 위 5개 카테고리를 각각 정확히 한 번씩만, 총 5개 포함해라.\n");
        sb.append("3. 출력은 지정된 JSON 스키마만 따르고, 스키마 밖의 다른 텍스트는 절대 포함하지 마라.\n");

        return sb.toString();
    }

    /** buildFeedbackPrompt와 짝을 이루는 Gemini Structured Output 스키마. answer_evaluations/user_answers 테이블 구조에 맞춘다. */
    private JsonNode buildFeedbackResponseSchema() {
        ObjectNode root = objectMapper.createObjectNode();
        root.put("type", "OBJECT");

        ObjectNode properties = root.putObject("properties");
        properties.set("resultStatus", enumStringSchema(ResultStatus.values()));
        properties.set("overallScore", integerSchema());
        properties.set("mistakeFeedback", stringSchema());
        properties.set("feedback", stringSchema());
        properties.set("skillScores", arrayOf(buildSkillScoreItemSchema()));

        ArrayNode required = root.putArray("required");
        required.add("resultStatus");
        required.add("overallScore");
        required.add("mistakeFeedback");
        required.add("feedback");
        required.add("skillScores");

        return root;
    }

    private ObjectNode buildSkillScoreItemSchema() {
        ObjectNode itemSchema = objectMapper.createObjectNode();
        itemSchema.put("type", "OBJECT");

        ObjectNode properties = itemSchema.putObject("properties");
        properties.set("skillCategory", enumStringSchema(SkillCategory.values()));
        properties.set("score", integerSchema());
        properties.set("feedback", stringSchema());

        ArrayNode required = itemSchema.putArray("required");
        required.add("skillCategory");
        required.add("score");
        required.add("feedback");

        return itemSchema;
    }

    private ObjectNode arrayOf(ObjectNode itemSchema) {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "ARRAY");
        node.set("items", itemSchema);
        return node;
    }

    private ObjectNode enumStringSchema(Enum<?>[] values) {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "STRING");
        ArrayNode enumArray = node.putArray("enum");
        for (Enum<?> v : values) {
            enumArray.add(v.name());
        }
        return node;
    }

    private ObjectNode stringSchema() {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "STRING");
        return node;
    }

    private ObjectNode integerSchema() {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "INTEGER");
        return node;
    }
}