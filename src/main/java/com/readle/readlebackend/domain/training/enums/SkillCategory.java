package com.readle.readlebackend.domain.training.enums;

import io.swagger.v3.oas.annotations.media.Schema;

public enum SkillCategory {

    @Schema(description = "문자 해독")
    문자해독,

    @Schema(description = "내용 이해")
    내용이해,

    @Schema(description = "맥락 파악")
    맥락파악,

    @Schema(description = "추론")
    추론,

    @Schema(description = "비판적 사고")
    비판적사고
}
