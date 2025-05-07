package com.tabus.tabus.service.impl;

import com.tabus.tabus.mapper.ClassroomAnalysisMapper;
import com.tabus.tabus.mapper.EmotionRecordMapper;
import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.pojo.entity.CourseInfo;
import com.tabus.tabus.mapper.CourseInfoMapper;
import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.tabus.tabus.service.ICourseInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 课程服务实现类
 */
@Service
public class CourseInfoServiceImpl extends ServiceImpl<CourseInfoMapper, CourseInfo> implements ICourseInfoService {

    @Autowired
    private EmotionRecordMapper emotionRecordMapper;

    @Autowired
    private ClassroomAnalysisMapper classroomAnalysisMapper;

    @Override
    public Long startCourse(CourseInfo courseInfo) {
        // 插入课程信息到数据库
        baseMapper.insert(courseInfo);
        // 返回插入的课程 ID
        return courseInfo.getId();
    }

    @Override
    public void endCourse(Long courseId, LocalDateTime endTime) {
        // 根据课程 ID 查询课程信息
        CourseInfo course = baseMapper.selectById(courseId);
        // 更新课程的结束时间
        course.setEndTime(endTime);
        // 将更新后的课程信息保存到数据库
        baseMapper.updateById(course);

        // 查询该课程下所有学生的情绪记录
        List<EmotionRecord> studentRecords = emotionRecordMapper.selectByCourseIdAndType(courseId, "student");
        // 学生情绪记录的总帧数
        long totalFrames = studentRecords.size();
        // 学生抬头的帧数
        long raiseCount = studentRecords.stream().filter(r -> r.getFaceToken() != null && !r.getFaceToken().isEmpty()).count();
        // 计算学生抬头率
        double raiseRate = totalFrames == 0 ? 0 : (double) raiseCount / totalFrames * 100;

        // 查询该课程下教师的情绪记录
        List<EmotionRecord> teacherRecords = emotionRecordMapper.selectByCourseIdAndType(courseId, "teacher");
        // 计算教师高兴情绪的均值
        double happinessAvg = teacherRecords.stream().mapToDouble(EmotionRecord::getHappiness).average().orElse(0);
        // 计算教师愤怒情绪的均值
        double angerAvg = teacherRecords.stream().mapToDouble(EmotionRecord::getAnger).average().orElse(0);
        // 计算教师平静情绪的均值
        double neutralAvg = teacherRecords.stream().mapToDouble(EmotionRecord::getNeutral).average().orElse(0);

        // 创建课堂分析实体
        ClassroomAnalysis analysis = new ClassroomAnalysis();
        // 设置关联的课程 ID
        analysis.setCourseId(courseId);
        // 设置学生抬头率
        analysis.setStudentRaiseRate(raiseRate);
        // 设置学生低头率
        analysis.setStudentLowerRate(100 - raiseRate);
        // 设置教师高兴情绪的均值
        analysis.setTeacherHappinessAvg(happinessAvg);
        // 设置教师愤怒情绪的均值
        analysis.setTeacherAngerAvg(angerAvg);
        // 设置教师平静情绪的均值
        analysis.setTeacherNeutralAvg(neutralAvg);
        // 将课堂分析数据插入数据库
        classroomAnalysisMapper.insert(analysis);
    }
}
