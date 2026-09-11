package com.readle.readlebackend.domain.question.entity;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class QuestionFormatConverter implements AttributeConverter<QuestionFormat, String> {

    @Override
    public String convertToDatabaseColumn(QuestionFormat attribute) {
        return attribute == null ? null : attribute.getValue();
    }

    @Override
    public QuestionFormat convertToEntityAttribute(String dbData) {
        return dbData == null ? null : QuestionFormat.fromValue(dbData);
    }
}
