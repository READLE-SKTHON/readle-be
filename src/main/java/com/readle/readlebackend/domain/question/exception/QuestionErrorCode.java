package com.readle.readlebackend.domain.question.exception;

import com.readle.readlebackend.global.exception.model.BaseErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum QuestionErrorCode implements BaseErrorCode {

    GEMINI_API_ERROR("Q001", "AI 문제 생성 요청 중 오류가 발생했습니다.", HttpStatus.BAD_GATEWAY),
    GEMINI_RESPONSE_PARSE_ERROR("Q002", "AI 응답을 문제 형식으로 변환하는 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR),
    NO_ARTICLE_TO_GENERATE("Q003", "문제를 생성할 새로운 기사가 없습니다.", HttpStatus.NOT_FOUND);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
