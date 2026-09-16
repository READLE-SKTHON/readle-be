package com.readle.readlebackend.domain.user.repository;

import com.readle.readlebackend.domain.user.entity.Friend;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FriendRepository extends JpaRepository<Friend, Long> {

    // 친구 랭킹 조회용: 이 유저가 추가한 친구 목록
    List<Friend> findByUserId(Long userId);

    // 이미 친구인지 조회
    Optional<Friend> findByUserIdAndAddedUserId(Long userId, Long addedUserId);
}
