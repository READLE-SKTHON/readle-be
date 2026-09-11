-- 박예지(user_id=4)를 4레벨로 변경. xp도 4레벨 구간(1400~2399, User.calculateLevel 기준)에 맞춘다.
UPDATE users
SET level = 4, xp = 1500
WHERE user_id = 4;
