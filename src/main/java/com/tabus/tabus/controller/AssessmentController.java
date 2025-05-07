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

    @GetMapping("/{courseId}")
    public String assessTeaching(@PathVariable Long courseId) {
        return assessmentService.assessTeaching(courseId);
    }
}