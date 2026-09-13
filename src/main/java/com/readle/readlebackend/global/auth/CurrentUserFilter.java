package com.readle.readlebackend.global.auth;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * JWT 대신 {@code X-USER-ID} 헤더로 사용자를 식별
 *
 * <p>헤더에 담긴 값(1~4 등)을 그대로 userId 로 신뢰하여 SecurityContext 의
 * principal(Long) 로 저장한다. 값이 없거나 숫자가 아니면 인증 없이 통과하며,
 * 이후 {@code anyRequest().authenticated()} 에서 걸러진다.
 */
@Component
public class CurrentUserFilter extends OncePerRequestFilter {

    public static final String USER_ID_HEADER = "X-USER-ID";

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        String header = request.getHeader(USER_ID_HEADER);

        if (StringUtils.hasText(header)
                && SecurityContextHolder.getContext().getAuthentication() == null) {
            try {
                Long userId = Long.parseLong(header.trim());
                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(
                                userId, null, AuthorityUtils.createAuthorityList("ROLE_USER"));
                SecurityContextHolder.getContext().setAuthentication(authentication);
            } catch (NumberFormatException ignored) {
                // 잘못된 형식이면 인증 없이 통과
            }
        }

        filterChain.doFilter(request, response);
    }
}
