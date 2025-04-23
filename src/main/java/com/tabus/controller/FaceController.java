package com.tabus.controller;

import com.tabus.entity.FaceAnalysis;
import com.tabus.service.FaceAnalysisService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
public class FaceController {
    private final FaceAnalysisService analysisService;

    public FaceController(FaceAnalysisService analysisService) {
        this.analysisService = analysisService;
    }

    @PostMapping("/analyze")
    public FaceAnalysis analyzeFace(@RequestParam("image") MultipartFile imageFile) throws IOException {
        byte[] imageData = imageFile.getBytes();
        return analysisService.analyzeFace(imageData);
    }
}
