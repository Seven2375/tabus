package com.tabus.tabus.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.gson.Gson;
import com.tabus.tabus.common.properties.FacePlusplusProperties;
import com.tabus.tabus.mapper.EmotionRecordMapper;
import com.tabus.tabus.pojo.dto.EmotionResponseDTO;
import com.tabus.tabus.pojo.entity.EmotionRecord;
import com.tabus.tabus.pojo.vo.EmotionRecordVO;
import com.tabus.tabus.service.IEmotionRecordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 情绪记录服务实现类，实现了 IEmotionRecordService 接口
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class EmotionRecordServiceImpl extends ServiceImpl<EmotionRecordMapper, EmotionRecord> implements IEmotionRecordService {


    private final EmotionRecordMapper recordMapper;
    private final OkHttpClient httpClient = new OkHttpClient();
    private final Gson gson = new Gson();
    private final FacePlusplusProperties properties;

    // 情绪类型列表
    private static final List<String> EMOTION_TYPES = Arrays.asList(
            "anger", "disgust", "fear", "happiness", "neutral", "sadness", "surprise"
    );

    @Override
    public List<EmotionRecordVO> recognize(@NotNull MultipartFile image) {
        try {

            RequestBody formBody = new MultipartBody.Builder()
                    .setType(MultipartBody.FORM)
                    .addFormDataPart("api_key", properties.getApiKey())
                    .addFormDataPart("api_secret", properties.getApi_secret())
                    //emotion:情绪识别结果。返回值包含以下字段。每个字段的值都是一个浮点数，
                    // 范围 [0,100]，小数点后 3 位有效数字。每个字段的返回值越大，
                    // 则该字段代表的状态的置信度越高。字段值的总和等于 100.
                    .addFormDataPart("return_attributes", "emotion")
                    .addFormDataPart(
                            "image_file",
                            image.getOriginalFilename(),
                            RequestBody.create(image.getBytes(), MediaType.parse("application/octet-stream"))
                    )
                    .build();

            Request request = new Request.Builder()
                    .url(properties.getApiUrl())
                    .post(formBody)
                    .build();

            Response response = httpClient.newCall(request).execute();
            if (!response.isSuccessful()) {
                throw new RuntimeException("旷世API调用失败: " + response.code());
            }
            String jsonResponse = response.body() != null ? response.body().string() : null;
            log.info("Emotion API response: {}", jsonResponse);

            EmotionResponseDTO respDto = gson.fromJson(jsonResponse, EmotionResponseDTO.class);

            // 持久化并转换为 VO
            return respDto.getFaces().stream().map(face -> {
                EmotionRecord entity = new EmotionRecord();
                entity.setRequestId(respDto.getRequest_id());
                entity.setImageId(respDto.getImage_id());
                entity.setFaceToken(face.getFace_token());
                entity.setAnger(face.getAttributes().getEmotion().getAnger());
                entity.setDisgust(face.getAttributes().getEmotion().getDisgust());
                entity.setFear(face.getAttributes().getEmotion().getFear());
                entity.setHappiness(face.getAttributes().getEmotion().getHappiness());
                entity.setNeutral(face.getAttributes().getEmotion().getNeutral());
                entity.setSadness(face.getAttributes().getEmotion().getSadness());
                entity.setSurprise(face.getAttributes().getEmotion().getSurprise());
                entity.setCreatedAt(LocalDateTime.now());
                recordMapper.insert(entity);

                return getEmotionRecordVO(entity);
            }).collect(Collectors.toList());

        } catch (IOException e) {
            log.error("Emotion recognition failed", e);
            throw new RuntimeException("情绪识别失败", e);
        }
    }



    private static @NotNull EmotionRecordVO getEmotionRecordVO(@NotNull EmotionRecord entity) {
        EmotionRecordVO vo = new EmotionRecordVO();
        vo.setId(entity.getId());
        vo.setAnger(entity.getAnger());
        vo.setDisgust(entity.getDisgust());
        vo.setFear(entity.getFear());
        vo.setHappiness(entity.getHappiness());
        vo.setNeutral(entity.getNeutral());
        vo.setSadness(entity.getSadness());
        vo.setSurprise(entity.getSurprise());
        vo.setTimestamp(entity.getCreatedAt());
        return vo;
    }

    public Map<String, Object> getAnalysisByCourseId(Long courseId) {
        // 查询学生和教师情绪记录
        List<EmotionRecord> studentRecords = queryRecords(courseId, "student");
        List<EmotionRecord> teacherRecords = queryRecords(courseId, "teacher");

        // 构建分析结果
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("courseId", courseId);
        result.put("analysisTime", LocalDateTime.now());

        // 学生分析结果
        if (!studentRecords.isEmpty()) {
            result.put("studentAnalysis", analyzeRecords(studentRecords));
        }

        // 教师分析结果
        if (!teacherRecords.isEmpty()) {
            result.put("teacherAnalysis", analyzeRecords(teacherRecords));
        }

        // 相关性分析（如果同时有学生和教师数据）
        if (!studentRecords.isEmpty() && !teacherRecords.isEmpty()) {
            result.put("correlationAnalysis", calculateCorrelation(studentRecords, teacherRecords));
        }

        // 最后存入情绪数据
//        result.put("studentEmotionsData",studentRecords);
//        result.put("teacherEmotionsData",teacherRecords);
        return result;
    }

    // 查询情绪记录
    private List<EmotionRecord> queryRecords(Long courseId, String type) {
        return lambdaQuery()
                .eq(EmotionRecord::getCourseId, courseId)
                .eq(EmotionRecord::getType, type)
                .list();
    }

    // 分析记录并返回Map结构
    private Map<String, Object> analyzeRecords(List<EmotionRecord> records) {
        Map<String, Object> analysis = new LinkedHashMap<>();

        // 基本统计
        analysis.put("totalRecords", records.size());
        analysis.put("userIds", records.stream().map(EmotionRecord::getId).collect(Collectors.toList()));

        // 情绪统计数据
        Map<String, Map<String, Double>> emotionStats = new LinkedHashMap<>();
        for (String emotion : EMOTION_TYPES) {
            List<Double> values = extractEmotionValues(records, emotion);
            emotionStats.put(emotion, calculateStats(values));
        }
        analysis.put("emotionStats", emotionStats);

        // 主导情绪
        analysis.put("dominantEmotion", findDominantEmotion(emotionStats));

        // 异常值检测
        analysis.put("outliers", detectOutliers(records));

        // 整体情绪评分 (自定义公式：积极情绪 - 消极情绪)
        double overallScore = calculateOverallScore(records);
        analysis.put("overallScore", overallScore);
        analysis.put("emotionLevel", getEmotionLevel(overallScore));

        return analysis;
    }

    // 提取特定情绪的值列表
    private List<Double> extractEmotionValues(List<EmotionRecord> records, String emotion) {
        return records.stream()
                .map(r -> getEmotionValue(r, emotion))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    // 获取情绪值
    private Double getEmotionValue(EmotionRecord record, String emotion) {
        switch (emotion) {
            case "anger": return record.getAnger();
            case "disgust": return record.getDisgust();
            case "fear": return record.getFear();
            case "happiness": return record.getHappiness();
            case "neutral": return record.getNeutral();
            case "sadness": return record.getSadness();
            case "surprise": return record.getSurprise();
            default: return null;
        }
    }

    // 计算统计数据
    private Map<String, Double> calculateStats(List<Double> values) {
        Map<String, Double> stats = new LinkedHashMap<>();
        if (values.isEmpty()) return stats;

        double sum = values.stream().mapToDouble(Double::doubleValue).sum();
        double avg = sum / values.size();
        double max = values.stream().mapToDouble(Double::doubleValue).max().orElse(0);
        double min = values.stream().mapToDouble(Double::doubleValue).min().orElse(0);
        double variance = calculateVariance(values, avg);
        double stdDev = Math.sqrt(variance);

        stats.put("sum", sum);
        stats.put("average", avg);
        stats.put("max", max);
        stats.put("min", min);
        stats.put("variance", variance);
        stats.put("stdDev", stdDev);

        return stats;
    }

    // 计算方差
    private double calculateVariance(List<Double> values, double mean) {
        return values.stream()
                .mapToDouble(v -> Math.pow(v - mean, 2))
                .average()
                .orElse(0);
    }

    // 查找主导情绪
    private String findDominantEmotion(Map<String, Map<String, Double>> emotionStats) {
        return emotionStats.entrySet().stream()
                .max(Comparator.comparingDouble(e -> e.getValue().get("average")))
                .map(Map.Entry::getKey)
                .orElse("neutral");
    }

    // 检测异常值 (Z-score > 3)
    private List<Map<String, Object>> detectOutliers(List<EmotionRecord> records) {
        List<Map<String, Object>> outliers = new ArrayList<>();

        for (String emotion : EMOTION_TYPES) {
            List<Double> values = extractEmotionValues(records, emotion);
            if (values.isEmpty()) continue;

            double mean = values.stream().mapToDouble(Double::doubleValue).average().orElse(0);
            double stdDev = Math.sqrt(calculateVariance(values, mean));

            // 避免除以零
            if (stdDev == 0) continue;

            for (EmotionRecord record : records) {
                Double value = getEmotionValue(record, emotion);
                if (value == null) continue;

                double zScore = Math.abs((value - mean) / stdDev);
                if (zScore > 3) {
                    outliers.add(Map.of(
                            "userId", record.getId(),
                            "emotionType", emotion,
                            "value", value,
                            "zScore", zScore
                    ));
                }
            }
        }

        return outliers;
    }

    // 计算整体情绪评分
    private double calculateOverallScore(List<EmotionRecord> records) {
        // 自定义评分公式: 积极情绪 - 消极情绪
        return records.stream()
                .mapToDouble(r ->
                        (r.getHappiness() + r.getNeutral()) -
                                (r.getAnger() + r.getDisgust() + r.getFear() + r.getSadness())
                )
                .average()
                .orElse(0);
    }

    // 获取情绪等级描述
    private String getEmotionLevel(double score) {
        if (score > 0.7) return "非常积极";
        if (score > 0.3) return "积极";
        if (score > -0.3) return "中性";
        if (score > -0.7) return "消极";
        return "非常消极";
    }

    // 计算学生和教师情绪的相关性
    private Map<String, Object> calculateCorrelation(List<EmotionRecord> students, List<EmotionRecord> teachers) {
        Map<String, Object> correlationResult = new LinkedHashMap<>();

        for (String emotion : EMOTION_TYPES) {
            List<Double> studentValues = extractEmotionValues(students, emotion);
            List<Double> teacherValues = extractEmotionValues(teachers, emotion);

            if (studentValues.size() >= 2 && teacherValues.size() >= 2) {
                double correlation = calculatePearsonCorrelation(studentValues, teacherValues);
                correlationResult.put(emotion, correlation);
            }
        }

        return correlationResult;
    }

    // 计算皮尔逊相关系数
    private double calculatePearsonCorrelation(List<Double> x, List<Double> y) {
        if (x.size() != y.size() || x.size() < 2) return 0;

        double sumX = 0, sumY = 0, sumXY = 0;
        double sumX2 = 0, sumY2 = 0;

        for (int i = 0; i < x.size(); i++) {
            double xi = x.get(i);
            double yi = y.get(i);

            sumX += xi;
            sumY += yi;
            sumXY += xi * yi;
            sumX2 += xi * xi;
            sumY2 += yi * yi;
        }

        int n = x.size();
        double numerator = n * sumXY - sumX * sumY;
        double denominator = Math.sqrt((n * sumX2 - sumX * sumX) * (n * sumY2 - sumY * sumY));

        return denominator == 0 ? 0 : numerator / denominator;
    }


}
