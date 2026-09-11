-- V22: skill_category_type 을 새 5개 카테고리로 재정의
--   기존: vocab / reading / inference / critical_thinking / expression
--   신규: 문자해독 / 내용이해 / 맥락파악 / 추론 / 비판적사고
--        (기존 inference 를 맥락파악·추론 두 개로 나누고, expression은 제외)
-- 임베딩 기반 능력치 평가 방식으로 바뀌면서 카테고리 체계를 새로 정의하므로,
-- 기존 answer_evaluations 데이터(테스트 데이터)는 초기화한다.

DELETE FROM answer_evaluations;

ALTER TABLE answer_evaluations
    ALTER COLUMN skill_category TYPE VARCHAR(20);

DROP TYPE skill_category_type;

CREATE TYPE skill_category_type AS ENUM ('문자해독', '내용이해', '맥락파악', '추론', '비판적사고');

ALTER TABLE answer_evaluations
    ALTER COLUMN skill_category TYPE skill_category_type USING skill_category::skill_category_type;
