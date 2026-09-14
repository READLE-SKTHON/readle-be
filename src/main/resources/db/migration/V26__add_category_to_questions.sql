-- V27: questions 테이블에 category(뉴스 카테고리) 컬럼을 추가한다.
-- 목적: room에서 특정 카테고리로 문제를 조회할 때, 지금까지는
--   1) newsCategory로 news_articles 조회 -> newsId 목록 확보
--   2) 그 newsId 목록으로 questions 조회
-- 이렇게 news_articles를 매번 거쳐야 했는데, questions에 category를 직접 들고 있으면
-- news_articles 조인 없이 한 번의 조회로 끝낼 수 있어 더 효율적이다.
--
-- 기존에 이미 저장된 문제들(V16/V19/V24/V25/V26 등에서 넣은 목업 데이터 포함)은
-- 전부 news_id로 연결된 news_articles의 category 값을 그대로 복사해서 채운다.
-- (이미 적용된 마이그레이션 파일들은 체크섬 문제 때문에 직접 수정하지 않고,
--  이렇게 실행 시점에 데이터를 백필하는 방식으로 처리한다.)

ALTER TABLE questions ADD COLUMN category news_category_type;

UPDATE questions q
SET category = n.category
FROM news_articles n
WHERE q.news_id = n.news_id;

ALTER TABLE questions ALTER COLUMN category SET NOT NULL;
