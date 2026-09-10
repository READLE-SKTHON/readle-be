package com.readle.readlebackend;

import com.readle.readlebackend.support.TestcontainersConfiguration;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;

@SpringBootTest
@Import(TestcontainersConfiguration.class)
class ReadleBackendApplicationTests {

    @Test
    void contextLoads() {
    }

}
