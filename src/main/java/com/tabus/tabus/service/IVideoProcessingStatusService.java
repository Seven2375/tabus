package com.tabus.tabus.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tabus.tabus.pojo.entity.VideoProcessingStatus;

/**
 * 视频处理状态服务接口
 */
public interface IVideoProcessingStatusService extends IService<VideoProcessingStatus> {
    
    /**
     * 创建处理状态记录
     */
    VideoProcessingStatus createStatus(Long courseId, String type);
    
    /**
     * 更新处理状态
     */
    void updateStatus(Long courseId, String type, String status, Integer progress);
    
    /**
     * 更新处理错误
     */
    void updateError(Long courseId, String type, String errorMessage);
    
    /**
     * 获取处理状态
     */
    VideoProcessingStatus getStatus(Long courseId, String type);
} 