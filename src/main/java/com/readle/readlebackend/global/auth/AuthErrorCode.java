package com.readle.readlebackend.global.auth;

import com.readle.readlebackend.global.exception.model.BaseErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum AuthErrorCode implements BaseErrorCode {

    UNAUTHORIZED("A001", "인증 정보가 없습니다. X-USER-ID 헤더를 확인해주세요.", HttpStatus.UNAUTHORIZED),
    INVALID_USER_ID("A002", "유효하지 않은 X-USER-ID 값입니다.", HttpStatus.BAD_REQUEST),
    LOGIN_USER_NOT_FOUND("A003", "존재하지 않는 유저입니다.", HttpStatus.NOT_FOUND);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
