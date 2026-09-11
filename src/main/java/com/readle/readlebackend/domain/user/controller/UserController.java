package com.readle.readlebackend.domain.user.controller;

import com.readle.readlebackend.domain.user.dto.response.AllRankingResponse;
import com.readle.readlebackend.domain.user.dto.response.SchoolRankingResponse;
import com.readle.readlebackend.domain.user.service.UserService;
import com.readle.readlebackend.global.auth.CurrentUser;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
@Tag(name = "Ranking", description = "랭킹 관련 API")
public class UserController {

    private final UserService userService;

    // 전체 사용자 랭킹 조회
    @Operation(summary = "전체 랭킹 조회 API", description = "상위 7명 + (7등 밖이면) 내 순위를 조회하는 API")
    @GetMapping("/ranking/all")
    public ResponseEntity<BaseResponse<AllRankingResponse>> getAllRanking(
            @CurrentUser Long userId) {

        // service 호출
        AllRankingResponse response = userService.getAllRanking(userId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "전체 랭킹 조회 성공", response));
    }

    // 학교별 랭킹 조회
    @Operation(summary = "학교별 랭킹 조회 API", description = "소속 학생 xp 평균 기준 상위 7개교 + 내 학교 순위를 조회하는 API")
    @GetMapping("/ranking/school")
    public ResponseEntity<BaseResponse<SchoolRankingResponse>> getSchoolRanking(
            @CurrentUser Long userId) {

        // service 호출
        SchoolRankingResponse response = userService.getSchoolRanking(userId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "학교별 랭킹 조회 성공", response));
    }
}
