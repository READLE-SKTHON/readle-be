package com.readle.readlebackend.domain.news.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * {@code daily_representative_article} 테이블 매핑 엔티티.
 * 날짜(rep_date) + 레벨(level)별로 "오늘의 대표 기사" 하나를 저장한다.
 *
 * <p>PK가 (rep_date, level) 복합키라서 surrogate id 컬럼이 없다.
 * {@link DailyRepresentativeArticleId} 를 {@code @IdClass}로 사용한다.
 *
 * <p>{@code created_at} 은 DB 기본값(CURRENT_TIMESTAMP)에 맡기므로 insert/update 대상에서 제외한다.
 */
@Entity
@Table(name = "daily_representative_article")
@IdClass(DailyRepresentativeArticleId.class)
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DailyRepresentativeArticle {

    @Id
    @Column(name = "rep_date", nullable = false)
    private LocalDate repDate;

    @Id
    @Column(nullable = false)
    private Integer level;

    @Column(name = "article_id", nullable = false)
    private Long articleId;

    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Builder
    private DailyRepresentativeArticle(LocalDate repDate, Integer level, Long articleId) {
        this.repDate = repDate;
        this.level = level;
        this.articleId = articleId;
    }
}
