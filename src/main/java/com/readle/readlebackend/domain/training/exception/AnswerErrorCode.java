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
    QUESTION_NOT_FOUND("AN004", "문제가 존재하지 않습니다.", HttpStatus.NOT_FOUND),
    FEEDBACK_PARSE_ERROR("AN005", "AI 피드백 응답을 처리하는 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR),
    QUESTION_NOT_FOUND("AN006", "문제가 존재하지 않습니다.", HttpStatus.NOT_FOUND),
    TODAY_NOT_COMPLETED("AN007", "아직 오늘 문제를 다 풀지 않았습니다.", HttpStatus.BAD_REQUEST);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
