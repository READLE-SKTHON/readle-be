package com.readle.readlebackend.domain.training.repository;

import com.readle.readlebackend.domain.training.entity.Answer;
import com.readle.readlebackend.domain.training.enums.ResultStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface AnswerRepository extends JpaRepository<Answer, Long> {

    // 여러 문제에 대한 이 유저의 모든 제출 기록
    List<Answer> findByUserIdAndQuestionIdIn(Long userId, List<Long> questionIds);

    // 특정 기간(오늘 등) 동안의 제출 기록
    List<Answer> findByUserIdAndCreatedAtBetween(Long userId, LocalDateTime start, LocalDateTime end);

    // 복습용: 이 유저의 전체 제출 기록을 최신순으로 조회 (문제별 최신 제출만 추려서 "현재 오답" 판단에 사용)
    List<Answer> findByUserIdOrderByCreatedAtDesc(Long userId);
}
