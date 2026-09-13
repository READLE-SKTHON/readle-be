package com.readle.readlebackend.global.auth;

import com.readle.readlebackend.domain.user.entity.User;
import com.readle.readlebackend.domain.user.repository.UserRepository;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import org.springframework.core.MethodParameter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

/**
 * {@link CurrentUser} 애노테이션이 붙은 파라미터에 현재 요청자를 주입한다.
 *
 * <ul>
 *   <li>{@code @CurrentUser Long userId} → userId 만
 *   <li>{@code @CurrentUser User user} → DB 조회한 엔티티
 * </ul>
 *
 * <p>userId 는 {@link CurrentUserFilter} 가 SecurityContext 에 저장한 principal 에서 가져온다.
 */
@Component
@RequiredArgsConstructor
public class CurrentUserArgumentResolver implements HandlerMethodArgumentResolver {

    private final UserRepository userRepository;

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        if (!parameter.hasParameterAnnotation(CurrentUser.class)) {
            return false;
        }
        Class<?> type = parameter.getParameterType();
        return type.equals(Long.class) || type.equals(User.class);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter,
                                  ModelAndViewContainer mavContainer,
                                  NativeWebRequest webRequest,
                                  WebDataBinderFactory binderFactory) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !(authentication.getPrincipal() instanceof Long userId)) {
            throw new CustomException(AuthErrorCode.UNAUTHORIZED);
        }

        if (parameter.getParameterType().equals(Long.class)) {
            return userId;
        }

        return userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(AuthErrorCode.INVALID_USER_ID));
    }
}
