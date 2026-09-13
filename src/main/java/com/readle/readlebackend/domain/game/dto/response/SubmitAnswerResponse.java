package com.readle.readlebackend.domain.game.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Schema(description = "정답 제출 응답 (채점 결과는 공개하지 않음 — 타이머 종료 후 /status 에서 확인)")
public class SubmitAnswerResponse {

    @Schema(description = "문제 ID", example = "1")
    private Long questionId;

    @Schema(description = "제출 성공 여부", example = "true")
    private Boolean submitted;
}
