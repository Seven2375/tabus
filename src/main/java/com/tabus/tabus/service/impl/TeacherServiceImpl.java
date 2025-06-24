package com.tabus.tabus.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tabus.tabus.mapper.TeacherMapper;
import com.tabus.tabus.pojo.entity.Teacher;
import com.tabus.tabus.service.ITeacherService;
import org.springframework.stereotype.Service;

@Service
public class TeacherServiceImpl extends ServiceImpl<TeacherMapper, Teacher> implements ITeacherService {
} 