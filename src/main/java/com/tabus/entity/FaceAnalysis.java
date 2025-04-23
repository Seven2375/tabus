package com.tabus.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("face_analysis")
public class FaceAnalysis {
    @TableId(type = IdType.AUTO)
    private Long id;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime timestamp;          // 分析时间
    private String faceExpression;          // 面部表情（微笑/专注/疲惫等）
    private Double headPitchAngle;          // 头部俯仰角度
    private Double headYawAngle;            // 头部偏航角度
    private Boolean eyeOpenState;           // 眼睛睁开状态
    private String imageBase64;             // 用于溯源的图片Base64（仅Demo保留）
}
