package com.readle.readlebackend.domain.game.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Schema(description = "순위표 항목")
public class ScoreboardEntryResponse {

    @Schema(description = "순위 (1부터)", example = "1")
    private Integer rank;

    @Schema(description = "유저 ID", example = "1")
    private Long userId;

    @Schema(description = "닉네임", example = "지우")
    private String nickname;

    @Schema(description = "누적 점수", example = "80")
    private Integer totalScore;
}
