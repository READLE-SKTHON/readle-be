package com.readle.readlebackend.domain.room.service;

import com.readle.readlebackend.domain.room.dto.request.CreateRoomRequest;
import com.readle.readlebackend.domain.room.dto.response.CreateRoomResponse;
import com.readle.readlebackend.domain.room.entity.GameRoom;
import com.readle.readlebackend.domain.room.entity.RoomParticipant;
import com.readle.readlebackend.domain.room.enums.Category;
import com.readle.readlebackend.domain.room.enums.Difficulty;
import com.readle.readlebackend.domain.room.exception.RoomErrorCode;
import com.readle.readlebackend.domain.room.repository.GameRoomRepository;
import com.readle.readlebackend.domain.room.repository.RoomParticipantRepository;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.concurrent.ThreadLocalRandom;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RoomService {

    private final GameRoomRepository gameRoomRepository;
    private final RoomParticipantRepository roomParticipantRepository;

    @Transactional
    public CreateRoomResponse createRoom(Long userId, CreateRoomRequest request) {
        Category category = request.getCategory() != null ? request.getCategory() : Category.전체;
        Difficulty difficulty = request.getDifficulty() != null ? request.getDifficulty() : Difficulty.중;

        long roomCode = generateUniqueRoomCode();

        GameRoom room = GameRoom.builder()
                .roomCode(roomCode)
                .category(category)
                .difficulty(difficulty)
                .timer(request.getTimer())
                .memberCount(request.getMemberCount())
                .questionCount(request.getQuestionCount())
                .build();

        GameRoom saved = gameRoomRepository.save(room);

        RoomParticipant host = RoomParticipant.builder()
                .userId(userId)
                .roomId(saved.getId())
                .isHost(true)
                .build();

        roomParticipantRepository.save(host);

        return CreateRoomResponse.from(saved);
    }

    @Transactional
    public CreateRoomResponse joinRoom(Long userId, Long roomCode) {
        GameRoom room = gameRoomRepository.findByRoomCode(roomCode)
                .orElseThrow(() -> new CustomException(RoomErrorCode.ROOM_NOT_FOUND));

        if (roomParticipantRepository.existsByRoomIdAndUserId(room.getId(), userId)) {
            throw new CustomException(RoomErrorCode.ALREADY_JOINED);
        }

        int currentCount = roomParticipantRepository.countByRoomId(room.getId());
        if (currentCount >= room.getMemberCount()) {
            throw new CustomException(RoomErrorCode.ROOM_FULL);
        }

        RoomParticipant participant = RoomParticipant.builder()
                .userId(userId)
                .roomId(room.getId())
                .isHost(false)
                .build();

        roomParticipantRepository.save(participant);

        return CreateRoomResponse.from(room);
    }

    /**
     * 4자리 방 코드를 생성한다 (1000~9999). 다른 방과 겹치면 재시도한다.
     */
    private long generateUniqueRoomCode() {
        for (int attempt = 0; attempt < 10; attempt++) {
            long code = ThreadLocalRandom.current().nextLong(1000, 10000);
            if (gameRoomRepository.findByRoomCode(code).isEmpty()) {
                return code;
            }
        }
        throw new CustomException(RoomErrorCode.ROOM_CODE_GENERATION_FAILED);
    }
}
