package com.readle.readlebackend.domain.auth.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Schema(description = "닉네임+학교 로그인 요청")
public class LoginByNicknameRequest {

    @Schema(description = "닉네임", example = "김환희")
    @NotBlank
    private String nickname;

    @Schema(description = "학교 이름. \"서경대\", \"서경대학교\" 처럼 줄인 표기/정식 표기 아무거나 입력해도 된다.",
            example = "서경대")
    @NotBlank
    private String schoolName;
}
