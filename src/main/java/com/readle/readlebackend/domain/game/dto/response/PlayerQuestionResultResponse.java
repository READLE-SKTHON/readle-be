package com.readle.readlebackend.domain.game.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Schema(description = "REVEAL 페이즈에서 참여자별 이번 문제 결과 (전원 공개)")
public class PlayerQuestionResultResponse {

    @Schema(description = "유저 ID", example = "1")
    private Long userId;

    @Schema(description = "닉네임", example = "지우")
    private String nickname;

    @Schema(description = "정답 여부 (미제출이면 false)", example = "true")
    private Boolean isCorrect;

    @Schema(description = "이번 문제에서 획득한 점수", example = "50")
    private Integer score;
}
