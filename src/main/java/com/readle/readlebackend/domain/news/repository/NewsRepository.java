package com.readle.readlebackend.domain.news.repository;

import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.enums.NewsCategory;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface NewsRepository extends JpaRepository<News, Long> {

    /**
     * questions 테이블에 news_id로 한 번도 참조되지 않은(=아직 문제가 생성되지 않은) 기사를
     * news_id 오름차순으로 조회한다. 한 건씩 순차 처리할 것이므로 호출 측에서 Pageable로 1건만 요청한다.
     */
    @Query("""
            SELECT n FROM News n
            WHERE n.id NOT IN (SELECT DISTINCT q.newsId FROM Question q)
            ORDER BY n.id ASC
            """)
    List<News> findArticlesWithoutQuestions(Pageable pageable);

    List<News> findAllByCategory(NewsCategory category);

    /**
     * 지정한 level의 기사 중 하나를 무작위로 골라 news_id를 반환한다.
     * (임시 시드 API용 - 해당 level에 기사가 하나도 없으면 빈 Optional)
     */
    @Query(value = "SELECT news_id FROM news_articles WHERE level = :level ORDER BY RANDOM() LIMIT 1",
            nativeQuery = true)
    Optional<Long> findRandomIdByLevel(@Param("level") Integer level);
}
