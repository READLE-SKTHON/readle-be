package com.readle.readlebackend.domain.question.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.readle.readlebackend.domain.question.exception.QuestionErrorCode;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Gemini generateContent REST API를 직접 호출하는 클라이언트.
 * 별도 SDK 의존성 없이 JDK 내장 HttpClient + Jackson만 사용한다.
 * responseSchema로 구조화된 JSON 출력을 강제한다 (Structured Output).
 */
@Slf4j
@Component
public class GeminiClient {

    private static final String ENDPOINT_TEMPLATE =
            "https://generativelanguage.googleapis.com/v1beta/models/%s:generateContent?key=%s";

    private final String apiKey;
    private final String model;
    private final ObjectMapper objectMapper;
    private final HttpClient httpClient;

    public GeminiClient(
            @Value("${gemini.api-key}") String apiKey,
            @Value("${gemini.model}") String model,
            ObjectMapper objectMapper) {
        this.apiKey = apiKey;
        this.model = model;
        this.objectMapper = objectMapper;
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
    }

    /**
     * 프롬프트와 응답 JSON 스키마를 보내고, 스키마에 맞는 원본 JSON 문자열을 그대로 반환한다.
     * 파싱은 호출부(Service)에서 담당한다.
     */
    public String generateJson(String prompt, JsonNode responseSchema) {
        String requestBody = buildRequestBody(prompt, responseSchema);
        String url = ENDPOINT_TEMPLATE.formatted(model, apiKey);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofSeconds(60))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response;
        try {
            response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        } catch (IOException e) {
            log.error("Gemini API 호출 실패", e);
            throw new CustomException(QuestionErrorCode.GEMINI_API_ERROR);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new CustomException(QuestionErrorCode.GEMINI_API_ERROR);
        }

        if (response.statusCode() != 200) {
            log.error("Gemini API 응답 오류 (status={}): {}", response.statusCode(), response.body());
            throw new CustomException(QuestionErrorCode.GEMINI_API_ERROR);
        }

        return extractText(response.body());
    }

    private String buildRequestBody(String prompt, JsonNode responseSchema) {
        ObjectNode root = objectMapper.createObjectNode();

        ArrayNode contents = root.putArray("contents");
        ObjectNode content = contents.addObject();
        ArrayNode parts = content.putArray("parts");
        parts.addObject().put("text", prompt);

        ObjectNode generationConfig = root.putObject("generationConfig");
        generationConfig.put("responseMimeType", "application/json");
        generationConfig.set("responseSchema", responseSchema);

        try {
            return objectMapper.writeValueAsString(root);
        } catch (IOException e) {
            throw new CustomException(QuestionErrorCode.GEMINI_API_ERROR);
        }
    }

    private String extractText(String responseBody) {
        try {
            JsonNode responseJson = objectMapper.readTree(responseBody);
            JsonNode textNode = responseJson
                    .path("candidates").path(0)
                    .path("content").path("parts").path(0)
                    .path("text");

            if (textNode.isMissingNode() || textNode.isNull()) {
                log.error("Gemini 응답에서 text를 찾을 수 없음: {}", responseBody);
                throw new CustomException(QuestionErrorCode.GEMINI_RESPONSE_PARSE_ERROR);
            }
            return textNode.asText();
        } catch (IOException e) {
            log.error("Gemini 응답 파싱 실패", e);
            throw new CustomException(QuestionErrorCode.GEMINI_RESPONSE_PARSE_ERROR);
        }
    }
}
