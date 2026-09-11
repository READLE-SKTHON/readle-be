package com.readle.readlebackend.domain.news.entity;

import com.readle.readlebackend.domain.news.enums.NewsCategory;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;

/**
 * {@code news_articles} 테이블 매핑 엔티티. 스키마는 Flyway {@code V1__init.sql} 기준.
 *
 * <p>{@code created_at} / {@code updated_at} 은 DB 기본값(now())에 맡기므로
 * insert/update 대상에서 제외한다.
 */
@Entity
@Table(name = "news_articles")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class News {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "news_id")
    private Long id;

    @Column(nullable = false, length = 100)
    private String title;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(nullable = false, columnDefinition = "news_category_type")
    private NewsCategory category;

    @Column(nullable = false, length = 100)
    private String publisher;

    @Column(name = "published_at", nullable = false)
    private LocalDateTime publishedAt;

    @Column(nullable = false)
    private String content;

    @Column(name = "source_url", nullable = false, length = 100)
    private String sourceUrl;

    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false, insertable = false, updatable = false)
    private LocalDateTime updatedAt;

    @Column(nullable = false)
    private Integer level;

    @Builder
    private News(String title, NewsCategory category, String publisher,
                  LocalDateTime publishedAt, String content, String sourceUrl, Integer level) {
        this.title = title;
        this.category = category;
        this.publisher = publisher;
        this.publishedAt = publishedAt;
        this.content = content;
        this.sourceUrl = sourceUrl;
        this.level = level;
    }

    /**
     * 문제 생성 AI가 판단한 난이도로 기사 자체의 level을 갱신한다.
     * (목데이터로 미리 넣어둔 level은 임시값이므로, 문제 생성 시점에 AI 판단값으로 덮어쓴다.)
     */
    public void updateLevel(Integer level) {
        this.level = level;
    }
}

