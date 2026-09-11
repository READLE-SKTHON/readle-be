package com.readle.readlebackend.global.validation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 정수 필드가 정해진 값 목록 중 하나인지 검증한다.
 *
 * <p>사용 예: {@code @AllowedIntValues({5, 7, 10, 15, 20})}
 */
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = AllowedIntValuesValidator.class)
public @interface AllowedIntValues {

    int[] value();

    String message() default "허용되지 않는 값입니다.";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
