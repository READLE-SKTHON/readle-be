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
}
