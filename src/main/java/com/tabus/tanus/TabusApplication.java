package com.tabus.tanus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class TabusApplication {

    public static void main(String[] args) {
        SpringApplication.run(TabusApplication.class, args);
    }

}
