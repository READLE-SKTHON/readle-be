package com.readle.readlebackend.domain.question.repository;

import com.readle.readlebackend.domain.question.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Long> {
}
