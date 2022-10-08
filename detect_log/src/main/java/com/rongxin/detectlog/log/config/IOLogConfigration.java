package com.rongxin.detectlog.log.config;

import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
public class IOLogConfigration {

    @Bean
    public IOLogAspect ioLogAspect(){
        return new IOLogAspect();
    }
}