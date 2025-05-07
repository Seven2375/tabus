package com.tabus.tabus.pojo.dto;

import lombok.Data;

import java.util.List;

@Data
public class EmotionResponseDTO {
    private String request_id;
    private List<FaceDTO> faces;
    private String image_id;
    private Integer face_num;
}
