package com.readle.readlebackend.domain.school.entity;

import com.readle.readlebackend.domain.user.entity.User;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "schools")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class School {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "school_id")
    private Long id;

    @Column(nullable = false, length = 50)
    private String schoolName;

    private Long point;

    private Integer schoolAvg;

    // 소속 학생들의 xp 평균 계산
    public int calculateAvgXp(List<User> allUsers) {
        int xpSum = 0;
        int studentCount = 0;
        for (User user : allUsers) {
            if (this.id.equals(user.getSchoolId())) {
                xpSum += user.getXp() == null ? 0 : user.getXp();
                studentCount++;
            }
        }
        return studentCount == 0 ? 0 : xpSum / studentCount;
    }
}
