package com.readle.readlebackend.domain.news.controller;

import com.readle.readlebackend.domain.news.dto.TodayRepresentativeArticleDto;
import com.readle.readlebackend.domain.news.service.DailyRepresentativeArticleService;
import com.readle.readlebackend.global.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * [임시] 오늘의 대표 기사(레벨별) 관련 API.
 * 문제 생성 로직에서 자동으로 채워주는 정식 플로우가 붙기 전까지,
 * 테스트 데이터를 손으로 채워넣기 위한 용도다.
 */
@Tag(name = "Daily Representative Article (임시)", description = "오늘의 레벨별 대표 기사 임시 API")
@RestController
@RequestMapping("/api/news/today-representative-articles")
@RequiredArgsConstructor
public class DailyRepresentativeArticleController {

    private final DailyRepresentativeArticleService dailyRepresentativeArticleService;

    @Operation(summary = "[임시] 오늘의 레벨별 대표 기사 랜덤 시드",
            description = "레벨 1~5마다 해당 레벨의 기사 중 하나를 무작위로 골라 오늘 날짜의 대표 기사로 저장한다. "
                    + "이미 오늘 저장된 레벨이 있어도 새로 뽑은 기사로 덮어쓴다.")
    @PostMapping("/seed-random")
    public BaseResponse<List<TodayRepresentativeArticleDto>> seedRandom() {
        List<TodayRepresentativeArticleDto> result = dailyRepresentativeArticleService.seedRandomForToday();
        return BaseResponse.success(result);
    }
}
