package com.readle.readlebackend.domain.game.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 방 게임 정답 제출 요청. {@code training} 도메인의 {@code SubmitAnswerRequest}와 이름이 겹치면
 * OpenAPI(Swagger) 컴포넌트 스키마가 클래스 simple name 기준으로 등록돼 서로 충돌하기 때문에
 * 이름을 구분했다 (게임 쪽은 근거(reason) 입력이 없다).
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Schema(description = "정답 제출 요청")
public class GameSubmitAnswerRequest {

    @Schema(description = "제출한 답. OX: \"O\"/\"X\", 객관식(multiple_choice): 1부터 시작하는 보기 번호(\"1\"~\"4\"), "
            + "단답형(short_answer): 텍스트 그대로", example = "2")
    @NotBlank
    private String selectedAnswer;
}
