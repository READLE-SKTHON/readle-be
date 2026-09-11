package com.readle.readlebackend.domain.training.controller;

import com.readle.readlebackend.domain.training.dto.response.TodayQuestionsResponse;
import com.readle.readlebackend.domain.training.service.AnswerService;
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
@Tag(name = "Training", description = "문제(개인 퀴즈) 풀이 관련 API")
public class AnswerController {

    private final AnswerService answerService;

    // 오늘의 기사 및 문제 조회
    @Operation(summary = "오늘의 문제 조회", description = "사용자가 기사와 문제를 조회하는 API")
    @GetMapping("/training/today")
    public ResponseEntity<BaseResponse<TodayQuestionsResponse>> getTodayQuestions(
            @CurrentUser Long userId) {

        // service 호출
        TodayQuestionsResponse response = answerService.getTodayQuestions(userId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "오늘의 문제 조회 성공", response));
    }
}
