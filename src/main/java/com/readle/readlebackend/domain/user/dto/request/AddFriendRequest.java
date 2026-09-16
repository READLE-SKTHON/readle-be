package com.readle.readlebackend.domain.user.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class AddFriendRequest {

    @Schema(description = "친구로 추가할 유저의 닉네임", example = "김정모")
    @NotBlank(message = "닉네임은 필수 입력값 입니다.")
    private String nickname;
}
