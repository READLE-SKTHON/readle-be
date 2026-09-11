package com.readle.readlebackend.domain.question.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.readle.readlebackend.domain.question.client.GeminiClient;
import com.readle.readlebackend.domain.question.dto.QuestionGenerationRequest;
import com.readle.readlebackend.domain.question.dto.QuestionGenerationResult;
import com.readle.readlebackend.domain.question.exception.QuestionErrorCode;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 기사 1건을 받아 (1) 난이도 1~5 판단, (2) 오늘의 학습 문제 10개, (3) 게임용 문제 10개를
 * 한 번의 Gemini 호출로 생성한다. 아직 저장(persist)은 하지 않고 확인용으로 결과만 반환한다.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionGenerationService {

    /** 대분류(main_category) 하나당 각 문제 세트(오늘의 학습/게임)에서 생성할 개수. 5개 카테고리 x 2개 = 세트당 10개. */
    private static final int QUESTIONS_PER_CATEGORY = 2;

    private final GeminiClient geminiClient;
    private final ObjectMapper objectMapper;

    public QuestionGenerationResult generate(QuestionGenerationRequest request) {
        String prompt = buildPrompt(request);
        JsonNode schema = buildResponseSchema();

        String rawJson = geminiClient.generateJson(prompt, schema);

        try {
            return objectMapper.readValue(rawJson, QuestionGenerationResult.class);
        } catch (IOException e) {
            log.error("Gemini 응답 JSON 파싱 실패. raw={}", rawJson, e);
            throw new CustomException(QuestionErrorCode.GEMINI_RESPONSE_PARSE_ERROR);
        }
    }

    private String buildPrompt(QuestionGenerationRequest request) {
        int totalPerSet = QUESTIONS_PER_CATEGORY * MainCategory.values().length;

        StringBuilder sb = new StringBuilder();
        sb.append("너는 한국 대학생 문해력 학습 앱 'Readle'의 문제 출제자야. ");
        sb.append("아래 뉴스 기사를 분석해서 난이도를 판단하고, 두 종류의 문제 세트를 만들어줘.\n\n");

        sb.append("[기사 제목]\n").append(request.articleTitle()).append("\n\n");
        sb.append("[기사 본문]\n").append(request.articleContent()).append("\n\n");

        sb.append("[1단계: 난이도 판단]\n");
        sb.append("어휘 난이도, 문장 길이와 복잡도, 필요한 배경지식 수준을 고려해서 이 기사를 1~5 사이의 정수로 판단해라 ")
                .append("(1=매우 쉬움, 5=매우 어려움). 결과의 level 필드에 이 정수를 넣어라.\n\n");

        sb.append("[2단계: 오늘의 학습 문제 (dailyQuestions) - 총 ").append(totalPerSet).append("개]\n");
        sb.append("사용자가 기사 전문을 이미 읽은 뒤에 푸는 문제야. 아래 5개 카테고리를 각각 ")
                .append(QUESTIONS_PER_CATEGORY).append("개씩 만들어라: ")
                .append("vocab(어휘력), info_extraction(정보추출), core_understanding(핵심파악), ")
                .append("inference_judgment(추론및판단), structure(구조파악).\n");
        sb.append("- questionFormat은 OX, multiple_choice, short_answer 중에서 고르되, ")
                .append("1단계에서 판단한 level이 1이면 절대 short_answer를 쓰지 말고 OX와 multiple_choice만 사용해라. ")
                .append("level이 2 이상이면 세 형식을 자유롭게 섞어라.\n");
        sb.append("- content는 지문 전체를 이미 읽었다는 전제이므로 질문만 있어도 되고, ")
                .append("필요하면 일부 문제에만 실제 기사 문장을 인용해도 된다.\n\n");

        sb.append("[3단계: 게임용 문제 (gameQuestions) - 총 ").append(totalPerSet).append("개]\n");
        sb.append("사용자가 기사를 읽지 않은 상태에서, 문제 안에 포함된 문단 하나만 보고 푸는 문제야. ")
                .append("마찬가지로 5개 카테고리를 각각 ").append(QUESTIONS_PER_CATEGORY).append("개씩 만들어라.\n");
        sb.append("- 모든 문제의 content 맨 앞에 기사에서 실제로 가져온 문단(문장 1~3개 정도)을 그대로 인용해서 ")
                .append("\"[문단] ...\\n\\n[문제] ...\" 형태로 반드시 포함해라. 그 문단만 보고도 답할 수 있어야 한다.\n");
        sb.append("- 오늘의 학습 문제보다 상대적으로 쉬운 문제로 만들어라. ")
                .append("복잡한 추론보다는 문단에 직접 드러난 정보를 확인하는 수준으로 난이도를 낮춰라.\n");
        sb.append("- questionFormat은 난이도(level)와 상관없이 OX, multiple_choice, short_answer를 자유롭게 섞어서 사용해라.\n\n");

        sb.append("[공통 규칙]\n");
        sb.append("1. 각 문제의 subCategory는 mainCategory에 맞는 세부 유형 중 하나를 선택해라.\n");
        sb.append("2. questionFormat이 multiple_choice이면 choices에 보기 4개를 넣고, ")
                .append("answer는 choices 중 하나와 글자까지 정확히 일치해야 한다. ")
                .append("OX면 choices는 빈 배열로 두고 answer는 'O' 또는 'X'로 해라. ")
                .append("short_answer면 choices는 빈 배열로 둬라.\n");
        sb.append("3. 모든 문제에는 정답 근거를 설명하는 explanation을 반드시 채워라.\n");
        sb.append("4. 모든 문제에는 hint를 반드시 채워라. 정답을 직접 알려주지 말고, ")
                .append("기사의 어느 부분을 다시 보면 좋을지 방향만 알려줘라. (빈 문자열 금지)\n");
        sb.append("5. 출력은 지정된 JSON 스키마만 따르고, 스키마 밖의 다른 텍스트는 절대 포함하지 마라.\n");

        return sb.toString();
    }

    private JsonNode buildResponseSchema() {
        ObjectNode root = objectMapper.createObjectNode();
        root.put("type", "OBJECT");

        ObjectNode properties = root.putObject("properties");
        properties.set("level", integerSchema());
        properties.set("dailyQuestions", arrayOf(buildQuestionItemSchema()));
        properties.set("gameQuestions", arrayOf(buildQuestionItemSchema()));

        ArrayNode required = root.putArray("required");
        required.add("level");
        required.add("dailyQuestions");
        required.add("gameQuestions");

        return root;
    }

    private ObjectNode buildQuestionItemSchema() {
        ObjectNode itemSchema = objectMapper.createObjectNode();
        itemSchema.put("type", "OBJECT");

        ObjectNode properties = itemSchema.putObject("properties");
        properties.set("mainCategory", enumStringSchema(enumValues(MainCategory.values())));
        properties.set("subCategory", enumStringSchema(enumValues(SubCategory.values())));
        properties.set("questionFormat", enumStringSchema(enumValues(QuestionFormat.values())));
        properties.set("content", stringSchema());
        properties.set("choices", arrayOfStringSchema());
        properties.set("answer", stringSchema());
        properties.set("explanation", stringSchema());
        properties.set("hint", stringSchema());

        ArrayNode required = itemSchema.putArray("required");
        required.add("mainCategory");
        required.add("subCategory");
        required.add("questionFormat");
        required.add("content");
        required.add("choices");
        required.add("answer");
        required.add("explanation");
        required.add("hint");

        return itemSchema;
    }

    private ObjectNode arrayOf(ObjectNode itemSchema) {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "ARRAY");
        node.set("items", itemSchema);
        return node;
    }

    private ObjectNode enumStringSchema(List<String> values) {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "STRING");
        ArrayNode enumArray = node.putArray("enum");
        values.forEach(enumArray::add);
        return node;
    }

    private ObjectNode stringSchema() {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "STRING");
        return node;
    }

    private ObjectNode integerSchema() {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "INTEGER");
        return node;
    }

    private ObjectNode arrayOfStringSchema() {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("type", "ARRAY");
        node.set("items", stringSchema());
        return node;
    }

    private List<String> enumValues(MainCategory[] values) {
        return Arrays.stream(values).map(MainCategory::name).collect(Collectors.toList());
    }

    private List<String> enumValues(SubCategory[] values) {
        return Arrays.stream(values).map(SubCategory::name).collect(Collectors.toList());
    }

    private List<String> enumValues(QuestionFormat[] values) {
        return Arrays.stream(values).map(QuestionFormat::name).collect(Collectors.toList());
    }
}
