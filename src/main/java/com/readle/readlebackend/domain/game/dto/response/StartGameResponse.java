package com.readle.readlebackend.domain.game.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
@Schema(description = "게임 시작 / 문제 목록 조회 응답")
public class StartGameResponse {

    @Schema(description = "방 ID", example = "1")
    private Long roomId;

    @Schema(description = "게임 시작 시각")
    private LocalDateTime startedAt;

    @Schema(description = "배정된 문제 목록 (풀이 순서대로 정렬됨)")
    private List<GameQuestionResponse> questions;
}
