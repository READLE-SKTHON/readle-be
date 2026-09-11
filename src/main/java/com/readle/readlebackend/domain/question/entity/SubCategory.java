package com.readle.readlebackend.domain.question.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * {@code sub_category_type} Postgres enum 매핑.
 */
public enum SubCategory {
    VOCAB_APPROPRIATENESS("vocab_appropriateness"),
    VOCAB_MEANING("vocab_meaning"),
    VOCAB_PARAPHRASE("vocab_paraphrase"),
    INFO_CONSISTENCY("info_consistency"),
    INFO_EVIDENCE("info_evidence"),
    CORE_TOPIC("core_topic"),
    CORE_TITLE("core_title"),
    CORE_GIST("core_gist"),
    CORE_ARGUMENT("core_argument"),
    INFERENCE_BLANK("inference_blank"),
    INFERENCE_IMPLICATION("inference_implication"),
    INFERENCE_CONTINUATION("inference_continuation"),
    STRUCTURE_SENTENCE_INSERTION("structure_sentence_insertion"),
    STRUCTURE_ORDER("structure_order"),
    STRUCTURE_IRRELEVANT_SENTENCE("structure_irrelevant_sentence");

    private final String value;

    SubCategory(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static SubCategory fromValue(String value) {
        for (SubCategory category : values()) {
            if (category.value.equals(value)) {
                return category;
            }
        }
        throw new IllegalArgumentException("Unknown sub_category_type value: " + value);
    }
}
