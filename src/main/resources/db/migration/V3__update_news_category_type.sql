-- 카테고리 값 변경: 정치 -> 경제
ALTER TYPE news_category_type RENAME VALUE '정치' TO '경제';

-- 방 난이도 타입 및 컬럼 추가
CREATE TYPE room_difficulty_type AS ENUM ('상', '중', '하', '랜덤');

ALTER TABLE game_rooms
    ADD COLUMN difficulty room_difficulty_type NOT NULL DEFAULT '중';
