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
@Schema(title = "복습 문제 제출 응답 dto", description = "정답이면 +1xp 지급")
public class ReviewSubmitResponse {

    @Schema(description = "정답 여부", example = "true")
    private boolean isCorrect;

    @Schema(description = "정답", example = "2")
    private String correctAnswer;

    @Schema(description = "정답 근거 설명", example = "문단에서 '문해력 향상을 위한 정부의 노력'이 핵심 소재로 제시되고 있습니다.")
    private String explanation;

    @Schema(description = "이번 제출로 획득한 xp (오답이면 0)", example = "1")
    private int earnedXp;
}
