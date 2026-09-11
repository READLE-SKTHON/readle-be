package com.readle.readlebackend.domain.review.exception;

import com.readle.readlebackend.global.exception.model.BaseErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ReviewErrorCode implements BaseErrorCode {

    SESSION_NOT_FOUND("RV001", "복습 세션이 존재하지 않습니다.", HttpStatus.NOT_FOUND),
    QUESTION_NOT_IN_SESSION("RV002", "이 문제는 해당 복습 세션에 속하지 않습니다.", HttpStatus.BAD_REQUEST),
    NO_WRONG_QUESTIONS_FOUND("RV003", "해당 날짜/소분류에 복습할 오답이 없습니다.", HttpStatus.NOT_FOUND);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
