package com.readle.readlebackend.domain.room.entity;

import com.readle.readlebackend.domain.room.enums.Category;
import com.readle.readlebackend.domain.room.enums.Difficulty;
import com.readle.readlebackend.global.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;

@Entity
@Table(name = "game_rooms")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class GameRoom extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "game_room_id")
    private Long id;

    @Column(name = "room_code", nullable = false)
    private Long roomCode;

    @Column(name = "invite_link")
    private String inviteLink;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(nullable = false, columnDefinition = "news_category_type")
    private Category category;

    @Column(nullable = false)
    private Integer timer;

    @Column(name = "member_count", nullable = false)
    private Integer memberCount;

    @Column(name = "question_count", nullable = false)
    private Integer questionCount;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(nullable = false, columnDefinition = "room_difficulty_type")
    private Difficulty difficulty;

    @Column(name = "started_at")
    private LocalDateTime startedAt;

    /** 지금까지 몇 판(round)을 시작했는지. 0 = 아직 한 판도 시작 안 함. 같은 방에서 재시작할 때마다 1씩 증가. */
    @Column(name = "current_round", nullable = false)
    private Integer currentRound = 0;

    @Builder
    public GameRoom(Long roomCode, String inviteLink, Category category,
                    Integer timer, Integer memberCount, Integer questionCount,
                    Difficulty difficulty) {
        this.roomCode = roomCode;
        this.inviteLink = inviteLink;
        this.category = category;
        this.timer = timer;
        this.memberCount = memberCount;
        this.questionCount = questionCount;
        this.difficulty = difficulty;
    }

    /**
     * 새 판을 시작한다. {@code currentRound} 를 1 증가시키고 시작 시각을 지금으로 갱신한다.
     * 이전 판이 아직 진행 중인지는 호출부(Service)에서 먼저 확인해야 한다.
     */
    public void start() {
        this.currentRound = this.currentRound + 1;
        this.startedAt = LocalDateTime.now();
    }

    /** 지금까지 한 번이라도 시작한 적이 있는지 (진행 중이든 끝났든). */
    public boolean isStarted() {
        return startedAt != null;
    }
}
