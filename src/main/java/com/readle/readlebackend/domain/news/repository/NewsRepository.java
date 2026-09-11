package com.readle.readlebackend.domain.news.repository;

import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.enums.NewsCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface NewsRepository extends JpaRepository<News, Long> {
    List<News> findAllByCategory(NewsCategory category);

    /** 특정 레벨의 뉴스 중 게시 시각이 [start, end) 구간(보통 오늘 하루)에 속하는 것들. */
    List<News> findAllByLevelAndPublishedAtGreaterThanEqualAndPublishedAtLessThan(
            Integer level, LocalDateTime start, LocalDateTime end);

    /** 특정 레벨의 뉴스 중 가장 최근에 게시된 것 1개. 오늘 뉴스가 없을 때 대체용. */
    Optional<News> findFirstByLevelOrderByPublishedAtDesc(Integer level);
}
