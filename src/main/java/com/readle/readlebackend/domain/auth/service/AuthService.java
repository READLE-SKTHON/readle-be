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
}
