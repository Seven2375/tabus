package com.tabus.tabus.controller;

import com.tabus.tabus.common.Result;
import com.tabus.tabus.pojo.entity.ClassName;
import com.tabus.tabus.service.IClassNameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/admin/class-name")
public class ClassNameController {
    @Autowired
    private IClassNameService classNameService;

    @GetMapping("/list")
    public Result list() {
        return Result.success(classNameService.list());
    }

    @PostMapping("/add")
    public Result add(@RequestBody ClassName className) {
        classNameService.save(className);
        return Result.success();
    }

    @PutMapping("/update")
    public Result update(@RequestBody ClassName className) {
        classNameService.updateById(className);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Long id) {
        classNameService.removeById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getById(@PathVariable Long id) {
        return Result.success(classNameService.getById(id));
    }
} 