package com.readle.readlebackend.domain.news.scheduler;

import com.readle.readlebackend.domain.news.dto.TodayRepresentativeArticleDto;
import com.readle.readlebackend.domain.news.service.DailyRepresentativeArticleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 매일 새벽, 레벨별 "오늘의 대표 기사"를 자동으로 랜덤 시드한다.
 * {@link DailyRepresentativeArticleService#seedRandomForToday()} 를 그대로 재사용하며,
 * 수동 트리거용 {@code POST /api/news/today-representative-articles/seed-random} API는
 * 운영/QA 중 수동 재실행이 필요할 수 있어 그대로 유지한다.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class DailyRepresentativeArticleScheduler {

    private final DailyRepresentativeArticleService dailyRepresentativeArticleService;

    /**
     * 매일 새벽 4시(KST)에 실행된다.
     */
    @Scheduled(cron = "0 0 4 * * *", zone = "Asia/Seoul")
    public void seedRandomForToday() {
        log.info("[DailyRepresentativeArticleScheduler] 오늘의 대표 기사 랜덤 시드 스케줄러 시작");
        try {
            List<TodayRepresentativeArticleDto> result = dailyRepresentativeArticleService.seedRandomForToday();
            log.info("[DailyRepresentativeArticleScheduler] 오늘의 대표 기사 랜덤 시드 스케줄러 완료: {}", result);
        } catch (Exception e) {
            log.error("[DailyRepresentativeArticleScheduler] 오늘의 대표 기사 랜덤 시드 스케줄러 실패", e);
        }
    }
}
