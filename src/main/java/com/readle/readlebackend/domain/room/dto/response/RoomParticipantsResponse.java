package com.readle.readlebackend.domain.room.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Schema(description = "대기방 참여자 목록 조회 응답 (폴링용)")
public class RoomParticipantsResponse {

    @Schema(description = "방 ID", example = "1")
    private Long roomId;

    @Schema(description = "현재 인원", example = "2")
    private Integer currentCount;

    @Schema(description = "최대 인원", example = "4")
    private Integer memberCount;

    @Schema(description = "참여자 목록")
    private List<ParticipantResponse> participants;
}
