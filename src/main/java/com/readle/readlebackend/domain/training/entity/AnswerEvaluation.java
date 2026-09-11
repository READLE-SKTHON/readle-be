package com.readle.readlebackend.domain.training.entity;

import com.readle.readlebackend.domain.training.enums.SkillCategory;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.global.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Entity
@Table(name = "answer_evaluations")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AnswerEvaluation extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "answer_evaluations_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_answer_id", nullable = false)
    private Answer answer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "skill_category", nullable = false, columnDefinition = "skill_category_type")
    private SkillCategory skillCategory; // 능력치 종류

    private Integer score; // 점수

    private String feedback; // 코멘트

    @Builder
    private AnswerEvaluation(Answer answer, User user, SkillCategory skillCategory, Integer score, String feedback) {
        this.answer = answer;
        this.user = user;
        this.skillCategory = skillCategory;
        this.score = score;
        this.feedback = feedback;
    }
}
