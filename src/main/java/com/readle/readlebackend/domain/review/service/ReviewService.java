package com.readle.readlebackend.domain.review.service;

import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.question.enums.SubCategory;
import com.readle.readlebackend.domain.review.dto.response.ReviewCategoriesResponse;
import com.readle.readlebackend.domain.training.entity.Answer;
import com.readle.readlebackend.domain.training.enums.ResultStatus;
import com.readle.readlebackend.domain.training.repository.AnswerRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class ReviewService {

    private final AnswerRepository answerRepository;

    // 복습 화면에서 유형별 조회
    public ReviewCategoriesResponse getCategories(Long userId) {

        // 이 유저의 전체 오답 조회
        List<Answer> wrongAnswers = answerRepository.findByUserIdAndResultStatusNot(userId, ResultStatus.correct);

        // 유형별 오답 개수 집계
        Map<MainCategory, Long> wrongCountByCategory = new HashMap<>();
        for (Answer wrong : wrongAnswers) {
            MainCategory mainCategory = wrong.getQuestion().getMainCategory();
            wrongCountByCategory.merge(mainCategory, 1L, Long::sum);
        }

        // 5개 유형 전부 포함해서 응답 구성
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

            // 정보 추출
            case vocab -> List.of(
                    SubCategory.vocab_appropriateness.name(),
                    SubCategory.vocab_meaning.name(),
                    SubCategory.vocab_paraphrase.name());

            // 정보 추출
            case info_extraction -> List.of(
                    SubCategory.info_consistency.name(),
                    SubCategory.info_evidence.name());

            // 핵심 파악
            case core_understanding -> List.of(
                    SubCategory.core_topic.name(),
                    SubCategory.core_title.name(),
                    SubCategory.core_gist.name(),
                    SubCategory.core_argument.name());

            // 추론 및 판단
            case inference_judgment -> List.of(
                    SubCategory.inference_blank.name(),
                    SubCategory.inference_implication.name(),
                    SubCategory.inference_continuation.name());

            // 구조파악
            case structure -> List.of(
                    SubCategory.structure_sentence_insertion.name(),
                    SubCategory.structure_order.name(),
                    SubCategory.structure_irrelevant_sentence.name());
        };
    }
}
