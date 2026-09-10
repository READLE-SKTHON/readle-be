package com.readle.readlebackend.global.config;

import com.readle.readlebackend.global.auth.CurrentUserFilter;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Value("${server.servlet.context-path:}")
    private String contextPath;

    @Bean
    public OpenAPI customOpenAPI() {

        Server localServer = new Server();
        localServer.setUrl(contextPath);
        localServer.setDescription("Local Server");

        String schemeName = CurrentUserFilter.USER_ID_HEADER;

        return new OpenAPI()
                .addServersItem(localServer)
                .addSecurityItem(new SecurityRequirement().addList(schemeName))
                .components(
                        new Components().addSecuritySchemes(
                                schemeName,
                                new SecurityScheme()
                                        .type(SecurityScheme.Type.APIKEY)
                                        .in(SecurityScheme.In.HEADER)
                                        .name(schemeName)
                                        .description("JWT 대신 사용하는 사용자 식별 헤더. 값에 userId(1~4) 입력.")
                        )
                )
                .info(new Info().title("Readle API 명세서").version("1.0").description("Swagger Test"));
    }

    @Bean
    public GroupedOpenApi customGroupedOpenApi() {
        return GroupedOpenApi.builder().group("api").pathsToMatch("/**").build();
    }
}
