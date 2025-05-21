package com.tabus.tabus.pojo.vo;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 课堂分析记录视图对象，包含课程信息和分析结果
 */
@Data
public class ClassroomAnalysisRecordVO {
    
    /**
     * 分析记录ID
     */
    private Long id;
    
    /**
     * 课程ID
     */
    private Long courseId;
    
    /**
     * 教师姓名
     */
    private String teacher;
    
    /**
     * 课程名称
     */
    private String courseName;
    
    /**
     * 班级
     */
    private String className;
    
    /**
     * 课程开始时间
     */
    private LocalDateTime startTime;
    
    /**
     * 课程结束时间
     */
    private LocalDateTime endTime;
    
    /**
     * 学生抬头率（百分比）
     */
    private Double studentRaiseRate;
    
    /**
     * 学生低头率（百分比）
     */
    private Double studentLowerRate;
    
    /**
     * 教师高兴值均值
     */
    private Double teacherHappinessAvg;
    
    /**
     * 教师愤怒值均值
     */
    private Double teacherAngerAvg;
    
    /**
     * 教师平静值均值
     */
    private Double teacherNeutralAvg;
} 