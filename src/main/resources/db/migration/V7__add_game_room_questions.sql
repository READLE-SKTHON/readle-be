-- 게임 시작 시각 기록 (null = 대기중, 값 있음 = 시작됨)
ALTER TABLE game_rooms
    ADD COLUMN started_at TIMESTAMP;

-- 방에 배정된 문제 목록. 참여자 전원이 같은 문제를 같은 순서로 풀어야 하므로 고정 저장한다.
CREATE TABLE game_room_questions (
    id BIGSERIAL PRIMARY KEY,
    room_id BIGINT NOT NULL REFERENCES game_rooms(game_room_id),
    question_id BIGINT NOT NULL REFERENCES questions(question_id),
    display_order INT NOT NULL
);
