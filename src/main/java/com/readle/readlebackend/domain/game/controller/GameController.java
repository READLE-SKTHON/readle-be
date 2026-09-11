package com.readle.readlebackend.domain.game.controller;

import com.readle.readlebackend.domain.game.dto.response.GameQuestionResponse;
import com.readle.readlebackend.domain.game.dto.response.StartGameResponse;
import com.readle.readlebackend.domain.room.service.RoomService;
import com.readle.readlebackend.global.auth.CurrentUser;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 게임 진행(시작/문제 조회) API. 방 생성/참가/대기실 관련은 {@code /api/rooms} ({@code RoomController}) 참고.
 *
 * <p>로직 자체는 아직 {@code RoomService} 에 있다 — 방(GameRoom) 상태를 그대로 다루기 때문.
 * 정답 제출/채점처럼 게임 전용 로직이 늘어나면 그때 서비스/엔티티도 이 패키지로 옮길 것.
 */
@RestController
@RequestMapping("/api/game")
@RequiredArgsConstructor
@Tag(name = "Game", description = "게임 진행 API")
public class GameController {

    private final RoomService roomService;

    @PostMapping("/{gameRoomId}/start")
    @Operation(summary = "게임 시작", description = "방장이 게임을 시작합니다. 방 설정(카테고리/난이도/문제 수)에 맞는 문제를 랜덤으로 배정합니다.")
    public ResponseEntity<BaseResponse<StartGameResponse>> startGame(
            @CurrentUser Long userId,
            @PathVariable Long gameRoomId
    ) {
        StartGameResponse response = roomService.startGame(userId, gameRoomId);
        return ResponseEntity.ok(BaseResponse.success("게임이 시작되었습니다.", response));
    }

    @GetMapping("/{gameRoomId}/questions/{order}")
    @Operation(summary = "문제 조회 (테스트용)", description = "지정한 순서(order, 0부터 시작)의 문제를 조회합니다. (정답/해설/힌트 제외) "
            + "실제 게임 진행 중에는 이 API 대신 상태 폴링 API(/status, 예정)가 문제 내용까지 함께 반환할 예정이며, 이 API는 개별 확인/디버깅용입니다.")
    public ResponseEntity<BaseResponse<GameQuestionResponse>> getQuestion(
            @CurrentUser Long userId,
            @PathVariable Long gameRoomId,
            @PathVariable Integer order
    ) {
        GameQuestionResponse response = roomService.getQuestion(userId, gameRoomId, order);
        return ResponseEntity.ok(BaseResponse.success(response));
    }
}
