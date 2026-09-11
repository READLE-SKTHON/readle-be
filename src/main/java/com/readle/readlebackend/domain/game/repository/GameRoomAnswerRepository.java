package com.readle.readlebackend.domain.game.repository;

import com.readle.readlebackend.domain.game.entity.GameRoomAnswer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GameRoomAnswerRepository extends JpaRepository<GameRoomAnswer, Long> {
    boolean existsByRoomIdAndQuestionIdAndUserId(Long roomId, Long questionId, Long userId);
    Optional<GameRoomAnswer> findByRoomIdAndQuestionIdAndUserId(Long roomId, Long questionId, Long userId);
    List<GameRoomAnswer> findAllByRoomIdAndQuestionId(Long roomId, Long questionId);
    List<GameRoomAnswer> findAllByRoomId(Long roomId);
}
