package com.readle.readlebackend.domain.auth.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Schema(description = "로그인 응답")
public class LoginResponse {

    @Schema(description = "유저 ID. 이후 요청부터는 이 값을 X-USER-ID 헤더에 담아 보내면 됨", example = "1")
    private Long userId;

    @Schema(description = "닉네임", example = "김환희")
    private String nickname;

    @Schema(description = "학교 ID (없으면 null)", example = "1")
    private Long schoolId;

    @Schema(description = "학교 이름 (없으면 null)", example = "서경대학교")
    private String schoolName;
}
