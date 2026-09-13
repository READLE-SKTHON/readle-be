package com.readle.readlebackend.domain.training.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "오늘 문제풀이 최종 결과 응답 dto", description = "오늘 제출한 문제들을 집계한 결과")
public class AnswerResultResponse {

    @Schema(description = "총 문제 수", example = "10")
    private int totalQuestions;

    @Schema(description = "맞은 문제 수", example = "4")
    private int correctCount;

    @Schema(description = "오늘의 퀴즈 정답률(%)", example = "40")
    private int accuracy;

    @Schema(description = "오늘 획득한 경험치", example = "320")
    private int earnedExp;

    @Schema(description = "능력치 카테고리별 누적 평균 점수 목록 (근거형 문제를 한 번도 평가받지 않았으면 빈 리스트)")
    private List<SkillResultDto> skillResults;
}
