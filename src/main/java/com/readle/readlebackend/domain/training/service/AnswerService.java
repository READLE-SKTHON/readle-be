package com.readle.readlebackend.domain.training.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.client.GeminiClient;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.domain.training.dto.request.SubmitAnswerRequest;
import com.readle.readlebackend.domain.training.dto.response.AnswerResultResponse;
import com.readle.readlebackend.domain.training.dto.response.SubmitAnswerResponse;
import com.readle.readlebackend.domain.training.dto.response.TodayQuestionsResponse;
import com.readle.readlebackend.domain.training.entity.Answer;
import com.readle.readlebackend.domain.training.entity.AnswerEvaluation;
import com.readle.readlebackend.domain.training.enums.ResultStatus;
import com.readle.readlebackend.domain.training.enums.SkillCategory;
import com.readle.readlebackend.domain.training.exception.AnswerErrorCode;
import com.readle.readlebackend.domain.training.repository.AnswerEvaluationRepository;
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

import java.io.IOException;
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
    private final AnswerEvaluationRepository answerEvaluationRepository;
    private final ObjectMapper objectMapper;
    private final GeminiClient geminiClient;

    // 오늘의 문제 조회
    public TodayQuestionsResponse getTodayQuestions(Long userId) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));

        // 오늘 생성된 daily_solo 문제 조회
        List<Question> todayQuestions = findTodayQuestions(user.getLevel());

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
                    .requireReason(requiresReason(q.getQuestionFormat()))
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

    // 오늘(00:00~24:00) 생성된, 특정 유저 레벨에 맞는 daily_solo 문제 조회
    private List<Question> findTodayQuestions(Long userLevel) {
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1);
        return questionRepository.findAllByGameModeAndLevelInAndCreatedAtBetween(GameMode.daily_solo, List.of(userLevel.intValue()), startOfDay, endOfDay);
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

    // 답안 제출
    @Transactional
    public SubmitAnswerResponse submitAnswer(SubmitAnswerRequest request, Long userId, Long questionId) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));

        // 퀴즈가 존재하는지 조회
        Question question = questionRepository.findById(questionId)
                .orElseThrow(() -> new CustomException(AnswerErrorCode.QUESTION_NOT_FOUND));

        // O,X 퀴즈와 short_answer에 근거가 있는지 조회
        if (requiresReason(question.getQuestionFormat()) && (request.getReason() == null || request.getReason().isBlank())) {
            log.warn("[AnswerService] 근거 누락: userId={}, questionId={}", userId, questionId);
            throw new CustomException(AnswerErrorCode.REASON_REQUIRED);
        }

        // 문제 유형별 채점
        GradingResult grading = (question.getQuestionFormat() == QuestionFormat.multiple_choice)
                ? gradeMultipleChoice(question, request)
                : gradeReasoningBased(question, request);

        // 답안 저장
        Answer answer = Answer.builder()
                .user(user)
                .question(question)
                .selectedAnswer(request.getSelectedAnswer())
                .resultStatus(grading.resultStatus())
                .justification(request.getReason())
                .overallScore(grading.score())
                .mistakeFeedback(grading.mistakeFeedback())
                .feedback(grading.feedback())
                .build();

        // DB 저장
        answerRepository.save(answer);

        // 능력치별 평가 저장 (객관식은 skillScores가 없어서 건너뜀)
        if (grading.skillScores() != null) {
            for (SkillScoreDto skillScore : grading.skillScores()) {
                answerEvaluationRepository.save(AnswerEvaluation.builder()
                        .answer(answer)
                        .user(user)
                        .skillCategory(skillScore.skillCategory())
                        .score(skillScore.score())
                        .feedback(skillScore.feedback())
                        .build());
            }
        }

        // 로그 출력
        log.info("[AnswerService] 답안 제출 성공: userId={}, questionId={}, resultStatus={}", userId, questionId, grading.resultStatus());

        // 응답 세팅
        return SubmitAnswerResponse.builder()
                .resultStatus(grading.resultStatus())
                .selectedAnswer(request.getSelectedAnswer())
                .answer(question.getAnswer())
                .overallScore(grading.score())
                .feedback(SubmitAnswerResponse.Feedback.builder()
                        .explanation(question.getExplanation())
                        .mistakeFeedback(grading.mistakeFeedback())
                        .comment(grading.feedback())
                        .hint(grading.resultStatus() == ResultStatus.correct ? null : question.getHint())
                        .build())
                .build();
    }

    // 객관식 채점 — 정답이 하나로 고정돼있어 판단 여지가 없으므로 단순 비교로 끝
    private GradingResult gradeMultipleChoice(Question question, SubmitAnswerRequest request) {
        boolean isCorrect = question.getAnswer().equals(request.getSelectedAnswer());
        return new GradingResult(
                isCorrect ? ResultStatus.correct : ResultStatus.incorrect,
                isCorrect ? 10 : 0,
                isCorrect ? null : "정답을 다시 확인해보세요.",
                isCorrect ? "정답이에요!" : "아쉽지만 오답이에요.",
                null
        );
    }

    // O,X / short_answer 채점 — 근거 글을 Gemini에 보내 정오답 판정 + 5개 능력치 평가를 함께 받는다.
    private GradingResult gradeReasoningBased(Question question, SubmitAnswerRequest request) {
        String prompt = buildFeedbackPrompt(question, request.getSelectedAnswer(), request.getReason());
        JsonNode schema = buildFeedbackResponseSchema();

        // 근거 채점은 정오답 판정 + 점수 매기기가 목적이라 thinking 없이도 품질 저하가 크지 않다고 판단해 thinking을 꺼서 응답 속도를 높인다.
        String rawJson = geminiClient.generateJson(prompt, schema, 0);

        FeedbackResult result;
        try {
            result = objectMapper.readValue(rawJson, FeedbackResult.class);
        } catch (IOException e) {
            log.error("[AnswerService] AI 피드백 응답 파싱 실패. raw={}", rawJson, e);
            throw new CustomException(AnswerErrorCode.FEEDBACK_PARSE_ERROR);
        }

        return new GradingResult(
                result.resultStatus(),
                result.overallScore(),
                result.mistakeFeedback(),
                result.feedback(),
                result.skillScores()
        );
    }

    // 채점 결과를 담는 내부 전용 타입
    private record GradingResult(ResultStatus resultStatus, int score, String mistakeFeedback, String feedback, List<SkillScoreDto> skillScores) {
    }

    // OX/short_answer는 근거 작성 필요
    private boolean requiresReason(QuestionFormat questionFormat) {
        return questionFormat == QuestionFormat.OX || questionFormat == QuestionFormat.short_answer;
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
        sb.append("너는 한국어 문해력 앱 Readle의 첨삭관이야. 아래 문제·정답 근거를 기준으로 사용자의 답과 근거를 채점해.\n\n");

        sb.append("[문제]\n").append(question.getContent()).append("\n\n");
        sb.append("[정답]\n").append(question.getAnswer()).append("\n\n");
        sb.append("[정답 근거 (채점 기준용, 사용자에게 노출 금지)]\n")
                .append(question.getExplanation() != null ? question.getExplanation() : "")
                .append("\n\n");

        sb.append("[사용자가 제출한 답]\n").append(selectedAnswer).append("\n\n");
        sb.append("[사용자가 작성한 근거]\n")
                .append(justification != null && !justification.isBlank() ? justification : "(근거 미작성)")
                .append("\n\n");

        sb.append("resultStatus: correct=답·근거 모두 타당 / incorrect=답 틀림 또는 근거 논리 명백히 틀림 / insufficient_reasoning=답은 맞았으나 근거 없음·무관·부실\n");
        sb.append("overallScore(0~100): 정답 여부+근거 타당성 종합 점수\n");
        sb.append("mistakeFeedback: incorrect·insufficient_reasoning일 때만, 정답 근거를 인용해 무엇이 왜 틀렸는지를 담은 한 문장. correct면 빈 문자열\n");
        sb.append("feedback: 사용자가 쓴 답/근거 내용을 구체적으로 짚어 잘한 점 또는 보완점을 담은 한 문장, 격려 톤\n");
        sb.append("skillScores(5개 필수, 각 0~100, 근거 글만 기준): ")
                .append("vocab=단어 선택 정확성/문맥 적합성, reading=지문·문제 이해도, inference=비명시 내용의 논리적 추론, ")
                .append("critical_thinking=논리 전개의 타당성, expression=명확하고 조리 있는 표현. ")
                .append("단서 부족 시 feedback에 언급하고 중간 점수 부여\n");
        sb.append("규칙: 정답 재안내 금지(제출 내용 기준 평가) / skillScores 5개 각 1회 / mistakeFeedback·feedback은 각각 정확히 한 문장(줄바꿈·나열 금지) / JSON 스키마만 출력, 그 외 텍스트 금지\n");

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

    // Gemini 피드백 응답 파싱용 내부 전용 타입 (buildFeedbackResponseSchema와 1:1 대응)
    private record FeedbackResult(
            ResultStatus resultStatus,
            Integer overallScore,
            String mistakeFeedback,
            String feedback,
            List<SkillScoreDto> skillScores
    ) {
    }

    private record SkillScoreDto(SkillCategory skillCategory, Integer score, String feedback) {
    }
}


    // 오늘의 퀴즈 결과 조회
    // 호출할 때마다 유저의 xp, level, currentStreak을 갱신해서 저장하기 때문에 @Transactional 사용
    @Transactional
    public AnswerResultResponse getAnswerResult(Long userId) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));

        // 오늘 생성된 daily_solo 문제 조회
        List<Question> todayQuestions = findTodayQuestions(user.getLevel());
        if (todayQuestions.isEmpty()) {
            log.warn("[AnswerService] 오늘의 문제가 아직 준비되지 않았습니다: userId={}", userId);
            throw new CustomException(AnswerErrorCode.TODAY_QUESTIONS_NOT_FOUND);
        }

        // 오늘 문제에 대한 제출 기록 조회
        List<Long> questionIds = new ArrayList<>();
        for (Question q : todayQuestions) {
            questionIds.add(q.getId());
        }
        List<Answer> todayAnswers = answerRepository.findByUserIdAndQuestionIdIn(userId, questionIds);

        // 오늘 문제를 다 풀었는지 확인
        if (todayAnswers.size() < todayQuestions.size()) {
            log.warn("[AnswerService] 오늘 문제풀이 미완료: userId={}, 제출={}, 전체={}", userId, todayAnswers.size(), todayQuestions.size());
            throw new CustomException(AnswerErrorCode.TODAY_NOT_COMPLETED);
        }

        // 정답 수, 획득 경험치 집계
        int correctCount = 0;
        int earnedExp = 0;
        for (Answer answer : todayAnswers) {
            if (answer.getResultStatus() == ResultStatus.correct) {
                correctCount++;
            }
            earnedExp += answer.getOverallScore();
        }
        int accuracy = correctCount * 100 / todayQuestions.size();

        // 사용자 xp/레벨/연속학습일 갱신
        user.applyDailyResult(earnedExp, LocalDate.now());
        userRepository.save(user);

        // 로그 출력
        log.info("[AnswerService] 오늘 문제풀이 결과 조회 성공: userId={}, correctCount={}, earnedExp={}",
                userId, correctCount, earnedExp);

        // 응답 세팅 (레벨/연속학습일은 마이페이지 API에서 보여주는 값이라 여기선 응답에 안 담음)
        return AnswerResultResponse.builder()
                .totalQuestions(todayQuestions.size())
                .correctCount(correctCount)
                .accuracy(accuracy)
                .earnedExp(earnedExp)
                .build();
    }
}