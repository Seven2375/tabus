package com.tabus.tanus.pojo.dto;

import lombok.Data;

@Data
public class FaceDTO {
    private String face_token;
    private Attributes attributes;

    @Data
    public static class Attributes {
        private Emotion emotion;
    }

    @Data
    public static class Emotion {
        private Double anger;
        private Double disgust;
        private Double fear;
        private Double happiness;
        private Double neutral;
        private Double sadness;
        private Double surprise;
    }
}