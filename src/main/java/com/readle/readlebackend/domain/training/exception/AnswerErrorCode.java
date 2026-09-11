package com.readle.readlebackend.domain.training.exception;

import com.readle.readlebackend.global.exception.model.BaseErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum AnswerErrorCode implements BaseErrorCode {

    TODAY_QUESTIONS_NOT_FOUND("AN001", "오늘의 문제가 아직 준비되지 않았습니다.", HttpStatus.NOT_FOUND),
    TODAY_ALREADY_COMPLETED("AN002", "오늘 문제풀이를 이미 완료했습니다.", HttpStatus.CONFLICT),
    REASON_REQUIRED("AN003", "이 문제는 근거 작성이 필요합니다.", HttpStatus.BAD_REQUEST),
    QUESTION_NOT_FOUND("AN004", "문제가 존재하지 않습니다.", HttpStatus.NOT_FOUND);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
