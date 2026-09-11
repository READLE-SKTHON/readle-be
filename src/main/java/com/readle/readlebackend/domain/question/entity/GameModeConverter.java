package com.readle.readlebackend.domain.question.entity;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class GameModeConverter implements AttributeConverter<GameMode, String> {

    @Override
    public String convertToDatabaseColumn(GameMode attribute) {
        return attribute == null ? null : attribute.getValue();
    }

    @Override
    public GameMode convertToEntityAttribute(String dbData) {
        return dbData == null ? null : GameMode.fromValue(dbData);
    }
}
