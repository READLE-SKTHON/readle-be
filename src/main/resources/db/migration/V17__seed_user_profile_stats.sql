-- 시드 유저 4명의 기본 정보(레벨/경험치/연속 학습일/정답률/읽은 뉴스 수 등) 채우기.
-- school_id(V14)는 이미 채워져 있어 그대로 두고, level/xp는 V12에서 채운 값을
-- "2레벨 2명 + 3레벨 2명" 구성으로 덮어쓴다. 홈 화면 API(GET /api/home) 등에서
-- 바로 확인할 수 있도록 데모용 값으로 넣는다.

UPDATE users
SET level = 2, xp = 300, current_streak = 5, answer_rate = 80, news_read_count = 12, last_activity_date = CURRENT_DATE
WHERE user_id = 1; -- 김환희

UPDATE users
SET level = 2, xp = 450, current_streak = 2, answer_rate = 65, news_read_count = 6, last_activity_date = CURRENT_DATE
WHERE user_id = 2; -- 장서후

UPDATE users
SET level = 3, xp = 700, current_streak = 8, answer_rate = 90, news_read_count = 20, last_activity_date = CURRENT_DATE
WHERE user_id = 3; -- 김정모

UPDATE users
SET level = 3, xp = 900, current_streak = 1, answer_rate = 50, news_read_count = 3, last_activity_date = CURRENT_DATE - INTERVAL '1 day'
WHERE user_id = 4; -- 박예지 (어제까지만 학습, 오늘은 아직 활동 안 한 상태로 세팅)
