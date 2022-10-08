package com.rongxin.detectinq;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.mongo.MongoAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;


@SpringBootApplication
@EnableDiscoveryClient
@MapperScan("com.rongxin.detectinq.mapper")
public class DetectInqApplication {
    public static void main(String[] args) {
        SpringApplication.run(DetectInqApplication.class,args);
    }
}
