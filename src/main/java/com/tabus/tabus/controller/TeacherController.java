package com.tabus.tabus.controller;

import com.tabus.tabus.common.Result;
import com.tabus.tabus.pojo.entity.Teacher;
import com.tabus.tabus.service.ITeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/admin/teacher")
public class TeacherController {
    @Autowired
    private ITeacherService teacherService;

    @GetMapping("/list")
    public Result list() {
        return Result.success(teacherService.list());
    }

    @PostMapping("/add")
    public Result add(@RequestBody Teacher teacher) {
        teacherService.save(teacher);
        return Result.success();
    }

    @PutMapping("/update")
    public Result update(@RequestBody Teacher teacher) {
        teacherService.updateById(teacher);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Long id) {
        teacherService.removeById(id);
        return Result.success();
    }
} 