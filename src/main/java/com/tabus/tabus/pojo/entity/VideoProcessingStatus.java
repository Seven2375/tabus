package com.tabus.tabus.pojo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 视频处理状态实体类
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName("video_processing_status")
public class VideoProcessingStatus {

    @TableId(type = IdType.AUTO)
    private Long id;
    
    // 关联的课程ID
    private Long courseId;
    
    // 视频类型（"student" 或 "teacher"）
    private String type;
    
    // 处理状态：PENDING, PROCESSING, COMPLETED, ERROR
    private String status;
    
    // 处理进度（0-100）
    private Integer progress;
    
    // 错误信息（如果有）
    private String errorMessage;
    
    // 创建时间
    private Date createTime;
    
    // 更新时间
    private Date updateTime;
} 