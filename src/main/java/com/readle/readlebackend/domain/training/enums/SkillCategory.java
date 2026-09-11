package com.readle.readlebackend.domain.training.enums;

import io.swagger.v3.oas.annotations.media.Schema;

public enum SkillCategory {

    @Schema(description = "어휘력")
    vocab,

    @Schema(description = "독해력")
    reading,

    @Schema(description = "추론력")
    inference,

    @Schema(description = "비판적 사고력")
    critical_thinking,

    @Schema(description = "표현력")
    expression
}
