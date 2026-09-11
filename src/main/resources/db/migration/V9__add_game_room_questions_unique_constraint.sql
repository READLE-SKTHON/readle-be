-- 동시 게임 시작 요청으로 같은 방/순서에 문제가 중복 배정되는 걸 DB 차원에서도 막는다.
-- (애플리케이션 레벨에서 PESSIMISTIC_WRITE 잠금으로 1차 방지하지만, 이중 안전장치로 추가)
ALTER TABLE game_room_questions
    ADD CONSTRAINT uq_game_room_questions_room_order UNIQUE (room_id, display_order);
