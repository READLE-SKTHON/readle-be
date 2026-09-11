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
    /** 임시: 아직 문제가 있는 기사로 고정해야 하는 레벨. 추후 모든 레벨에 문제 데이터가 갖춰지면 제거한다. */
    private static final int FIXED_LEVEL_WITH_QUESTIONS = 4;

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
            // 임시: 레벨 4는 아직 문제가 있는 기사가 하나뿐이라, 랜덤이 아니라 그 기사로 고정한다.
            // (다른 레벨은 문제 데이터가 갖춰지기 전까지 기존처럼 랜덤 선택 유지)
            Long articleId = (level == FIXED_LEVEL_WITH_QUESTIONS)
                    ? newsRepository.findFirstIdWithQuestionsByLevel(level)
                            .orElseThrow(() -> new CustomException(NewsErrorCode.NO_ARTICLE_FOR_LEVEL))
                    : newsRepository.findRandomIdByLevel(level)
                            .orElseThrow(() -> new CustomException(NewsErrorCode.NO_ARTICLE_FOR_LEVEL));

            dailyRepresentativeArticleRepository.upsert(today, level, articleId);
            result.add(new TodayRepresentativeArticleDto(level, articleId));
        }

        log.info("[DailyRepresentativeArticleService] 오늘({}) 대표 기사 랜덤 시드 완료: {}", today, result);
        return result;
    }
}
