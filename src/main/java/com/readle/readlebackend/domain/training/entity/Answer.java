package com.readle.readlebackend.domain.training.entity;

import com.readle.readlebackend.domain.training.enums.ResultStatus;
import com.readle.readlebackend.domain.question.entity.Question;
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
@Table(name = "user_answers")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Answer extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_answer_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    @Column(nullable = false)
    private String selectedAnswer; // 선택한 답안

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "result_status", nullable = false, columnDefinition = "result_status_type")
    private ResultStatus resultStatus; // 정답 상태

    private String justification; // 작성한 근거

    @Column(nullable = false)
    private Integer overallScore; // 점수

    private String mistakeFeedback; // 틀린 이유

    @Column(nullable = false)
    private String feedback; // 피드백

    @Builder
    private Answer(User user, Question question, String selectedAnswer, ResultStatus resultStatus, String justification, Integer overallScore, String mistakeFeedback, String feedback) {
        this.user = user;
        this.question = question;
        this.selectedAnswer = selectedAnswer;
        this.resultStatus = resultStatus;
        this.justification = justification;
        this.overallScore = overallScore;
        this.mistakeFeedback = mistakeFeedback;
        this.feedback = feedback;
    }
}
