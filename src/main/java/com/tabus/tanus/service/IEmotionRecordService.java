package com.tabus.tanus.service;

import com.tabus.tanus.pojo.entity.EmotionRecord;
import com.baomidou.mybatisplus.extension.service.IService;
import com.tabus.tanus.pojo.vo.EmotionRecordVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author tabus
 * @since 2025-04-24
 */
public interface IEmotionRecordService extends IService<EmotionRecord> {

    /**
     * 调用旷世人脸识别API，识别图片中的学生情绪
     */
    List<EmotionRecordVO> recognize(MultipartFile image);
}
