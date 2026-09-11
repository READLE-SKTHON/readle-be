package com.readle.readlebackend.domain.room.service;

import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.enums.NewsCategory;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import com.readle.readlebackend.domain.question.enums.SubCategory;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.domain.room.entity.GameRoom;
import com.readle.readlebackend.domain.room.entity.RoomParticipant;
import com.readle.readlebackend.domain.room.enums.Category;
import com.readle.readlebackend.domain.room.enums.Difficulty;
import com.readle.readlebackend.domain.room.exception.RoomErrorCode;
import com.readle.readlebackend.domain.room.repository.GameRoomRepository;
import com.readle.readlebackend.domain.room.repository.RoomParticipantRepository;
import com.readle.readlebackend.global.exception.CustomException;
import com.readle.readlebackend.support.TestcontainersConfiguration;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * 게임 시작(startGame)에 대한 동시 요청 처리 검증.
 * 같은 방장이 (더블클릭 등으로) 거의 동시에 두 번 시작을 요청해도
 * 하나만 성공하고 나머지는 ROOM_ALREADY_STARTED 로 걸러져야 한다.
 */
@SpringBootTest
@Import(TestcontainersConfiguration.class)
class RoomServiceConcurrencyTest {

    // V2__seed_users.sql 로 항상 존재하는 시드 유저.
    private static final Long HOST_USER_ID = 1L;

    @Autowired
    private RoomService roomService;

    @Autowired
    private GameRoomRepository gameRoomRepository;

    @Autowired
    private RoomParticipantRepository roomParticipantRepository;

    @Autowired
    private NewsRepository newsRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Test
    void 동시에_두번_시작해도_하나만_성공한다() throws InterruptedException {
        News news = newsRepository.save(News.builder()
                .title("테스트 기사")
                .category(NewsCategory.전체)
                .publisher("테스트 언론사")
                .publishedAt(LocalDateTime.now())
                .content("테스트 본문")
                .sourceUrl("https://example.com/test")
                .level(1)
                .build());

        for (int i = 0; i < 5; i++) {
            questionRepository.save(Question.builder()
                    .newsId(news.getId())
                    .content("동시성 테스트 문제 " + i)
                    .questionFormat(QuestionFormat.OX)
                    .choices("[]")
                    .answer("O")
                    .explanation("설명")
                    .hint("힌트")
                    .gameMode(GameMode.category_practice)
                    .mainCategory(MainCategory.vocab)
                    .subCategory(SubCategory.vocab_meaning)
                    .level(1)
                    .build());
        }

        GameRoom room = gameRoomRepository.save(GameRoom.builder()
                .roomCode(9999L)
                .inviteLink("https://dummy-invite-link.com")
                .category(Category.전체)
                .difficulty(Difficulty.랜덤)
                .timer(30)
                .memberCount(4)
                .questionCount(5)
                .build());

        roomParticipantRepository.save(RoomParticipant.builder()
                .userId(HOST_USER_ID)
                .roomId(room.getId())
                .isHost(true)
                .build());

        int threadCount = 2;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch readyLatch = new CountDownLatch(threadCount);
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch doneLatch = new CountDownLatch(threadCount);
        List<String> outcomes = Collections.synchronizedList(new ArrayList<>());

        for (int i = 0; i < threadCount; i++) {
            executor.submit(() -> {
                readyLatch.countDown();
                try {
                    startLatch.await();
                    roomService.startGame(HOST_USER_ID, room.getId());
                    outcomes.add("SUCCESS");
                } catch (CustomException e) {
                    outcomes.add(e.getErrorCode().getCode());
                } catch (Exception e) {
                    outcomes.add("UNEXPECTED_ERROR: " + e);
                } finally {
                    doneLatch.countDown();
                }
            });
        }

        readyLatch.await();
        startLatch.countDown();
        boolean finished = doneLatch.await(10, TimeUnit.SECONDS);
        executor.shutdown();

        assertThat(finished).as("두 요청이 제한 시간 내에 끝나야 함").isTrue();
        assertThat(outcomes).hasSize(2);
        assertThat(outcomes).containsExactlyInAnyOrder(
                "SUCCESS", RoomErrorCode.ROOM_ALREADY_STARTED.getCode());
    }
}
