package com.readle.readlebackend.domain.user.repository;

import com.readle.readlebackend.domain.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
}
