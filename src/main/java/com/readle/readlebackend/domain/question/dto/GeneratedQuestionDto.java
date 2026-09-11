package com.readle.readlebackend.domain.question.dto;

import java.util.List;

/**
 * Gemini가 생성한 문제 1개를 그대로 담는 DTO.
 * 확인용 응답이므로 아직 Question 엔티티로 변환/저장하지 않는다.
 */
public record GeneratedQuestionDto(
        MainCategory mainCategory,
        SubCategory subCategory,
        QuestionFormat questionFormat,
        String content,
        List<String> choices,
        String answer,
        String explanation,
        String hint
) {
}
