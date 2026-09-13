package com.readle.readlebackend.domain.news.repository;

import com.readle.readlebackend.domain.news.entity.DailyRepresentativeArticle;
import com.readle.readlebackend.domain.news.entity.DailyRepresentativeArticleId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Optional;

public interface DailyRepresentativeArticleRepository
        extends JpaRepository<DailyRepresentativeArticle, DailyRepresentativeArticleId> {

    /**
     * (rep_date, level)의 오늘의 대표 기사를 조회한다. 아직 그 레벨의 대표 기사가 안 정해졌으면 빈 Optional.
     */
    Optional<DailyRepresentativeArticle> findByRepDateAndLevel(LocalDate repDate, Integer level);

    /**
     * (rep_date, level)에 대표 기사가 없으면 새로 넣고, 이미 있으면 조용히 무시한다.
     *
     * <p>exists-check 후 save 하는 방식은 같은 레벨의 기사 두 건이 거의 동시에 처리될 때
     * 경쟁 상태(race condition)가 생길 수 있어, DB의 (rep_date, level) PK 제약을 이용한
     * 원자적 UPSERT(ON CONFLICT DO NOTHING)로 처리한다.
     *
     * @return 실제로 삽입되었으면 1, 이미 존재해서 무시됐으면 0
     */
    @Modifying
    @Transactional
    @Query(value = """
            INSERT INTO daily_representative_article (rep_date, level, article_id)
            VALUES (:repDate, :level, :articleId)
            ON CONFLICT (rep_date, level) DO NOTHING
            """, nativeQuery = true)
    int insertIfAbsent(@Param("repDate") LocalDate repDate,
                        @Param("level") Integer level,
                        @Param("articleId") Long articleId);

    /**
     * (rep_date, level)의 대표 기사를 새 article_id로 덮어쓴다(UPSERT).
     * 임시 시드 API처럼 "다시 호출하면 새로 갱신되어야 하는" 경우에 사용한다.
     */
    @Modifying
    @Transactional
    @Query(value = """
            INSERT INTO daily_representative_article (rep_date, level, article_id)
            VALUES (:repDate, :level, :articleId)
            ON CONFLICT (rep_date, level) DO UPDATE SET article_id = EXCLUDED.article_id
            """, nativeQuery = true)
    void upsert(@Param("repDate") LocalDate repDate,
                @Param("level") Integer level,
                @Param("articleId") Long articleId);
}
