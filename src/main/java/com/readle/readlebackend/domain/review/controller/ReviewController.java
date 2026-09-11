package com.readle.readlebackend.domain.review.controller;
import com.readle.readlebackend.domain.review.dto.response.ReviewCategoriesResponse;
import com.readle.readlebackend.domain.review.service.ReviewService;
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
@Tag(name = "Review", description = "복습 관련 API")
public class ReviewController {

    private final ReviewService reviewService;

    // 유형별 틀린 문제 목록
    @Operation(summary = "틀린 유형 목록 API", description = "5개 유형을 항상 전부 반환하고, 유형별 틀린 문제 개수를 함께 내려주는 API")
    @GetMapping("/review/categories")
    public ResponseEntity<BaseResponse<ReviewCategoriesResponse>> getCategories(
            @CurrentUser Long userId) {

        // service 호출
        ReviewCategoriesResponse response = reviewService.getCategories(userId);

        // 응답 반환
        return ResponseEntity.status(HttpStatus.OK).body(BaseResponse.success(200, "유형별 틀린 문제 목록 조회 성공", response));
    }
}
