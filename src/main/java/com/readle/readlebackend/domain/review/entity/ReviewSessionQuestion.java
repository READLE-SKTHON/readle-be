package com.readle.readlebackend.domain.review.entity;

import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.global.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "review_session_question")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReviewSessionQuestion extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "review_session_id", nullable = false)
    private ReviewSession reviewSession;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    @Column(name = "display_order", nullable = false)
    private Integer displayOrder;

    // 이 세션 안에서 이 문제를 맞았는지 여부. 아직 제출 안 했으면 null.
    @Column(name = "is_correct")
    private Boolean correct;

    @Builder
    private ReviewSessionQuestion(ReviewSession reviewSession, Question question, Integer displayOrder) {
        this.reviewSession = reviewSession;
        this.question = question;
        this.displayOrder = displayOrder;
    }

    // 복습 문제 제출 결과 기록
    public void markResult(boolean isCorrect) {
        this.correct = isCorrect;
    }
}
