package com.tabus.tabus.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tabus.tabus.pojo.entity.DiscussionText;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
/**
 * 课堂讨论文本 Mapper 接口
 */
@Mapper
public interface DiscussionTextMapper extends BaseMapper<DiscussionText> {
    /**
     * 根据课程 ID 查询讨论文本数据
     * @param courseId 课程 ID
     * @return 讨论文本列表
     */
    @Select("SELECT * FROM discussion_text WHERE course_id = #{courseId}")
    List<DiscussionText> selectByCourseId(Long courseId);
}