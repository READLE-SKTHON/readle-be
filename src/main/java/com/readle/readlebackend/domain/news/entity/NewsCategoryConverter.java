package com.readle.readlebackend.domain.news.entity;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class NewsCategoryConverter implements AttributeConverter<NewsCategory, String> {

    @Override
    public String convertToDatabaseColumn(NewsCategory attribute) {
        return attribute == null ? null : attribute.getValue();
    }

    @Override
    public NewsCategory convertToEntityAttribute(String dbData) {
        return dbData == null ? null : NewsCategory.fromValue(dbData);
    }
}
