package com.tabus.tabus.mapper;

import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 情绪记录 Mapper 接口
 */
@Mapper
public interface EmotionRecordMapper extends BaseMapper<EmotionRecord> {

    /**
     * 根据课程 ID 和记录类型查询情绪记录数据
     * @param courseId 课程 ID
     * @param type 记录类型（student/teacher）
     * @return 情绪记录列表
     */
    @Select("SELECT * FROM emotion_record WHERE course_id = #{courseId} AND type = #{type}")
    List<EmotionRecord> selectByCourseIdAndType(Long courseId, String type);
}
