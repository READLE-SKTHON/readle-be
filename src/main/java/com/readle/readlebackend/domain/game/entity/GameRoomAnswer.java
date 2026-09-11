package com.readle.readlebackend.domain.game.entity;

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

import java.time.LocalDateTime;

/**
 * {@code game_room_answers} 테이블 매핑 엔티티. 방 게임 중 제출한 답안 1건.
 * 문제당 유저 1회만 제출 가능 (DB unique 제약 + 서비스 레벨 중복 검사).
 */
@Entity
@Table(name = "game_room_answers")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class GameRoomAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "room_id", nullable = false)
    private Long roomId;

    @Column(name = "question_id", nullable = false)
    private Long questionId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "selected_answer")
    private String selectedAnswer;

    @Column(name = "is_correct", nullable = false)
    private Boolean isCorrect;

    @Column(nullable = false)
    private Integer score;

    @Column(name = "answered_at", nullable = false)
    private LocalDateTime answeredAt;

    @Builder
    public GameRoomAnswer(Long roomId, Long questionId, Long userId, String selectedAnswer,
                          Boolean isCorrect, Integer score, LocalDateTime answeredAt) {
        this.roomId = roomId;
        this.questionId = questionId;
        this.userId = userId;
        this.selectedAnswer = selectedAnswer;
        this.isCorrect = isCorrect;
        this.score = score;
        this.answeredAt = answeredAt;
    }
}
