package com.tabus.tabus.controller;

import com.tabus.tabus.common.Result;
import com.tabus.tabus.service.ITeacherAnalysisService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/teacher-analysis")
@RequiredArgsConstructor
public class TeacherAnalysisController {

    private final ITeacherAnalysisService teacherAnalysisService;

    @GetMapping("/summary-list")
    public Result getSummaryList() {
        return Result.success(teacherAnalysisService.getTeacherAnalysisSummaryList());
    }

    @GetMapping("/{teacherId}/detail")
    public Result getDetail(@PathVariable Long teacherId) {
        return Result.success(teacherAnalysisService.getTeacherAnalysisDetail(teacherId));
    }
} 