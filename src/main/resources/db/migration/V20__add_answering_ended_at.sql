-- 참가자 전원이 답을 제출하면 타이머가 남아있어도 즉시 정답 공개로 넘어가기 위해,
-- 문제별로 ANSWERING 페이즈가 "실제로 끝난 시각"을 기록한다. null이면 타이머가 끝날 때까지가 정상 길이.
ALTER TABLE game_room_questions ADD COLUMN answering_ended_at TIMESTAMP(6) NULL;
