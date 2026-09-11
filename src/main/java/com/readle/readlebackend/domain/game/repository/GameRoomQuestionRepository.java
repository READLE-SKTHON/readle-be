package com.readle.readlebackend.domain.game.repository;

import com.readle.readlebackend.domain.game.entity.GameRoomQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GameRoomQuestionRepository extends JpaRepository<GameRoomQuestion, Long> {
    List<GameRoomQuestion> findAllByRoomIdOrderByDisplayOrderAsc(Long roomId);
    Optional<GameRoomQuestion> findByRoomIdAndDisplayOrder(Long roomId, Integer displayOrder);
    boolean existsByRoomId(Long roomId);
}
