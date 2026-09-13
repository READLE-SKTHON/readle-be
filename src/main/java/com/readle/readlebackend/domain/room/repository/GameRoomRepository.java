package com.readle.readlebackend.domain.room.repository;

import com.readle.readlebackend.domain.room.entity.GameRoom;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface GameRoomRepository extends JpaRepository<GameRoom, Long> {
    Optional<GameRoom> findByRoomCode(Long roomCode);

    /**
     * 게임 시작 처리(startGame)처럼 "확인 후 실행"이 원자적이어야 하는 곳에서 사용한다.
     * 이 행을 잠가서, 같은 방에 대한 동시 시작 요청 중 하나가 커밋될 때까지 나머지는 대기하게 만든다.
     */
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select r from GameRoom r where r.id = :id")
    Optional<GameRoom> findByIdForUpdate(@Param("id") Long id);
}
