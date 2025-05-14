package com.tabus.tabus.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 *
 * </p>
 *
 * @author tabus
 * @since 2025-04-24
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("emotion_record")
public class EmotionRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private String requestId;

    private String imageId;

    private String faceToken;

    private Long courseId; // 关联课程 ID

    private String type;   // 记录类型（student/teacher）

    private Double anger;   //愤怒

    private Double disgust; //厌恶

    private Double fear;    //恐惧

    private Double happiness;   //高兴

    private Double neutral; //平静

    private Double sadness; //伤心

    private Double surprise;    //惊讶

    private LocalDateTime createdAt;


}
