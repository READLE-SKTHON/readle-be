-- 같은 방에서 여러 판(round)을 반복해서 플레이할 수 있도록 round 개념 추가.
-- (기존엔 방 하나 = 게임 한 판이라 재시작 자체가 불가능했음)

ALTER TABLE game_rooms
    ADD COLUMN current_round INT NOT NULL DEFAULT 0;

-- 이미 시작됐던(=라운드 개념 생기기 전에 game_room_questions/answers 가 round=1로 채워질) 방은
-- current_round 도 0이 아니라 1로 맞춰야 한다. 안 그러면 재시작 시 "1판째"를 다시 만들려다
-- 이미 있는 round=1 배정과 유일성 제약이 충돌한다.
UPDATE game_rooms SET current_round = 1 WHERE started_at IS NOT NULL;

ALTER TABLE game_room_questions
    ADD COLUMN round INT NOT NULL DEFAULT 1;

ALTER TABLE game_room_questions
    DROP CONSTRAINT uq_game_room_questions_room_order,
    ADD CONSTRAINT uq_game_room_questions_room_round_order UNIQUE (room_id, round, display_order);

ALTER TABLE game_room_answers
    ADD COLUMN round INT NOT NULL DEFAULT 1;

ALTER TABLE game_room_answers
    DROP CONSTRAINT game_room_answers_room_id_question_id_user_id_key,
    ADD CONSTRAINT uq_game_room_answers_room_round_question_user UNIQUE (room_id, round, question_id, user_id);
