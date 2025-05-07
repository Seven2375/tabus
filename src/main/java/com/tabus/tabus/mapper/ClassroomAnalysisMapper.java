package com.tabus.tabus.mapper;

import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 * 课堂分析数据表 Mapper 接口
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
@Mapper
public interface ClassroomAnalysisMapper extends BaseMapper<ClassroomAnalysis> {
    @Select("SELECT * FROM classroom_analysis WHERE course_id = #{courseId}")
    ClassroomAnalysis selectByCourseId(Long courseId);
}
