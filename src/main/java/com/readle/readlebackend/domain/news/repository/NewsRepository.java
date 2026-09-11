package com.readle.readlebackend.domain.news.repository;

import com.readle.readlebackend.domain.news.entity.News;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

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
}
