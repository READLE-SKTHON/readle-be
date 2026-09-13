package com.readle.readlebackend.domain.user.service;

import com.readle.readlebackend.domain.school.entity.School;
import com.readle.readlebackend.domain.school.repository.SchoolRepository;
import com.readle.readlebackend.domain.user.dto.response.AllRankingResponse;
import com.readle.readlebackend.domain.user.dto.response.SchoolRankingResponse;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.exception.UserErrorCode;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.auth.AuthErrorCode;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class UserService {

    private final UserRepository userRepository;
    private final SchoolRepository schoolRepository;

    // 전체 랭킹 조회 (상위 7명 + 7등 밖일 때만 내 순위)
    public AllRankingResponse getAllRanking(Long userId) {

        // 전체 유저를 xp 내림차순으로 조회
        List<User> allUsers = userRepository.findAllByOrderByXpDesc();

        // 랭킹 목록(상위 7명) + 내 순위 계산 (7등 밖일 때만 myRank 표시)
        List<AllRankingResponse.RankingItem> rankings = new ArrayList<>();
        AllRankingResponse.RankingItem myRank = null;
        boolean userFound = false;

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
                userFound = true;
                if (rank > 7) {
                    myRank = item;
                }
            }
            rank++;
        }

        // 요청한 유저가 존재하는지 확인 (전체 유저 목록에 없었다면 못 찾은 것)
        if (!userFound) {
            log.warn("[UserService] 전체 랭킹 조회 실패, 존재하지 않는 유저: userId={}", userId);
            throw new CustomException(AuthErrorCode.INVALID_USER_ID);
        }

        // 로그 출력
        log.info("[UserService] 전체 랭킹 조회 성공: userId={}, myRank={}", userId, myRank != null ? myRank.getRank() : null);

        // 응답 세팅
        return AllRankingResponse.builder()
                .rankings(rankings)
                .myRank(myRank)
                .build();
    }

    // 학교별 랭킹 조회 (소속 학생 xp 평균 기준, 상위 7개교 + 7등 밖일 때만 내 학교 순위)
    public SchoolRankingResponse getSchoolRanking(Long userId) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));

        // 소속 학교가 있는지 확인
        if (user.getSchoolId() == null) {
            log.warn("[UserService] 학교별 랭킹 조회 실패, 소속 학교 없음: userId={}", userId);
            throw new CustomException(UserErrorCode.NO_SCHOOL_ASSIGNED);
        }

        // 전체 유저 조회
        List<User> allUsers = userRepository.findAll();

        // 학교마다 소속 학생 xp 평균 계산
        Map<School, Integer> avgXpBySchool = new HashMap<>();
        for (School school : schoolRepository.findAll()) {
            avgXpBySchool.put(school, school.calculateAvgXp(allUsers));
        }

        // 평균 xp 내림차순 정렬
        List<Map.Entry<School, Integer>> sortedSchools = new ArrayList<>(avgXpBySchool.entrySet());
        sortedSchools.sort((a, b) -> b.getValue() - a.getValue());

        // 랭킹 목록(상위 7개교) + 내 학교 순위 계산
        List<SchoolRankingResponse.RankingItem> rankings = new ArrayList<>();
        SchoolRankingResponse.RankingItem myRank = null;

        int rank = 1;
        for (Map.Entry<School, Integer> entry : sortedSchools) {
            // 현재 등수/학교명/평균xp로 랭킹 항목 생성
            SchoolRankingResponse.RankingItem item = SchoolRankingResponse.RankingItem.builder()
                    .rank(rank)
                    .schoolName(entry.getKey().getSchoolName())
                    .avgXp(entry.getValue())
                    .build();

            // 7등 이내면 상위 랭킹 목록에 추가
            if (rank <= 7) {
                rankings.add(item);
            }
            // 내 소속 학교가 7등 밖이면 myRank에 저장 (7등 이내면 이미 rankings에 표시됨)
            if (rank > 7 && entry.getKey().getId().equals(user.getSchoolId())) {
                myRank = item;
            }
            rank++;
        }

        // 로그 출력
        log.info("[UserService] 학교별 랭킹 조회 성공: userId={}, schoolId={}, myRank={}",
                userId, user.getSchoolId(), myRank != null ? myRank.getRank() : null);

        // 응답 세팅
        return SchoolRankingResponse.builder()
                .rankings(rankings)
                .myRank(myRank)
                .build();
    }
}