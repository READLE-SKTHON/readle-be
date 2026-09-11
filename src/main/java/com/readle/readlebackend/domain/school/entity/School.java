package com.readle.readlebackend.domain.school.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * {@code schools} 테이블 매핑 엔티티. 스키마는 Flyway {@code V1__init.sql} 기준.
 * 지금은 로그인 응답에 학교 이름을 보여주는 용도로만 조회한다 (생성/수정 로직 없음).
 */
@Entity
@Table(name = "schools")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class School {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "school_id")
    private Long id;

    @Column(name = "school_name", nullable = false, length = 50)
    private String schoolName;

    private Long point;

    @Column(name = "school_avg")
    private Integer schoolAvg;
}
