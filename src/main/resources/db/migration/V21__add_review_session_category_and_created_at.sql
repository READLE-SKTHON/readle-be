-- 복습 세션에 유형(대분류)과 BaseTimeEntity(created_at/updated_at) 컬럼 추가
ALTER TABLE review_sessions
    ADD COLUMN main_category main_category_type NOT NULL,
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT now(),
    ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT now();

-- 복습 세션-문제 연결 테이블에 BaseTimeEntity(created_at/updated_at) +
-- 이 세션 안에서의 정답 여부(is_correct, 안 풀었으면 NULL) 컬럼 추가
ALTER TABLE review_session_question
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT now(),
    ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT now(),
    ADD COLUMN is_correct BOOLEAN;