package com.tabus.tabus.service;

import cn.hutool.extra.tokenizer.engine.analysis.AnalysisResult;
import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.baomidou.mybatisplus.extension.service.IService;
import com.tabus.tabus.pojo.vo.EmotionRecordVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;


/**
 * 情绪记录服务接口，继承自 IService，提供情绪识别功能
 */
public interface IEmotionRecordService extends IService<EmotionRecord> {

    /**
     * 调用旷世人脸识别 API，识别图片中的学生情绪
     * @param image 上传的图片文件
     * @return 情绪识别结果列表
     */
    List<EmotionRecordVO> recognize(MultipartFile image);

    /**
     * 根据课程id获取本节课的课程分析
     * @param courseId
     */
    Map<String, Object> getAnalysisByCourseId(Long courseId);
}
