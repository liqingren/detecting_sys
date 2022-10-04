package com.rongxin.detectlog.log.config;


import cn.hutool.json.JSONUtil;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import com.rongxin.detectlog.pojo.DetectLog;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Aspect
public class IOLogAspect {

    @Autowired
    RocketMQTemplate rocketMQTemplate;

    @Pointcut("@annotation(com.rongxin.detectlog.log.annotation.IOLogRecorder)")
    public void pointCut() {
    }

    @Around("pointCut()")
    public Object record(ProceedingJoinPoint joinPoint) throws Throwable {

        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = servletRequestAttributes.getRequest();
        String url = request.getRequestURI();
        String contentType= request.getHeader("content-type");
        String method = request.getMethod();

        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        IOLogRecorder ioLogRecorder = methodSignature.getMethod().getAnnotation(IOLogRecorder.class);
        System.out.println(methodSignature.getMethod().getName());
        Object[] args = joinPoint.getArgs();
        String inArgs = JSONUtil.toJsonStr(args);
        Object response =  joinPoint.proceed();
        long timestamp = System.nanoTime();
        DetectLog detectLog = DetectLog.builder()
                .logTime(new Date())
                .keyword(ioLogRecorder.keyword())
                .description(ioLogRecorder.descrition())
                .url(url)
                .contentType(contentType)
                .method(method)
                .args(inArgs)
                .response(response).build();
        rocketMQTemplate.sendOneWay("iolog", MessageBuilder.withPayload(detectLog).build());

        return response;
    }

}