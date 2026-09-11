package com.readle.readlebackend.domain.game.dto.response;

import com.readle.readlebackend.domain.game.enums.GamePhase;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

/**
 * 게임 진행 상태 폴링 응답. 프론트가 1초 간격으로 호출하는 걸 전제로 한다.
 * phase 에 따라 아래 필드 중 일부만 채워진다:
 * <ul>
 *   <li>ANSWERING: question, answerStatus
 *   <li>REVEAL: myResult, allResults
 *   <li>LEADERBOARD: leaderboard
 *   <li>FINISHED: leaderboard (최종 결과)
 * </ul>
 */
@Getter
@Builder
@Schema(description = "게임 상태 폴링 응답")
public class GameStatusResponse {

    @Schema(description = "현재 페이즈")
    private GamePhase phase;

    @Schema(description = "이 방에서 몇 번째 판(라운드)인지, 1부터 시작 (같은 방으로 재시작할 때마다 증가)", example = "1")
    private Integer round;

    @Schema(description = "현재(또는 마지막) 문제 순서, 0부터 시작", example = "0")
    private Integer currentQuestionOrder;

    @Schema(description = "현재(또는 마지막) 문제 번호, 1부터 시작 (\"totalQuestions 중 몇 번째\" 표시용)", example = "1")
    private Integer currentQuestionNumber;

    @Schema(description = "현재 페이즈에서 남은 시간(초)", example = "12")
    private Integer remainingSeconds;

    @Schema(description = "전체 문제 수", example = "5")
    private Integer totalQuestions;

    @Schema(description = "ANSWERING 페이즈 전용: 현재 문제 내용 (정답 제외)")
    private GameQuestionResponse question;

    @Schema(description = "ANSWERING 페이즈 전용: 참여자별 답변 제출 현황")
    private List<AnswerStatusResponse> answerStatus;

    @Schema(description = "REVEAL 페이즈 전용: 내 이번 문제 결과")
    private MyResultResponse myResult;

    @Schema(description = "REVEAL 페이즈 전용: 참여자 전원의 이번 문제 결과 (누가 맞고 몇 점 얻었는지)")
    private List<PlayerQuestionResultResponse> allResults;

    @Schema(description = "LEADERBOARD/FINISHED 페이즈: 누적 순위표")
    private List<ScoreboardEntryResponse> scoreboard;
}
