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
@Schema(title = "전체 랭킹 조회 응답 dto", description = "상위 7명 + (7등 밖이면) 내 순위")
public class AllRankingResponse {

    @Schema(description = "상위 7명 랭킹")
    private List<RankingItem> rankings;

    @Schema(description = "내 순위 (7등 밖일 때만 포함, 7등 이내면 null)")
    private RankingItem myRank;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @Schema(title = "랭킹 항목 dto")
    public static class RankingItem {

        @Schema(description = "등수", example = "1")
        private int rank;

        @Schema(description = "닉네임", example = "장서후")
        private String nickname;

        @Schema(description = "경험치", example = "5000")
        private Integer xp;
    }
}
