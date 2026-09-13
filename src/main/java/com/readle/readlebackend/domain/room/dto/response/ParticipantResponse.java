package com.readle.readlebackend.domain.room.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Schema(description = "참여자 정보")
public class ParticipantResponse {

    @Schema(description = "유저 ID", example = "1")
    private Long userId;

    @Schema(description = "닉네임", example = "지우")
    private String nickname;

    @Schema(description = "방장 여부", example = "true")
    private Boolean isHost;
}
