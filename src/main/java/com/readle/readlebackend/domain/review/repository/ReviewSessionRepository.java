package com.readle.readlebackend.domain.review.repository;

import com.readle.readlebackend.domain.review.entity.ReviewSession;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReviewSessionRepository extends JpaRepository<ReviewSession, Long> {
}
