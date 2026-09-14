package com.readle.readlebackend.domain.auth.controller;

import com.readle.readlebackend.domain.auth.dto.request.LoginByNicknameRequest;
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
 * 로그인 API. 비밀번호 검증 없이 닉네임+학교 이름만 확인한다 (해커톤용 임시 인증).
 * 로그인 성공 후에는 응답으로 받은 userId를 이후 모든 요청의 {@code X-USER-ID} 헤더에 담아 보내면 된다.
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Auth", description = "로그인 API")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login/by-name")
    @Operation(summary = "닉네임+학교 로그인", description = "닉네임과 학교 이름이 일치하는 유저인지 확인하고 프로필을 반환합니다. "
            + "학교 이름은 \"서경대\"/\"서경대학교\", \"OO고\"/\"OO고등학교\" 처럼 줄인 표기와 정식 표기를 구분하지 않습니다. "
            + "비밀번호는 검증하지 않습니다. 이후 요청부터는 응답의 userId를 X-USER-ID 헤더에 담아 보내면 됩니다.")
    public ResponseEntity<BaseResponse<LoginResponse>> loginByNickname(
            @Valid @RequestBody LoginByNicknameRequest request) {
        LoginResponse response = authService.loginByNickname(request.getNickname(), request.getSchoolName());
        return ResponseEntity.ok(BaseResponse.success("로그인되었습니다.", response));
    }

    // 임시 로그아웃 api
    @PostMapping("/logout")
    @Operation(summary = "로그아웃", description = "해커톤용 임시 인증이라 서버에 별도로 무효화할 토큰/세션이 없습니다. "
            + "실제 로그아웃 처리는 클라이언트가 저장해둔 userId(X-USER-ID)를 삭제하는 것으로 이루어지며, "
            + "이 API는 프론트엔드의 일관된 인증 흐름을 위한 형식적인 엔드포인트입니다.")
    public ResponseEntity<BaseResponse<Void>> logout() {
        return ResponseEntity.ok(BaseResponse.success("로그아웃되었습니다.", null));
    }
}
