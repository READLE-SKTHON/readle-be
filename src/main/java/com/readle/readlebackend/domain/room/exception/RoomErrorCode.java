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
    ROOM_CODE_GENERATION_FAILED("R005", "방 코드 생성에 실패했습니다. 다시 시도해주세요.", HttpStatus.INTERNAL_SERVER_ERROR);

    private final String code;
    private final String message;
    private final HttpStatus status;
}
