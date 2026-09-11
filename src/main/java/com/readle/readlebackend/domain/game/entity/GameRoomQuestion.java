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

/**
 * {@code game_room_questions} 테이블 매핑 엔티티.
 * 방에 배정된 문제를 순서(displayOrder)와 함께 고정 저장한다 — 참여자 전원이 같은 문제/순서를 풀어야 하기 때문.
 */
@Entity
@Table(name = "game_room_questions")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class GameRoomQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "room_id", nullable = false)
    private Long roomId;

    @Column(name = "question_id", nullable = false)
    private Long questionId;

    @Column(name = "display_order", nullable = false)
    private Integer displayOrder;

    @Builder
    public GameRoomQuestion(Long roomId, Long questionId, Integer displayOrder) {
        this.roomId = roomId;
        this.questionId = questionId;
        this.displayOrder = displayOrder;
    }
}
