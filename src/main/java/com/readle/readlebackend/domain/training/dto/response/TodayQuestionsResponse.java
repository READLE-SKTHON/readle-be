package com.readle.readlebackend.domain.training.dto.response;

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
@Schema(title = "오늘 문제풀이 조회 응답 dto", description = "혼자 문제풀기 시작 시 반환되는 오늘의 기사와 문제 목록")
public class TodayQuestionsResponse {

    @Schema(description = "문제 구성에 사용된 유저 레벨", example = "3")
    private Long userLevel;

    @Schema(description = "오늘의 뉴스 기사 정보")
    private ArticleResponse article;

    @Schema(description = "총 문제 수", example = "10")
    private int questionCount;

    @Schema(description = "문제 목록")
    private List<QuestionResponse> questions;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "기사 정보 응답 dto", description = "오늘의 문제풀이에 포함된 뉴스 기사 정보")
    public static class ArticleResponse {

        @Schema(description = "기사 고유번호", example = "1")
        private Long newsId;

        @Schema(description = "기사 제목", example = "소비자물가 상승률 3.6%, 3년 만에 최고치")
        private String title;

        @Schema(description = "언론사", example = "중앙일보")
        private String publisher;

        @Schema(description = "게시일", example = "2026-08-01")
        private String publishedAt;

        @Schema(description = "기사 카테고리", example = "경제")
        private String category;

        @Schema(description = "기사 본문", example = "최근 소비자물가가 계속 상승하면서 가계의 생활비 부담이 커지고 있다...")
        private String content;

        @Schema(description = "기사 난이도 레벨", example = "3")
        private Integer level;
    }

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "문제 정보 응답 dto", description = "오늘 문제풀이 조회 시 노출되는 문제 하나의 정보 (정답, 근거, 힌트는 포함되지 않음)")
    public static class QuestionResponse {

        @Schema(description = "문제 고유번호", example = "1")
        private Long questionId;

        @Schema(description = "문제 노출 순서", example = "1")
        private int order;

        @Schema(description = "문제 유형", example = "multiple_choice")
        private String questionFormat;

        @Schema(description = "능력치 대분류", example = "core_understanding")
        private String mainCategory;

        @Schema(description = "능력치 소분류", example = "core_gist")
        private String subCategory;

        @Schema(description = "문제 본문", example = "이 글의 중심 내용으로 적절한 것은?")
        private String content;

        @Schema(description = "선택지 목록 (객관식 문제만 존재)", example = "[\"가계 부담 증가\", \"수출 감소\", \"환율 하락\", \"실업률 상승\"]")
        private List<String> choices;

        @Schema(description = "문제 난이도 레벨", example = "3")
        private Integer level;

        @Schema(description = "근거 작성 필요 여부 (OX 문제만 true)", example = "false")
        private boolean requireReason;
    }
}
