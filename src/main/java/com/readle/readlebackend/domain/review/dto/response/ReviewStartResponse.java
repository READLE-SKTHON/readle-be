package com.readle.readlebackend.domain.review.dto.response;

import com.readle.readlebackend.domain.review.enums.ReviewMode;
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
@Schema(title = "복습 문제 시작 응답 dto", description = "오답 복기 + 같은 유형 다른 기사 문제 세트")
public class ReviewStartResponse {

    @Schema(description = "복습 세션 id")
    private Long reviewSessionId;

    @Schema(description = "이 세션의 전체 문제 수")
    private int totalQuestions;

    @Schema(description = "복습 문제 목록 (오답 복기 + 같은 유형 다른 기사 문제가 번갈아 배치됨)")
    private List<ReviewQuestionItem> questions;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "복습 문제 항목 dto")
    public static class ReviewQuestionItem {

        @Schema(description = "순서", example = "1")
        private int order;

        @Schema(description = "RECALL(틀린 문제 복기) / PRACTICE(같은 유형 다른 기사 문제)", example = "RECALL")
        private ReviewMode mode;

        @Schema(description = "문제가 속한 기사 (지문 전체보기용 본문 포함)")
        private ArticleResponse article;

        @Schema(description = "문제")
        private QuestionResponse question;
    }

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "복습용 기사 dto")
    public static class ArticleResponse {

        @Schema(description = "기사 id")
        private Long newsId;

        @Schema(description = "제목")
        private String title;

        @Schema(description = "본문 (지문 전체보기)")
        private String content;
    }

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "복습용 문제 dto")
    public static class QuestionResponse {

        @Schema(description = "문제 id")
        private Long questionId;

        @Schema(description = "문제 유형 (OX/multiple_choice/short_answer)")
        private String questionFormat;

        @Schema(description = "능력치 대분류", example = "vocab")
        private String mainCategory;

        @Schema(description = "능력치 소분류", example = "vocab_meaning")
        private String subCategory;

        @Schema(description = "문제 내용")
        private String content;

        @Schema(description = "선택지 (객관식인 경우만)")
        private List<String> choices;
    }
}