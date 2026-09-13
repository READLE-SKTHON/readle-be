package com.readle.readlebackend.domain.training.repository;

import com.readle.readlebackend.domain.training.entity.AnswerEvaluation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AnswerEvaluationRepository extends JpaRepository<AnswerEvaluation, Long> {

    // 특정 답안(Answer)에 대한 능력치별 평가 전체
    List<AnswerEvaluation> findByAnswerId(Long answerId);

    List<AnswerEvaluation> findByUserId(Long userId);

    // 특정 답안(Answer)에 이미 능력치 평가가 저장돼있는지 (결과 조회를 여러 번 호출해도 중복 평가/중복 API 호출 방지용)
    boolean existsByAnswerId(Long answerId);

    // 유저의 전체 누적 answer_evaluations를 능력치 카테고리별로 평균 낸다.
    // (오늘 결과 조회 API, 능력치 단독 조회 API에서 공용으로 사용)
    @Query("SELECT ae.skillCategory AS skillCategory, AVG(ae.score) AS avgScore " +
            "FROM AnswerEvaluation ae WHERE ae.user.id = :userId GROUP BY ae.skillCategory")
    List<SkillCategoryAverageView> findAverageScoresByUserId(@Param("userId") Long userId);
}
