package com.tabus.tabus.controller;

import com.tabus.tabus.common.Result;
import com.tabus.tabus.common.ResultCodeEnum;
import com.tabus.tabus.pojo.dto.VideoProcessingDTO;
import com.tabus.tabus.pojo.entity.VideoProcessingStatus;
import com.tabus.tabus.service.IVideoProcessingStatusService;
import com.tabus.tabus.service.impl.VideoProcessingService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * 视频处理控制器，提供视频上传接口
 */
@RestController
@RequestMapping("/admin/video")
@RequiredArgsConstructor
@Slf4j
public class VideoController {

    private final VideoProcessingService videoService;
    private final IVideoProcessingStatusService statusService;

    /**
     * 上传视频并触发处理流程
     * @param video 视频文件（学生或教师摄像头录制）
     * @param courseId 关联的课程 ID（来自 /admin/course/start 接口）
     * @param type 视频类型（"student" 或 "teacher"）
     * @return 处理状态
     */
    @PostMapping("/upload")
    public Result uploadVideo(
            @RequestParam("video") MultipartFile video,
            @RequestParam("courseId") Long courseId,
            @RequestParam("type") String type
    ) {
        try {
            // 校验类型是否合法
            if (!"student".equals(type) && !"teacher".equals(type)) {
                return Result.error(ResultCodeEnum.SYSTEM_ERROR.code,"错误：type 必须为 student 或 teacher");
            }
            
            // 校验文件是否为空
            if (video.isEmpty()) {
                return Result.error(ResultCodeEnum.SYSTEM_ERROR.code, "错误：视频文件不能为空");
            }
            
            // 检查文件扩展名是否合法
            String fileName = video.getOriginalFilename();
            if (fileName == null || (!fileName.toLowerCase().endsWith(".mp4") && 
                                     !fileName.toLowerCase().endsWith(".avi") && 
                                     !fileName.toLowerCase().endsWith(".mov") && 
                                     !fileName.toLowerCase().endsWith(".wmv"))) {
                return Result.error(ResultCodeEnum.SYSTEM_ERROR.code, "错误：仅支持mp4、avi、mov、wmv格式的视频");
            }

            log.info("接收到视频上传请求: 课程ID={}, 类型={}, 文件名={}, 大小={}KB", 
                    courseId, type, video.getOriginalFilename(), video.getSize()/1024);
                    
            // 读取文件内容到内存（关键步骤，避免异步处理时临时文件已被删除）
            byte[] fileContent = video.getBytes();
            String contentType = video.getContentType();
            
            log.info("已读取视频文件内容到内存: 大小={}KB, 内容类型={}", fileContent.length/1024, contentType);
            
            // 创建数据传输对象
            VideoProcessingDTO videoDTO = VideoProcessingDTO.builder()
                    .fileContent(fileContent)
                    .originalFilename(fileName)
                    .contentType(contentType)
                    .courseId(courseId)
                    .type(type)
                    .build();

            // 创建处理状态记录
            statusService.createStatus(courseId, type);

            // 异步处理视频（不会阻塞接口）
            videoService.processVideo(videoDTO);
            
            return Result.success("视频已接收，正在处理中...");
        } catch (IOException e) {
            log.error("视频文件读取失败", e);
            return Result.error(ResultCodeEnum.SYSTEM_ERROR.code, "视频文件读取失败: " + e.getMessage());
        } catch (Exception e) {
            log.error("视频上传处理失败", e);
            return Result.error(ResultCodeEnum.SYSTEM_ERROR.code, "视频上传失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取视频处理状态
     * @param courseId 课程ID
     * @param type 视频类型（"student" 或 "teacher"）
     * @return 处理状态信息
     */
    @GetMapping("/status")
    public Result getProcessingStatus(
            @RequestParam("courseId") Long courseId,
            @RequestParam("type") String type
    ) {
        try {
            // 校验类型是否合法
            if (!"student".equals(type) && !"teacher".equals(type)) {
                return Result.error(ResultCodeEnum.SYSTEM_ERROR.code,"错误：type 必须为 student 或 teacher");
            }
            
            VideoProcessingStatus status = statusService.getStatus(courseId, type);
            if (status == null) {
                return Result.error(ResultCodeEnum.SYSTEM_ERROR.code, "未找到指定视频的处理状态");
            }
            
            return Result.success(status);
        } catch (Exception e) {
            log.error("获取视频处理状态失败", e);
            return Result.error(ResultCodeEnum.SYSTEM_ERROR.code, "获取处理状态失败: " + e.getMessage());
        }
    }
}