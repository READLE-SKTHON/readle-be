package com.readle.readlebackend.domain.review.controller;

import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.review.dto.request.ReviewStartRequest;
import com.readle.readlebackend.domain.review.dto.request.ReviewSubmitRequest;
import com.readle.readlebackend.domain.review.dto.response.ReviewCategoriesResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewGroupsResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewResultResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewStartResponse;
import com.readle.readlebackend.domain.review.dto.response.ReviewSubmitResponse;
import com.readle.readlebackend.domain.review.service.ReviewService;
import com.readle.readlebackend.global.auth.CurrentUser;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
@Tag(name = "Review", description = "복습 관련 API")
public class ReviewController {

    private final ReviewService reviewService;

    // 유형별 틀린 문제 목록
    @Operation(summary = "유형별 틀린 문제 목록 API", description = "5개 유형을 항상 전부 반환하고, 유형별 틀린 문제 개수를 함께 내려주는 API")
    @GetMapping("/review/categories")
    public ResponseEntity<BaseResponse<ReviewCategoriesResponse>> getCategories(
            @CurrentUser Long userId) {

        // service 호출
        ReviewCategoriesResponse response = reviewService.getCategories(userId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "유형별 틀린 문제 목록 조회 성공", response));
    }

    // 대분류 안에서 날짜/소분류별 틀린 문제 목록
    @Operation(summary = "날짜/소분류별 틀린 문제 목록 API", description = "선택한 대분류 안에서, 현재 틀린 문제가 있는 (날짜, 소분류) 조합만 반환하는 API")
    @GetMapping("/review/{mainCategory}/groups")
    public ResponseEntity<BaseResponse<ReviewGroupsResponse>> getGroups(
            @CurrentUser Long userId,
            @PathVariable MainCategory mainCategory) {

        // service 호출
        ReviewGroupsResponse response = reviewService.getGroups(userId, mainCategory);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "날짜/소분류별 틀린 문제 목록 조회 성공", response));
    }

    // 복습 문제 시작
    @Operation(summary = "복습 문제 시작 API", description = "선택한 (대분류, 소분류, 날짜)의 오답 복기 + 같은 소분류 다른 기사 문제를 반환하는 API")
    @PostMapping("/review/start")
    public ResponseEntity<BaseResponse<ReviewStartResponse>> startReview(
            @CurrentUser Long userId,
            @Valid @RequestBody ReviewStartRequest request) {

        // service 호출
        ReviewStartResponse response = reviewService.startReview(userId, request);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.CREATED).body(BaseResponse.success(201, "복습 문제 시작 성공", response));
    }

    // 복습 문제 제출
    @Operation(summary = "복습 문제 제출 API", description = "복습 문제 답안을 제출하고 채점 결과를 반환하는 API (정답이면 +1xp)")
    @PostMapping("/review/{reviewSessionId}/questions/{questionId}/submit")
    public ResponseEntity<BaseResponse<ReviewSubmitResponse>> submitReview(
            @CurrentUser Long userId,
            @PathVariable Long reviewSessionId,
            @PathVariable Long questionId,
            @Valid @RequestBody ReviewSubmitRequest request) {

        // service 호출
        ReviewSubmitResponse response = reviewService.submitReview(userId, reviewSessionId, questionId, request);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.CREATED).body(BaseResponse.success(201, "복습 문제 제출 성공", response));
    }

    // 복습 완료 결과 조회
    @Operation(summary = "복습 완료 결과 조회 API", description = "이 복습 세션에서 실제로 푼 문제 기준 정답률을 반환하는 API")
    @GetMapping("/review/{reviewSessionId}/result")
    public ResponseEntity<BaseResponse<ReviewResultResponse>> getResult(
            @CurrentUser Long userId,
            @PathVariable Long reviewSessionId) {

        // service 호출
        ReviewResultResponse response = reviewService.getResult(userId, reviewSessionId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "복습 완료 결과 조회 성공", response));
    }
}