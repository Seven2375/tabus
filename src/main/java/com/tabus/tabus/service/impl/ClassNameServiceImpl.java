package com.tabus.tabus.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tabus.tabus.mapper.ClassNameMapper;
import com.tabus.tabus.pojo.entity.ClassName;
import com.tabus.tabus.service.IClassNameService;
import org.springframework.stereotype.Service;

@Service
public class ClassNameServiceImpl extends ServiceImpl<ClassNameMapper, ClassName> implements IClassNameService {
} 