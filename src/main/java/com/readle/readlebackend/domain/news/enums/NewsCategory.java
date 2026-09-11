package com.readle.readlebackend.domain.news.enums;

/**
 * {@code news_category_type} Postgres enum 매핑.
 * 자바 enum 상수 이름을 DB 값과 완전히 동일하게 맞춰서(NAMED_ENUM),
 * 별도의 Converter 없이 Hibernate가 직접 매핑하도록 한다. (room 도메인 Difficulty와 동일한 방식)
 */
public enum NewsCategory {
    전체,
    경제,
    사회,
    세계,
    과학IT,
    생활문화
}
