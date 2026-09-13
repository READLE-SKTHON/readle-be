package com.readle.readlebackend.domain.news.service;

import com.readle.readlebackend.domain.news.dto.TodayRepresentativeArticleDto;
import com.readle.readlebackend.domain.news.exception.NewsErrorCode;
import com.readle.readlebackend.domain.news.repository.DailyRepresentativeArticleRepository;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class DailyRepresentativeArticleService {

    private static final int MIN_LEVEL = 1;
    private static final int MAX_LEVEL = 5;

    private final NewsRepository newsRepository;
    private final DailyRepresentativeArticleRepository dailyRepresentativeArticleRepository;

    /**
     * [임시/테스트용] 레벨 1~5마다 해당 레벨의 기사 중 하나를 무작위로 골라
     * 오늘 날짜의 대표 기사로 저장한다. 이미 오늘 저장된 레벨이 있어도 새로 뽑은 기사로 덮어쓴다(UPSERT).
     *
     * <p>문제 생성 로직에서 자동으로 채워주는 정식 플로우가 아직 없어서,
     * 프론트/QA가 "오늘의 기사" 데이터를 미리 채워넣고 테스트할 수 있도록 만든 임시 API용 메서드다.
     */
    @Transactional
    public List<TodayRepresentativeArticleDto> seedRandomForToday() {
        LocalDate today = LocalDate.now();
        List<TodayRepresentativeArticleDto> result = new ArrayList<>();

        for (int level = MIN_LEVEL; level <= MAX_LEVEL; level++) {
            Long articleId = newsRepository.findRandomIdByLevel(level)
                    .orElseThrow(() -> new CustomException(NewsErrorCode.NO_ARTICLE_FOR_LEVEL));

            dailyRepresentativeArticleRepository.upsert(today, level, articleId);
            result.add(new TodayRepresentativeArticleDto(level, articleId));
        }

        log.info("[DailyRepresentativeArticleService] 오늘({}) 대표 기사 랜덤 시드 완료: {}", today, result);
        return result;
    }
}
