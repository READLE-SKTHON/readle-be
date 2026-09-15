package com.readle.readlebackend.domain.home.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "홈 화면 응답")
public class HomeResponse {

    @Schema(description = "닉네임", example = "김환희")
    private String nickname;

    @Schema(description = "현재 레벨 (1~5)", example = "3")
    private Long level;

    @Schema(description = "현재 경험치", example = "700")
    private Integer xp;

    @Schema(description = "해당 레벨의 최대 경험치", example = "1400")
    private Integer maxXp;

    @Schema(description = "연속 학습 일수", example = "5")
    private Long currentStreak;

    @Schema(description = "읽은 뉴스 수", example = "12")
    private Integer newsReadCount;

    @Schema(description = "평균 정답률 (0~100 정수)", example = "80")
    private Long answerRate;
}
