-- 방 게임 중 제출한 답안 기록. 문제당 유저 1회 제출만 허용(재제출 방지).
-- answered_at 은 제출 순서로 등수/점수를 매기는 기준이라 마이크로초까지 저장한다(TIMESTAMP(6)).
CREATE TABLE game_room_answers (
    id BIGSERIAL PRIMARY KEY,
    room_id BIGINT NOT NULL REFERENCES game_rooms(game_room_id),
    question_id BIGINT NOT NULL REFERENCES questions(question_id),
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    selected_answer TEXT,
    is_correct BOOLEAN NOT NULL,
    score INT NOT NULL DEFAULT 0,
    answered_at TIMESTAMP(6) NOT NULL,
    UNIQUE (room_id, question_id, user_id)
);
