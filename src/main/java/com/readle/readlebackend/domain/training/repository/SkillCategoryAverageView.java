package com.readle.readlebackend.domain.training.repository;

import com.readle.readlebackend.domain.training.enums.SkillCategory;

/**
 * 유저의 능력치 카테고리별 누적 평균 점수 집계 결과를 담는 JPA 프로젝션 인터페이스.
 * {@link AnswerEvaluationRepository#findAverageScoresByUserId} 조회 결과를 받는다.
 */
public interface SkillCategoryAverageView {
    SkillCategory getSkillCategory();
    Double getAvgScore();
}
