package com.readle.readlebackend.domain.review.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "복습 결과 조회 응답 dto", description = "이 복습 세션에서 실제로 푼 문제 결과 응답 데이터")
public class ReviewResultResponse {

    @Schema(description = "이 세션에서 푼 문제 수 (아직 안 푼 문제는 제외)", example = "5")
    private int totalQuestions;

    @Schema(description = "정답 개수", example = "3")
    private int correctCount;

    @Schema(description = "정답률 (%)", example = "70")
    private int accuracy;
}
