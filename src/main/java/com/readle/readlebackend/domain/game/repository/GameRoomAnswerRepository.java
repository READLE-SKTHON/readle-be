package com.readle.readlebackend.domain.game.repository;

import com.readle.readlebackend.domain.game.entity.GameRoomAnswer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GameRoomAnswerRepository extends JpaRepository<GameRoomAnswer, Long> {
    boolean existsByRoomIdAndRoundAndQuestionIdAndUserId(
            Long roomId, Integer round, Long questionId, Long userId);
    Optional<GameRoomAnswer> findByRoomIdAndRoundAndQuestionIdAndUserId(
            Long roomId, Integer round, Long questionId, Long userId);
    List<GameRoomAnswer> findAllByRoomIdAndRoundAndQuestionId(Long roomId, Integer round, Long questionId);
    List<GameRoomAnswer> findAllByRoomIdAndRound(Long roomId, Integer round);

    /** 방장이 나가서 방을 통째로 종료할 때, 이 방의 모든 라운드 답안을 한 번에 지운다. */
    void deleteAllByRoomId(Long roomId);
}
