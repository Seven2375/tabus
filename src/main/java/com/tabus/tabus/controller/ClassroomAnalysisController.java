package com.tabus.tabus.controller;


import com.tabus.tabus.common.Result;
import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.service.IClassroomAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


/**
 * 课堂分析控制器，处理课堂分析相关的请求
 */
@RestController
@RequestMapping("/admin/analysis")
public class ClassroomAnalysisController {

    @Autowired
    private IClassroomAnalysisService classroomAnalysisService;

    /**
     * 根据课程 ID 获取课堂分析数据的接口
     * @param courseId 课程 ID
     * @return 课堂分析实体
     */
    @GetMapping("/{courseId}")
    public Result getAnalysis(@PathVariable Long courseId) {
        // 调用课堂分析服务的获取分析数据方法
        return Result.success(classroomAnalysisService.getAnalysisByCourseId(courseId));
    }
    
    /**
     * 获取课堂分析记录列表的接口
     * @param page 当前页码
     * @param size 每页记录数
     * @return 课堂分析记录分页列表
     */
    @GetMapping("/records")
    public Result getAnalysisRecords(
            @RequestParam(value = "page", defaultValue = "1") Integer page,
            @RequestParam(value = "size", defaultValue = "10") Integer size) {
        return Result.success(classroomAnalysisService.getAnalysisRecords(page, size));
    }
}
