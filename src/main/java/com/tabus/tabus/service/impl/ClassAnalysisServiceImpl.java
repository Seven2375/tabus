package com.tabus.tabus.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.tabus.tabus.mapper.ClassNameMapper;
import com.tabus.tabus.mapper.ClassroomAnalysisMapper;
import com.tabus.tabus.mapper.CourseInfoMapper;
import com.tabus.tabus.mapper.EmotionRecordMapper;
import com.tabus.tabus.pojo.entity.ClassName;
import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.pojo.entity.CourseInfo;
import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.tabus.tabus.pojo.vo.ClassAnalysisSummaryVO;
import com.tabus.tabus.service.IClassAnalysisService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ClassAnalysisServiceImpl implements IClassAnalysisService {

    private final ClassNameMapper classNameMapper;
    private final CourseInfoMapper courseInfoMapper;
    private final ClassroomAnalysisMapper classroomAnalysisMapper;
    private final EmotionRecordMapper emotionRecordMapper;

    @Override
    public ClassAnalysisSummaryVO getClassAnalysisSummary(Long classId) {
        ClassAnalysisSummaryVO summary = new ClassAnalysisSummaryVO();
        
        // 1. 获取班级基本信息
        ClassName className = classNameMapper.selectById(classId);
        if (className == null) {
            return summary;
        }
        summary.setClassId(classId);
        summary.setClassName(className.getName());

        // 2. 获取该班级的所有课程
        List<CourseInfo> courses = courseInfoMapper.selectList(
            new LambdaQueryWrapper<CourseInfo>()
                .eq(CourseInfo::getClassId, classId)
        );
        summary.setTotalCourses(courses.size());

        if (courses.isEmpty()) {
            return summary;
        }

        // 3. 获取所有课程的分析数据
        List<Long> courseIds = courses.stream()
            .map(CourseInfo::getId)
            .collect(Collectors.toList());

        List<ClassroomAnalysis> analyses = classroomAnalysisMapper.selectList(
            new LambdaQueryWrapper<ClassroomAnalysis>()
                .in(ClassroomAnalysis::getCourseId, courseIds)
        );

        if (analyses.isEmpty()) {
            return summary;
        }

        // 4. 计算平均值
        double avgRaiseRate = analyses.stream()
            .mapToDouble(ClassroomAnalysis::getStudentRaiseRate)
            .average()
            .orElse(0.0);
        double avgLowerRate = analyses.stream()
            .mapToDouble(ClassroomAnalysis::getStudentLowerRate)
            .average()
            .orElse(0.0);
        double avgTeacherHappiness = analyses.stream()
            .mapToDouble(ClassroomAnalysis::getTeacherHappinessAvg)
            .average()
            .orElse(0.0);
        double avgTeacherAnger = analyses.stream()
            .mapToDouble(ClassroomAnalysis::getTeacherAngerAvg)
            .average()
            .orElse(0.0);
        double avgTeacherNeutral = analyses.stream()
            .mapToDouble(ClassroomAnalysis::getTeacherNeutralAvg)
            .average()
            .orElse(0.0);

        summary.setAvgRaiseRate(avgRaiseRate);
        summary.setAvgLowerRate(avgLowerRate);
        summary.setAvgParticipation(avgRaiseRate); // 暂时用抬头率代表参与度
        summary.setAvgTeacherHappiness(avgTeacherHappiness);
        summary.setAvgTeacherAnger(avgTeacherAnger);
        summary.setAvgTeacherNeutral(avgTeacherNeutral);

        return summary;
    }

    @Override
    public ClassAnalysisSummaryVO getClassAnalysisDetail(Long classId) {
        ClassAnalysisSummaryVO detail = getClassAnalysisSummary(classId);

        // 1. 获取该班级的所有课程
        List<CourseInfo> courses = courseInfoMapper.selectList(
            new LambdaQueryWrapper<CourseInfo>()
                .eq(CourseInfo::getClassId, classId)
                .orderByAsc(CourseInfo::getStartTime)
        );

        // 初始化默认值，防止前端空指针
        if (detail.getDates() == null) detail.setDates(new ArrayList<>());
        if (detail.getRaiseRates() == null) detail.setRaiseRates(new ArrayList<>());
        if (detail.getLowerRates() == null) detail.setLowerRates(new ArrayList<>());
        if (detail.getEmotions() == null) {
            ClassAnalysisSummaryVO.EmotionDistribution emotionDist = new ClassAnalysisSummaryVO.EmotionDistribution();
            emotionDist.setHappy(0.0);
            emotionDist.setNeutral(0.0);
            emotionDist.setSad(0.0);
            emotionDist.setAngry(0.0);
            detail.setEmotions(emotionDist);
        }
        if (detail.getQuality() == null) {
            ClassAnalysisSummaryVO.QualityScore quality = new ClassAnalysisSummaryVO.QualityScore();
            quality.setParticipation(0.0);
            quality.setEmotion(0.0);
            quality.setFocus(0.0);
            quality.setInteraction(0.0);
            quality.setEffect(0.0);
            detail.setQuality(quality);
        }

        if (courses.isEmpty()) {
            return detail;
        }

        // 2. 获取趋势数据
        List<String> dates = new ArrayList<>();
        List<Double> raiseRates = new ArrayList<>();
        List<Double> lowerRates = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");

        Map<Long, List<ClassroomAnalysis>> analysisMap = classroomAnalysisMapper.selectList(
            new LambdaQueryWrapper<ClassroomAnalysis>()
                .in(ClassroomAnalysis::getCourseId, courses.stream().map(CourseInfo::getId).collect(Collectors.toList()))
        ).stream().collect(Collectors.groupingBy(ClassroomAnalysis::getCourseId));

        for (CourseInfo course : courses) {
            List<ClassroomAnalysis> analysisList = analysisMap.get(course.getId());
            if (analysisList != null && !analysisList.isEmpty()) {
                String date = course.getStartTime().format(formatter);
                double avgRaise = analysisList.stream().mapToDouble(ClassroomAnalysis::getStudentRaiseRate).average().orElse(0.0);
                double avgLower = analysisList.stream().mapToDouble(ClassroomAnalysis::getStudentLowerRate).average().orElse(0.0);
                dates.add(date);
                raiseRates.add(avgRaise);
                lowerRates.add(avgLower);
            }
        }

        detail.setDates(dates);
        detail.setRaiseRates(raiseRates);
        detail.setLowerRates(lowerRates);

        // 3. 计算情绪分布
        List<EmotionRecord> emotions = emotionRecordMapper.selectList(
            new LambdaQueryWrapper<EmotionRecord>()
                .in(EmotionRecord::getCourseId, courses.stream().map(CourseInfo::getId).collect(Collectors.toList()))
                .eq(EmotionRecord::getType, "student")
        );

        ClassAnalysisSummaryVO.EmotionDistribution emotionDist = detail.getEmotions();
        if (emotions != null && !emotions.isEmpty()) {
            emotionDist.setHappy(emotions.stream().mapToDouble(EmotionRecord::getHappiness).average().orElse(0.0));
            emotionDist.setNeutral(emotions.stream().mapToDouble(EmotionRecord::getNeutral).average().orElse(0.0));
            emotionDist.setSad(emotions.stream().mapToDouble(EmotionRecord::getSadness).average().orElse(0.0));
            emotionDist.setAngry(emotions.stream().mapToDouble(EmotionRecord::getAnger).average().orElse(0.0));
        }
        detail.setEmotions(emotionDist);

        // 4. 计算课堂质量评分
        ClassAnalysisSummaryVO.QualityScore quality = detail.getQuality();
        quality.setParticipation(detail.getAvgRaiseRate() != null ? detail.getAvgRaiseRate() : 0.0); // 参与度用抬头率表示
        quality.setEmotion(emotionDist.getHappy() != null ? emotionDist.getHappy() * 100 : 0.0); // 情绪积极性用快乐值表示
        quality.setFocus(detail.getAvgLowerRate() != null ? 100 - detail.getAvgLowerRate() : 0.0); // 专注度用(100-低头率)表示
        quality.setInteraction(70.0); // 互动频率暂时固定值
        quality.setEffect(75.0); // 学习效果暂时固定值
        detail.setQuality(quality);

        return detail;
    }
} 