package com.readle.readlebackend.domain.review.repository;

import com.readle.readlebackend.domain.review.entity.ReviewSessionQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ReviewSessionQuestionRepository extends JpaRepository<ReviewSessionQuestion, Long> {

    // 제출용: 이 문제가 해당 복습 세션에 속하는지 확인
    Optional<ReviewSessionQuestion> findByReviewSession_IdAndQuestion_Id(Long reviewSessionId, Long questionId);

    // 결과 조회용: 이 세션에 속한 문제 전체 조회
    List<ReviewSessionQuestion> findByReviewSession_Id(Long reviewSessionId);
}
