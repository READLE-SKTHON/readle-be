package com.readle.readlebackend.domain.question.entity;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class MainCategoryConverter implements AttributeConverter<MainCategory, String> {

    @Override
    public String convertToDatabaseColumn(MainCategory attribute) {
        return attribute == null ? null : attribute.getValue();
    }

    @Override
    public MainCategory convertToEntityAttribute(String dbData) {
        return dbData == null ? null : MainCategory.fromValue(dbData);
    }
}
