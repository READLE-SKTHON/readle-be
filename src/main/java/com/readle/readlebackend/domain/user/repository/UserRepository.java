package com.readle.readlebackend.domain.user.repository;

import com.readle.readlebackend.domain.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByNickname(String nickname);

    // xp 내림차순으로 전체 유저 조회 (전체 랭킹 조회용)
    List<User> findAllByOrderByXpDesc();
}
