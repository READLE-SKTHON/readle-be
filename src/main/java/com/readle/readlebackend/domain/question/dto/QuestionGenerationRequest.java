package com.readle.readlebackend.domain.question.dto;

import jakarta.validation.constraints.NotBlank;

/**
 * 문제 생성 미리보기 요청 DTO.
 * 난이도(level)와 게임 모드는 더 이상 입력받지 않는다 — AI가 기사를 보고 직접 판단/생성한다.
 */
public record QuestionGenerationRequest(
        @NotBlank String articleTitle,
        @NotBlank String articleContent
) {
}
