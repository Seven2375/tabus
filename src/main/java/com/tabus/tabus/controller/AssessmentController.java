package com.tabus.tabus.controller;

import com.tabus.tabus.service.IAssessmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/assessment")
public class AssessmentController {

    @Autowired
    private IAssessmentService assessmentService;


    /**
     * 根据课程 ID 评估教学情况的接口
     * @param courseId 课程 ID
     * @return 教学评估结果字符串
     */
    @GetMapping("/{courseId}")
    public String assessTeaching(@PathVariable Long courseId) {
        return assessmentService.assessTeaching(courseId);
    }
}