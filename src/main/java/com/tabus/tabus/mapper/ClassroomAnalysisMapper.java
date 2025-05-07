package com.tabus.tabus.mapper;

import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * 课堂分析 Mapper 接口
 */

@Mapper
public interface ClassroomAnalysisMapper extends BaseMapper<ClassroomAnalysis> {
    /**
     * 根据课程 ID 查询课堂分析数据
     * @param courseId 课程 ID
     * @return 课堂分析实体
     */
    @Select("SELECT * FROM classroom_analysis WHERE course_id = #{courseId}")
    ClassroomAnalysis selectByCourseId(Long courseId);
}
