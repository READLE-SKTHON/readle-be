package com.readle.readlebackend.domain.training.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.domain.training.dto.response.TodayQuestionsResponse;
import com.readle.readlebackend.domain.training.entity.Answer;
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
}