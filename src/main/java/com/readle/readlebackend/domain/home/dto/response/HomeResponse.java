package com.readle.readlebackend.domain.home.dto.response;

import com.readle.readlebackend.domain.news.enums.NewsCategory;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "홈 화면 응답")
public class HomeResponse {

    @Schema(description = "닉네임", example = "김환희")
    private String nickname;

    @Schema(description = "현재 레벨 (1~5)", example = "3")
    private Long level;

    @Schema(description = "현재 경험치", example = "700")
    private Integer xp;

    @Schema(description = "해당 레벨의 최대 경험치", example = "1400")
    private Integer maxXp;

    @Schema(description = "연속 학습 일수", example = "5")
    private Long currentStreak;

    @Schema(description = "읽은 뉴스 수", example = "12")
    private Integer newsReadCount;

    @Schema(description = "평균 정답률 (0~100 정수)", example = "80")
    private Long answerRate;

    @Schema(description = "오늘의 뉴스. 유저 레벨과 일치하는 뉴스가 하나도 없으면 null")
    private TodayNewsResponse todayNews;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(description = "오늘의 뉴스 1건")
    public static class TodayNewsResponse {

        @Schema(description = "뉴스 ID", example = "1")
        private Long newsId;

        @Schema(description = "제목", example = "소비자물가 상승률 3.6%, 3년 만에 최고치")
        private String title;

        @Schema(description = "언론사", example = "중앙일보")
        private String publisher;

        @Schema(description = "카테고리")
        private NewsCategory category;

        @Schema(description = "게시 시각")
        private LocalDateTime publishedAt;

        @Schema(description = "기사 본문", example = "정부가 오늘 발표한 정책에 따르면...")
        private String content;

        @Schema(description = "난이도 레벨", example = "3")
        private Integer level;
    }
}
