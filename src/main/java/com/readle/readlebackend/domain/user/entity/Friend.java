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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user; // 친구 추가한 사람


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "added_user_id", nullable = false)
    private User addedUser; // 추가된 친구

    @Builder
    private Friend(User user, User addedUser) {
        this.user = user;
        this.addedUser = addedUser;
    }
}
