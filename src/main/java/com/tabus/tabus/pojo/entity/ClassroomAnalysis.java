package com.tabus.tabus.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 课堂分析数据表
 * </p>
 *
 * @author xuege
 * @since 2025-05-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("classroom_analysis")
//@ApiModel(value="ClassroomAnalysis对象", description="课堂分析数据表")
public class ClassroomAnalysis implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

//    @ApiModelProperty(value = "关联课程ID")
    private Long courseId;

//    @ApiModelProperty(value = "学生抬头率（百分比）")
    private Double studentRaiseRate;

//    @ApiModelProperty(value = "学生低头率（百分比）")
    private Double studentLowerRate;

//    @ApiModelProperty(value = "教师高兴值均值")
    private Double teacherHappinessAvg;

//    @ApiModelProperty(value = "教师愤怒值均值")
    private Double teacherAngerAvg;

//    @ApiModelProperty(value = "教师平静值均值")
    private Double teacherNeutralAvg;


}
