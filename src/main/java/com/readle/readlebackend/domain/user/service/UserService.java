package com.readle.readlebackend.domain.user.service;

import com.readle.readlebackend.domain.user.dto.response.AllRankingResponse;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.exception.CustomException;
import com.readle.readlebackend.global.auth.AuthErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class UserService {

    private final UserRepository userRepository;

    // 전체 랭킹 조회 (상위 7명 + 내 순위)
    public AllRankingResponse getAllRanking(Long userId) {

        // 전체 유저를 xp 내림차순으로 조회
        List<User> allUsers = userRepository.findAll(Sort.by(Sort.Direction.DESC, "xp"));

        // 랭킹 목록(상위 7명) + 내 순위 계산
        List<AllRankingResponse.RankingItem> rankings = new ArrayList<>();
        AllRankingResponse.RankingItem myRank = null;

        int rank = 1;
        for (User user : allUsers) {
            AllRankingResponse.RankingItem item = AllRankingResponse.RankingItem.builder()
                    .rank(rank)
                    .nickname(user.getNickname())
                    .xp(user.getXp())
                    .build();

            if (rank <= 7) {
                rankings.add(item);
            }
            if (user.getId().equals(userId)) {
                myRank = item;
            }
            rank++;
        }

        // 요청한 유저가 존재하는지 확인 (전체 유저 목록에 없었다면 못 찾은 것)
        if (myRank == null) {
            log.warn("[UserService] 전체 랭킹 조회 실패, 존재하지 않는 유저: userId={}", userId);
            throw new CustomException(AuthErrorCode.INVALID_USER_ID);
        }

        // 로그 출력
        log.info("[UserService] 전체 랭킹 조회 성공: userId={}, myRank={}", userId, myRank.getRank());

        // 응답 세팅
        return AllRankingResponse.builder()
                .rankings(rankings)
                .myRank(myRank)
                .build();
    }
}
