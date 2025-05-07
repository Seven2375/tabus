package com.tabus.tabus.mapper;

import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author tabus
 * @since 2025-04-24
 */
@Mapper
public interface EmotionRecordMapper extends BaseMapper<EmotionRecord> {

    @Select("SELECT * FROM emotion_record WHERE course_id = #{courseId} AND type = #{type}")
    List<EmotionRecord> selectByCourseIdAndType(Long courseId, String type);
}
