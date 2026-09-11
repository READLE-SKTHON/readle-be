package com.readle.readlebackend.domain.training.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "답안 제출 요청 dto", description = "문제 하나에 대한 답안 제출")
public class SubmitAnswerRequest {

    @Schema(description = "선택/작성한 답. OX는 O 또는 X, 객관식은 선택지 텍스트, short_answer는 직접 입력 텍스트", example = "O")
    @NotBlank(message = "답안은 필수 입력값 입니다.")
    private String selectedAnswer;

    @Schema(description = "근거 (OX, short_answer 문제일 때 필수 / 객관식은 불필요)", example = "지난달 물가가 실제로 3.6% 올랐다고 기사에 나와있다.")
    private String reason;
}
