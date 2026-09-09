package com.readle.readlebackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class ReadleBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(ReadleBackendApplication.class, args);
    }

}
