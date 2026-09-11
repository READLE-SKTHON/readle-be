package com.readle.readlebackend.domain.review.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "틀린 유형 문제 제출 dto", description = "사용자가 틀린 유형의 문제를 풀고 제출할때 요청 보내는 데이터")
public class ReviewSubmitRequest {

    @Schema(description = "제출한 답. OX: \"O\"/\"X\", 객관식(multiple_choice): 1부터 시작하는 보기 번호(\"1\"~\"4\"), " + "단답형(short_answer): 텍스트 그대로", example = "2")
    @NotBlank(message = "정답은 필수 입력값 입니다.")
    private String selectedAnswer;
}
