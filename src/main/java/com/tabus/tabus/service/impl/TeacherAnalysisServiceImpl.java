package com.tabus.tabus.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.tabus.tabus.mapper.ClassroomAnalysisMapper;
import com.tabus.tabus.mapper.CourseInfoMapper;
import com.tabus.tabus.mapper.TeacherMapper;
import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.pojo.entity.CourseInfo;
import com.tabus.tabus.pojo.entity.Teacher;
import com.tabus.tabus.pojo.vo.TeacherAnalysisSummaryVO;
import com.tabus.tabus.service.ITeacherAnalysisService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TeacherAnalysisServiceImpl implements ITeacherAnalysisService {

    private final TeacherMapper teacherMapper;
    private final CourseInfoMapper courseInfoMapper;
    private final ClassroomAnalysisMapper classroomAnalysisMapper;

    @Override
    public List<TeacherAnalysisSummaryVO> getTeacherAnalysisSummaryList() {
        // 1. 获取所有教师
        List<Teacher> teachers = teacherMapper.selectList(null);

        // 2. 为每位教师计算分析数据
        return teachers.stream().map(teacher -> {
            TeacherAnalysisSummaryVO summary = new TeacherAnalysisSummaryVO();
            summary.setTeacherId(teacher.getId());
            summary.setTeacherName(teacher.getName());

            // 3. 获取该教师的所有课程
            List<CourseInfo> courses = courseInfoMapper.selectList(
                new LambdaQueryWrapper<CourseInfo>().eq(CourseInfo::getTeacherId, teacher.getId())
            );
            summary.setTotalCourses(courses.size());

            if (courses.isEmpty()) {
                summary.setAvgHappiness(0.0);
                summary.setAvgAnger(0.0);
                summary.setAvgNeutral(0.0);
                return summary;
            }

            // 4. 获取所有课程的分析数据
            List<Long> courseIds = courses.stream().map(CourseInfo::getId).collect(Collectors.toList());
            List<ClassroomAnalysis> analyses = classroomAnalysisMapper.selectList(
                new LambdaQueryWrapper<ClassroomAnalysis>().in(ClassroomAnalysis::getCourseId, courseIds)
            );

            // 5. 计算平均情绪
            summary.setAvgHappiness(analyses.stream().mapToDouble(ClassroomAnalysis::getTeacherHappinessAvg).average().orElse(0.0));
            summary.setAvgAnger(analyses.stream().mapToDouble(ClassroomAnalysis::getTeacherAngerAvg).average().orElse(0.0));
            summary.setAvgNeutral(analyses.stream().mapToDouble(ClassroomAnalysis::getTeacherNeutralAvg).average().orElse(0.0));

            return summary;
        }).collect(Collectors.toList());
    }

    @Override
    public TeacherAnalysisSummaryVO getTeacherAnalysisDetail(Long teacherId) {
        // 1. 获取教师基本信息和课程、情绪平均值
        TeacherAnalysisSummaryVO detail = getTeacherAnalysisSummaryList().stream()
                .filter(s -> s.getTeacherId().equals(teacherId))
                .findFirst()
                .orElse(new TeacherAnalysisSummaryVO());

        // 2. 获取该教师的所有课程，并按时间排序
        List<CourseInfo> courses = courseInfoMapper.selectList(
            new LambdaQueryWrapper<CourseInfo>()
                .eq(CourseInfo::getTeacherId, teacherId)
                .orderByAsc(CourseInfo::getStartTime)
        );

        // 初始化趋势列表
        detail.setDates(new ArrayList<>());
        detail.setHappinessRates(new ArrayList<>());
        detail.setAngerRates(new ArrayList<>());
        detail.setNeutralRates(new ArrayList<>());

        if (courses.isEmpty()) {
            return detail;
        }

        // 3. 获取所有课程的分析数据
        Map<Long, List<ClassroomAnalysis>> analysisMap = classroomAnalysisMapper.selectList(
            new LambdaQueryWrapper<ClassroomAnalysis>()
                .in(ClassroomAnalysis::getCourseId, courses.stream().map(CourseInfo::getId).collect(Collectors.toList()))
        ).stream().collect(Collectors.groupingBy(ClassroomAnalysis::getCourseId));

        // 4. 填充趋势数据
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
        for (CourseInfo course : courses) {
            List<ClassroomAnalysis> analysisList = analysisMap.get(course.getId());
            if (analysisList != null && !analysisList.isEmpty()) {
                detail.getDates().add(course.getStartTime().format(formatter));
                double avgHappiness = analysisList.stream().mapToDouble(ClassroomAnalysis::getTeacherHappinessAvg).average().orElse(0.0);
                double avgAnger = analysisList.stream().mapToDouble(ClassroomAnalysis::getTeacherAngerAvg).average().orElse(0.0);
                double avgNeutral = analysisList.stream().mapToDouble(ClassroomAnalysis::getTeacherNeutralAvg).average().orElse(0.0);
                detail.getHappinessRates().add(avgHappiness);
                detail.getAngerRates().add(avgAnger);
                detail.getNeutralRates().add(avgNeutral);
            }
        }
        return detail;
    }
} 