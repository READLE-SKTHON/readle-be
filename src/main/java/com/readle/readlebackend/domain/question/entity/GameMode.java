package com.readle.readlebackend.domain.question.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * {@code game_mode_type} Postgres enum 매핑.
 */
public enum GameMode {
    DAILY_SOLO("daily_solo"),
    ROOM("room"),
    CATEGORY_PRACTICE("category_practice");

    private final String value;

    GameMode(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static GameMode fromValue(String value) {
        for (GameMode mode : values()) {
            if (mode.value.equals(value)) {
                return mode;
            }
        }
        throw new IllegalArgumentException("Unknown game_mode_type value: " + value);
    }
}
