package com.rongxin.detectacl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
//@ComponentScan("com.rongxin.detectacl")
@MapperScan("com.rongxin.detectacl.mapper")
@EnableDiscoveryClient
public class DetectAclApplication {
        public static void main(String[] args) {
            SpringApplication.run(DetectAclApplication.class, args);
        }
}
