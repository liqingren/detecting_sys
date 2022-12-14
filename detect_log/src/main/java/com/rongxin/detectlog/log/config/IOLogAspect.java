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
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;

@Aspect
@Component
public class IOLogAspect {

    @Autowired
    RocketMQTemplate rocketMQTemplate;

    @Pointcut("@annotation(com.rongxin.detectlog.log.annotation.IOLogRecorder)")
    public void pointCut() {
    }

    @Around("pointCut()")
    public Object record(ProceedingJoinPoint joinPoint) throws Throwable {
        //获取request
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = servletRequestAttributes.getRequest();
        //获取时间
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String logtime = sdf.format(date);
        //获取访问ip
        String ip = getIpAddress(request);
        //获取访问的uri
        String url = request.getRequestURI();
        //获取请求头中的content-type
        String contentType= request.getHeader("content-type");
        //获取请求方法
        String method = request.getMethod();
        //获取参数
        Object[] args = joinPoint.getArgs();
        String inArgs = JSONUtil.toJsonStr(args);
        //获取返回值
        Object response =  joinPoint.proceed();
        //创建对象并将属性赋值
        DetectLog detectLog = DetectLog.builder()
                .logTime(logtime)
                .ip(ip)
                .url(url)
                .contentType(contentType)
                .method(method)
                .args(inArgs)
                .response(response).build();
        //发送消息
        rocketMQTemplate.syncSend("iolog", MessageBuilder.withPayload(detectLog).build());
        return response;
    }


    //获取客户端IP地址
    private String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknow".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            String IP = request.getRemoteAddr();
            ip = IP.equals("0:0:0:0:0:0:0:1")?"127.0.0.1":IP;
            if (ip.equals("127.0.0.1")) {
                //根据网卡取本机配置的IP
                InetAddress inet = null;
                try {
                    inet = InetAddress.getLocalHost();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                ip = inet.getHostAddress();
            }
        }
        // 多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ip != null && ip.length() > 15) {
            if (ip.indexOf(",") > 0) {
                ip = ip.substring(0, ip.indexOf(","));
            }
        }
        return ip;

    }
}