package com.readle.readlebackend.domain.question.repository;

import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface QuestionRepository extends JpaRepository<Question, Long> {

    // 특정 게임 모드로 오늘(생성 시각 기준) 만들어진 문제 목록 조회
    List<Question> findByGameModeAndCreatedAtBetween(GameMode gameMode, LocalDateTime start, LocalDateTime end);
}
