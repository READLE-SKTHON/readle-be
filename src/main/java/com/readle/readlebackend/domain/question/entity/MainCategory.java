package com.readle.readlebackend.domain.question.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * {@code main_category_type} Postgres enum 매핑.
 */
public enum MainCategory {
    VOCAB("vocab"),
    INFO_EXTRACTION("info_extraction"),
    CORE_UNDERSTANDING("core_understanding"),
    INFERENCE_JUDGMENT("inference_judgment"),
    STRUCTURE("structure");

    private final String value;

    MainCategory(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static MainCategory fromValue(String value) {
        for (MainCategory category : values()) {
            if (category.value.equals(value)) {
                return category;
            }
        }
        throw new IllegalArgumentException("Unknown main_category_type value: " + value);
    }
}
