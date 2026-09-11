package com.readle.readlebackend.domain.school.repository;

import com.readle.readlebackend.domain.school.entity.School;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SchoolRepository extends JpaRepository<School, Long> {
}
