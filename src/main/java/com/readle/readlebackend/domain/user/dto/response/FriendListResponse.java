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
@Schema(title = "친구 목록 항목 dto", description = "친구 목록 조회할떄 서버에서 응답하는 데이터")
public class FriendListResponse {

    @Schema(description = "유저 id", example = "1")
    private Long userId;

    @Schema(description = "닉네임", example = "김정모")
    private String nickname;

    @Schema(description = "레벨", example = "3")
    private Long level;
}
