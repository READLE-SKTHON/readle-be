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
}
