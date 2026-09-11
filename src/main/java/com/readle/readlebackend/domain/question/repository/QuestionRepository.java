package com.readle.readlebackend.domain.question.repository;

import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

public interface QuestionRepository extends JpaRepository<Question, Long> {

    // 특정 게임 모드로 오늘(생성 시각 기준) 만들어진 문제 목록 조회
    List<Question> findByGameModeAndCreatedAtBetween(GameMode gameMode, LocalDateTime start, LocalDateTime end);

    // 문제가 하나라도 생성된(=처리 완료된) 기사 수
    @Query("SELECT COUNT(DISTINCT q.newsId) FROM Question q")
    long countDistinctNewsId();

    // 해당 기사에 이미 생성된 문제가 있는지 확인 (중복 생성 방지용)
    boolean existsByNewsId(Long newsId);

    /** 카테고리 제한 없이(방 category = 전체) 게임 모드/레벨로만 후보를 뽑을 때 사용. */
    List<Question> findAllByGameModeAndLevelIn(GameMode gameMode, List<Integer> levels);

    /** 특정 뉴스 카테고리(News.newsId 목록)로 제한해서 후보를 뽑을 때 사용. */
    List<Question> findAllByNewsIdInAndGameModeAndLevelIn(
            List<Long> newsIds, GameMode gameMode, List<Integer> levels);

    // 오늘의 문제(daily_solo) 조회용 (특정 게임 모드 + 특정 레벨 + 오늘 생성된 것)
    List<Question> findAllByGameModeAndLevelInAndCreatedAtBetween(GameMode gameMode, List<Integer> levels, LocalDateTime start, LocalDateTime end);
}
