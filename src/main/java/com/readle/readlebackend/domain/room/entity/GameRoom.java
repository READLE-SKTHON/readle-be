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

    /** 게임을 시작 상태로 전환한다. 이미 시작된 방인지는 호출부(Service)에서 먼저 확인해야 한다. */
    public void start() {
        this.startedAt = LocalDateTime.now();
    }

    public boolean isStarted() {
        return startedAt != null;
    }
}
