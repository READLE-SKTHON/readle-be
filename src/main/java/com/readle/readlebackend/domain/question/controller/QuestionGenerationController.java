package com.readle.readlebackend.domain.question.controller;

import com.readle.readlebackend.domain.question.dto.QuestionGenerationRequest;
import com.readle.readlebackend.domain.question.dto.QuestionGenerationResult;
import com.readle.readlebackend.domain.question.service.QuestionGenerationService;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 문제 생성 확인용 컨트롤러.
 * 아직 DB 저장은 하지 않고, Gemini가 생성한 (난이도 + 오늘의 학습 문제 + 게임 문제)를 그대로 반환한다.
 */
@Tag(name = "Question Generation", description = "AI 기반 문제 생성 (확인용, 저장 없음)")
@RestController
@RequestMapping("/api/questions/generate")
@RequiredArgsConstructor
public class QuestionGenerationController {

    private final QuestionGenerationService questionGenerationService;

    @Operation(summary = "기사 기반 문제 생성 미리보기", description = "기사 원문을 받아 Gemini로 난이도(1~5)를 판단하고, 오늘의 학습 문제 10개 + 게임용 문제 10개를 생성해 그대로 반환한다. DB에 저장하지 않는다.")
    @PostMapping("/preview")
    public BaseResponse<QuestionGenerationResult> preview(@Valid @RequestBody QuestionGenerationRequest request) {
        QuestionGenerationResult result = questionGenerationService.generate(request);
        return BaseResponse.success(result);
    }
}
