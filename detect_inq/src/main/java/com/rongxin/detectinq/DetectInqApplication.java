package com.rongxin.detectinq;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.mongo.MongoAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.bind.annotation.CrossOrigin;

@SpringBootApplication
//@ComponentScan("com.rongxin")
@MapperScan("com.rongxin.detectinq.mapper")
public class DetectInqApplication {
    public static void main(String[] args) {
        SpringApplication.run(DetectInqApplication.class,args);
    }
}
