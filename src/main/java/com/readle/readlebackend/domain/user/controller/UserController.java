package com.readle.readlebackend.domain.user.controller;

import com.readle.readlebackend.domain.user.dto.request.AddFriendRequest;
import com.readle.readlebackend.domain.user.dto.response.*;
import com.readle.readlebackend.domain.user.service.UserService;
import com.readle.readlebackend.global.auth.CurrentUser;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
@Tag(name = "User", description = "사용자 관련 API")
public class UserController {

    private final UserService userService;

    // 닉네임으로 친구 검색
    @Operation(summary = "닉네임 친구 검색 API", description = "닉네임을 검색하는 API")
    @GetMapping("/friends/search")
    public ResponseEntity<BaseResponse<FriendSearchResponse>> searchFriend(
            @CurrentUser Long userId,
            @RequestParam String nickname) {

        // service 호출
        FriendSearchResponse response = userService.searchFriends(userId, nickname);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "닉네임 친구 검색 성공", response));
    }

    // 친구 추가
    @Operation(summary = "친구 추가 API", description = "닉네임으로 친구 추가하는 API")
    @PostMapping("/friends")
    public ResponseEntity<BaseResponse<AddFriendResponse>> addFriend(
            @CurrentUser Long userId,
            @Valid @RequestBody AddFriendRequest request) {

        // service 호출
        AddFriendResponse response = userService.addFriend(userId, request);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.CREATED).body(BaseResponse.success(201, "친구 추가 성공", response));
    }

    // 친구 목록 조회
    @Operation(summary = "친구 목록 조회 API", description = "내가 추가한 친구 목록을 조회하는 API")
    @GetMapping("/friends")
    public ResponseEntity<BaseResponse<List<FriendListResponse>>> getFriendList(
            @CurrentUser Long userId) {

        // service 호출
        List<FriendListResponse> response = userService.getFriendList(userId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "친구 목록 조회 성공", response));
    }
}
