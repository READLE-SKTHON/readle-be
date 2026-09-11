package com.readle.readlebackend.domain.user.entity;

import com.readle.readlebackend.global.common.BaseTimeEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * {@code users} 테이블 매핑 엔티티. 스키마는 Flyway {@code V1__init.sql} 기준.
 *
 * <p>{@code created_at} / {@code updated_at} 은 {@link BaseTimeEntity} 의
 * JPA Auditing 이 채운다.
 */
@Entity
@Table(name = "users")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long id;

    @Column(nullable = false, length = 50)
    private String nickname;

    private LocalDateTime birth;

    private String password;

    @Column(name = "school_id")
    private Long schoolId;

    private Long level;

    private Integer xp;

    @Column(name = "last_activity_date")
    private LocalDate lastActivityDate;

    @Column(name = "current_streak", nullable = false)
    private Long currentStreak = 0L;

    @Column(name = "answer_rate")
    private Long answerRate;

    @Column(name = "news_read_count")
    private Integer newsReadCount;

    // 오늘의 퀴즈 결과 반영 및 xp & 레벨 계산 & 연속 학습일 갱신
    public void applyDailyResult(int earnedExp, LocalDate today) {
        this.xp = (this.xp == null ? 0 : this.xp) + earnedExp;
        this.level = calculateLevel(this.xp);

        // 마지막 학습일이 어제인지 확인
        if (this.lastActivityDate == null || !this.lastActivityDate.isEqual(today)) {

            // 마지막 학습일이 어제일 때
            if (this.lastActivityDate != null && this.lastActivityDate.isEqual(today.minusDays(1))) {
                this.currentStreak = this.currentStreak + 1;
            }

            // 어제 활동을 안했거나 첫 활동일 때
            else {
                this.currentStreak = 1L;
            }

            // 마지막 학습일을 오늘로 바꾸기
            this.lastActivityDate = today;
        }
    }

    // Level 구간
    private Long calculateLevel(int xp) {
        if (xp < 200) return 1L;
        if (xp < 600) return 2L;
        if (xp < 1400) return 3L;
        if (xp < 2400) return 4L;
        return 5L;
    }
}
