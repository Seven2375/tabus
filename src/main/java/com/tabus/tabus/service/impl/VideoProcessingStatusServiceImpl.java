package com.tabus.tabus.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tabus.tabus.mapper.VideoProcessingStatusMapper;
import com.tabus.tabus.pojo.entity.VideoProcessingStatus;
import com.tabus.tabus.service.IVideoProcessingStatusService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * 视频处理状态服务实现类
 */
@Service
@RequiredArgsConstructor
public class VideoProcessingStatusServiceImpl extends ServiceImpl<VideoProcessingStatusMapper, VideoProcessingStatus> 
        implements IVideoProcessingStatusService {

    /**
     * 创建处理状态记录
     */
    @Override
    public VideoProcessingStatus createStatus(Long courseId, String type) {
        // 查询是否已存在状态记录
        VideoProcessingStatus existingStatus = getStatus(courseId, type);
        if (existingStatus != null) {
            // 如果存在，则重置状态
            existingStatus.setStatus("PENDING");
            existingStatus.setProgress(0);
            existingStatus.setErrorMessage(null);
            existingStatus.setUpdateTime(new Date());
            updateById(existingStatus);
            return existingStatus;
        }
        
        // 创建新的状态记录
        VideoProcessingStatus status = VideoProcessingStatus.builder()
                .courseId(courseId)
                .type(type)
                .status("PENDING")
                .progress(0)
                .createTime(new Date())
                .updateTime(new Date())
                .build();
        
        save(status);
        return status;
    }

    /**
     * 更新处理状态
     */
    @Override
    public void updateStatus(Long courseId, String type, String status, Integer progress) {
        VideoProcessingStatus processingStatus = getStatus(courseId, type);
        if (processingStatus != null) {
            processingStatus.setStatus(status);
            processingStatus.setProgress(progress);
            processingStatus.setUpdateTime(new Date());
            updateById(processingStatus);
        }
    }

    /**
     * 更新处理错误
     */
    @Override
    public void updateError(Long courseId, String type, String errorMessage) {
        VideoProcessingStatus processingStatus = getStatus(courseId, type);
        if (processingStatus != null) {
            processingStatus.setStatus("ERROR");
            processingStatus.setErrorMessage(errorMessage);
            processingStatus.setUpdateTime(new Date());
            updateById(processingStatus);
        }
    }

    /**
     * 获取处理状态
     */
    @Override
    public VideoProcessingStatus getStatus(Long courseId, String type) {
        LambdaQueryWrapper<VideoProcessingStatus> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(VideoProcessingStatus::getCourseId, courseId)
                .eq(VideoProcessingStatus::getType, type);
        
        return getOne(wrapper);
    }
} 