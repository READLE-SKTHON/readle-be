package com.readle.readlebackend.domain.room.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.readle.readlebackend.domain.game.dto.response.GameQuestionResponse;
import com.readle.readlebackend.domain.game.dto.response.StartGameResponse;
import com.readle.readlebackend.domain.game.entity.GameRoomQuestion;
import com.readle.readlebackend.domain.game.repository.GameRoomQuestionRepository;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.enums.NewsCategory;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.domain.room.dto.request.CreateRoomRequest;
import com.readle.readlebackend.domain.room.dto.response.CreateRoomResponse;
import com.readle.readlebackend.domain.room.dto.response.ParticipantResponse;
import com.readle.readlebackend.domain.room.dto.response.RoomParticipantsResponse;
import com.readle.readlebackend.domain.room.entity.GameRoom;
import com.readle.readlebackend.domain.room.entity.RoomParticipant;
import com.readle.readlebackend.domain.room.enums.Category;
import com.readle.readlebackend.domain.room.enums.Difficulty;
import com.readle.readlebackend.domain.room.exception.RoomErrorCode;
import com.readle.readlebackend.domain.room.repository.GameRoomRepository;
import com.readle.readlebackend.domain.room.repository.RoomParticipantRepository;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RoomService {

    // TODO: 실제 초대 링크 생성 로직 없음. 프론트 라우트 정해지면 교체.
    private static final String DUMMY_INVITE_LINK = "https://dummy-invite-link.com";

    /**
     * TODO: 스키마상 방 게임용 문제는 game_mode_type='room' 이 의도이지만,
     * QuestionGenerationService 가 "게임용 문제"를 category_practice 로 저장하고 있어
     * 실제 데이터와 맞추기 위해 우선 이 값으로 조회한다. 생성 쪽이 정리되면 함께 바꿀 것.
     */
    private static final GameMode ROOM_GAME_MODE = GameMode.category_practice;

    private final GameRoomRepository gameRoomRepository;
    private final RoomParticipantRepository roomParticipantRepository;
    private final GameRoomQuestionRepository gameRoomQuestionRepository;
    private final UserRepository userRepository;
    private final NewsRepository newsRepository;
    private final QuestionRepository questionRepository;
    private final ObjectMapper objectMapper;

    @Transactional
    public CreateRoomResponse createRoom(Long userId, CreateRoomRequest request) {
        Category category = request.getCategory() != null ? request.getCategory() : Category.전체;
        Difficulty difficulty = request.getDifficulty() != null ? request.getDifficulty() : Difficulty.중;

        long roomCode = generateUniqueRoomCode();

        GameRoom room = GameRoom.builder()
                .roomCode(roomCode)
                .inviteLink(DUMMY_INVITE_LINK)
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
     * 대기방 참여자 목록을 조회한다. 프론트에서 폴링으로 주기 호출하는 용도.
     */
    public RoomParticipantsResponse getParticipants(Long userId, Long roomId) {
        GameRoom room = gameRoomRepository.findById(roomId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.ROOM_NOT_FOUND));

        if (!roomParticipantRepository.existsByRoomIdAndUserId(roomId, userId)) {
            throw new CustomException(RoomErrorCode.NOT_ROOM_PARTICIPANT);
        }

        List<RoomParticipant> participants =
                roomParticipantRepository.findAllByRoomIdOrderByJoinedAtAsc(roomId);

        List<Long> userIds = participants.stream()
                .map(RoomParticipant::getUserId)
                .toList();

        Map<Long, String> nicknameByUserId = userRepository.findAllById(userIds).stream()
                .collect(Collectors.toMap(User::getId, User::getNickname));

        List<ParticipantResponse> participantResponses = participants.stream()
                .map(p -> ParticipantResponse.builder()
                        .userId(p.getUserId())
                        .nickname(nicknameByUserId.get(p.getUserId()))
                        .isHost(p.getIsHost())
                        .build())
                .toList();

        return RoomParticipantsResponse.builder()
                .roomId(room.getId())
                .currentCount(participantResponses.size())
                .memberCount(room.getMemberCount())
                .participants(participantResponses)
                .startedAt(room.getStartedAt())
                .build();
    }

    /**
     * 방장이 게임을 시작한다. 방 설정(카테고리/난이도)에 맞는 문제를 문제 수만큼 랜덤으로 뽑아
     * {@code game_room_questions} 에 순서 고정 저장하고, 방을 시작 상태로 전환한다.
     */
    @Transactional
    public StartGameResponse startGame(Long userId, Long roomId) {
        GameRoom room = gameRoomRepository.findById(roomId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.ROOM_NOT_FOUND));

        RoomParticipant participant = roomParticipantRepository.findByRoomIdAndUserId(roomId, userId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.NOT_ROOM_PARTICIPANT));

        if (!Boolean.TRUE.equals(participant.getIsHost())) {
            throw new CustomException(RoomErrorCode.NOT_ROOM_HOST);
        }

        if (room.isStarted()) {
            throw new CustomException(RoomErrorCode.ROOM_ALREADY_STARTED);
        }

        List<Question> pool = findEligibleQuestions(room.getCategory(), room.getDifficulty());
        if (pool.size() < room.getQuestionCount()) {
            throw new CustomException(RoomErrorCode.INSUFFICIENT_QUESTIONS);
        }

        List<Question> shuffled = new ArrayList<>(pool);
        Collections.shuffle(shuffled);
        List<Question> selected = shuffled.subList(0, room.getQuestionCount());

        List<GameRoomQuestion> assignments = new ArrayList<>();
        for (int order = 0; order < selected.size(); order++) {
            assignments.add(GameRoomQuestion.builder()
                    .roomId(roomId)
                    .questionId(selected.get(order).getId())
                    .displayOrder(order)
                    .build());
        }
        gameRoomQuestionRepository.saveAll(assignments);

        room.start();
        gameRoomRepository.save(room);

        List<GameQuestionResponse> questionResponses = new ArrayList<>();
        for (int order = 0; order < selected.size(); order++) {
            questionResponses.add(toGameQuestionResponse(selected.get(order), order));
        }

        return StartGameResponse.builder()
                .roomId(room.getId())
                .startedAt(room.getStartedAt())
                .questions(questionResponses)
                .build();
    }

    /**
     * 시작된 방에 배정된 문제 중 지정한 순서(order, 0부터 시작) 하나만 조회한다.
     * 호스트가 아닌 참여자도 같은 문제를 같은 순서로 봐야 하므로 방 참여자면 누구나 호출 가능.
     */
    public GameQuestionResponse getQuestion(Long userId, Long roomId, Integer order) {
        GameRoom room = gameRoomRepository.findById(roomId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.ROOM_NOT_FOUND));

        if (!roomParticipantRepository.existsByRoomIdAndUserId(roomId, userId)) {
            throw new CustomException(RoomErrorCode.NOT_ROOM_PARTICIPANT);
        }

        if (!room.isStarted()) {
            throw new CustomException(RoomErrorCode.ROOM_NOT_STARTED);
        }

        GameRoomQuestion assignment = gameRoomQuestionRepository
                .findByRoomIdAndDisplayOrder(roomId, order)
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));

        Question question = questionRepository.findById(assignment.getQuestionId())
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));

        return toGameQuestionResponse(question, order);
    }

    /** 방 category(전체 포함)/difficulty(레벨 범위)에 맞는 게임용 문제 후보를 조회한다. */
    private List<Question> findEligibleQuestions(Category category, Difficulty difficulty) {
        List<Integer> levels = levelsFor(difficulty);

        if (category == Category.전체) {
            return questionRepository.findAllByGameModeAndLevelIn(ROOM_GAME_MODE, levels);
        }

        // TODO: room.enums.Category 와 news.enums.NewsCategory 가 값이 같은 별개 enum이라 이름으로 변환한다.
        // 둘을 하나로 합치면 이 변환은 필요 없어진다.
        NewsCategory newsCategory = NewsCategory.valueOf(category.name());
        List<Long> newsIds = newsRepository.findAllByCategory(newsCategory).stream()
                .map(News::getId)
                .toList();

        if (newsIds.isEmpty()) {
            return List.of();
        }

        return questionRepository.findAllByNewsIdInAndGameModeAndLevelIn(newsIds, ROOM_GAME_MODE, levels);
    }

    /** 난이도 → News/Question level(1~5) 매핑. 하=1,2 / 중=3,4 / 상=5 / 랜덤=1~5. */
    private List<Integer> levelsFor(Difficulty difficulty) {
        return switch (difficulty) {
            case 하 -> List.of(1, 2);
            case 중 -> List.of(3, 4);
            case 상 -> List.of(5);
            case 랜덤 -> List.of(1, 2, 3, 4, 5);
        };
    }

    private GameQuestionResponse toGameQuestionResponse(Question question, int displayOrder) {
        return GameQuestionResponse.builder()
                .questionId(question.getId())
                .displayOrder(displayOrder)
                .questionFormat(question.getQuestionFormat())
                .content(question.getContent())
                .choices(parseChoices(question.getChoices()))
                .build();
    }

    private List<String> parseChoices(String choicesJson) {
        if (choicesJson == null || choicesJson.isBlank()) {
            return List.of();
        }
        try {
            return objectMapper.readValue(choicesJson, new TypeReference<List<String>>() {});
        } catch (IOException e) {
            log.error("choices 파싱 실패: {}", choicesJson, e);
            return List.of();
        }
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
