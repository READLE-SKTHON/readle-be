package com.readle.readlebackend.domain.training.exception;

import com.readle.readlebackend.global.exception.model.BaseErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum AnswerErrorCode implements BaseErrorCode {

    TODAY_QUESTIONS_NOT_FOUND("A001", "오늘의 문제가 아직 준비되지 않았습니다.", HttpStatus.NOT_FOUND),
    TODAY_ALREADY_COMPLETED("A002", "오늘 문제풀이를 이미 완료했습니다.", HttpStatus.CONFLICT);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
