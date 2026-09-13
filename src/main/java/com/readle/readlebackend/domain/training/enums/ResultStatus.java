package com.readle.readlebackend.domain.training.enums;

import io.swagger.v3.oas.annotations.media.Schema;

public enum ResultStatus {

    @Schema(description = "정답")
    correct,

    @Schema(description = "오답")
    incorrect,

    @Schema(description = "근거 부족")
    insufficient_reasoning
}
