package com.tabus.tanus.controller;


import com.tabus.tanus.pojo.vo.EmotionRecordVO;
import com.tabus.tanus.service.IEmotionRecordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author tabus
 * @since 2025-04-24
 */
@RestController
@RequestMapping("/admin/emotion")
@RequiredArgsConstructor
@Slf4j
public class EmotionRecordController {
    private final IEmotionRecordService emotionService;

    /**
     * 识别上传图片中的学生情绪
     * @param image 学生照片文件
     * @return 情绪识别结果列表
     */
    @PostMapping("/recognize")
    public List<EmotionRecordVO> recognize(@RequestPart MultipartFile image) {
        log.info("Start emotion recognition for uploaded image");
        return emotionService.recognize(image);
    }
}
