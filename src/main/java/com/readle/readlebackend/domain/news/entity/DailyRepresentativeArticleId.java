package com.readle.readlebackend.domain.news.entity;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * {@link DailyRepresentativeArticle} 의 복합키 (rep_date, level).
 * 필드명이 엔티티의 {@code @Id} 필드명(repDate, level)과 정확히 일치해야 한다.
 */
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class DailyRepresentativeArticleId implements Serializable {
    private LocalDate repDate;
    private Integer level;
}
