package com.rongxin.detecthos;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
@MapperScan("com.rongxin.detecthos.mapper")
public class DetecthosApplication {
    public static void main(String[] args) {
        SpringApplication.run(DetecthosApplication.class,args);
    }
}
