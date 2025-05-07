package com.tabus.tabus.service.impl;

import com.hankcs.hanlp.classification.classifiers.IClassifier;
import com.hankcs.hanlp.classification.classifiers.NaiveBayesClassifier;
import com.hankcs.hanlp.classification.models.NaiveBayesModel;
import com.tabus.tabus.mapper.ClassroomAnalysisMapper;
import com.tabus.tabus.mapper.DiscussionTextMapper;
import com.tabus.tabus.pojo.entity.ClassroomAnalysis;
import com.tabus.tabus.pojo.entity.DiscussionText;
import com.tabus.tabus.service.IAssessmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

/**
 * 教学评估服务实现类
 */
@Service
public class AssessmentServiceImpl implements IAssessmentService {

    @Autowired
    private ClassroomAnalysisMapper classroomAnalysisMapper;

    @Autowired
    private DiscussionTextMapper discussionTextMapper;

    @Override
    public String assessTeaching(Long courseId) {
        // 根据课程 ID 查询课堂分析数据
        ClassroomAnalysis analysis = classroomAnalysisMapper.selectByCourseId(courseId);
        // 根据课程 ID 查询讨论文本数据
        List<DiscussionText> discussions = discussionTextMapper.selectByCourseId(courseId);

        // 积极讨论的数量
        double positiveCount = 0;
        // 创建朴素贝叶斯分类器
        IClassifier classifier = new NaiveBayesClassifier(new NaiveBayesModel());
        // 对每条讨论文本进行情感分析
        for (DiscussionText discussion : discussions) {
            // 对讨论文本进行分类，判断其情感倾向
            String sentiment = classifier.classify(discussion.getContent());
            if ("positive".equals(sentiment)) {
                // 如果是积极情感，积极讨论数量加 1
                positiveCount++;
            }
        }

        // 计算讨论的积极率
        double positiveRate = discussions.isEmpty() ? 0 : positiveCount / discussions.size() * 100;

        // 用于构建评估结果的字符串
        StringBuilder assessment = new StringBuilder();
        if (analysis.getStudentRaiseRate() > 70 && positiveRate > 60) {
            // 如果学生抬头率大于 70% 且积极率大于 60%，认为教学方式生动
            assessment.append("本节课学生抬头率高（").append(analysis.getStudentRaiseRate()).append("%）");
            assessment.append("，讨论积极度高（").append(positiveRate).append("%），教学方式生动。");
        } else if (analysis.getStudentRaiseRate() < 50 && positiveRate < 40) {
            // 如果学生抬头率小于 50% 且积极率小于 40%，建议增加互动
            assessment.append("本节课学生抬头率较低（").append(analysis.getStudentRaiseRate()).append("%）");
            assessment.append("，讨论积极度低（").append(positiveRate).append("%），建议增加互动。");
        } else {
            // 其他情况，提示可结合具体情况优化教学
            assessment.append("课堂数据正常，可结合具体情况优化教学。");
        }
        return assessment.toString();
    }
}