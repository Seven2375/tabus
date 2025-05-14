package com.tabus.tabus.service.impl;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.tabus.tabus.pojo.vo.EmotionRecordVO;
import com.tabus.tabus.service.IEmotionRecordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * 视频处理服务，负责视频上传、帧提取和批量情绪识别
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class VideoProcessingService {

    // 注入情绪识别服务
    private final IEmotionRecordService emotionService;
    // 视频存储目录（配置在 application.yml）
    @Value("${tabus.video.upload-dir}")
    private String uploadDir;
    // FFmpeg 路径（配置在 application.yml，默认从环境变量获取）
    @Value("${tabus.ffmpeg.path:ffmpeg}")
    private String ffmpegPath;

    /**
     * 异步处理视频文件（关键方法）
     * @param video 上传的视频文件
     * @param courseId 关联的课程 ID
     * @param type 视频类型（student/teacher）
     */
    @Async("taskExecutor") // 需要配置异步线程池
    public void processVideo(MultipartFile video, Long courseId, String type) {
        try {
            // 1. 保存视频到本地
            String videoPath = saveVideoToLocal(video);
            log.info("视频已保存到：{}", videoPath);

            // 2. 提取视频帧（每 1 秒提取 1 帧）
            List<String> framePaths = extractVideoFrames(videoPath, courseId, type);
            log.info("共提取 {} 帧", framePaths.size());

            // 3. 对每帧调用情绪识别接口并保存结果
            for (String framePath : framePaths) {

                // 模拟单图上传（将帧文件转为 MultipartFile）
                //MultipartFile frameFile = FileUtil.toMultipartFile(new File(framePath));
                File frameFile = new File(framePath);
                byte[] fileBytes = FileCopyUtils.copyToByteArray(frameFile);

                //检测文件类型
                String contentType = Files.probeContentType(Paths.get(framePath));
                // 若检测失败，默认使用 "application/octet-stream"
                contentType = contentType != null ? contentType : "application/octet-stream";

                // 构造 MultipartFile 对象（MockMultipartFile 是 Spring 提供的实现类）
                MultipartFile cMultiFile  = new MockMultipartFile(
                        "image",            // 对应接口中文件参数的名称（与情绪识别接口的 @RequestPart 一致）
                        frameFile.getName(),      // 原始文件名（如 "frame_0001.png"）
                        contentType,              // 文件类型（根据实际帧格式调整，如 "image/jpeg"）
                        fileBytes                 // 文件内容的字节数组
                );

                List<EmotionRecordVO> records = emotionService.recognize(cMultiFile);

                // 关联课程 ID 和类型（需修改 EmotionRecord 实体）
                records.forEach(vo -> {
                    EmotionRecord entity = emotionService.getById(vo.getId());
                    entity.setCourseId(courseId);
                    entity.setType(type);
                    emotionService.updateById(entity);
                });

                // 清理临时帧文件
                FileUtil.del(framePath);
            }

            // 4. 清理原始视频文件
            FileUtil.del(videoPath);
            log.info("视频处理完成，课程 ID：{}，类型：{}", courseId, type);

        } catch (Exception e) {
            log.error("视频处理失败，courseId={}, type={}", courseId, type, e);
            throw new RuntimeException("视频处理失败", e);
        }
    }

    /**
     * 保存视频到本地目录
     */
    private String saveVideoToLocal(MultipartFile video) throws IOException {
        // 生成唯一文件名（避免冲突）
        String originalName = video.getOriginalFilename();
        String ext = StrUtil.subAfter(originalName, ".", true);
        String fileName = UUID.randomUUID() + "." + ext;
        Path targetPath = Path.of(uploadDir, fileName);

        // 创建目录并保存文件
        FileUtil.mkParentDirs(targetPath);
        video.transferTo(targetPath.toFile());
        return targetPath.toString();
    }

    /**
     * 使用 FFmpeg 提取视频帧（每 1 秒 1 帧）
     */
    private List<String> extractVideoFrames(String videoPath, Long courseId, String type) throws IOException {
        List<String> framePaths = new ArrayList<>();
        // 生成帧存储目录（按课程 ID 和类型分类）
        String frameDir = Path.of(uploadDir, "frames", courseId.toString(), type).toString();
        FileUtil.mkdir(frameDir);

        // FFmpeg 命令：每 1 秒提取 1 帧，输出为 PNG 格式
        String command = String.format(
                "%s -i %s -vf fps=1 %s/frame_%%04d.png",
                ffmpegPath, videoPath, frameDir
        );

        // 执行命令
        Process process = Runtime.getRuntime().exec(command);
        int exitCode;
        try {
            exitCode = process.waitFor();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException("FFmpeg 执行被中断", e);
        }

        if (exitCode != 0) {
            throw new IOException("FFmpeg 提取帧失败，退出码：" + exitCode);
        }

        // 收集所有帧文件路径
        File[] frameFiles = FileUtil.ls(frameDir);
        for (File file : frameFiles) {
            framePaths.add(file.getAbsolutePath());
        }
        return framePaths;
    }
}