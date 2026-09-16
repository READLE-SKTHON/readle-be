package com.readle.readlebackend.domain.user.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "닉네임 친구 검색 응답 dto", description = "닉네임으로 정확히 일치하는 유저 1명 검색")
public class FriendSearchResponse {

    @Schema(description = "검색된 유저 id", example = "1")
    private Long userId;

    @Schema(description = "닉네임", example = "김정모")
    private String nickname;

    @Schema(description = "레벨", example = "3")
    private Long level;

    @Schema(description = "이미 친구인지 여부 (친구면 true, 친구가 아니면 false)", example = "false")
    private boolean isAlreadyFriend;
}
