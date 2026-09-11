-- V23: 능력치(임베딩) 평가 기능 재테스트를 위해 user_id=4(박예지)의 "오늘" 제출 데이터를 초기화한다.
-- answer_evaluations가 user_answers를 참조하므로(FK) 자식(answer_evaluations)부터 지운다.

DELETE FROM answer_evaluations
WHERE user_id = 4
  AND user_answer_id IN (
      SELECT user_answer_id FROM user_answers
      WHERE user_id = 4
        AND created_at::date = CURRENT_DATE
  );

DELETE FROM user_answers
WHERE user_id = 4
  AND created_at::date = CURRENT_DATE;

DELETE FROM user_answers;
DELETE FROM questions;
