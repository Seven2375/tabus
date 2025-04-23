package com.tabus.service;


import com.tabus.entity.FaceAnalysis;
import com.tabus.mapper.FaceAnalysisMapper;
import jakarta.annotation.PostConstruct;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.core.MatOfRect;
import org.opencv.core.Rect;
import org.opencv.imgproc.Imgproc;
import org.opencv.objdetect.CascadeClassifier;
import org.springframework.stereotype.Service;
import org.opencv.core.MatOfByte;
import org.opencv.imgcodecs.Imgcodecs;

import java.time.LocalDateTime;
import java.util.Base64;

@Service
public class FaceAnalysisService {
    private final FaceAnalysisMapper faceAnalysisMapper;
    private CascadeClassifier faceDetector;

    public FaceAnalysisService(FaceAnalysisMapper faceAnalysisMapper) {
        this.faceAnalysisMapper = faceAnalysisMapper;
    }

    @PostConstruct
    public void init() {
        // 从 classpath 加载模型（确保文件在 resources 目录下）
        String modelPath = getClass().getClassLoader().getResource("haarcascade_frontalface_default.xml").getPath();
        faceDetector = new CascadeClassifier(modelPath);
    }

    public FaceAnalysis analyzeFace(byte[] imageData) {

        // 将字节数据转换为OpenCV Mat对象
        MatOfByte matOfByte = new MatOfByte();
        matOfByte.put(0, 0, imageData);
        Mat image = Imgcodecs.imdecode(matOfByte, Imgcodecs.IMREAD_COLOR);
        Mat grayImage = new Mat();
        Imgproc.cvtColor(image, grayImage, Imgproc.COLOR_BGR2GRAY);
        Imgproc.equalizeHist(grayImage, grayImage);

        // 人脸检测
        MatOfRect faces = new MatOfRect();
        faceDetector.detectMultiScale(grayImage, faces);

        FaceAnalysis result = new FaceAnalysis();
        result.setTimestamp(LocalDateTime.now());
        result.setImageBase64(Base64.getEncoder().encodeToString(imageData));

        if (faces.toArray().length > 0) {
            // 取第一个检测到的人脸（Demo简化处理）
            Rect faceRect = faces.toArray()[0];
            Mat faceROI = grayImage.submat(faceRect);

            // 模拟表情分析（实际需集成深度学习模型）
            result.setFaceExpression(faceROI.width() > faceROI.height() ? "微笑" : "专注");

            // 模拟头部姿态（假设通过宽高比估算）
            result.setHeadPitchAngle(Math.random() * 15 - 7.5);  // -7.5~7.5度
            result.setHeadYawAngle(Math.random() * 20 - 10);    // -10~10度

            // 模拟眼睛状态（假设随机生成）
            result.setEyeOpenState(Math.random() > 0.2);
        } else {
            result.setFaceExpression("未检测到人脸");
        }

        // 存储分析结果到MySQL
        faceAnalysisMapper.insert(result);
        return result;
    }
}