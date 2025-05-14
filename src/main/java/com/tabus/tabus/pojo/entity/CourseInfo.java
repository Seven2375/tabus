package com.tabus.tabus.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 课程基本信息表
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("course_info")
//@ApiModel(value="CourseInfo对象", description="课程基本信息表")
public class CourseInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

//    @ApiModelProperty(value = "教师姓名")
    private String teacher;

//    @ApiModelProperty(value = "课程名称")
    private String courseName;

//    @ApiModelProperty(value = "班级（如“高三1班”）")
    private String className;

//    @ApiModelProperty(value = "课程开始时间")
    private LocalDateTime startTime;

//    @ApiModelProperty(value = "课程结束时间")
    private LocalDateTime endTime;


}
