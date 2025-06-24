package com.tabus.tabus.service;

import com.tabus.tabus.pojo.vo.TeacherAnalysisSummaryVO;
import java.util.List;

public interface ITeacherAnalysisService {

    /**
     * 获取所有教师的分析摘要列表
     * @return 教师分析摘要列表
     */
    List<TeacherAnalysisSummaryVO> getTeacherAnalysisSummaryList();

    /**
     * 获取单个教师的详细分析数据
     * @param teacherId 教师ID
     * @return 教师详细分析数据
     */
    TeacherAnalysisSummaryVO getTeacherAnalysisDetail(Long teacherId);
} 