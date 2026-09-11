package com.readle.readlebackend.domain.question.controller;

import com.readle.readlebackend.domain.question.dto.QuestionGenerationResult;
import com.readle.readlebackend.domain.question.service.QuestionGenerationService;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 문제 생성 컨트롤러.
 * 호출할 때마다 news_articles 중 아직 문제가 생성되지 않은 기사를 하나 가져와서,
 * Gemini로 난이도 + 오늘의 학습 문제 + 게임 문제를 생성하고 DB에 저장한 뒤 결과를 응답으로 반환한다.
 * 이미 문제가 생성된 기사는 다시 처리하지 않는다.
 */
@Tag(name = "Question Generation", description = "AI 기반 문제 생성 및 저장")
@RestController
@RequestMapping("/api/questions/generate")
@RequiredArgsConstructor
public class QuestionGenerationController {

    private final QuestionGenerationService questionGenerationService;

    @Operation(summary = "미처리 기사 기반 문제 생성",
            description = "아직 문제가 생성되지 않은 기사를 하나 가져와 Gemini로 난이도(1~5)를 판단하고, "
                    + "오늘의 학습 문제 10개 + 게임용 문제 10개를 생성해서 DB에 저장한 뒤, 생성 결과를 응답으로도 반환한다. "
                    + "처리할 기사가 하나도 없으면 에러를 반환한다.")
    @PostMapping("/preview")
    public BaseResponse<QuestionGenerationResult> preview() {
        QuestionGenerationResult result = questionGenerationService.generate();
        return BaseResponse.success(result);
    }
}
