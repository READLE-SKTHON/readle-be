package com.readle.readlebackend.domain.training.repository;

import com.readle.readlebackend.domain.training.entity.AnswerEvaluation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AnswerEvaluationRepository extends JpaRepository<AnswerEvaluation, Long> {

    // 특정 답안(Answer)에 대한 능력치별 평가 전체
    List<AnswerEvaluation> findByAnswerId(Long answerId);

    List<AnswerEvaluation> findByUserId(Long userId);
}
