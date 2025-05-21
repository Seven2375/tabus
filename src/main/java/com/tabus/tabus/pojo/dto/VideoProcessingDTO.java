package com.tabus.tabus.pojo.dto;

import lombok.Builder;
import lombok.Data;

/**
 * 视频处理数据传输对象
 * 用于在控制器和异步处理服务之间传递数据
 */
@Data
@Builder
public class VideoProcessingDTO {
    
    /**
     * 视频文件内容
     */
    private byte[] fileContent;
    
    /**
     * 原始文件名
     */
    private String originalFilename;
    
    /**
     * 文件类型
     */
    private String contentType;
    
    /**
     * 课程ID
     */
    private Long courseId;
    
    /**
     * 视频类型（"student" 或 "teacher"）
     */
    private String type;
} 