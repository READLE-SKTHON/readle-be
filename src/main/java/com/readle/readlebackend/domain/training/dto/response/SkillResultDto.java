package com.readle.readlebackend.domain.training.dto.response;

import com.readle.readlebackend.domain.training.enums.SkillCategory;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "능력치 카테고리별 누적 평균 점수")
public class SkillResultDto {

    @Schema(description = "능력치 카테고리 (문자해독/내용이해/맥락파악/추론/비판적사고)", example = "추론")
    private SkillCategory skillCategory;

    @Schema(description = "해당 카테고리의 전체 누적 평균 점수(0~100)", example = "76")
    private int averageScore;
}
