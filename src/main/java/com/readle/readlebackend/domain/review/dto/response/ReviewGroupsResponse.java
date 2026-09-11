package com.readle.readlebackend.domain.review.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(title = "날짜/소분류별 틀린 문제 목록 응답 dto", description = "선택한 대분류 안에서, 현재(최신 제출 기준) 틀린 문제가 있는 (날짜, 소분류) 조합만 나열. 다 맞추면 목록에서 사라짐")
public class ReviewGroupsResponse {

    @Schema(description = "날짜/소분류 그룹 목록 (최신 날짜순)")
    private List<GroupItem> groups;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "날짜/소분류 그룹 dto")
    public static class GroupItem {

        @Schema(description = "가장 최근에 틀린 날짜 (yyyy-MM-dd)", example = "2026-09-28")
        private String date;

        @Schema(description = "능력치 소분류", example = "vocab_appropriateness")
        private String subCategory;

        @Schema(description = "이 날짜/소분류에서 현재 틀린 문제 개수", example = "4")
        private long wrongCount;
    }
}
