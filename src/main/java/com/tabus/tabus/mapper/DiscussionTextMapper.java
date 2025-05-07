package com.tabus.tabus.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tabus.tabus.pojo.entity.DiscussionText;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DiscussionTextMapper extends BaseMapper<DiscussionText> {
    @Select("SELECT * FROM discussion_text WHERE course_id = #{courseId}")
    List<DiscussionText> selectByCourseId(Long courseId);
}