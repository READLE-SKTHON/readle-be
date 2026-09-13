package com.readle.readlebackend.domain.training.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "능력치 결과 응답 dto", description = "유저의 능력치(문자해독/내용이해/맥락파악/추론/비판적사고) 카테고리별 누적 평균 점수")
public class SkillResultResponse {

    @Schema(description = "능력치 카테고리별 누적 평균 점수 목록")
    private List<SkillResultDto> skillResults;
}
