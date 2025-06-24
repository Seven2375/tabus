package com.tabus.tabus.controller;


import com.tabus.tabus.common.Result;
import com.tabus.tabus.pojo.entity.CourseInfo;
import com.tabus.tabus.service.ICourseInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * 课程控制器，处理课程相关的请求
 */
@RestController
@RequestMapping("/admin/course")
public class CourseInfoController {
    @Autowired
    private ICourseInfoService courseService;


    /**
     * 开始一门课程的接口
     * @param courseInfo 课程信息实体
     * @return 课程的 ID
     */
    @PostMapping("/start")
    public Result startCourse(@RequestBody CourseInfo courseInfo) {
        // 设置课程的开始时间为当前时间
        courseInfo.setStartTime(LocalDateTime.now());
        // 调用课程服务的开始课程方法
        return Result.success(courseService.startCourse(courseInfo));
    }

    /**
     * 结束一门课程的接口
     * @param courseId 课程 ID
     */
    @PostMapping("/end")
    public Result endCourse(Long courseId) {
        // 调用课程服务的结束课程方法，结束时间为当前时间
        courseService.endCourse(courseId, LocalDateTime.now());
        return Result.success();
    }

    @GetMapping("/list")
    public Result list() {
        return Result.success(courseService.list());
    }

    @PostMapping("/add")
    public Result add(@RequestBody CourseInfo courseInfo) {
        // 自动设置课程开始时间为当前时间
        courseInfo.setStartTime(java.time.LocalDateTime.now());
        courseService.save(courseInfo);
        return Result.success();
    }

    @PutMapping("/update")
    public Result update(@RequestBody CourseInfo courseInfo) {
        courseService.updateById(courseInfo);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Long id) {
        courseService.removeById(id);
        return Result.success();
    }
}
