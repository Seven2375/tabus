package com.tabus.tabus.controller;

import com.tabus.tabus.common.Result;
import com.tabus.tabus.pojo.vo.ClassAnalysisSummaryVO;
import com.tabus.tabus.service.IClassAnalysisService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/admin/class-analysis")
@RequiredArgsConstructor
public class ClassAnalysisController {

    private final IClassAnalysisService classAnalysisService;

    @GetMapping("/{classId}/summary")
    public Result getClassAnalysisSummary(@PathVariable Long classId) {
        return Result.success(classAnalysisService.getClassAnalysisSummary(classId));
    }

    @GetMapping("/{classId}/detail")
    public Result getClassAnalysisDetail(@PathVariable Long classId) {
        ClassAnalysisSummaryVO vo = classAnalysisService.getClassAnalysisDetail(classId);

        Map<String, Object> result = new java.util.HashMap<>();
        // trend
        Map<String, Object> trend = new java.util.HashMap<>();
        trend.put("dates", vo.getDates());
        trend.put("raiseRates", vo.getRaiseRates());
        trend.put("lowerRates", vo.getLowerRates());
        result.put("trend", trend);

        // emotions
        result.put("emotions", vo.getEmotions());

        // participation
        Map<String, Object> participation = new java.util.HashMap<>();
        participation.put("avgRaiseRate", vo.getAvgRaiseRate());
        participation.put("avgLowerRate", vo.getAvgLowerRate());
        result.put("participation", participation);

        // quality
        result.put("quality", vo.getQuality());

        // summary
        Map<String, Object> summary = new java.util.HashMap<>();
        summary.put("totalCourses", vo.getTotalCourses());
        summary.put("avgRaiseRate", vo.getAvgRaiseRate());
        summary.put("avgParticipation", vo.getAvgParticipation());
        result.put("summary", summary);

        return Result.success(result);
    }
} 