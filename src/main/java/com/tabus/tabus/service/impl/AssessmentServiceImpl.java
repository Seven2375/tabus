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

import java.util.List;

@Service
public class AssessmentServiceImpl implements IAssessmentService {

    @Autowired
    private ClassroomAnalysisMapper classroomAnalysisMapper;

    @Autowired
    private DiscussionTextMapper discussionTextMapper;

    @Override
    public String assessTeaching(Long courseId) {
        ClassroomAnalysis analysis = classroomAnalysisMapper.selectByCourseId(courseId);
        List<DiscussionText> discussions = discussionTextMapper.selectByCourseId(courseId);

        double positiveCount = 0;
        IClassifier classifier = new NaiveBayesClassifier(new NaiveBayesModel());
        for (DiscussionText discussion : discussions) {
            String sentiment = classifier.classify(discussion.getContent());
            if ("positive".equals(sentiment)) {
                positiveCount++;
            }
        }

        double positiveRate = discussions.isEmpty() ? 0 : positiveCount / discussions.size() * 100;

        StringBuilder assessment = new StringBuilder();
        if (analysis.getStudentRaiseRate() > 70 && positiveRate > 60) {
            assessment.append("本节课学生抬头率高（").append(analysis.getStudentRaiseRate()).append("%）");
            assessment.append("，讨论积极度高（").append(positiveRate).append("%），教学方式生动。");
        } else if (analysis.getStudentRaiseRate() < 50 && positiveRate < 40) {
            assessment.append("本节课学生抬头率较低（").append(analysis.getStudentRaiseRate()).append("%）");
            assessment.append("，讨论积极度低（").append(positiveRate).append("%），建议增加互动。");
        } else {
            assessment.append("课堂数据正常，可结合具体情况优化教学。");
        }
        return assessment.toString();
    }
}