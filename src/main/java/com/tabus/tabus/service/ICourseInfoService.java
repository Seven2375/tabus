package com.tabus.tabus.service;

import com.tabus.tabus.pojo.entity.CourseInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.time.LocalDateTime;

/**
 * <p>
 * 课程基本信息表 服务类
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
public interface ICourseInfoService extends IService<CourseInfo> {
    Long startCourse(CourseInfo courseInfo);
    void endCourse(Long courseId, LocalDateTime endTime);
}
