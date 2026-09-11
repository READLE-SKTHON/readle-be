-- 학교 시드 데이터 (id 직접 지정)
INSERT INTO schools (school_id, school_name) VALUES (1, '서경대학교');
INSERT INTO schools (school_id, school_name) VALUES (2, '국민대학교');

-- BIGSERIAL 시퀀스를 시드 이후 최대값으로 보정 (이후 INSERT 시 PK 충돌 방지)
SELECT setval(pg_get_serial_sequence('schools', 'school_id'), (SELECT MAX(school_id) FROM schools));

-- 유저 소속 학교 설정
UPDATE users SET school_id = 1 WHERE user_id IN (1, 2); -- 김환희, 장서후 -> 서경대학교
UPDATE users SET school_id = 2 WHERE user_id IN (3, 4); -- 김정모, 박예지 -> 국민대학교