package com.readle.readlebackend.domain.room.controller;

import com.readle.readlebackend.domain.room.dto.request.CreateRoomRequest;
import com.readle.readlebackend.domain.room.dto.response.CreateRoomResponse;
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

    @PostMapping("/{roomId}/join")
    @Operation(summary = "방 참가(코드용)", description = "방 코드로 게임 방에 참가합니다.")
    public ResponseEntity<BaseResponse<Void>> joinRoom(
            @CurrentUser Long userId,
            @PathVariable Long roomId
    ) {
        roomService.joinRoom(userId, roomId);
        return ResponseEntity.ok(BaseResponse.success("방에 참가했습니다.", null));
    }
}
