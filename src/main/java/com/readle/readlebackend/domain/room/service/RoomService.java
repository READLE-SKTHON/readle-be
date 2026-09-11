package com.readle.readlebackend.domain.room.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.readle.readlebackend.domain.game.dto.request.SubmitAnswerRequest;
import com.readle.readlebackend.domain.game.dto.response.AnswerStatusResponse;
import com.readle.readlebackend.domain.game.dto.response.GameQuestionResponse;
import com.readle.readlebackend.domain.game.dto.response.GameStatusResponse;
import com.readle.readlebackend.domain.game.dto.response.ScoreboardEntryResponse;
import com.readle.readlebackend.domain.game.dto.response.MyResultResponse;
import com.readle.readlebackend.domain.game.dto.response.PlayerQuestionResultResponse;
import com.readle.readlebackend.domain.game.dto.response.StartGameResponse;
import com.readle.readlebackend.domain.game.dto.response.SubmitAnswerResponse;
import com.readle.readlebackend.domain.game.entity.GameRoomAnswer;
import com.readle.readlebackend.domain.game.entity.GameRoomQuestion;
import com.readle.readlebackend.domain.game.enums.GamePhase;
import com.readle.readlebackend.domain.game.repository.GameRoomAnswerRepository;
import com.readle.readlebackend.domain.game.repository.GameRoomQuestionRepository;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.enums.NewsCategory;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
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
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RoomService {

    // TODO: 실제 초대 링크 생성 로직 없음. 프론트 라우트 정해지면 교체.
    private static final String DUMMY_INVITE_LINK = "https://dummy-invite-link.com";

    /** 방 게임용 문제를 조회할 때 사용하는 game_mode. */
    private static final GameMode ROOM_GAME_MODE = GameMode.room;

    /** 정답 공개 페이즈 고정 길이(초). */
    private static final int REVEAL_SECONDS = 3;
    /** 순위 공개 페이즈 고정 길이(초). */
    private static final int LEADERBOARD_SECONDS = 3;
    /** 정답 순서(등수)별 점수. 5등 이후는 0점 (방 최대 인원이 4명이라 사실상 안 씀). */
    private static final int[] RANK_SCORES = {50, 30, 20, 10};

    private final GameRoomRepository gameRoomRepository;
    private final RoomParticipantRepository roomParticipantRepository;
    private final GameRoomQuestionRepository gameRoomQuestionRepository;
    private final GameRoomAnswerRepository gameRoomAnswerRepository;
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
        // 동시 시작 요청 방지: 이 방 행을 잠가서 "이미 시작됐는지 확인 → 문제 배정/시작 처리"가
        // 원자적으로 이뤄지게 한다. 같은 방에 대한 두 번째 요청은 첫 번째가 커밋될 때까지 여기서 대기한다.
        GameRoom room = gameRoomRepository.findByIdForUpdate(roomId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.ROOM_NOT_FOUND));

        RoomParticipant participant = roomParticipantRepository.findByRoomIdAndUserId(roomId, userId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.NOT_ROOM_PARTICIPANT));

        if (!Boolean.TRUE.equals(participant.getIsHost())) {
            throw new CustomException(RoomErrorCode.NOT_ROOM_HOST);
        }

        // 이전 판이 아직 진행 중이면(FINISHED 전) 재시작 불가. 한 번도 시작 안 한 방은 당연히 통과.
        if (isRoundInProgress(room)) {
            throw new CustomException(RoomErrorCode.ROOM_ALREADY_STARTED);
        }

        // 이 방에서 이전 판까지 이미 나온 문제는 재사용하지 않는다.
        Set<Long> usedQuestionIds = gameRoomQuestionRepository.findAllByRoomId(roomId).stream()
                .map(GameRoomQuestion::getQuestionId)
                .collect(Collectors.toSet());

        List<Question> pool = findEligibleQuestions(room.getCategory(), room.getDifficulty(), usedQuestionIds);
        if (pool.size() < room.getQuestionCount()) {
            throw new CustomException(RoomErrorCode.INSUFFICIENT_QUESTIONS);
        }

        List<Question> shuffled = new ArrayList<>(pool);
        Collections.shuffle(shuffled);
        List<Question> selected = shuffled.subList(0, room.getQuestionCount());

        room.start();
        gameRoomRepository.save(room);
        int round = room.getCurrentRound();

        List<GameRoomQuestion> assignments = new ArrayList<>();
        for (int order = 0; order < selected.size(); order++) {
            assignments.add(GameRoomQuestion.builder()
                    .roomId(roomId)
                    .round(round)
                    .questionId(selected.get(order).getId())
                    .displayOrder(order)
                    .build());
        }
        gameRoomQuestionRepository.saveAll(assignments);

        List<GameQuestionResponse> questionResponses = new ArrayList<>();
        for (int order = 0; order < selected.size(); order++) {
            questionResponses.add(toGameQuestionResponse(selected.get(order), order));
        }

        return StartGameResponse.builder()
                .roomId(room.getId())
                .round(round)
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
                .findByRoomIdAndRoundAndDisplayOrder(roomId, room.getCurrentRound(), order)
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));

        Question question = questionRepository.findById(assignment.getQuestionId())
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));

        return toGameQuestionResponse(question, order);
    }

    /**
     * 정답을 제출한다. 문제당 유저 1회만 가능하고, 그 문제의 ANSWERING 페이즈 동안만 제출 가능하다.
     * 채점 결과(정답 여부/점수)는 응답에 포함하지 않는다 — 타이머 종료 후 {@link #getStatus} 로만 공개한다.
     */
    @Transactional
    public SubmitAnswerResponse submitAnswer(Long userId, Long roomId, Integer order, SubmitAnswerRequest request) {
        GameRoom room = gameRoomRepository.findById(roomId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.ROOM_NOT_FOUND));

        if (!roomParticipantRepository.existsByRoomIdAndUserId(roomId, userId)) {
            throw new CustomException(RoomErrorCode.NOT_ROOM_PARTICIPANT);
        }

        if (!room.isStarted()) {
            throw new CustomException(RoomErrorCode.ROOM_NOT_STARTED);
        }

        GameProgress progress = calculateProgress(room);
        if (progress.phase() != GamePhase.ANSWERING || !order.equals(progress.questionOrder())) {
            throw new CustomException(RoomErrorCode.ANSWER_WINDOW_CLOSED);
        }

        int round = room.getCurrentRound();

        // 동시 제출 방지: 이 방/판/문제 배정 행을 잠가서 "정답 개수 세기 → 등수 결정 → 저장"이
        // 원자적으로 이뤄지게 한다. 같은 문제에 대한 다른 유저의 동시 제출은 여기서 대기한다.
        GameRoomQuestion assignment = gameRoomQuestionRepository
                .findByRoomIdAndRoundAndDisplayOrderForUpdate(roomId, round, order)
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));

        if (gameRoomAnswerRepository.existsByRoomIdAndRoundAndQuestionIdAndUserId(
                roomId, round, assignment.getQuestionId(), userId)) {
            throw new CustomException(RoomErrorCode.ALREADY_ANSWERED);
        }

        Question question = questionRepository.findById(assignment.getQuestionId())
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));

        boolean isCorrect = isCorrectAnswer(question, request.getSelectedAnswer());
        int score = 0;
        if (isCorrect) {
            long correctSoFar = gameRoomAnswerRepository
                    .findAllByRoomIdAndRoundAndQuestionId(roomId, round, assignment.getQuestionId()).stream()
                    .filter(GameRoomAnswer::getIsCorrect)
                    .count();
            score = scoreForRank((int) correctSoFar + 1);
        }

        GameRoomAnswer answer = GameRoomAnswer.builder()
                .roomId(roomId)
                .round(round)
                .questionId(assignment.getQuestionId())
                .userId(userId)
                .selectedAnswer(request.getSelectedAnswer())
                .isCorrect(isCorrect)
                .score(score)
                .answeredAt(LocalDateTime.now())
                .build();

        try {
            gameRoomAnswerRepository.save(answer);
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            // 동시에 두 번 제출돼도 DB unique 제약이 마지막 방어선 역할을 한다.
            throw new CustomException(RoomErrorCode.ALREADY_ANSWERED);
        }

        return SubmitAnswerResponse.builder()
                .questionId(assignment.getQuestionId())
                .submitted(true)
                .build();
    }

    /**
     * 게임 진행 상태를 조회한다. 스케줄러/이벤트 없이 {@code GameRoom.startedAt} 기준 경과 시간만으로
     * 페이즈(ANSWERING/REVEAL/LEADERBOARD/FINISHED)를 계산한다. 프론트는 이걸 1초 간격으로 폴링한다.
     */
    public GameStatusResponse getStatus(Long userId, Long roomId) {
        GameRoom room = gameRoomRepository.findById(roomId)
                .orElseThrow(() -> new CustomException(RoomErrorCode.ROOM_NOT_FOUND));

        if (!roomParticipantRepository.existsByRoomIdAndUserId(roomId, userId)) {
            throw new CustomException(RoomErrorCode.NOT_ROOM_PARTICIPANT);
        }

        if (!room.isStarted()) {
            throw new CustomException(RoomErrorCode.ROOM_NOT_STARTED);
        }

        int round = room.getCurrentRound();
        GameProgress progress = calculateProgress(room);

        if (progress.phase() == GamePhase.FINISHED) {
            return GameStatusResponse.builder()
                    .phase(GamePhase.FINISHED)
                    .round(round)
                    .currentQuestionOrder(room.getQuestionCount() - 1)
                    .currentQuestionNumber(room.getQuestionCount())
                    .remainingSeconds(0)
                    .totalQuestions(room.getQuestionCount())
                    .scoreboard(buildScoreboard(roomId, round))
                    .build();
        }

        GameRoomQuestion assignment = gameRoomQuestionRepository
                .findByRoomIdAndRoundAndDisplayOrder(roomId, round, progress.questionOrder())
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));
        Question question = questionRepository.findById(assignment.getQuestionId())
                .orElseThrow(() -> new CustomException(RoomErrorCode.QUESTION_ORDER_OUT_OF_RANGE));

        GameStatusResponse.GameStatusResponseBuilder builder = GameStatusResponse.builder()
                .phase(progress.phase())
                .round(round)
                .currentQuestionOrder(progress.questionOrder())
                .currentQuestionNumber(progress.questionOrder() + 1)
                .remainingSeconds(progress.remainingSeconds())
                .totalQuestions(room.getQuestionCount());

        switch (progress.phase()) {
            case ANSWERING -> builder
                    .question(toGameQuestionResponse(question, progress.questionOrder()))
                    .answerStatus(buildAnswerStatus(roomId, round, assignment.getQuestionId()));
            case REVEAL -> builder
                    .myResult(buildMyResult(roomId, round, assignment.getQuestionId(), userId, question))
                    .allResults(buildAllResults(roomId, round, assignment.getQuestionId()));
            case LEADERBOARD -> builder.scoreboard(buildScoreboard(roomId, round));
            default -> throw new IllegalStateException("예상치 못한 페이즈: " + progress.phase());
        }

        return builder.build();
    }

    /** 지금이 몇 번째 문제, 어떤 페이즈, 얼마나 남았는지 경과 시간만으로 계산한다. */
    private GameProgress calculateProgress(GameRoom room) {
        long elapsed = Duration.between(room.getStartedAt(), LocalDateTime.now()).getSeconds();
        int cycle = room.getTimer() + REVEAL_SECONDS + LEADERBOARD_SECONDS;
        long totalDuration = (long) cycle * room.getQuestionCount();

        if (elapsed >= totalDuration) {
            return new GameProgress(GamePhase.FINISHED, room.getQuestionCount() - 1, 0);
        }

        int questionOrder = (int) (elapsed / cycle);
        long withinCycle = elapsed % cycle;

        if (withinCycle < room.getTimer()) {
            int remaining = (int) (room.getTimer() - withinCycle);
            return new GameProgress(GamePhase.ANSWERING, questionOrder, remaining);
        } else if (withinCycle < room.getTimer() + REVEAL_SECONDS) {
            int remaining = (int) (room.getTimer() + REVEAL_SECONDS - withinCycle);
            return new GameProgress(GamePhase.REVEAL, questionOrder, remaining);
        } else {
            int remaining = (int) (cycle - withinCycle);
            return new GameProgress(GamePhase.LEADERBOARD, questionOrder, remaining);
        }
    }

    private record GameProgress(GamePhase phase, int questionOrder, int remainingSeconds) {
    }

    /** 이전 판이 아직 진행 중인지 (FINISHED 에 도달하지 않았는지). 한 번도 시작 안 했으면 false. */
    private boolean isRoundInProgress(GameRoom room) {
        if (!room.isStarted()) {
            return false;
        }
        return calculateProgress(room).phase() != GamePhase.FINISHED;
    }

    /**
     * 정답 여부를 판단한다. {@code multiple_choice} 는 보기 텍스트를 그대로 비교하는 대신
     * "몇 번째 보기가 정답인지" 위치로 비교한다 (프론트가 긴 한글 텍스트를 그대로 되돌려보내야
     * 하는 불안정함을 없애기 위함). {@code selectedAnswer} 는 1부터 시작하는 인덱스 문자열("1"~"4").
     * OX/단답형은 기존처럼 텍스트를 trim 후 대소문자 무시하고 비교한다.
     */
    private boolean isCorrectAnswer(Question question, String selectedAnswer) {
        if (selectedAnswer == null || selectedAnswer.isBlank() || question.getAnswer() == null) {
            return false;
        }

        if (question.getQuestionFormat() == QuestionFormat.multiple_choice) {
            return isCorrectMultipleChoiceIndex(question, selectedAnswer);
        }

        return question.getAnswer().trim().equalsIgnoreCase(selectedAnswer.trim());
    }

    private boolean isCorrectMultipleChoiceIndex(Question question, String selectedAnswer) {
        List<String> choices = parseChoices(question.getChoices());
        int correctIndex = choices.indexOf(question.getAnswer());
        if (correctIndex < 0) {
            log.warn("문제 {} 의 answer가 choices 목록 안에 없습니다. answer={}, choices={}",
                    question.getId(), question.getAnswer(), choices);
            return false;
        }

        try {
            int submittedIndex = Integer.parseInt(selectedAnswer.trim()) - 1; // 1-based -> 0-based
            return submittedIndex == correctIndex;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private int scoreForRank(int rank) {
        if (rank < 1 || rank > RANK_SCORES.length) {
            return 0;
        }
        return RANK_SCORES[rank - 1];
    }

    /** 참여자별로 이 문제에 답을 제출했는지 여부. 정답 여부는 포함하지 않는다 (부정행위 방지). */
    private List<AnswerStatusResponse> buildAnswerStatus(Long roomId, Integer round, Long questionId) {
        List<RoomParticipant> participants = roomParticipantRepository.findAllByRoomIdOrderByJoinedAtAsc(roomId);
        Set<Long> answeredUserIds = gameRoomAnswerRepository
                .findAllByRoomIdAndRoundAndQuestionId(roomId, round, questionId).stream()
                .map(GameRoomAnswer::getUserId)
                .collect(Collectors.toSet());

        Map<Long, String> nicknameByUserId = nicknamesFor(participants);

        return participants.stream()
                .map(p -> AnswerStatusResponse.builder()
                        .userId(p.getUserId())
                        .nickname(nicknameByUserId.get(p.getUserId()))
                        .answered(answeredUserIds.contains(p.getUserId()))
                        .build())
                .toList();
    }

    /** 내가 이번 문제에서 정답을 맞혔는지/점수/정답을 반환한다. 미제출이면 오답 처리. */
    private MyResultResponse buildMyResult(Long roomId, Integer round, Long questionId, Long userId, Question question) {
        GameRoomAnswer myAnswer = gameRoomAnswerRepository
                .findByRoomIdAndRoundAndQuestionIdAndUserId(roomId, round, questionId, userId)
                .orElse(null);

        return MyResultResponse.builder()
                .isCorrect(myAnswer != null && Boolean.TRUE.equals(myAnswer.getIsCorrect()))
                .score(myAnswer != null ? myAnswer.getScore() : 0)
                .correctAnswer(question.getAnswer())
                .explanation(question.getExplanation())
                .build();
    }

    /** 참여자 전원의 이번 문제 결과(정답 여부/점수). 미제출자는 오답/0점으로 포함된다. */
    private List<PlayerQuestionResultResponse> buildAllResults(Long roomId, Integer round, Long questionId) {
        List<RoomParticipant> participants = roomParticipantRepository.findAllByRoomIdOrderByJoinedAtAsc(roomId);
        Map<Long, String> nicknameByUserId = nicknamesFor(participants);

        Map<Long, GameRoomAnswer> answerByUserId = gameRoomAnswerRepository
                .findAllByRoomIdAndRoundAndQuestionId(roomId, round, questionId).stream()
                .collect(Collectors.toMap(GameRoomAnswer::getUserId, a -> a));

        return participants.stream()
                .map(p -> {
                    GameRoomAnswer answer = answerByUserId.get(p.getUserId());
                    return PlayerQuestionResultResponse.builder()
                            .userId(p.getUserId())
                            .nickname(nicknameByUserId.get(p.getUserId()))
                            .isCorrect(answer != null && Boolean.TRUE.equals(answer.getIsCorrect()))
                            .score(answer != null ? answer.getScore() : 0)
                            .build();
                })
                .toList();
    }

    /** 방 참여자 전원의 이번 판 누적 점수 순위표. 아직 한 문제도 안 맞힌 참여자는 0점으로 포함된다. */
    private List<ScoreboardEntryResponse> buildScoreboard(Long roomId, Integer round) {
        List<RoomParticipant> participants = roomParticipantRepository.findAllByRoomIdOrderByJoinedAtAsc(roomId);
        Map<Long, String> nicknameByUserId = nicknamesFor(participants);

        Map<Long, Integer> totalScoreByUserId = gameRoomAnswerRepository.findAllByRoomIdAndRound(roomId, round).stream()
                .collect(Collectors.groupingBy(
                        GameRoomAnswer::getUserId,
                        Collectors.summingInt(GameRoomAnswer::getScore)));

        List<ScoreboardEntryResponse> entries = new ArrayList<>();
        for (RoomParticipant p : participants) {
            entries.add(ScoreboardEntryResponse.builder()
                    .userId(p.getUserId())
                    .nickname(nicknameByUserId.get(p.getUserId()))
                    .totalScore(totalScoreByUserId.getOrDefault(p.getUserId(), 0))
                    .build());
        }

        entries.sort(Comparator.comparingInt(ScoreboardEntryResponse::getTotalScore).reversed());

        List<ScoreboardEntryResponse> ranked = new ArrayList<>();
        for (int i = 0; i < entries.size(); i++) {
            ScoreboardEntryResponse e = entries.get(i);
            ranked.add(ScoreboardEntryResponse.builder()
                    .rank(i + 1)
                    .userId(e.getUserId())
                    .nickname(e.getNickname())
                    .totalScore(e.getTotalScore())
                    .build());
        }
        return ranked;
    }

    private Map<Long, String> nicknamesFor(List<RoomParticipant> participants) {
        List<Long> userIds = participants.stream().map(RoomParticipant::getUserId).toList();
        return userRepository.findAllById(userIds).stream()
                .collect(Collectors.toMap(User::getId, User::getNickname));
    }

    /**
     * 방 category(전체 포함)/difficulty(레벨 범위)에 맞는 게임용 문제 후보를 조회한다.
     * {@code excludedQuestionIds} 에 담긴 문제(이 방에서 이전 판까지 이미 나온 문제)는 후보에서 제외한다.
     */
    private List<Question> findEligibleQuestions(Category category, Difficulty difficulty,
                                                 Set<Long> excludedQuestionIds) {
        List<Integer> levels = levelsFor(difficulty);

        List<Question> pool;
        if (category == Category.전체) {
            pool = questionRepository.findAllByGameModeAndLevelIn(ROOM_GAME_MODE, levels);
        } else {
            // TODO: room.enums.Category 와 news.enums.NewsCategory 가 값이 같은 별개 enum이라 이름으로 변환한다.
            // 둘을 하나로 합치면 이 변환은 필요 없어진다.
            NewsCategory newsCategory = NewsCategory.valueOf(category.name());
            List<Long> newsIds = newsRepository.findAllByCategory(newsCategory).stream()
                    .map(News::getId)
                    .toList();

            if (newsIds.isEmpty()) {
                return List.of();
            }

            pool = questionRepository.findAllByNewsIdInAndGameModeAndLevelIn(newsIds, ROOM_GAME_MODE, levels);
        }

        return pool.stream()
                .filter(q -> !excludedQuestionIds.contains(q.getId()))
                .toList();
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
