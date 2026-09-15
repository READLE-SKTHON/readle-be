package com.readle.readlebackend.domain.home.service;

import com.readle.readlebackend.domain.home.dto.response.HomeResponse;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.exception.UserErrorCode;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class HomeService {

    /** 레벨별 최대 경험치. {@link User#applyDailyResult} 의 레벨 산정 구간과 맞춘 값이다. */
    private static final Map<Long, Integer> LEVEL_MAX_XP = Map.of(
            1L, 200,
            2L, 600,
            3L, 1400,
            4L, 2400,
            5L, 2400 // 최고 레벨: 다음 구간이 없어 4레벨 상한과 동일하게 둔다.
    );
    private static final int DEFAULT_MAX_XP = 200;

    private final UserRepository userRepository;

    public HomeResponse getHome(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(UserErrorCode.USER_NOT_FOUND));

        Long level = user.getLevel() != null ? user.getLevel() : 1L;

        return HomeResponse.builder()
                .nickname(user.getNickname())
                .level(level)
                .xp(user.getXp() != null ? user.getXp() : 0)
                .maxXp(LEVEL_MAX_XP.getOrDefault(level, DEFAULT_MAX_XP))
                .currentStreak(user.getCurrentStreak() != null ? user.getCurrentStreak() : 0L)
                .newsReadCount(user.getNewsReadCount() != null ? user.getNewsReadCount() : 0)
                .answerRate(user.getAnswerRate() != null ? user.getAnswerRate() : 0L)
                .build();
    }
}
