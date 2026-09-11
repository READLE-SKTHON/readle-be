package com.readle.readlebackend.domain.review.enums;

import io.swagger.v3.oas.annotations.media.Schema;

public enum ReviewMode {

    @Schema(description = "다시 푸는 문제")
    RECALL,

    @Schema(description = "같은 유형 연습 문제")
    PRACTICE
}
