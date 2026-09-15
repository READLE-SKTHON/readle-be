package com.readle.readlebackend.domain.user.repository;

import com.readle.readlebackend.domain.user.entity.Friend;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FriendRepository extends JpaRepository<Friend, Long> {

    // 친구 랭킹 조회용: 이 유저가 추가한 친구 목록
    List<Friend> findByUserId(Long userId);
}
