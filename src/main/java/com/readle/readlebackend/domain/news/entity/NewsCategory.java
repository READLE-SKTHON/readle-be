package com.readle.readlebackend.domain.news.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * {@code news_category_type} Postgres enum 매핑.
 * Jackson 직렬화/역직렬화도 DB 값(value) 기준으로 동작하도록 @JsonValue/@JsonCreator를 붙인다.
 */
public enum NewsCategory {
    ALL("전체"),
    POLITICS("정치"),
    SOCIETY("사회"),
    WORLD("세계"),
    SCIENCE_IT("과학IT"),
    CULTURE_LIFE("생활문화");

    private final String value;

    NewsCategory(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static NewsCategory fromValue(String value) {
        for (NewsCategory category : values()) {
            if (category.value.equals(value)) {
                return category;
            }
        }
        throw new IllegalArgumentException("Unknown news_category_type value: " + value);
    }
}
