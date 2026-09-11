package com.readle.readlebackend.domain.news.dto;

/**
 * 오늘 날짜의 레벨별 대표 기사 1건.
 */
public record TodayRepresentativeArticleDto(
        Integer level,
        Long articleId
) {
}
