package com.tabus.tabus.service;

/**
 * 教学评估服务接口，提供教学评估相关的业务操作
 */
public interface IAssessmentService {
    /**
     * 根据课程 ID 评估教学情况
     * @param courseId 课程 ID
     * @return 教学评估结果字符串
     */
    String assessTeaching(Long courseId);
}
