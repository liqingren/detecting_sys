package com.rongxin.detectlog.controller;

import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Hello {
    @Autowired
    RocketMQTemplate rocketMQTemplate;

    @IOLogRecorder
    @RequestMapping("/test1")
    public String test1(){
        System.out.println("log test");
        return "log";
    }
}
