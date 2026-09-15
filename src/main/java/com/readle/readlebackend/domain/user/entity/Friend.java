package com.readle.readlebackend.domain.user.entity;

import com.readle.readlebackend.global.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "friends")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Friend extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "friend_id")
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "added_user_id", nullable = false)
    private Long addedUserId; // 추가된 친구

    @Builder
    private Friend(Long userId, Long addedUserId) {
        this.userId = userId;
        this.addedUserId = addedUserId;
    }
}
