package com.tabus.tabus.service.impl;

import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.mapper.ClassroomAnalysisMapper;
import com.tabus.tabus.service.IClassroomAnalysisService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tabus.tabus.pojo.vo.ClassroomAnalysisRecordVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 课堂分析服务实现类
 */
@Service
public class ClassroomAnalysisServiceImpl extends ServiceImpl<ClassroomAnalysisMapper, ClassroomAnalysis> implements IClassroomAnalysisService {

    @Autowired
    private ClassroomAnalysisMapper classroomAnalysisMapper;

    @Override
    public ClassroomAnalysis getAnalysisByCourseId(Long courseId) {
        // 根据课程 ID 查询课堂分析数据
        return classroomAnalysisMapper.selectByCourseId(courseId);
    }
    
    @Override
    public Page<ClassroomAnalysisRecordVO> getAnalysisRecords(Integer page, Integer size) {
        // 创建分页对象
        Page<ClassroomAnalysisRecordVO> pageObj = new Page<>();
        
        // 计算偏移量
        int offset = (page - 1) * size;
        
        // 查询记录列表
        List<ClassroomAnalysisRecordVO> records = classroomAnalysisMapper.selectAnalysisRecords(offset, size);
        
        // 查询总记录数
        Integer total = classroomAnalysisMapper.selectAnalysisRecordsCount();
        
        // 设置分页参数
        pageObj.setRecords(records);
        pageObj.setTotal(total);
        pageObj.setCurrent(page);
        pageObj.setSize(size);
        
        return pageObj;
    }
}
