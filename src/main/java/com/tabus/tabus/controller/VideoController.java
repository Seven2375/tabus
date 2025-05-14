package com.tabus.tabus.controller;

import com.tabus.tabus.common.Result;
import com.tabus.tabus.common.ResultCodeEnum;
import com.tabus.tabus.service.impl.VideoProcessingService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * 视频处理控制器，提供视频上传接口
 */
@RestController
@RequestMapping("/admin/video")
@RequiredArgsConstructor
public class VideoController {

    private final VideoProcessingService videoService;

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
        // 校验类型是否合法
        if (!"student".equals(type) && !"teacher".equals(type)) {
            return Result.error(ResultCodeEnum.SYSTEM_ERROR.code,"错误：type 必须为 student 或 teacher");
        }

        // 异步处理视频（不会阻塞接口）
        videoService.processVideo(video, courseId, type);
        return Result.success("视频已接收，正在处理中...");
    }
}