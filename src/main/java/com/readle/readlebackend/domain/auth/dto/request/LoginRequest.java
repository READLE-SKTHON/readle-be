package com.readle.readlebackend.domain.auth.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
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
@Schema(description = "로그인 요청")
public class LoginRequest {

    @Schema(description = "로그인할 유저 ID (존재 여부만 확인, 비밀번호 검증 없음)", example = "1")
    @NotNull
    private Long userId;
}
