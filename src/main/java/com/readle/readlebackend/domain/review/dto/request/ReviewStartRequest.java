package com.readle.readlebackend.domain.review.dto.request;

import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.question.enums.SubCategory;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "틀린 유형 문제 풀기 시작 요청 dto", description = "사용자가 틀린 유형의 문제를 풀때 시작하는 요청 데이터")
public class ReviewStartRequest {

    @NotNull
    @Schema(description = "복습할 문제의 대분류", example = "vocab")
    private MainCategory mainCategory;

    @NotNull
    @Schema(description = "복습할 문제의 소분류", example = "vocab_appropriateness")
    private SubCategory subCategory;

    @NotNull
    @Schema(description = "복습할 오답의 날짜 (날짜/소분류 목록 화면에서 고른 값)", example = "2026-09-28")
    private LocalDate date;
}
