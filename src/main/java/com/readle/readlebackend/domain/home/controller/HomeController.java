package com.readle.readlebackend.domain.home.controller;

import com.readle.readlebackend.domain.home.dto.response.HomeResponse;
import com.readle.readlebackend.domain.home.service.HomeService;
import com.readle.readlebackend.global.auth.CurrentUser;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/home")
@RequiredArgsConstructor
@Tag(name = "Home", description = "홈 화면 API")
public class HomeController {

    private final HomeService homeService;

    @GetMapping
    @Operation(summary = "홈 화면 조회", description = "닉네임/레벨/경험치/연속 학습일/읽은 뉴스 수/평균 정답률과 "
            + "오늘의 뉴스 1건을 반환합니다.")
    public ResponseEntity<BaseResponse<HomeResponse>> getHome(@CurrentUser Long userId) {
        HomeResponse response = homeService.getHome(userId);
        return ResponseEntity.ok(BaseResponse.success(response));
    }
}
