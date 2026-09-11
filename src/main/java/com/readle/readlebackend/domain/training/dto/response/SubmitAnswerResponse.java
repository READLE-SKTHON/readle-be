package com.readle.readlebackend.domain.training.dto.response;

import com.readle.readlebackend.domain.training.enums.ResultStatus;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "답안 제출 응답 dto", description = "문제 하나를 제출했을 때 반환되는 채점 결과")
public class SubmitAnswerResponse {

    @Schema(description = "정답 상태", example = "correct")
    private ResultStatus resultStatus;

    @Schema(description = "내가 선택/작성한 답", example = "O")
    private String selectedAnswer;

    @Schema(description = "정답 (questions.answer)", example = "X")
    private String answer;

    @Schema(description = "이 문제에서 획득한 점수", example = "10")
    private Integer overallScore;

    @Schema(description = "피드백")
    private Feedback feedback;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "채점 피드백 응답 dto", description = "문제별로 달라지는 채점 세부 내용")
    public static class Feedback {

        @Schema(description = "완벽한 답안 예시", example = "정답은 가계 부담 증가야. 기사 셋째 문단에 명시돼 있어.")
        private String explanation;

        @Schema(description = "틀린 이유 (정답이면 null)", example = "선택은 맞았지만 근거가 기사 내용과 무관해요.")
        private String mistakeFeedback;

        @Schema(description = "근거 작성에 대한 전반적인 AI 코멘트", example = "핵심 논리는 잘 짚었지만 근거를 조금 더 구체적으로 써보면 좋겠어요.")
        private String comment;

        @Schema(description = "기사에서 다시 찾아볼 부분 (정답이면 null)", example = "셋째 문단의 소비자물가지수 관련 내용을 다시 확인해보세요.")
        private String hint;
    }
}