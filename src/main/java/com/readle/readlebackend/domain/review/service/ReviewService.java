package com.readle.readlebackend.domain.review.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.question.enums.SubCategory;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.domain.review.dto.request.ReviewStartRequest;
import com.readle.readlebackend.domain.review.dto.request.ReviewSubmitRequest;
import com.readle.readlebackend.domain.review.dto.response.ReviewCategoriesResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewGroupsResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewResultResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewStartResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewSubmitResponse;
import com.readle.readlebackend.domain.review.entity.ReviewSession;
import com.readle.readlebackend.domain.review.entity.ReviewSessionQuestion;
import com.readle.readlebackend.domain.review.enums.ReviewMode;
import com.readle.readlebackend.domain.review.exception.ReviewErrorCode;
import com.readle.readlebackend.domain.review.repository.ReviewSessionQuestionRepository;
import com.readle.readlebackend.domain.review.repository.ReviewSessionRepository;
import com.readle.readlebackend.domain.training.entity.Answer;
import com.readle.readlebackend.domain.training.enums.ResultStatus;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class ReviewService {

    private final UserRepository userRepository;
    private final QuestionRepository questionRepository;
    private final NewsRepository newsRepository;
    private final AnswerRepository answerRepository;
    private final ReviewSessionRepository reviewSessionRepository;
    private final ReviewSessionQuestionRepository reviewSessionQuestionRepository;
    private final ObjectMapper objectMapper;
    private final Random random = new Random();

    // 복습 화면에서 유형별 조회 (5개 유형 항상 전부 노출, "현재" 오답 없으면 0)
    public ReviewCategoriesResponse getCategories(Long userId) {

        // 문제별 최신 제출 기록만 모음 (다시 풀어서 맞췄으면 더 이상 오답 아님)
        Map<Long, Answer> latestByQuestion = findLatestAnswerByQuestion(userId);

        // 유형별 "현재" 오답 개수 집계
        Map<MainCategory, Long> wrongCountByCategory = new HashMap<>();
        for (Answer latest : latestByQuestion.values()) {
            if (latest.getResultStatus() == ResultStatus.correct) {
                continue;
            }
            MainCategory mainCategory = latest.getQuestion().getMainCategory();
            wrongCountByCategory.merge(mainCategory, 1L, Long::sum);
        }

        // 5개 유형 전부 포함해서 응답 구성 (오답 없으면 0)
        List<ReviewCategoriesResponse.CategoryItem> categories = new ArrayList<>();
        for (MainCategory mainCategory : MainCategory.values()) {
            categories.add(ReviewCategoriesResponse.CategoryItem.builder()
                    .mainCategory(mainCategory.name())
                    .subCategories(findSubCategories(mainCategory))
                    .wrongCount(wrongCountByCategory.getOrDefault(mainCategory, 0L))
                    .build());
        }

        // 로그 출력
        log.info("[ReviewService] 유형별 틀린 문제 목록 조회 성공: userId={}", userId);

        // 응답 세팅
        return ReviewCategoriesResponse.builder()
                .categories(categories)
                .build();
    }

    // 대분류에 속한 소분류 이름 목록 조회
    private List<String> findSubCategories(MainCategory mainCategory) {
        return switch (mainCategory) {
            case vocab -> List.of(
                    SubCategory.vocab_appropriateness.name(),
                    SubCategory.vocab_meaning.name(),
                    SubCategory.vocab_paraphrase.name());
            case info_extraction -> List.of(
                    SubCategory.info_consistency.name(),
                    SubCategory.info_evidence.name());
            case core_understanding -> List.of(
                    SubCategory.core_topic.name(),
                    SubCategory.core_title.name(),
                    SubCategory.core_gist.name(),
                    SubCategory.core_argument.name());
            case inference_judgment -> List.of(
                    SubCategory.inference_blank.name(),
                    SubCategory.inference_implication.name(),
                    SubCategory.inference_continuation.name());
            case structure -> List.of(
                    SubCategory.structure_sentence_insertion.name(),
                    SubCategory.structure_order.name(),
                    SubCategory.structure_irrelevant_sentence.name());
        };
    }

    // 대분류 안에서, 날짜/소분류별로 "현재" 틀린 문제 목록 (다 맞추면 그 조합은 목록에서 사라짐)
    public ReviewGroupsResponse getGroups(Long userId, MainCategory mainCategory) {

        // 문제별 최신 제출 기록만 모음
        Map<Long, Answer> latestByQuestion = findLatestAnswerByQuestion(userId);

        // (날짜, 소분류)별로 집계
        Map<GroupKey, Long> countByGroup = new LinkedHashMap<>();
        for (Answer latest : latestByQuestion.values()) {
            if (latest.getResultStatus() == ResultStatus.correct) {
                continue;
            }
            Question question = latest.getQuestion();
            if (question.getMainCategory() != mainCategory) {
                continue;
            }
            LocalDate date = latest.getCreatedAt().toLocalDate();
            GroupKey key = new GroupKey(date, question.getSubCategory());
            countByGroup.merge(key, 1L, Long::sum);
        }

        // 응답 구성 (최신 날짜순 정렬)
        List<ReviewGroupsResponse.GroupItem> groups = new ArrayList<>();
        for (Map.Entry<GroupKey, Long> entry : countByGroup.entrySet()) {
            groups.add(ReviewGroupsResponse.GroupItem.builder()
                    .date(entry.getKey().date().toString())
                    .subCategory(entry.getKey().subCategory().name())
                    .wrongCount(entry.getValue())
                    .build());
        }
        groups.sort((a, b) -> b.getDate().compareTo(a.getDate()));

        // 로그 출력
        log.info("[ReviewService] 날짜/소분류별 틀린 문제 목록 조회 성공: userId={}, mainCategory={}, groupCount={}",
                userId, mainCategory, groups.size());

        // 응답 세팅
        return ReviewGroupsResponse.builder()
                .groups(groups)
                .build();
    }

    // 복습 문제 시작 (특정 날짜/소분류의 오답 복기 + 같은 소분류 다른 기사 문제)
    @Transactional
    public ReviewStartResponse startReview(Long userId, ReviewStartRequest request) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));

        MainCategory mainCategory = request.getMainCategory();
        SubCategory subCategory = request.getSubCategory();
        LocalDate date = request.getDate();

        // 문제별 최신 제출 기록 중, 요청한 (날짜, 소분류)에 해당하는 "현재" 오답만 추출
        Map<Long, Answer> latestByQuestion = findLatestAnswerByQuestion(userId);
        List<Answer> targetWrongAnswers = new ArrayList<>();
        for (Answer latest : latestByQuestion.values()) {
            if (latest.getResultStatus() == ResultStatus.correct) {
                continue;
            }
            Question question = latest.getQuestion();
            if (question.getSubCategory() != subCategory) {
                continue;
            }
            if (!latest.getCreatedAt().toLocalDate().isEqual(date)) {
                continue;
            }
            targetWrongAnswers.add(latest);
        }

        // 해당 없으면 에러 (그룹 목록에서 골라 들어온 거라 정상적으로는 항상 있어야 함)
        if (targetWrongAnswers.isEmpty()) {
            log.warn("[ReviewService] 복습 문제 시작 실패, 해당 날짜/소분류에 오답 없음: userId={}, subCategory={}, date={}",
                    userId, subCategory, date);
            throw new CustomException(ReviewErrorCode.NO_WRONG_QUESTIONS_FOUND);
        }

        // 1차: 오답 하나당 [복기(틀린 문제 그대로) + 다른 지문(같은 레벨/소분류, 오답 기사 제외 랜덤 1개)] 구성
        List<QuestionWithMode> plan = new ArrayList<>();
        for (Answer wrong : targetWrongAnswers) {
            Question wrongQuestion = wrong.getQuestion();
            plan.add(new QuestionWithMode(ReviewMode.RECALL, wrongQuestion));

            List<Question> candidates = questionRepository.findAllByLevelAndSubCategoryAndNewsIdNotIn(
                    user.getLevel().intValue(), subCategory, List.of(wrongQuestion.getNewsId()));

            if (!candidates.isEmpty()) {
                Question practice = candidates.get(random.nextInt(candidates.size()));
                plan.add(new QuestionWithMode(ReviewMode.PRACTICE, practice));
            }
        }

        // 2차: 실제 문제 수가 확정된 뒤 복습 세션 저장
        ReviewSession reviewSession = reviewSessionRepository.save(
                ReviewSession.builder().user(user).questionCount(plan.size()).mainCategory(mainCategory).build());

        List<ReviewStartResponse.ReviewQuestionItem> items = new ArrayList<>();
        int order = 1;
        for (QuestionWithMode qwm : plan) {
            reviewSessionQuestionRepository.save(ReviewSessionQuestion.builder()
                    .reviewSession(reviewSession)
                    .question(qwm.question())
                    .displayOrder(order)
                    .build());
            items.add(buildItem(order, qwm.mode(), qwm.question()));
            order++;
        }

        // 로그 출력
        log.info("[ReviewService] 복습 문제 시작 성공: userId={}, subCategory={}, date={}, reviewSessionId={}, totalQuestions={}",
                userId, subCategory, date, reviewSession.getId(), items.size());

        // 응답 세팅
        return ReviewStartResponse.builder()
                .reviewSessionId(reviewSession.getId())
                .totalQuestions(items.size())
                .questions(items)
                .build();
    }

    // 복습 문제 제출 (정답이면 +1xp, 오답이면 새 오답 기록이 오늘 날짜로 남아 목록에 다시 나타남)
    @Transactional
    public ReviewSubmitResponse submitReview(Long userId, Long reviewSessionId, Long questionId, ReviewSubmitRequest request) {

        // 복습 세션이 존재하고 본인 것인지 확인
        ReviewSession reviewSession = reviewSessionRepository.findById(reviewSessionId)
                .orElseThrow(() -> new CustomException(ReviewErrorCode.SESSION_NOT_FOUND));
        if (!reviewSession.getUser().getId().equals(userId)) {
            throw new CustomException(AuthErrorCode.INVALID_USER_ID);
        }

        // 이 문제가 해당 세션에 속하는지 확인
        ReviewSessionQuestion reviewSessionQuestion = reviewSessionQuestionRepository
                .findByReviewSession_IdAndQuestion_Id(reviewSessionId, questionId)
                .orElseThrow(() -> new CustomException(ReviewErrorCode.QUESTION_NOT_IN_SESSION));

        // 사용자, 문제 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));
        Question question = questionRepository.findById(questionId)
                .orElseThrow(() -> new CustomException(GlobalErrorCode.RESOURCE_NOT_FOUND));

        // 채점 (정답이면 +1xp, 오답이면 0 - 오답이면 새 Answer가 오늘 날짜로 쌓여서 다음 조회 때 다시 오답으로 잡힘)
        boolean isCorrect = question.getAnswer().equals(request.getSelectedAnswer());
        int earnedXp = isCorrect ? 1 : 0;

        // 답안 저장 (전체 오답 이력용)
        answerRepository.save(Answer.builder()
                .user(user)
                .question(question)
                .selectedAnswer(request.getSelectedAnswer())
                .resultStatus(isCorrect ? ResultStatus.correct : ResultStatus.incorrect)
                .overallScore(earnedXp)
                .feedback(isCorrect ? "정답이에요!" : "아쉽지만 오답이에요.")
                .build());

        // 이 세션 안에서의 결과 기록 (결과 조회용)
        reviewSessionQuestion.markResult(isCorrect);
        reviewSessionQuestionRepository.save(reviewSessionQuestion);

        // 정답이면 xp/레벨 반영
        if (isCorrect) {
            user.addReviewXp(earnedXp);
            userRepository.save(user);
        }

        // 로그 출력
        log.info("[ReviewService] 복습 문제 제출 성공: userId={}, reviewSessionId={}, questionId={}, isCorrect={}, earnedXp={}",
                userId, reviewSessionId, questionId, isCorrect, earnedXp);

        // 응답 세팅
        return ReviewSubmitResponse.builder()
                .isCorrect(isCorrect)
                .correctAnswer(question.getAnswer())
                .explanation(question.getExplanation())
                .earnedXp(earnedXp)
                .build();
    }

    // 복습 결과 조회 (이 세션에서 실제로 푼 문제 기준 정답률)
    public ReviewResultResponse getResult(Long userId, Long reviewSessionId) {

        // 복습 세션이 존재하고 본인 것인지 확인
        ReviewSession reviewSession = reviewSessionRepository.findById(reviewSessionId)
                .orElseThrow(() -> new CustomException(ReviewErrorCode.SESSION_NOT_FOUND));
        if (!reviewSession.getUser().getId().equals(userId)) {
            throw new CustomException(AuthErrorCode.INVALID_USER_ID);
        }

        // 이 세션에 속한 문제 전체 조회
        List<ReviewSessionQuestion> sessionQuestions = reviewSessionQuestionRepository.findByReviewSession_Id(reviewSessionId);

        // 실제로 제출한(is_correct가 채워진) 문제만 집계
        int totalQuestions = 0;
        int correctCount = 0;
        for (ReviewSessionQuestion sessionQuestion : sessionQuestions) {
            if (sessionQuestion.getCorrect() == null) {
                continue;
            }
            totalQuestions++;
            if (sessionQuestion.getCorrect()) {
                correctCount++;
            }
        }
        int accuracy = totalQuestions == 0 ? 0 : correctCount * 100 / totalQuestions;

        // 로그 출력
        log.info("[ReviewService] 복습 결과 조회 성공: userId={}, reviewSessionId={}, totalQuestions={}, correctCount={}",
                userId, reviewSessionId, totalQuestions, correctCount);

        // 응답 세팅
        return ReviewResultResponse.builder()
                .totalQuestions(totalQuestions)
                .correctCount(correctCount)
                .accuracy(accuracy)
                .build();
    }

    // 유저의 문제별 "최신 제출 기록"만 모음 (같은 문제를 여러 번 냈으면 제일 최근 것만 남음)
    private Map<Long, Answer> findLatestAnswerByQuestion(Long userId) {
        List<Answer> allAnswers = answerRepository.findByUserIdOrderByCreatedAtDesc(userId);
        Map<Long, Answer> latestByQuestion = new LinkedHashMap<>();
        for (Answer answer : allAnswers) {
            Long questionId = answer.getQuestion().getId();
            latestByQuestion.putIfAbsent(questionId, answer);
        }
        return latestByQuestion;
    }

    // 문제 + 소속 기사로 복습 문제 항목 생성
    private ReviewStartResponse.ReviewQuestionItem buildItem(int order, ReviewMode mode, Question question) {
        News news = newsRepository.findById(question.getNewsId())
                .orElseThrow(() -> new CustomException(GlobalErrorCode.RESOURCE_NOT_FOUND));

        return ReviewStartResponse.ReviewQuestionItem.builder()
                .order(order)
                .mode(mode)
                .article(ReviewStartResponse.ArticleResponse.builder()
                        .newsId(news.getId())
                        .title(news.getTitle())
                        .content(news.getContent())
                        .build())
                .question(ReviewStartResponse.QuestionResponse.builder()
                        .questionId(question.getId())
                        .questionFormat(question.getQuestionFormat().name())
                        .mainCategory(question.getMainCategory().name())
                        .subCategory(question.getSubCategory() != null ? question.getSubCategory().name() : null)
                        .content(question.getContent())
                        .choices(parseChoices(question.getChoices()))
                        .build())
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
            log.warn("[ReviewService] 선택지 파싱 실패: choicesJson={}", choicesJson, e);
            throw new CustomException(GlobalErrorCode.INTERNAL_SERVER_ERROR);
        }
    }

    // 복습 세션 구성 계획 (실제 저장 전 임시 보관용)
    private record QuestionWithMode(ReviewMode mode, Question question) {
    }

    // 날짜/소분류 그룹 키
    private record GroupKey(LocalDate date, SubCategory subCategory) {
    }
}