-- V23: 능력치(임베딩) 평가 기능 재테스트를 위해 questions/user_answers 데이터를 전체 초기화한다.
-- FK 참조 관계상 자식 테이블부터 순서대로 지운다:
--   game_room_answers, game_room_questions, review_session_question -> questions
--   answer_evaluations -> user_answers
--   user_answers -> questions

DELETE FROM game_room_answers;
DELETE FROM game_room_questions;
DELETE FROM review_session_question;
DELETE FROM answer_evaluations;
DELETE FROM user_answers;
DELETE FROM questions;
