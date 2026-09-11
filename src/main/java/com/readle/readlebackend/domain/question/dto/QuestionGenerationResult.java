package com.readle.readlebackend.domain.question.dto;

import java.util.List;

/**
 * 문제 생성 결과 전체.
 * level: AI가 판단한 기사 난이도(1~5)
 * dailyQuestions: 오늘의 학습용 문제 (지문 전문을 읽었다는 전제)
 * gameQuestions: 게임용 문제 (문단 발췌만 보고 푸는 전제, 상대적으로 쉬움)
 */
public record QuestionGenerationResult(
        Integer level,
        List<GeneratedQuestionDto> dailyQuestions,
        List<GeneratedQuestionDto> gameQuestions
) {
}
