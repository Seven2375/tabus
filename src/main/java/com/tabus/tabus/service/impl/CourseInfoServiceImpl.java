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
 * <p>
 * 课程基本信息表 服务实现类
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
@Service
public class CourseInfoServiceImpl extends ServiceImpl<CourseInfoMapper, CourseInfo> implements ICourseInfoService {

    @Autowired
    private EmotionRecordMapper emotionRecordMapper;

    @Autowired
    private ClassroomAnalysisMapper classroomAnalysisMapper;

    @Override
    public Long startCourse(CourseInfo courseInfo) {
        baseMapper.insert(courseInfo);
        return courseInfo.getId();
    }

    @Override
    public void endCourse(Long courseId, LocalDateTime endTime) {
        CourseInfo course = baseMapper.selectById(courseId);
        course.setEndTime(endTime);
        baseMapper.updateById(course);

        List<EmotionRecord> studentRecords = emotionRecordMapper.selectByCourseIdAndType(courseId, "student");
        long totalFrames = studentRecords.size();
        long raiseCount = studentRecords.stream().filter(r -> r.getFaceToken() != null && !r.getFaceToken().isEmpty()).count();
        double raiseRate = totalFrames == 0 ? 0 : (double) raiseCount / totalFrames * 100;

        List<EmotionRecord> teacherRecords = emotionRecordMapper.selectByCourseIdAndType(courseId, "teacher");
        double happinessAvg = teacherRecords.stream().mapToDouble(EmotionRecord::getHappiness).average().orElse(0);
        double angerAvg = teacherRecords.stream().mapToDouble(EmotionRecord::getAnger).average().orElse(0);
        double neutralAvg = teacherRecords.stream().mapToDouble(EmotionRecord::getNeutral).average().orElse(0);

        ClassroomAnalysis analysis = new ClassroomAnalysis();
        analysis.setCourseId(courseId);
        analysis.setStudentRaiseRate(raiseRate);
        analysis.setStudentLowerRate(100 - raiseRate);
        analysis.setTeacherHappinessAvg(happinessAvg);
        analysis.setTeacherAngerAvg(angerAvg);
        analysis.setTeacherNeutralAvg(neutralAvg);
        classroomAnalysisMapper.insert(analysis);
    }
}
