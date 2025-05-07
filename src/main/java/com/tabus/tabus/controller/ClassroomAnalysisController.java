package com.tabus.tabus.controller;


import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.service.IClassroomAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 课堂分析数据表 前端控制器
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
@RestController
@RequestMapping("/admin/analysis")
public class ClassroomAnalysisController {

    @Autowired
    private IClassroomAnalysisService classroomAnalysisService;

    @GetMapping("/{courseId}")
    public ClassroomAnalysis getAnalysis(@PathVariable Long courseId) {
        return classroomAnalysisService.getAnalysisByCourseId(courseId);
    }
}
