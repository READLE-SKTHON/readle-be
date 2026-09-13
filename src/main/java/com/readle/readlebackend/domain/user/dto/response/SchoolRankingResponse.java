package com.readle.readlebackend.domain.user.dto.response;

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
@Schema(title = "학교별 랭킹 조회 응답 dto", description = "학교 소속 학생들의 xp 평균 기준 상위 7개교 + 내 학교 순위")
public class SchoolRankingResponse {

    @Schema(description = "상위 7개교 랭킹")
    private List<RankingItem> rankings;

    @Schema(description = "내 학교 순위 (7등 밖일 때만 포함, 7등 이내면 null)")
    private RankingItem myRank;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "학교 랭킹 항목 dto")
    public static class RankingItem {

        @Schema(description = "등수", example = "1")
        private int rank;

        @Schema(description = "학교명 (schools.school_name)", example = "서경대학교")
        private String schoolName;

        @Schema(description = "소속 학생 xp 평균 (반올림)", example = "115")
        private int avgXp;
    }
}
