package com.tabus.tabus.common.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> handleMaxUploadSizeExceeded(MaxUploadSizeExceededException ex) {
        Map<String, String> error = new HashMap<>();
        error.put("code", "400");
        error.put("message", "文件大小超过限制！最大允许单个文件：" + ex.getMaxUploadSize() + " bytes");
        return error;
    }
}