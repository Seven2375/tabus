package com.tabus.tabus.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import lombok.Data;
import java.io.Serializable;

@Data
@TableName("class_name")
public class ClassName implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String name;
} 