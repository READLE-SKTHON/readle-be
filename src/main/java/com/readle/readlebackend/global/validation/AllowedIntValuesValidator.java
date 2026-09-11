package com.readle.readlebackend.global.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class AllowedIntValuesValidator implements ConstraintValidator<AllowedIntValues, Integer> {

    private int[] allowed;

    @Override
    public void initialize(AllowedIntValues constraintAnnotation) {
        this.allowed = constraintAnnotation.value();
    }

    @Override
    public boolean isValid(Integer value, ConstraintValidatorContext context) {
        // null 은 @NotNull 이 별도로 처리하도록 통과시킨다.
        if (value == null) {
            return true;
        }
        for (int candidate : allowed) {
            if (candidate == value) {
                return true;
            }
        }
        return false;
    }
}
