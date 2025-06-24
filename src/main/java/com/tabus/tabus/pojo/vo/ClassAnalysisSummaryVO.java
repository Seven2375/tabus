package com.tabus.tabus.pojo.vo;

import lombok.Data;
import java.util.List;

@Data
public class ClassAnalysisSummaryVO {
    // 班级基本信息
    private Long classId;
    private String className;
    private Integer totalCourses; // 总课程数

    // 总体统计
    private Double avgRaiseRate; // 平均抬头率
    private Double avgLowerRate; // 平均低头率
    private Double avgParticipation; // 平均参与度

    // 教师情绪平均值
    private Double avgTeacherHappiness;
    private Double avgTeacherAnger;
    private Double avgTeacherNeutral;

    // 趋势数据
    private List<String> dates; // 日期列表
    private List<Double> raiseRates; // 对应的抬头率列表
    private List<Double> lowerRates; // 对应的低头率列表

    // 情绪分布统计
    private EmotionDistribution emotions;

    // 课堂质量评分
    private QualityScore quality;

    @Data
    public static class EmotionDistribution {
        private Double happy;
        private Double neutral;
        private Double sad;
        private Double angry;
    }

    @Data
    public static class QualityScore {
        private Double participation; // 参与度得分
        private Double emotion; // 情绪积极性得分
        private Double focus; // 专注度得分
        private Double interaction; // 互动频率得分
        private Double effect; // 学习效果得分
    }
} 