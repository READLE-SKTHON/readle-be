-- 개발/테스트용 시드 유저.
-- JWT 없이 X-USER-ID 헤더에 1~4 를 넣어 해당 유저로 요청을 보낼 수 있다.
INSERT INTO users (user_id, nickname) VALUES
    (1, '김환희'),
    (2, '장서후'),
    (3, '김정모'),
    (4, '박예지');

-- BIGSERIAL 시퀀스를 시드 이후 최대값으로 보정 (이후 INSERT 시 PK 충돌 방지)
SELECT setval(pg_get_serial_sequence('users', 'user_id'), (SELECT MAX(user_id) FROM users));
