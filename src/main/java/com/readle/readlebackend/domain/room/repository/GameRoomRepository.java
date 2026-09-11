package com.readle.readlebackend.domain.room.repository;

import com.readle.readlebackend.domain.room.entity.GameRoom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GameRoomRepository extends JpaRepository<GameRoom, Long> {
    Optional<GameRoom> findByRoomCode(Long roomCode);
}
