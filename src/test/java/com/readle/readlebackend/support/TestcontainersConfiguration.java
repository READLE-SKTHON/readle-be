package com.readle.readlebackend.support;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.context.annotation.Bean;
import org.testcontainers.postgresql.PostgreSQLContainer;
import org.testcontainers.utility.DockerImageName;

/**
 * 통합 테스트용 PostgreSQL 컨테이너 설정.
 *
 * <p>{@link ServiceConnection} 덕분에 datasource url/username/password 가 컨테이너 값으로
 * 자동 주입되며, Flyway 마이그레이션도 이 컨테이너 DB 에 적용된다.
 */
@TestConfiguration(proxyBeanMethods = false)
public class TestcontainersConfiguration {

    @Bean
    @ServiceConnection
    PostgreSQLContainer postgresContainer() {
        return new PostgreSQLContainer(DockerImageName.parse("postgres:16"));
    }
}
