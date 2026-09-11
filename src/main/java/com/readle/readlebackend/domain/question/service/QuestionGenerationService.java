package com.readle.readlebackend.domain.question.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.readle.readlebackend.domain.news.entity.News;
import com.readle.readlebackend.domain.news.repository.NewsRepository;
import com.readle.readlebackend.domain.question.client.GeminiClient;
import com.readle.readlebackend.domain.question.dto.GeneratedQuestionDto;
import com.readle.readlebackend.domain.question.dto.QuestionGenerationRequest;
import com.readle.readlebackend.domain.question.dto.QuestionGenerationResult;
import com.readle.readlebackend.domain.question.entity.Question;
import com.readle.readlebackend.domain.question.enums.GameMode;
import com.readle.readlebackend.domain.question.enums.MainCategory;
import com.readle.readlebackend.domain.question.enums.QuestionFormat;
import com.readle.readlebackend.domain.question.enums.SubCategory;
import com.readle.readlebackend.domain.question.exception.QuestionErrorCode;
import com.readle.readlebackend.domain.question.repository.QuestionRepository;
import com.readle.readlebackend.global.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 지정된 newsId의 기사를 대상으로 (1) 난이도 1~5 판단, (2) 오늘의 학습 문제 10개,
 * (3) 게임용 문제 10개를 한 번의 Gemini 호출로 생성하고, 생성된 문제들을 questions 테이블에 저장한다.
 *
 * <p>이미 questions.news_id로 참조된 적 있는(=문제가 이미 생성된) 기사는 다시 문제를 만들지 않는다.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionGenerationService {

    /** 대분류(main_category) 하나당 각 문제 세트(오늘의 학습/게임)에서 생성할 개수. 5개 카테고리 x 2개 = 세트당 10개. */
    private static final int QUESTIONS_PER_CATEGORY = 2;

    private final GeminiClient geminiClient;
    private final ObjectMapper objectMapper;
    private final QuestionRepository questionRepository;
    private final NewsRepository newsRepository;

    @Transactional
    public QuestionGenerationResult generate(Long newsId) {
        News news = newsRepository.findById(newsId)
                .orElseThrow(() -> new CustomException(QuestionErrorCode.ARTICLE_NOT_FOUND));

        if (questionRepository.existsByNewsId(newsId)) {
            throw new CustomException(QuestionErrorCode.ARTICLE_ALREADY_HAS_QUESTIONS);
        }

        String prompt = buildMakeQuestionPrompt(news.getTitle(), news.getContent());
        JsonNode schema = buildResponseSchema();

        String rawJson = geminiClient.generateJson(prompt, schema);

        QuestionGenerationResult result;
        try {
            result = objectMapper.readValue(rawJson, QuestionGenerationResult.class);
        } catch (IOException e) {
            log.error("Gemini 응답 JSON 파싱 실패. raw={}", rawJson, e);
            throw new CustomException(QuestionErrorCode.GEMINI_RESPONSE_PARSE_ERROR);
        }

        news.updateLevel(result.level());
        newsRepository.save(news);

        saveQuestions(result, news.getId());

        long completedCount = questionRepository.countDistinctNewsId();
        long totalCount = newsRepository.count();
        log.info("[QuestionGenerationService] 기사 처리 완료: news_id={}, title=\"{}\", level={} | 진행 상황 {}/{}개 기사 완료",
                news.getId(), news.getTitle(), result.level(), completedCount, totalCount);

        return result;
    }

    /** 생성된 dailyQuestions/gameQuestions를 Question 엔티티로 변환해서 저장한다. */
    private void saveQuestions(QuestionGenerationResult result, Long newsId) {
        List<Question> questions = new ArrayList<>();

        for (GeneratedQuestionDto dto : result.dailyQuestions()) {
            questions.add(toQuestionEntity(dto, GameMode.daily_solo, result.level(), newsId));
        }
        for (GeneratedQuestionDto dto : result.gameQuestions()) {
            questions.add(toQuestionEntity(dto, GameMode.room, result.level(), newsId));
        }

        questionRepository.saveAll(questions);
        log.info("문제 {}개 저장 완료 (news_id={})", questions.size(), newsId);
    }

    private Question toQuestionEntity(GeneratedQuestionDto dto, GameMode gameMode, Integer level, Long newsId) {
        String choicesJson;
        try {
            choicesJson = objectMapper.writeValueAsString(dto.choices());
        } catch (IOException e) {
            log.error("choices 직렬화 실패", e);
            throw new CustomException(QuestionErrorCode.GEMINI_RESPONSE_PARSE_ERROR);
        }

        return Question.builder()
                .newsId(newsId)
                .content(dto.content())
                .questionFormat(dto.questionFormat())
                .choices(choicesJson)
                .answer(dto.answer())
                .explanation(dto.explanation())
                .hint(dto.hint())
                .gameMode(gameMode)
                .mainCategory(dto.mainCategory())
                .subCategory(dto.subCategory())
                .level(level)
                .build();
    }

    private String buildMakeQuestionPrompt(String articleTitle, String articleContent) {
        int totalPerSet = QUESTIONS_PER_CATEGORY * MainCategory.values().length;

        // 고정 지침(캐싱 가능성을 위해 항상 동일한 내용)을 먼저 쓰고, 기사 제목/본문(매번 달라지는 내용)은 맨 뒤에 붙인다.
        // Gemini의 암묵적 캐싱은 "요청 앞부분이 이전 요청과 동일할 때" 작동하므로, 이 순서를 지켜야 캐싱이 걸릴 수 있다.
        StringBuilder sb = new StringBuilder();
        sb.append("너는 한국 대학생 문해력 학습 앱 'Readle'의 문제 출제자야. 기사 본문은 맨 마지막에 주어진다. ");
        sb.append("아래 지침에 따라 기사를 분석해서 난이도를 판단하고, 두 종류의 문제 세트를 만들어줘.\n\n");

        sb.append("[1단계: 난이도 판단]\n");
        sb.append("어휘 난이도, 문장 길이와 복잡도, 필요한 배경지식 수준을 고려해서 이 기사를 1~5 사이의 정수로 판단해라 ")
                .append("(1=매우 쉬움, 5=매우 어려움). 결과의 level 필드에 이 정수를 넣어라.\n\n");

        sb.append("[2단계: 오늘의 학습 문제 (dailyQuestions) - 총 ").append(totalPerSet).append("개]\n");
        sb.append("사용자가 기사 전문을 이미 읽은 뒤에 푸는 문제야. 아래 5개 카테고리를 각각 ")
                .append(QUESTIONS_PER_CATEGORY).append("개씩 만들어라: ")
                .append("vocab(어휘력), info_extraction(정보추출), core_understanding(핵심파악), ")
                .append("inference_judgment(추론및판단), structure(구조파악).\n");
        sb.append("- questionFormat은 OX, multiple_choice, short_answer 중에서 고르되, level이 1이면 short_answer는 절대 쓰지 말고 ")
                .append("OX·multiple_choice만 사용해라. level이 2 이상이면 세 형식을 자유롭게 섞어라.\n");
        sb.append("- content는 질문만 있어도 되고, 필요하면 일부 문제에만 실제 기사 문장을 인용해도 된다.\n\n");

        sb.append("[3단계: 게임용 문제 (gameQuestions) - 총 ").append(totalPerSet).append("개]\n");
        sb.append("사용자가 기사를 읽지 않은 상태에서, 문제 안에 포함된 문단 하나만 보고 푸는 문제야. ")
                .append("마찬가지로 5개 카테고리를 각각 ").append(QUESTIONS_PER_CATEGORY).append("개씩 만들어라.\n");
        sb.append("- 모든 문제의 content 맨 앞에 기사에서 실제로 가져온 문단(문장 1~3개 정도)을 그대로 인용해서 ")
                .append("\"[문단] ...\\n\\n[문제] ...\" 형태로 반드시 포함해라. 그 문단만 보고도 답할 수 있어야 한다.\n");
        sb.append("- dailyQuestions보다 쉽게 만들어라: 복잡한 추론보다는 문단에 직접 드러난 정보를 확인하는 수준으로.\n");
        sb.append("- questionFormat은 level과 상관없이 OX, multiple_choice, short_answer를 자유롭게 섞어서 사용해라.\n\n");

        sb.append("[subCategory 설명 - 정확히 이 뜻에 맞는 것만 골라서 사용해라]\n");
        sb.append("- vocab_appropriateness: 문맥상 단어를 다른 단어로 바꿔도 어색하지 않은지(적절성)를 판단\n");
        sb.append("- vocab_meaning: 특정 단어/표현의 뜻(사전적·문맥적 의미)을 직접 물음\n");
        sb.append("- vocab_paraphrase: 같은 의미의 다른 표현으로 바꿔 쓰기\n");
        sb.append("- info_consistency: 진술이 지문 내용과 일치/불일치하는지(사실 확인)\n");
        sb.append("- info_evidence: 주장이나 결론의 근거가 되는 문장을 찾기\n");
        sb.append("- core_topic: 글이 '무엇에 대해' 다루는지 중심 소재/화제 (결론이 아니라 대상)\n");
        sb.append("- core_title: 이 글에 어울리는 제목 고르기\n");
        sb.append("- core_gist: 글쓴이가 최종적으로 전달하려는 핵심 메시지/결론 (core_topic과 달리 '그래서 결론이 뭔지'에 초점)\n");
        sb.append("- core_argument: 글쓴이나 등장인물의 주장/견해 파악\n");
        sb.append("- inference_blank: 빈칸에 들어갈 말을 문맥으로 추론\n");
        sb.append("- inference_implication: 직접 쓰이지 않은 함축적 의미나 의도를 추론\n");
        sb.append("- inference_continuation: 지문 뒤에 이어질 내용을 추론\n");
        sb.append("- structure_sentence_insertion: 주어진 문장이 들어갈 자연스러운 위치 찾기\n");
        sb.append("- structure_order: 문단/문장을 논리적으로 올바른 순서로 배열\n");
        sb.append("- structure_irrelevant_sentence: 지문의 흐름과 관련 없는 문장 찾기\n\n");

        sb.append("[공통 규칙]\n");
        sb.append("1. subCategory는 위 설명에 정확히 부합하는 것만 골라라. 같은 mainCategory 안에서도 서로 다른 subCategory를 ")
                .append("다양하게 써서 같은 세트 안에 내용이 겹치지 않게 해라.\n");
        sb.append("2. multiple_choice는 choices 4개 + answer는 그중 하나와 글자까지 일치. OX는 choices 빈 배열 + answer는 'O' 또는 'X'. ")
                .append("short_answer는 choices 빈 배열.\n");
        sb.append("3. explanation은 정답 근거를 알차고 구체적으로 설명하는 한 문장으로 반드시 채워라.\n");
        sb.append("4. hint는 정답을 직접 알려주지 말고 기사의 어느 부분을 다시 보면 좋을지 방향을 알려주는 한 문장으로 반드시 채워라. ")
                .append("(빈 문자열 금지)\n");
        sb.append("5. explanation·hint는 각각 정확히 한 문장(줄바꿈·나열 금지)만 작성해라.\n");
        sb.append("6. 출력은 지정된 JSON 스키마만 따르고, 스키마 밖의 다른 텍스트는 절대 포함하지 마라.\n\n");

        sb.append("[기사 제목]\n").append(articleTitle).append("\n\n");
        sb.append("[기사 본문]\n").append(articleContent);

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
