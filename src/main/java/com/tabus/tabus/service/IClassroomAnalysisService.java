package com.tabus.tabus.service;

import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 课堂分析数据表 服务类
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
public interface IClassroomAnalysisService extends IService<ClassroomAnalysis> {
    ClassroomAnalysis getAnalysisByCourseId(Long courseId);
}
