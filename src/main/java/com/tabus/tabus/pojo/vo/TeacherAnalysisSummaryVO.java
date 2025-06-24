package com.tabus.tabus.pojo.vo;

import lombok.Data;
import java.util.List;

@Data
public class TeacherAnalysisSummaryVO {
    // 教师基本信息
    private Long teacherId;
    private String teacherName;
    private Integer totalCourses; // 总课程数

    // 教师情绪平均值
    private Double avgHappiness;
    private Double avgAnger;
    private Double avgNeutral;

    // 趋势数据 (用于详情页)
    private List<String> dates;
    private List<Double> happinessRates;
    private List<Double> angerRates;
    private List<Double> neutralRates;
} 