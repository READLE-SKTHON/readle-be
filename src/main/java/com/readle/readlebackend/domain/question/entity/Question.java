package com.readle.readlebackend.domain.question.entity;

import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import com.readle.readlebackend.domain.question.enums.SubCategory;
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
 * {@code questions} 테이블 매핑 엔티티. 스키마는 Flyway {@code V1__init.sql} 기준.
 *
 * <p>{@code news_id} 는 User.schoolId 와 동일한 컨벤션으로 연관관계 매핑 없이
 * 단순 FK 값(Long)으로만 보관한다.
 *
 * <p>{@code created_at} 은 DB 기본값(now())에 맡기므로 insert/update 대상에서 제외한다.
 * (questions 테이블에는 updated_at 컬럼 자체가 없다.)
 */
@Entity
@Table(name = "questions")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "question_id")
    private Long id;

    @Column(name = "news_id", nullable = false)
    private Long newsId;

    @Column(nullable = false)
    private String content;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "question_format", nullable = false, columnDefinition = "question_format_type")
    private QuestionFormat questionFormat;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column
    private String choices;

    @Column(nullable = false)
    private String answer;

    @Column
    private String explanation;

    @Column
    private String hint;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "game_mode", nullable = false, columnDefinition = "game_mode_type")
    private GameMode gameMode;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "main_category", nullable = false, columnDefinition = "main_category_type")
    private MainCategory mainCategory;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "sub_category", columnDefinition = "sub_category_type")
    private SubCategory subCategory;

    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private Integer level;

    @Builder
    private Question(Long newsId, String content, QuestionFormat questionFormat, String choices,
                      String answer, String explanation, String hint, GameMode gameMode,
                      MainCategory mainCategory, SubCategory subCategory, Integer level) {
        this.newsId = newsId;
        this.content = content;
        this.questionFormat = questionFormat;
        this.choices = choices;
        this.answer = answer;
        this.explanation = explanation;
        this.hint = hint;
        this.gameMode = gameMode;
        this.mainCategory = mainCategory;
        this.subCategory = subCategory;
        this.level = level;
    }
}
