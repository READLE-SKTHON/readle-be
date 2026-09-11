-- game_mode_type에서 category_practice 값을 제거하고 daily_solo, room 두 가지만 남긴다.
-- Postgres는 enum 값을 직접 DROP할 수 없으므로 타입을 새로 만들어 교체한다.
-- 기존에 category_practice로 저장돼 있던 문제는 room(게임용 문제)으로 통합한다.

UPDATE questions
SET game_mode = 'room'
WHERE game_mode = 'category_practice';

ALTER TYPE game_mode_type RENAME TO game_mode_type_old;

CREATE TYPE game_mode_type AS ENUM ('daily_solo', 'room');

ALTER TABLE questions
    ALTER COLUMN game_mode TYPE game_mode_type
    USING game_mode::text::game_mode_type;

DROP TYPE game_mode_type_old;
