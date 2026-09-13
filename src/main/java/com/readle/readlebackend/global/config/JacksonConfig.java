package com.readle.readlebackend.global.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Spring Boot 4.x에서 spring-boot-starter-web만으로는 ObjectMapper 빈이
 * 자동 등록되지 않아 직접 빈으로 정의한다. (GeminiClient, QuestionGenerationService에서 주입받아 사용)
 */
@Configuration
public class JacksonConfig {

    @Bean
    public ObjectMapper objectMapper() {
        return new ObjectMapper();
    }
}
