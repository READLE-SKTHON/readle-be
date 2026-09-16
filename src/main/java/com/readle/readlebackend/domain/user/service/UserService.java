package com.readle.readlebackend.domain.user.service;

import com.readle.readlebackend.domain.school.entity.School;
import com.readle.readlebackend.domain.school.repository.SchoolRepository;
import com.readle.readlebackend.domain.user.dto.request.AddFriendRequest;
import com.readle.readlebackend.domain.user.dto.response.*;
import com.readle.readlebackend.domain.user.entity.Friend;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.exception.UserErrorCode;
import com.readle.readlebackend.domain.user.repository.FriendRepository;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.auth.AuthErrorCode;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class UserService {

    private final UserRepository userRepository;
    private final SchoolRepository schoolRepository;
    private final FriendRepository friendRepository;

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

    // 친구별 랭킹 조회
    public FriendRankingResponse getFriendRanking(Long userId) {

        // 내가 추가한 친구 id 목록 조회
        List<Friend> friends = friendRepository.findByUserId(userId);

        // 나 + 친구들을 한 번에 조회
        Set<Long> targetUserIds = new HashSet<>();
        targetUserIds.add(userId);
        for (Friend friend : friends) {
            targetUserIds.add(friend.getAddedUserId());
        }
        // xp 내림차순으로 조회
        List<User> targetUsers = userRepository.findByIdInOrderByXpDesc(targetUserIds);

        // 랭킹 목록(상위 7명) + 내 순위 계산 (7등 밖일 때만 myRank 표시)
        List<FriendRankingResponse.RankingItem> rankings = new ArrayList<>();
        FriendRankingResponse.RankingItem myRank = null;
        boolean userFound = false;

        int rank = 1;
        for (User target : targetUsers) {
            // 현재 등수/닉네임/xp로 랭킹 항목 생성
            FriendRankingResponse.RankingItem item = FriendRankingResponse.RankingItem.builder()
                    .rank(rank)
                    .nickname(target.getNickname())
                    .xp(target.getXp())
                    .build();

            // 7등 이내면 상위 랭킹 목록에 추가
            if (rank <= 7) {
                rankings.add(item);
            }

            // 7등 이내면 이미 rankings에 표시되고 7등 밖일 때만 myRank에 저장
            if (target.getId().equals(userId)) {
                userFound = true;
                if (rank > 7) {
                    myRank = item;
                }
            }
            rank++;
        }

        // 요청한 유저가 존재하는지 확인
        if (!userFound) {
            log.warn("[UserService] 친구 랭킹 조회 실패, 존재하지 않는 유저: userId={}", userId);
            throw new CustomException(AuthErrorCode.INVALID_USER_ID);
        }

        // 로그 출력
        log.info("[UserService] 친구 랭킹 조회 성공: userId={}, friendCount={}, myRank={}",
                userId, friends.size(), myRank != null ? myRank.getRank() : null);

        // 응답 세팅
        return FriendRankingResponse.builder()
                .rankings(rankings)
                .myRank(myRank)
                .build();
    }

    // 닉네임으로 친구 검색
    public FriendSearchResponse searchFriends(Long userId, String nickname) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findByNickname(nickname)
                .orElseThrow(() -> new CustomException(UserErrorCode.USER_NOT_FOUND));

        // 이미 친구인지 확인
        boolean isAlreadyFriend = friendRepository.findByUserIdAndAddedUserId(userId, user.getId()).isPresent();

        // 로그 출력
        log.info("[UserService] 닉네임으로 친구 검색 성공: userId={}", userId);

        // 응답 세팅
        return FriendSearchResponse.builder()
                .userId(user.getId())
                .nickname(user.getNickname())
                .level(user.getLevel())
                .isAlreadyFriend(isAlreadyFriend)
                .build();
    }

    // 친구 추가
    @Transactional
    public AddFriendResponse addFriend(Long userId, AddFriendRequest request) {

        // 사용자가 존재하는지 조회
        User user = userRepository.findByNickname(request.getNickname())
                .orElseThrow(() -> new CustomException(UserErrorCode.USER_NOT_FOUND));

        // 자기 자신은 친구 추가가 안됨
        if (user.getId().equals(userId)) {
            log.warn("[UserService] 자기 자신은 친구로 추가할 수 없습니다.: userId={}", userId);
            throw new CustomException(UserErrorCode.SELF_FRIEND_NOT_ALLOWED);
        }

        // 이미 추가된 친구인지 조회
        if (friendRepository.findByUserIdAndAddedUserId(userId, user.getId()).isPresent()) {
            log.warn("[UserService] 친구 추가 실패, 이미 친구 추가가 되어 있습니다.: userId={}, friendUserId={}", userId, user.getId());
            throw new CustomException(UserErrorCode.ALREADY_FRIEND);
        }

        // 친구 관계 객체 생성
        Friend friend = Friend.builder()
                .userId(userId)
                .addedUserId(user.getId())
                .build();

        // DB 저장
        friendRepository.save(friend);

        // 로그 출력
        log.info("[UserService] 친구 추가 성공: userId={}, friendUserId={}", userId, user.getId());

        // 응답 세팅
        return AddFriendResponse.builder()
                .userId(user.getId())
                .nickname(user.getNickname())
                .build();
    }

    // 친구 목록 리스트 조회
    public List<FriendListResponse> getFriendList(Long userId) {

        // 친구 목록 조회
        List<Friend> friends = friendRepository.findByUserId(userId);

        // 응답 세팅
        List<FriendListResponse> list = new ArrayList<>();
        for (Friend friend : friends) {
            User friendUser = userRepository.findById(friend.getAddedUserId())
                    .orElseThrow(() -> new CustomException(UserErrorCode.USER_NOT_FOUND));

            list.add(FriendListResponse.builder()
                    .userId(friendUser.getId())
                    .nickname(friendUser.getNickname())
                    .level(friendUser.getLevel())
                    .build());
        }

        // 로그 출력
        log.info("[UserService] 친구 목록 조회 성공: userId={}", userId);

        return list;
    }
}