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
@Schema(title = "친구 추가 응답 dto", description = "사용자가 친구 추가를 하고 서버에서 응답하는 데이터")
public class AddFriendResponse {

    @Schema(description = "추가된 친구의 유저 id", example = "3")
    private Long userId;

    @Schema(description = "추가된 친구의 닉네임", example = "김정모")
    private String nickname;
}
