-- 친구 관계 테이블 (친구 추가 할 때는 닉네임 검색으로 추가)
CREATE TABLE friends (
    friend_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    added_user_id BIGINT NOT NULL REFERENCES users(user_id),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (user_id, added_user_id)
);
