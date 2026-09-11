package com.readle.readlebackend.domain.review.entity;

import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.global.common.BaseTimeEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Entity
@Table(name = "review_sessions")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReviewSession extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "is_completed", nullable = false)
    private boolean completed;

    @Column(name = "question_count", nullable = false)
    private Integer questionCount;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "main_category", nullable = false, columnDefinition = "main_category_type")
    private MainCategory mainCategory;

    @Builder
    private ReviewSession(User user, Integer questionCount, MainCategory mainCategory) {
        this.user = user;
        this.completed = false;
        this.questionCount = questionCount;
        this.mainCategory = mainCategory;
    }
}