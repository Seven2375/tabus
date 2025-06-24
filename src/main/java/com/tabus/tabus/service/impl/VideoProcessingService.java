package com.tabus.tabus.service.impl;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import com.tabus.tabus.pojo.dto.VideoProcessingDTO;
import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.tabus.tabus.pojo.vo.EmotionRecordVO;
import com.tabus.tabus.service.IEmotionRecordService;
import com.tabus.tabus.service.IVideoProcessingStatusService;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
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
    // 注入视频处理状态服务
    private final IVideoProcessingStatusService statusService;
    // 视频存储目录（配置在 application.yml）
    @Value("${tabus.video.upload-dir}")
    private String uploadDir;
    // FFmpeg 路径（配置在 application.yml，默认为空）
    @Value("${tabus.ffmpeg.path:}")
    private String configuredFfmpegPath;

    // 最终使用的 FFmpeg 路径
    private String ffmpegPath;

    /**
     * 初始化方法，在 Bean 创建后执行，验证并设置 FFmpeg 路径
     */
    @PostConstruct
    public void init() {
//        try {
//            // 1. 优先使用配置文件中指定的路径
//            if (StrUtil.isNotBlank(configuredFfmpegPath)) {
//                if (isValidFfmpegPath(configuredFfmpegPath)) {
//                    this.ffmpegPath = configuredFfmpegPath;
//                    log.info("使用配置文件中的 FFmpeg 路径: {}", ffmpegPath);
//                    return;
//                }
//                log.warn("配置文件中的 FFmpeg 路径无效: {}", configuredFfmpegPath);
//            }
//
//            // 2. 尝试从系统 PATH 环境变量中查找
//            String pathFromEnv = findFfmpegInPath();
//            if (pathFromEnv != null) {
//                this.ffmpegPath = pathFromEnv;
//                log.info("从系统 PATH 中找到 FFmpeg: {}", ffmpegPath);
//                return;
//            }
//
//            // 3. 所有查找方法都失败，抛出异常
//            throw new IllegalStateException("无法找到 FFmpeg 可执行文件，请配置 tabus.ffmpeg.path");
//
//        } catch (Exception e) {
//            log.error("初始化 FFmpeg 路径失败", e);
//            throw new RuntimeException("初始化 FFmpeg 路径失败", e);
//        }
    }


    /**
     * 异步处理视频数据传输对象
     * @param videoDTO 视频数据传输对象（包含视频内容、元数据等）
     */
    @Async("taskExecutor")
    public void processVideo(VideoProcessingDTO videoDTO) {
        String videoPath = null;
        try {
            Long courseId = videoDTO.getCourseId();
            String type = videoDTO.getType();
            
            // 更新状态为处理中
            statusService.updateStatus(courseId, type, "PROCESSING", 5);
            
            // 检查上传目录是否存在，不存在则创建
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
                log.info("创建上传目录: {}", uploadDir);
            }
            
            // 1. 保存视频到本地
            videoPath = saveVideoToLocal(videoDTO);
            log.info("视频已保存到：{}", videoPath);
            statusService.updateStatus(courseId, type, "PROCESSING", 20);

            // 2. 提取视频帧（每 1 秒提取 1 帧）
            List<String> framePaths = extractVideoFrames(videoPath, courseId, type);
            log.info("共提取 {} 帧", framePaths.size());
            statusService.updateStatus(courseId, type, "PROCESSING", 40);

            // 计算每帧处理后的进度增量
            int totalFrames = framePaths.size();
            if (totalFrames == 0) {
                throw new IOException("未能从视频中提取任何帧，请检查视频文件是否正确");
            }
            
            int remainingProgressPoints = 60; // 从40%到100%
            float progressPerFrame = (float) remainingProgressPoints / totalFrames;
            
            // 3. 对每帧调用情绪识别接口并保存结果
            for (int i = 0; i < framePaths.size(); i++) {
                String framePath = framePaths.get(i);

                // 将帧文件转为 MultipartFile
                File frameFile = new File(framePath);
                byte[] fileBytes = FileCopyUtils.copyToByteArray(frameFile);

                //检测文件类型
                String contentType = Files.probeContentType(Paths.get(framePath));
                // 若检测失败，默认使用 "application/octet-stream"
                contentType = contentType != null ? contentType : "application/octet-stream";

                // 构造 MultipartFile 对象（MockMultipartFile 是 Spring 提供的实现类）
                MultipartFile cMultiFile = new MockMultipartFile(
                        "image",                  // 对应接口中文件参数的名称
                        frameFile.getName(),      // 原始文件名（如 "frame_0001.png"）
                        contentType,              // 文件类型
                        fileBytes                 // 文件内容的字节数组
                );

                List<EmotionRecordVO> records = emotionService.recognize(cMultiFile);

                // 关联课程 ID 和类型
                records.forEach(vo -> {
                    EmotionRecord entity = emotionService.getById(vo.getId());
                    entity.setCourseId(courseId);
                    entity.setType(type);
                    emotionService.updateById(entity);
                });

                // 更新处理进度
                int currentProgress = 40 + Math.round(progressPerFrame * (i + 1));
                statusService.updateStatus(courseId, type, "PROCESSING", Math.min(currentProgress, 99));

                // 清理临时帧文件
                FileUtil.del(framePath);
            }

            // 4. 清理原始视频文件
            if (videoPath != null) {
                FileUtil.del(videoPath);
            }
            
            // 更新状态为已完成
            statusService.updateStatus(courseId, type, "COMPLETED", 100);
            log.info("视频处理完成，课程 ID：{}，类型：{}", courseId, type);

        } catch (Exception e) {
            log.error("视频处理失败", e);
            
            // 更新状态为错误
            if (videoDTO != null) {
                statusService.updateError(videoDTO.getCourseId(), videoDTO.getType(), e.getMessage());
            }
            
            // 清理失败时可能残留的视频文件
            if (videoPath != null) {
                try {
                    FileUtil.del(videoPath);
                } catch (Exception ex) {
                    log.error("清理视频文件失败: {}", videoPath, ex);
                }
            }
            
            throw new RuntimeException("视频处理失败", e);
        }
    }

    /**
     * 保存视频到本地目录
     * 从 VideoProcessingDTO 中获取文件内容，而非从 MultipartFile 获取
     */
    private String saveVideoToLocal(VideoProcessingDTO videoDTO) throws IOException {
        // 生成唯一文件名
        String originalName = videoDTO.getOriginalFilename();
        String ext = StrUtil.subAfter(originalName, ".", true);
        String fileName = UUID.randomUUID() + "." + ext;
        
        Path targetPath = Path.of(uploadDir, fileName);

        // 创建目录
        FileUtil.mkParentDirs(targetPath);
        
        // 直接将字节数组写入文件
        try (ByteArrayInputStream inputStream = new ByteArrayInputStream(videoDTO.getFileContent());
             FileOutputStream outputStream = new FileOutputStream(targetPath.toFile())) {
            
            FileCopyUtils.copy(inputStream, outputStream);
            log.info("保存视频文件成功: {}, 大小: {}KB", targetPath, videoDTO.getFileContent().length / 1024);
        }
        
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

        // 输出FFmpeg路径用于调试
        log.info("使用FFmpeg路径: {}", ffmpegPath);
        
        // 检查FFmpeg是否存在
        File ffmpegFile = new File(ffmpegPath);
        if (!ffmpegFile.exists()) {
            throw new IOException("FFmpeg可执行文件不存在: " + ffmpegPath);
        }
        
        // 使用绝对路径的FFmpeg命令
        String command = String.format(
                "\"%s\" -i \"%s\" -vf fps=1 \"%s/frame_%%04d.png\"",
                ffmpegPath, videoPath, frameDir
        );
        
        log.info("执行命令: {}", command);

        // 执行命令
        Process process = Runtime.getRuntime().exec(command);
        
        // 读取错误输出（用于诊断）
        StringBuilder errorOutput = new StringBuilder();
        try (java.io.BufferedReader reader = new java.io.BufferedReader(
                new java.io.InputStreamReader(process.getErrorStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                errorOutput.append(line).append("\n");
            }
        }
        
        int exitCode;
        try {
            exitCode = process.waitFor();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException("FFmpeg 执行被中断", e);
        }

        if (exitCode != 0) {
            log.error("FFmpeg 错误输出: {}", errorOutput);
            throw new IOException("FFmpeg 提取帧失败，退出码：" + exitCode);
        }

        // 收集所有帧文件路径
        File[] frameFiles = FileUtil.ls(frameDir);
        for (File file : frameFiles) {
            framePaths.add(file.getAbsolutePath());
        }
        
        // 如果没有帧，记录错误输出
        if (framePaths.isEmpty()) {
            log.error("FFmpeg 未能提取任何帧。错误输出: {}", errorOutput);
        }
        
        return framePaths;
    }



    /**
     * 验证 FFmpeg 路径是否有效
     */
    private boolean isValidFfmpegPath(String path) {
        if (StrUtil.isBlank(path)) return false;

        File ffmpegFile = new File(path);
        if (!ffmpegFile.exists()) {
            return false;
        }

        // 检查是否可执行（适用于 Linux/macOS）
        if (!ffmpegFile.canExecute()) {
            // 对于 Windows，文件存在即可
            if (System.getProperty("os.name").toLowerCase().contains("win")) {
                return true;
            }
            return false;
        }

        // 进一步验证是否为有效的 FFmpeg 可执行文件
        try {
            Process process = new ProcessBuilder(path, "-version").start();
            int exitCode = process.waitFor();
            return exitCode == 0;
        } catch (Exception e) {
            log.warn("验证 FFmpeg 版本失败: {}", path, e);
            return false;
        }
    }

    /**
     * 在系统 PATH 环境变量中查找 FFmpeg
     */
    private String findFfmpegInPath() {
        log.info("尝试从系统 PATH 中查找 FFmpeg...");

        String pathEnv = System.getenv("PATH");
        if (pathEnv == null) {
            log.warn("系统 PATH 环境变量未设置");
            return null;
        }

        // 根据操作系统确定可执行文件扩展名
        String[] extensions = new String[] { "" };
        if (System.getProperty("os.name").toLowerCase().contains("win")) {
            extensions = new String[] { ".exe", ".bat", ".cmd" };
        }

        // 分割 PATH 并检查每个目录
        String[] pathDirs = pathEnv.split(File.pathSeparator);
        for (String pathDir : pathDirs) {
            for (String ext : extensions) {
                File file = new File(pathDir, "ffmpeg" + ext);
                if (file.exists() && file.canExecute()) {
                    return file.getAbsolutePath();
                }
            }
        }

        log.warn("在系统 PATH 中未找到 FFmpeg");
        return null;
    }
}