package com.readle.readlebackend.domain.question.enums;

/**
 * {@code game_mode_type} Postgres enum 매핑. (NAMED_ENUM 방식, Converter 없음)
 *
 * <p>{@code category_practice} 값은 더 이상 사용하지 않는다 (V8 마이그레이션에서 DB enum에서도 제거).
 * 오늘의 학습 문제는 daily_solo, 게임용 문제는 room 으로만 저장한다.
 */
public enum GameMode {
    daily_solo,
    room
}
