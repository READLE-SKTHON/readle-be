package com.readle.readlebackend.global.auth;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * 인증되지 않은 요청에 대해 {@code BaseResponse} 형식의 401 JSON 응답을 내려준다.
 *
 * <p>고정 페이로드라 별도 직렬화 없이 문자열로 작성한다.
 */
@Component
public class
RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request,
                         HttpServletResponse response,
                         AuthenticationException authException) throws IOException {

        response.setStatus(AuthErrorCode.UNAUTHORIZED.getStatus().value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(
                "{\"success\":false,\"code\":\"%s\",\"message\":\"%s\",\"data\":null}"
                        .formatted(
                                AuthErrorCode.UNAUTHORIZED.getCode(),
                                AuthErrorCode.UNAUTHORIZED.getMessage()));
    }
}
