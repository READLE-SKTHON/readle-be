package com.readle.readlebackend.domain.room.repository;

import com.readle.readlebackend.domain.room.entity.RoomParticipant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RoomParticipantRepository extends JpaRepository<RoomParticipant, Long> {
    List<RoomParticipant> findAllByRoomId(Long roomId);
    List<RoomParticipant> findAllByRoomIdOrderByJoinedAtAsc(Long roomId);
    Optional<RoomParticipant> findByRoomIdAndUserId(Long roomId, Long userId);
    boolean existsByRoomIdAndUserId(Long roomId, Long userId);
    int countByRoomId(Long roomId);
}
