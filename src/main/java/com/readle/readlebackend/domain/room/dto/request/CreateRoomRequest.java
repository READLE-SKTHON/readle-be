package com.readle.readlebackend.domain.room.dto.request;

import com.readle.readlebackend.domain.room.enums.Category;
import com.readle.readlebackend.domain.room.enums.Difficulty;
import com.readle.readlebackend.global.validation.AllowedIntValues;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Schema(description = "방 생성 요청")
public class CreateRoomRequest {

    @Schema(description = "뉴스 카테고리 (미입력 시 전체)", example = "경제")
    private Category category;

    @Schema(description = "난이도 (미입력 시 중)", example = "중")
    private Difficulty difficulty;

    @Schema(description = "문제 풀이 제한 시간(초). 15/25/30초, 1/2/3분 단위만 허용", example = "30",
            allowableValues = {"15", "25", "30", "60", "120", "180"})
    @NotNull
    @AllowedIntValues({15, 25, 30, 60, 120, 180})
    private Integer timer;

    @Schema(description = "최대 참가 인원 (최대 4명)", example = "4")
    @NotNull
    @Min(2)
    @Max(4)
    private Integer memberCount;

    @Schema(description = "문제 수. 5/7/10/15/20 문제 단위만 허용", example = "5",
            allowableValues = {"5", "7", "10", "15", "20"})
    @NotNull
    @AllowedIntValues({5, 7, 10, 15, 20})
    private Integer questionCount;
}
