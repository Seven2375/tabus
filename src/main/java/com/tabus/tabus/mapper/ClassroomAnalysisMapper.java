package com.tabus.tabus.mapper;

import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tabus.tabus.pojo.vo.ClassroomAnalysisRecordVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;
import java.util.List;

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
    
    /**
     * 查询课堂分析记录列表，关联课程信息
     * @param offset 偏移量
     * @param limit 限制数
     * @return 课堂分析记录列表
     */
    @Select("SELECT a.id, a.course_id as courseId, c.teacher, c.course_name as courseName, " +
            "c.class_name as className, c.start_time as startTime, c.end_time as endTime, " +
            "a.student_raise_rate as studentRaiseRate, a.student_lower_rate as studentLowerRate, " +
            "a.teacher_happiness_avg as teacherHappinessAvg, a.teacher_anger_avg as teacherAngerAvg, " +
            "a.teacher_neutral_avg as teacherNeutralAvg " +
            "FROM classroom_analysis a " +
            "JOIN course_info c ON a.course_id = c.id " +
            "ORDER BY c.end_time DESC " +
            "LIMIT #{limit} OFFSET #{offset}")
    List<ClassroomAnalysisRecordVO> selectAnalysisRecords(@Param("offset") Integer offset, @Param("limit") Integer limit);
    
    /**
     * 查询课堂分析记录总数
     * @return 记录总数
     */
    @Select("SELECT COUNT(*) FROM classroom_analysis")
    Integer selectAnalysisRecordsCount();
}
