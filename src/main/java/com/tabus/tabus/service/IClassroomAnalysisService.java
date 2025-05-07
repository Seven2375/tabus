package com.tabus.tabus.service;

import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 课堂分析服务接口，提供课堂分析相关的业务操作
 */
public interface IClassroomAnalysisService extends IService<ClassroomAnalysis> {
    /**
     * 根据课程 ID 获取课堂分析数据
     * @param courseId 课程 ID
     * @return 课堂分析实体
     */
    ClassroomAnalysis getAnalysisByCourseId(Long courseId);
}
