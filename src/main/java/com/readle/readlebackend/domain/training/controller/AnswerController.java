package com.readle.readlebackend.domain.training.controller;

import com.readle.readlebackend.domain.training.dto.request.SubmitAnswerRequest;
import com.readle.readlebackend.domain.training.dto.response.AnswerResultResponse;
import com.readle.readlebackend.domain.training.dto.response.SubmitAnswerResponse;
import com.readle.readlebackend.domain.training.dto.response.TodayQuestionsResponse;

import com.readle.readlebackend.domain.training.service.AnswerService;
import com.readle.readlebackend.global.auth.CurrentUser;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    // 답안 제출
    @Operation(summary = "답안 제출", description = "문제 하나에 대한 답안을 제출하고 채점 결과를 받는 API")
    @PostMapping("/training/questions/{question-id}/submit")
    public ResponseEntity<BaseResponse<SubmitAnswerResponse>> submitAnswer(
            @CurrentUser Long userId,
            @PathVariable("question-id") Long questionId,
            @Valid @RequestBody SubmitAnswerRequest request) {

        // service 호출
        SubmitAnswerResponse response = answerService.submitAnswer(request, userId, questionId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "답안 제출 성공", response));
    }

    // 오늘 문제풀이 최종 결과 조회
    @Operation(summary = "오늘 문제풀이 최종 결과 조회", description = "오늘 제출한 문제들을 집계하고, xp/레벨/연속학습일을 갱신하는 API")
    @GetMapping("/training/result/today")
    public ResponseEntity<BaseResponse<AnswerResultResponse>> getAnswerResult(
            @CurrentUser Long userId) {

        // service 호출
        AnswerResultResponse response = answerService.getAnswerResult(userId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "오늘 문제풀이 결과 조회 성공", response));
    }
}
