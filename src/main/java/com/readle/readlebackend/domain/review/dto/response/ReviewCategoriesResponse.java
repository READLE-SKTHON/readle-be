package com.readle.readlebackend.domain.review.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "유형별 틀린 문제 목록 응답 dto", description = "5개 유형이 항상 전부 노출되고, 유형별 틀린 문제 개수를 함께 반환")
public class ReviewCategoriesResponse {

    @Schema(description = "유형별 틀린 문제 개수 목록 (5개 유형 전부 포함, 오답 없으면 0)")
    private List<CategoryItem> categories;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "유형별 틀린 문제 개수 dto")
    public static class CategoryItem {

        @Schema(description = "능력치 대분류", example = "vocab")
        private String mainCategory;

        @Schema(description = "이 대분류에 속한 소분류 목록", example = "[\"vocab_appropriateness\", \"vocab_meaning\", \"vocab_paraphrase\"]")
        private List<String> subCategories;

        @Schema(description = "이 유형에서 틀린 문제 개수", example = "6")
        private long wrongCount;
    }
}
