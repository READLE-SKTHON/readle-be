-- questions.answer 가 VARCHAR(100) 라 AI가 생성한 긴 답(특히 short_answer 형식)이 저장 안 되는 문제 수정.
-- content/explanation/hint 와 동일하게 TEXT 로 변경.
ALTER TABLE questions
    ALTER COLUMN answer TYPE TEXT;
