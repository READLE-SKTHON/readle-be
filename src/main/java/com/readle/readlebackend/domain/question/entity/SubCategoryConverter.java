package com.readle.readlebackend.domain.question.entity;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class SubCategoryConverter implements AttributeConverter<SubCategory, String> {

    @Override
    public String convertToDatabaseColumn(SubCategory attribute) {
        return attribute == null ? null : attribute.getValue();
    }

    @Override
    public SubCategory convertToEntityAttribute(String dbData) {
        return dbData == null ? null : SubCategory.fromValue(dbData);
    }
}
