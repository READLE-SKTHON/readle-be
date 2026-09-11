package com.readle.readlebackend.domain.user.exception;

import com.readle.readlebackend.global.exception.model.BaseErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum UserErrorCode implements BaseErrorCode {

    NO_SCHOOL_ASSIGNED("U001", "소속된 학교가 없습니다.", HttpStatus.BAD_REQUEST),
    USER_NOT_FOUND("U002", "존재하지 않는 유저입니다.", HttpStatus.NOT_FOUND);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
