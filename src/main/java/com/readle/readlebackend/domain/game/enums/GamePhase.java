package com.readle.readlebackend.domain.game.enums;

/**
 * 게임 진행 페이즈. {@code GameRoom.startedAt} 기준 경과 시간만으로 서버가 계산한다
 * (별도 스케줄러/이벤트 없음).
 */
public enum GamePhase {
    /** 문제 풀이 중 (방 설정 timer 만큼) */
    ANSWERING,
    /** 이번 문제 정답/점수 공개 (고정 3초) */
    REVEAL,
    /** 누적 순위 공개 (고정 3초) */
    LEADERBOARD,
    /** 마지막 문제까지 끝남 */
    FINISHED
}
