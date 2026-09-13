package com.readle.readlebackend.domain.training.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.repository.DailyRepresentativeArticleRepository;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.client.GeminiClient;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.domain.training.dto.request.SubmitAnswerRequest;
import com.readle.readlebackend.domain.training.dto.response.AnswerResultResponse;
import com.readle.readlebackend.domain.training.dto.response.SkillResultDto;
import com.readle.readlebackend.domain.training.dto.response.SkillResultResponse;
import com.readle.readlebackend.domain.training.dto.response.SubmitAnswerResponse;
import com.readle.readlebackend.domain.training.dto.response.TodayQuestionsResponse;
import com.readle.readlebackend.domain.training.entity.Answer;
import com.readle.readlebackend.domain.training.entity.AnswerEvaluation;
import com.readle.readlebackend.domain.training.enums.ResultStatus;
import com.readle.readlebackend.domain.training.enums.SkillCategory;
import com.readle.readlebackend.domain.training.exception.AnswerErrorCode;
import com.readle.readlebackend.domain.training.repository.AnswerEvaluationRepository;
import com.readle.readlebackend.domain.training.repository.AnswerRepository;
import com.readle.readlebackend.domain.training.repository.SkillCategoryAverageView;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.auth.AuthErrorCode;
import com.readle.readlebackend.global.exception.CustomException;
import com.readle.readlebackend.global.exception.GlobalErrorCode;
import com.readle.readlebackend.global.util.VectorUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class AnswerService {

    private final UserRepository userRepository;
    private final QuestionRepository questionRepository;
    private final NewsRepository newsRepository;
    private final DailyRepresentativeArticleRepository dailyRepresentativeArticleRepository;
    private final AnswerRepository answerRepository;
    private final AnswerEvaluationRepository answerEvaluationRepository;
    private final ObjectMapper objectMapper;
    private final GeminiClient geminiClient;

    // 오늘의 문제 조회
    public TodayQuestionsResponse getTodayQuestions(Long userId) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));

        LocalDate today = LocalDate.now();

        // 오늘 유저 레벨의 대표 기사 조회 (대표 기사 자체가 없으면 보여줄 게 없으니 에러)
        var representative = dailyRepresentativeArticleRepository
                .findByRepDateAndLevel(today, user.getLevel().intValue())
                .orElseThrow(() -> {
                    log.warn("[AnswerService] 오늘의 대표 기사가 아직 없습니다: userId={}", userId);
                    return new CustomException(AnswerErrorCode.TODAY_QUESTIONS_NOT_FOUND);
                });

        // 대표 기사 조회
        News news = newsRepository.findById(representative.getArticleId())
                .orElseThrow(() -> new CustomException(GlobalErrorCode.RESOURCE_NOT_FOUND));

        // 대표 기사에 연결된 daily_solo 문제 조회
        List<Question> todayQuestions = questionRepository.findAllByNewsIdAndGameMode(representative.getArticleId(), GameMode.daily_solo);

        // 대표 기사는 있지만 아직 문제가 생성되지 않은 경우: 에러 대신 기사 정보만 응답
        if (todayQuestions.isEmpty()) {
            log.warn("[AnswerService] 오늘의 대표 기사는 있지만 문제가 아직 없습니다: userId={}, newsId={}", userId, news.getId());
            return TodayQuestionsResponse.builder()
                    .userLevel(user.getLevel())
                    .article(toArticleResponse(news))
                    .questionCount(0)
                    .questions(List.of())
                    .build();
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
                .article(toArticleResponse(news))
                .questionCount(questionResponses.size())
                .questions(questionResponses)
                .build();
    }

    // News -> ArticleResponse 변환 (문제가 없어 기사 정보만 응답할 때도 재사용)
    private TodayQuestionsResponse.ArticleResponse toArticleResponse(News news) {
        return TodayQuestionsResponse.ArticleResponse.builder()
                .newsId(news.getId())
                .title(news.getTitle())
                .publisher(news.getPublisher())
                .publishedAt(news.getPublishedAt().toLocalDate().toString())
                .category(news.getCategory().name())
                .content(news.getContent())
                .level(news.getLevel())
                .build();
    }

    // 오늘 날짜의 daily_representative_article에서 해당 유저 레벨의 대표 기사를 찾고,
    // 그 기사에 연결된 daily_solo 문제 전체를 조회한다. 오늘 그 레벨의 대표 기사가 아직 없으면 빈 리스트.
    private List<Question> findTodayQuestions(Long userLevel) {
        LocalDate today = LocalDate.now();

        return dailyRepresentativeArticleRepository.findByRepDateAndLevel(today, userLevel.intValue())
                .map(representative -> questionRepository.findAllByNewsIdAndGameMode(representative.getArticleId(), GameMode.daily_solo))
                .orElseGet(List::of);
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
        // 능력치(5개 카테고리) 평가는 여기서 하지 않는다. 오늘 문제를 다 풀고 결과를 조회할 때(getAnswerResult)
        // 임베딩 유사도를 참고 정보로 넣어서 한 번에 판단하고 저장한다 (evaluateSkillsIfAbsent 참고).

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
                isCorrect ? "정답이에요!" : "아쉽지만 오답이에요."
        );
    }

    // O,X / short_answer 채점 — 근거 글을 Gemini에 보내 정오답 판정을 받는다.
    // (능력치 평가는 여기서 안 하고, 오늘 문제를 다 풀고 결과 조회할 때 한 번에 처리한다 - evaluateSkillsIfAbsent 참고)
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
                result.feedback()
        );
    }

    // 채점 결과를 담는 내부 전용 타입
    private record GradingResult(ResultStatus resultStatus, int score, String mistakeFeedback, String feedback) {
    }

    // OX/short_answer는 근거 작성 필요
    private boolean requiresReason(QuestionFormat questionFormat) {
        return questionFormat == QuestionFormat.OX || questionFormat == QuestionFormat.short_answer;
    }

    // ===== AI 피드백(정오답 판정 + 5개 능력치 평가) 프롬프트/스키마 =====

    /**
     * 문제와 정답 근거를 채점 기준으로 주고, 사용자가 제출한 답/근거 글을 보고
     * (1) 정오답 판정(resultStatus), (2) 종합 점수(overallScore), (3) 전반 피드백을
     * 한 번에 생성하도록 요청하는 프롬프트. user_answers 테이블 구조에 맞춘 출력을 요구한다.
     * (능력치 5개 카테고리 평가는 여기서 하지 않는다 - buildSkillEvaluationPrompt 참고)
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
        sb.append("규칙: 정답 재안내 금지(제출 내용 기준 평가) / mistakeFeedback·feedback은 각각 정확히 한 문장(줄바꿈·나열 금지) / JSON 스키마만 출력, 그 외 텍스트 금지\n");

        return sb.toString();
    }

    /** buildFeedbackPrompt와 짝을 이루는 Gemini Structured Output 스키마. user_answers 테이블 구조에 맞춘다. */
    private JsonNode buildFeedbackResponseSchema() {
        ObjectNode root = objectMapper.createObjectNode();
        root.put("type", "OBJECT");

        ObjectNode properties = root.putObject("properties");
        properties.set("resultStatus", enumStringSchema(ResultStatus.values()));
        properties.set("overallScore", integerSchema());
        properties.set("mistakeFeedback", stringSchema());
        properties.set("feedback", stringSchema());

        ArrayNode required = root.putArray("required");
        required.add("resultStatus");
        required.add("overallScore");
        required.add("mistakeFeedback");
        required.add("feedback");

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
            String feedback
    ) {
    }

    // 능력치(5개 카테고리) 평가 결과 - buildSkillEvaluationPrompt/evaluateSkillCategories에서 사용
    private record SkillScoreDto(SkillCategory skillCategory, Integer score, String feedback) {
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

        // 근거형(OX/short_answer) 문제 중 아직 능력치 평가가 없는 답안에 대해
        // 임베딩 유사도를 참고 정보로 넣어 능력치(문자해독/내용이해/맥락파악/추론/비판적사고) 평가를 만들어 저장
        evaluateSkillsIfAbsent(todayAnswers);

        // 능력치 카테고리별 누적(전체 기간) 평균 점수 계산
        List<SkillResultDto> skillResults = getSkillResults(userId);

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
                .skillResults(skillResults)
                .build();
    }

    // 능력치(5개 카테고리) 누적 평균 점수만 단독으로 조회
    public SkillResultResponse getSkillSummary(Long userId) {
        if (!userRepository.existsById(userId)) {
            throw new CustomException(AuthErrorCode.INVALID_USER_ID);
        }

        List<SkillResultDto> skillResults = getSkillResults(userId);

        return SkillResultResponse.builder()
                .skillResults(skillResults)
                .build();
    }

    // 유저의 능력치 카테고리별 누적(전체 기간) 평균 점수를 계산한다.
    // (오늘 결과 조회, 능력치 단독 조회 API에서 공용으로 사용)
    // 아직 평가된 적 없는 카테고리도 0점으로 채워서, 항상 5개 카테고리가 다 내려가도록 한다.
    private List<SkillResultDto> getSkillResults(Long userId) {
        List<SkillCategoryAverageView> skillAverages = answerEvaluationRepository.findAverageScoresByUserId(userId);

        Map<SkillCategory, Integer> averageByCategory = new HashMap<>();
        for (SkillCategoryAverageView view : skillAverages) {
            averageByCategory.put(view.getSkillCategory(), (int) Math.round(view.getAvgScore()));
        }

        List<SkillResultDto> skillResults = new ArrayList<>();
        for (SkillCategory category : SkillCategory.values()) {
            skillResults.add(SkillResultDto.builder()
                    .skillCategory(category)
                    .averageScore(averageByCategory.getOrDefault(category, 0))
                    .build());
        }
        return skillResults;
    }

    // ===== 능력치(5개 카테고리) 평가 — 임베딩 유사도 참고 + Gemini 판단, getAnswerResult에서만 수행 =====

    /**
     * 오늘 답안 중 근거형(OX/short_answer) 문제이고 아직 능력치 평가가 저장 안 된 것만 골라
     * 능력치 평가를 만들어 저장한다. 이미 평가된 답안은 건너뛰어서, 결과 조회를 여러 번 호출해도
     * 중복 저장/중복 Gemini 호출이 일어나지 않는다.
     */
    private void evaluateSkillsIfAbsent(List<Answer> todayAnswers) {
        for (Answer answer : todayAnswers) {
            Question question = answer.getQuestion();

            if (!requiresReason(question.getQuestionFormat())) {
                continue; // 객관식은 능력치 평가 대상이 아님
            }
            if (answerEvaluationRepository.existsByAnswerId(answer.getId())) {
                continue; // 이미 평가됨
            }

            String explanation = question.getExplanation();
            if (explanation == null || explanation.isBlank()) {
                log.warn("[AnswerService] 정답 근거(explanation)가 없어 능력치 평가를 건너뜁니다: answerId={}", answer.getId());
                continue;
            }

            String userEvidenceText = buildUserEvidenceText(question, answer.getSelectedAnswer(), answer.getJustification());
            Double similarityPercent = computeSimilarityPercent(explanation, userEvidenceText);

            List<SkillScoreDto> skillScores = evaluateSkillCategories(question, userEvidenceText, similarityPercent);
            for (SkillScoreDto skillScore : skillScores) {
                answerEvaluationRepository.save(AnswerEvaluation.builder()
                        .answer(answer)
                        .user(answer.getUser())
                        .skillCategory(skillScore.skillCategory())
                        .score(skillScore.score())
                        .feedback(skillScore.feedback())
                        .build());
            }
        }
    }

    /**
     * 유사도 계산에 쓸 "사용자 쪽 텍스트"를 문제 유형에 맞게 구성한다.
     * OX는 selectedAnswer가 "O"/"X" 한 글자뿐이라 의미 정보가 없어 근거(justification)만 쓰고,
     * short_answer는 selectedAnswer 자체가 답변 본문이라 근거와 합쳐서 쓴다.
     */
    private String buildUserEvidenceText(Question question, String selectedAnswer, String justification) {
        if (question.getQuestionFormat() == QuestionFormat.short_answer) {
            return selectedAnswer + " " + justification;
        }
        return justification;
    }

    /**
     * explanation(정답 근거)과 사용자 쪽 텍스트를 각각 임베딩해서 코사인 유사도(%)를 계산한다.
     * 임베딩 API 호출이 실패해도 능력치 평가 자체는 막지 않도록 예외를 잡고 null을 반환한다(참고 정보 없이 진행).
     */
    private Double computeSimilarityPercent(String explanation, String userEvidenceText) {
        try {
            double[] explanationVector = geminiClient.embed(explanation);
            double[] userVector = geminiClient.embed(userEvidenceText);
            double similarity = VectorUtils.cosineSimilarity(explanationVector, userVector);
            return Math.round(similarity * 1000) / 10.0; // 소수점 1자리 %
        } catch (Exception e) {
            log.warn("[AnswerService] 임베딩 유사도 계산 실패, 참고 정보 없이 능력치 평가를 진행합니다.", e);
            return null;
        }
    }

    // Gemini에게 능력치 5개 카테고리 판단을 요청하고 결과를 받아온다.
    private List<SkillScoreDto> evaluateSkillCategories(Question question, String userEvidenceText, Double similarityPercent) {
        String prompt = buildSkillEvaluationPrompt(question, userEvidenceText, similarityPercent);
        JsonNode schema = buildSkillEvaluationSchema();

        String rawJson = geminiClient.generateJson(prompt, schema, 0);
        try {
            SkillEvaluationResult result = objectMapper.readValue(rawJson, SkillEvaluationResult.class);
            return result.skillScores();
        } catch (IOException e) {
            log.error("[AnswerService] 능력치 평가 응답 파싱 실패. raw={}", rawJson, e);
            throw new CustomException(AnswerErrorCode.FEEDBACK_PARSE_ERROR);
        }
    }

    /**
     * 능력치 5개 카테고리(문자해독/내용이해/맥락파악/추론/비판적사고)를 판단하도록 요청하는 프롬프트.
     * 임베딩 유사도가 있으면 참고 정보로 함께 넣는다. feedback은 나중에 학습 데이터로도 쓸 수 있도록
     * 왜 그 점수를 줬는지 구체적인 평가 이유를 담도록 요구한다.
     */
    private String buildSkillEvaluationPrompt(Question question, String userEvidenceText, Double similarityPercent) {
        StringBuilder sb = new StringBuilder();
        sb.append("너는 한국어 문해력 앱 Readle의 능력치 평가관이야. 아래 문제와 사용자가 작성한 답/근거를 보고 ")
                .append("문자해독/내용이해/맥락파악/추론/비판적사고 5개 능력치를 평가해.\n\n");

        sb.append("[문제]\n").append(question.getContent()).append("\n\n");
        sb.append("[정답]\n").append(question.getAnswer()).append("\n\n");
        sb.append("[정답 근거]\n").append(question.getExplanation()).append("\n\n");
        sb.append("[사용자가 작성한 답/근거]\n").append(userEvidenceText).append("\n\n");

        if (similarityPercent != null) {
            sb.append("[참고] 사용자 답/근거와 정답 근거 사이의 의미적 유사도(임베딩 기반): ")
                    .append(similarityPercent)
                    .append("%. 이 수치는 참고용 보조 지표일 뿐이며, 최종 판단은 답/근거의 논리적 타당성을 기준으로 하세요.\n\n");
        }

        sb.append("skillScores(5개 필수, 각 0~100, 사용자가 작성한 답/근거 기준): ")
                .append("문자해독=글자·어휘를 정확히 읽고 의미를 파악하는 기초 능력, ")
                .append("내용이해=문장이나 글의 표면적 의미를 정확히 파악했는지, ")
                .append("맥락파악=명시되지 않은 의미(함축·화자의 의도·문맥상 뉘앙스)를 이해했는지, ")
                .append("추론=글에 드러나지 않은 내용을 논리적으로 추론했는지, ")
                .append("비판적사고=글의 내용을 평가하고 자신의 생각과 연결하거나 비판적으로 받아들였는지. ")
                .append("단서 부족 시 feedback에 언급하고 중간 점수 부여\n");
        sb.append("feedback: 각 능력치마다 왜 이 점수를 줬는지 사용자의 답/근거 내용을 구체적으로 인용해 설명하는 한 문장. ")
                .append("추후 학습(통계/모델 학습) 데이터로도 쓰이니 판단 이유를 분명하게 남길 것\n");
        sb.append("규칙: skillScores 5개 각 1회 / feedback은 각각 정확히 한 문장(줄바꿈·나열 금지) / JSON 스키마만 출력, 그 외 텍스트 금지\n");

        return sb.toString();
    }

    /** buildSkillEvaluationPrompt와 짝을 이루는 Gemini Structured Output 스키마. */
    private JsonNode buildSkillEvaluationSchema() {
        ObjectNode root = objectMapper.createObjectNode();
        root.put("type", "OBJECT");

        ObjectNode properties = root.putObject("properties");
        properties.set("skillScores", arrayOf(buildSkillScoreItemSchema()));

        ArrayNode required = root.putArray("required");
        required.add("skillScores");

        return root;
    }

    // Gemini 능력치 평가 응답 파싱용 내부 전용 타입 (buildSkillEvaluationSchema와 1:1 대응)
    private record SkillEvaluationResult(List<SkillScoreDto> skillScores) {
    }
}