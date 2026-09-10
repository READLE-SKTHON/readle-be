package com.readle.readlebackend.domain.user.entity;

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
 * <p>{@code created_at} / {@code updated_at} 은 DB 기본값(now())에 맡기므로
 * insert/update 대상에서 제외한다.
 */
@Entity
@Table(name = "users")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {

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

    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false, insertable = false, updatable = false)
    private LocalDateTime updatedAt;

    private Long level;

    private Integer xp;

    private LocalDate lastActivityDate;

    private Long currentStreak;

    private Long answerRate;

    private Integer newsReadCount;
}
