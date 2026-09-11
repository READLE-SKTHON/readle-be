package com.readle.readlebackend.domain.game.repository;

import com.readle.readlebackend.domain.game.entity.GameRoomQuestion;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface GameRoomQuestionRepository extends JpaRepository<GameRoomQuestion, Long> {

    List<GameRoomQuestion> findAllByRoomIdAndRoundOrderByDisplayOrderAsc(Long roomId, Integer round);

    Optional<GameRoomQuestion> findByRoomIdAndRoundAndDisplayOrder(
            Long roomId, Integer round, Integer displayOrder);

    /**
     * submitAnswer 에서 "정답 개수 세기 → 등수 결정 → 답안 저장"을 원자적으로 처리하기 위해 잠근다.
     * 같은 방/판/문제에 대한 동시 제출 중 하나가 커밋될 때까지 나머지는 여기서 대기한다.
     */
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select q from GameRoomQuestion q where q.roomId = :roomId and q.round = :round and q.displayOrder = :displayOrder")
    Optional<GameRoomQuestion> findByRoomIdAndRoundAndDisplayOrderForUpdate(
            @Param("roomId") Long roomId, @Param("round") Integer round, @Param("displayOrder") Integer displayOrder);
}
