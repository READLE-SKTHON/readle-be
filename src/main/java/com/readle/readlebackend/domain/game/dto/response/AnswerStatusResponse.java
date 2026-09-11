package com.readle.readlebackend.domain.game.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Schema(description = "참여자별 답변 제출 현황 (ANSWERING 페이즈에서만 제공, 정답 여부는 포함 안 함)")
public class AnswerStatusResponse {

    @Schema(description = "유저 ID", example = "1")
    private Long userId;

    @Schema(description = "닉네임", example = "지우")
    private String nickname;

    @Schema(description = "제출 여부", example = "true")
    private Boolean answered;
}
