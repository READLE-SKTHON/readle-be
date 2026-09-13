package com.readle.readlebackend.global.auth;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 현재 요청자의 userId 를 컨트롤러 파라미터로 주입받기 위한 애노테이션.
 *
 * <p>사용 예: {@code public ResponseEntity<?> get(@CurrentUser Long userId)}
 *
 * <p>값은 {@link CurrentUserFilter} 가 {@code X-USER-ID} 헤더에서 읽어
 * SecurityContext 에 저장한 principal(Long) 에서 가져온다.
 */
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface CurrentUser {
}
