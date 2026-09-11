package com.readle.readlebackend.domain.game.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Schema(description = "정답 제출 요청")
public class SubmitAnswerRequest {

    @Schema(description = "제출한 답 (OX: O/X, 객관식: 보기 텍스트 그대로, 단답형: 텍스트)", example = "O")
    @NotBlank
    private String selectedAnswer;
}
