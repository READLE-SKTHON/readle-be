package com.readle.readlebackend.domain.auth.service;

import com.readle.readlebackend.domain.auth.dto.response.LoginResponse;
import com.readle.readlebackend.domain.school.entity.School;
import com.readle.readlebackend.domain.school.repository.SchoolRepository;
import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.auth.AuthErrorCode;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AuthService {

    private final UserRepository userRepository;
    private final SchoolRepository schoolRepository;

    /**
     * userId가 존재하는 유저인지만 확인하고 프로필을 반환한다. 비밀번호 검증은 하지 않는다
     * (해커톤용 임시 인증 — 이후 요청은 이 userId를 X-USER-ID 헤더로 보내면 인증된다).
     */
    public LoginResponse login(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.LOGIN_USER_NOT_FOUND));

        String schoolName = null;
        if (user.getSchoolId() != null) {
            schoolName = schoolRepository.findById(user.getSchoolId())
                    .map(School::getSchoolName)
                    .orElse(null);
        }

        return LoginResponse.builder()
                .userId(user.getId())
                .nickname(user.getNickname())
                .schoolId(user.getSchoolId())
                .schoolName(schoolName)
                .build();
    }

    /**
     * 닉네임 + 학교 이름으로 로그인한다. 비밀번호 검증은 하지 않는다 (해커톤용 임시 인증).
     * 학교 이름은 "서경대"/"서경대학교", "OO고"/"OO고등학교" 처럼 줄인 표기와 정식 표기를
     * 구분하지 않고 같은 학교로 인식한다 ({@link #normalizeSchoolName}).
     */
    public LoginResponse loginByNickname(String nickname, String schoolNameInput) {
        User user = userRepository.findByNickname(nickname)
                .orElseThrow(() -> new CustomException(AuthErrorCode.LOGIN_USER_NOT_FOUND));

        if (user.getSchoolId() == null) {
            throw new CustomException(AuthErrorCode.LOGIN_SCHOOL_MISMATCH);
        }

        School school = schoolRepository.findById(user.getSchoolId())
                .orElseThrow(() -> new CustomException(AuthErrorCode.LOGIN_SCHOOL_MISMATCH));

        if (!normalizeSchoolName(school.getSchoolName()).equals(normalizeSchoolName(schoolNameInput))) {
            throw new CustomException(AuthErrorCode.LOGIN_SCHOOL_MISMATCH);
        }

        return LoginResponse.builder()
                .userId(user.getId())
                .nickname(user.getNickname())
                .schoolId(school.getId())
                .schoolName(school.getSchoolName())
                .build();
    }

    /**
     * 학교 이름의 정식 표기("OO대학교", "OO고등학교")와 줄인 표기("OO대", "OO고")를
     * 같은 것으로 취급하기 위해, 정식 표기 접미사만 줄인 표기 접미사로 바꿔서 비교 기준을 통일한다.
     * (줄인 표기는 이미 원하는 형태라 그대로 둔다.)
     */
    private String normalizeSchoolName(String schoolName) {
        String trimmed = schoolName.trim();
        if (trimmed.endsWith("대학교")) {
            return trimmed.substring(0, trimmed.length() - "대학교".length()) + "대";
        }
        if (trimmed.endsWith("고등학교")) {
            return trimmed.substring(0, trimmed.length() - "고등학교".length()) + "고";
        }
        return trimmed;
    }
}
