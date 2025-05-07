package com.tabus.tabus.service.impl;

import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.mapper.ClassroomAnalysisMapper;
import com.tabus.tabus.service.IClassroomAnalysisService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 课堂分析服务实现类
 */
@Service
public class ClassroomAnalysisServiceImpl extends ServiceImpl<ClassroomAnalysisMapper, ClassroomAnalysis> implements IClassroomAnalysisService {

    @Autowired
    private ClassroomAnalysisMapper classroomAnalysisMapper;

    @Override
    public ClassroomAnalysis getAnalysisByCourseId(Long courseId) {
        // 根据课程 ID 查询课堂分析数据
        return classroomAnalysisMapper.selectByCourseId(courseId);
    }
}
