package com.readle.readlebackend.domain.question.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * {@code question_format_type} Postgres enum 매핑.
 */
public enum QuestionFormat {
    OX("OX"),
    MULTIPLE_CHOICE("multiple_choice"),
    SHORT_ANSWER("short_answer");

    private final String value;

    QuestionFormat(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static QuestionFormat fromValue(String value) {
        for (QuestionFormat format : values()) {
            if (format.value.equals(value)) {
                return format;
            }
        }
        throw new IllegalArgumentException("Unknown question_format_type value: " + value);
    }
}
