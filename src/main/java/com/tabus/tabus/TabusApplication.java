package com.tabus.tabus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class TabusApplication {

    public static void main(String[] args) {
        SpringApplication.run(TabusApplication.class, args);
        System.out.println("兄弟们加油冲冲冲！");
        System.out.println("TABUS 塔布斯智慧课堂欢迎您！！");
    }

}
