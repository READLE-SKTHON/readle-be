package com.readle.readlebackend.domain.auth.controller;

import com.readle.readlebackend.domain.auth.dto.request.LoginRequest;
import com.readle.readlebackend.domain.auth.dto.response.LoginResponse;
import com.readle.readlebackend.domain.auth.service.AuthService;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 로그인 API. 비밀번호 검증 없이 userId 존재 여부만 확인한다 (해커톤용 임시 인증).
 * 로그인 성공 후에는 응답으로 받은 userId를 이후 모든 요청의 {@code X-USER-ID} 헤더에 담아 보내면 된다.
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Auth", description = "로그인 API")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    @Operation(summary = "로그인", description = "userId가 존재하는 유저인지 확인하고 프로필(닉네임/학교)을 반환합니다. "
            + "비밀번호는 검증하지 않습니다. 이후 요청부터는 응답의 userId를 X-USER-ID 헤더에 담아 보내면 됩니다.")
    public ResponseEntity<BaseResponse<LoginResponse>> login(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = authService.login(request.getUserId());
        return ResponseEntity.ok(BaseResponse.success("로그인되었습니다.", response));
    }
}
