package com.readle.readlebackend.domain.room.dto.response;

import com.readle.readlebackend.domain.room.entity.GameRoom;
import com.readle.readlebackend.domain.room.enums.Category;
import com.readle.readlebackend.domain.room.enums.Difficulty;
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
@Schema(description = "방 생성 응답")
public class CreateRoomResponse {

    @Schema(description = "방 ID", example = "1")
    private Long roomId;

    @Schema(description = "방 코드 (초대용)", example = "4829")
    private Long roomCode;

    @Schema(description = "초대 링크", example = "https://readle-fe.vercel.app/rooms/join/4829")
    private String inviteLink;

    @Schema(description = "카테고리", example = "경제")
    private Category category;

    @Schema(description = "난이도", example = "중")
    private Difficulty difficulty;

    @Schema(description = "제한 시간(초)", example = "30")
    private Integer timer;

    @Schema(description = "최대 인원", example = "4")
    private Integer memberCount;

    @Schema(description = "문제 수", example = "5")
    private Integer questionCount;

    public static CreateRoomResponse from(GameRoom room) {
        return CreateRoomResponse.builder()
                .roomId(room.getId())
                .roomCode(room.getRoomCode())
                .inviteLink(room.getInviteLink())
                .category(room.getCategory())
                .difficulty(room.getDifficulty())
                .timer(room.getTimer())
                .memberCount(room.getMemberCount())
                .questionCount(room.getQuestionCount())
                .build();
    }
}
