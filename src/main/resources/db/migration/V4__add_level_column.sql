-- news_articles / questions에 난이도(level) 컬럼 추가
-- 기존 행이 있을 수 있어 NOT NULL을 만족시키기 위해 DEFAULT 1을 둔다.

ALTER TABLE news_articles
    ADD COLUMN level INT NOT NULL DEFAULT 1;

ALTER TABLE questions
    ADD COLUMN level INT NOT NULL DEFAULT 1;
