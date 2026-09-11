package com.readle.readlebackend.domain.room.exception;

import com.readle.readlebackend.global.exception.model.BaseErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum RoomErrorCode implements BaseErrorCode {

    ROOM_NOT_FOUND("R001", "방을 찾을 수 없습니다.", HttpStatus.NOT_FOUND),
    ALREADY_JOINED("R002", "이미 참가한 방입니다.", HttpStatus.CONFLICT),
    ROOM_FULL("R003", "방이 가득 찼습니다.", HttpStatus.BAD_REQUEST),
    INVALID_CATEGORY("R004", "유효하지 않은 카테고리입니다.", HttpStatus.BAD_REQUEST),
    ROOM_CODE_GENERATION_FAILED("R005", "방 코드 생성에 실패했습니다. 다시 시도해주세요.", HttpStatus.INTERNAL_SERVER_ERROR),
    NOT_ROOM_PARTICIPANT("R006", "해당 방의 참여자가 아닙니다.", HttpStatus.FORBIDDEN),
    NOT_ROOM_HOST("R007", "방장만 게임을 시작할 수 있습니다.", HttpStatus.FORBIDDEN),
    ROOM_ALREADY_STARTED("R008", "이미 시작된 방입니다.", HttpStatus.CONFLICT),
    INSUFFICIENT_QUESTIONS("R009", "방 설정(카테고리/난이도)에 맞는 문제가 부족합니다.", HttpStatus.BAD_REQUEST),
    ROOM_NOT_STARTED("R010", "아직 시작되지 않은 방입니다.", HttpStatus.BAD_REQUEST),
    QUESTION_ORDER_OUT_OF_RANGE("R011", "존재하지 않는 문제 순서입니다.", HttpStatus.NOT_FOUND),
    ALREADY_ANSWERED("R012", "이미 이 문제에 답을 제출했습니다.", HttpStatus.CONFLICT),
    ANSWER_WINDOW_CLOSED("R013", "지금은 이 문제의 답을 제출할 수 있는 시간이 아닙니다.", HttpStatus.BAD_REQUEST);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
