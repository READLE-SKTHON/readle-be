-- ===== [INSERT] 기사 기반 문제 데이터 생성 =====
-- 기사 제목: 투쟁기금 단숨에 1.5억 모았다…'공룡 경찰' 3대 모임 해부

DROP TABLE IF EXISTS daily_representative_article;

CREATE TABLE daily_representative_article (
    rep_date    DATE      NOT NULL,
    level       INTEGER   NOT NULL,
    article_id  BIGINT    NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (rep_date, level),
    CONSTRAINT chk_level CHECK (level BETWEEN 1 AND 5),
    CONSTRAINT fk_daily_rep_article
    FOREIGN KEY (article_id) REFERENCES news_articles(news_id)
);