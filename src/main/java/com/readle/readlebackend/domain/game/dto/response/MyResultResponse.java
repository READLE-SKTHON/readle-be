package com.readle.readlebackend.domain.game.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Schema(description = "내 이번 문제 결과 (REVEAL 페이즈에서만 제공)")
public class MyResultResponse {

    @Schema(description = "정답 여부 (미제출이면 false)", example = "true")
    private Boolean isCorrect;

    @Schema(description = "이번 문제에서 획득한 점수", example = "50")
    private Integer score;

    @Schema(description = "정답", example = "O")
    private String correctAnswer;

    @Schema(description = "정답 근거 설명 (한두 줄)", example = "문단에서 '문해력 향상을 위한 정부의 노력'이 핵심 소재로 제시되고 있습니다.")
    private String explanation;
}
