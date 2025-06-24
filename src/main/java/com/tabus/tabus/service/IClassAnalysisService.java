package com.tabus.tabus.service;

import com.tabus.tabus.pojo.vo.ClassAnalysisSummaryVO;

public interface IClassAnalysisService {
    /**
     * 获取班级分析汇总数据
     * @param classId 班级ID
     * @return 班级分析汇总数据
     */
    ClassAnalysisSummaryVO getClassAnalysisSummary(Long classId);

    /**
     * 获取班级详细分析数据
     * @param classId 班级ID
     * @return 班级详细分析数据
     */
    ClassAnalysisSummaryVO getClassAnalysisDetail(Long classId);
} 