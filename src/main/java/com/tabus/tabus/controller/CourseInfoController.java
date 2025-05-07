package com.tabus.tabus.controller;


import com.tabus.tabus.pojo.entity.CourseInfo;
import com.tabus.tabus.service.ICourseInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

/**
 * <p>
 * 课程基本信息表 前端控制器
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
@RestController
@RequestMapping("/admin/course")
public class CourseInfoController {
    @Autowired
    private ICourseInfoService courseService;

    @PostMapping("/start")
    public Long startCourse(@RequestBody CourseInfo courseInfo) {
        courseInfo.setStartTime(LocalDateTime.now());
        return courseService.startCourse(courseInfo);
    }

    @PostMapping("/end")
    public void endCourse(Long courseId) {
        courseService.endCourse(courseId, LocalDateTime.now());
    }
}
