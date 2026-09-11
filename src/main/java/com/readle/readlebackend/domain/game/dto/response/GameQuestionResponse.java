package com.readle.readlebackend.domain.game.dto.response;

import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
@Schema(description = "게임 문제 (정답/해설/힌트는 부정행위 방지를 위해 제외)")
public class GameQuestionResponse {

    @Schema(description = "문제 ID", example = "1")
    private Long questionId;

    @Schema(description = "풀이 순서 (0부터 시작)", example = "0")
    private Integer displayOrder;

    @Schema(description = "문제 형식")
    private QuestionFormat questionFormat;

    @Schema(description = "문제 본문")
    private String content;

    @Schema(description = "보기 목록 (OX/단답형이면 빈 배열)")
    private List<String> choices;
}
