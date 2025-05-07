package com.tabus.tabus.service;

import com.tabus.tabus.pojo.entity.CourseInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.time.LocalDateTime;

/**
 * 课程服务接口，提供课程相关的业务操作
 */
public interface ICourseInfoService extends IService<CourseInfo> {
    /**
     * 开始一门课程，将课程信息插入数据库
     * @param courseInfo 课程信息实体
     * @return 课程的 ID
     */
    Long startCourse(CourseInfo courseInfo);

    /**
     * 结束一门课程，更新课程结束时间，并统计相关分析数据
     * @param courseId 课程 ID
     * @param endTime 课程结束时间
     */
    void endCourse(Long courseId, LocalDateTime endTime);
}
