package com.readle.readlebackend.domain.question.enums;

/**
 * {@code sub_category_type} Postgres enum 매핑. (NAMED_ENUM 방식, Converter 없음)
 */
public enum SubCategory {
    vocab_appropriateness,
    vocab_meaning,
    vocab_paraphrase,
    info_consistency,
    info_evidence,
    core_topic,
    core_title,
    core_gist,
    core_argument,
    inference_blank,
    inference_implication,
    inference_continuation,
    structure_sentence_insertion,
    structure_order,
    structure_irrelevant_sentence
}
