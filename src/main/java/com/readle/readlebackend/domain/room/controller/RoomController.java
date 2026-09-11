package com.readle.readlebackend.domain.room.controller;

import com.readle.readlebackend.domain.room.dto.request.CreateRoomRequest;
import com.readle.readlebackend.domain.room.dto.response.CreateRoomResponse;
import com.readle.readlebackend.domain.room.dto.response.RoomParticipantsResponse;
import com.readle.readlebackend.domain.room.service.RoomService;
import com.readle.readlebackend.global.auth.CurrentUser;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/rooms")
@RequiredArgsConstructor
@Tag(name = "Room", description = "게임 방 API")
public class RoomController {

    private final RoomService roomService;

    @PostMapping
    @Operation(summary = "방 생성", description = "새로운 게임 방을 생성합니다. 방장은 자동으로 참가자로 등록됩니다.")
    public ResponseEntity<BaseResponse<CreateRoomResponse>> createRoom(
            @CurrentUser Long userId,
            @Valid @RequestBody CreateRoomRequest request
    ) {
        CreateRoomResponse response = roomService.createRoom(userId, request);
        return ResponseEntity.ok(BaseResponse.success("방이 생성되었습니다.", response));
    }

    @PostMapping("/join/{roomCode}")
    @Operation(summary = "방 참가", description = "방 코드(4자리)로 게임 방에 참가합니다.")
    public ResponseEntity<BaseResponse<CreateRoomResponse>> joinRoom(
            @CurrentUser Long userId,
            @PathVariable Long roomCode
    ) {
        CreateRoomResponse response = roomService.joinRoom(userId, roomCode);
        return ResponseEntity.ok(BaseResponse.success("방에 참가했습니다.", response));
    }

    @GetMapping("/{roomId}/participants")
    @Operation(summary = "참여자 목록 조회", description = "대기방 참여자 목록을 조회합니다. 해당 방 참여자만 조회 가능하며, 프론트에서 폴링으로 반복 호출합니다.")
    public ResponseEntity<BaseResponse<RoomParticipantsResponse>> getParticipants(
            @CurrentUser Long userId,
            @PathVariable Long roomId
    ) {
        RoomParticipantsResponse response = roomService.getParticipants(userId, roomId);
        return ResponseEntity.ok(BaseResponse.success(response));
    }
}
