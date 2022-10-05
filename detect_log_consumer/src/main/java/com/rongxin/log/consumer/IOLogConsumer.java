package com.rongxin.log.consumer;

import cn.hutool.json.JSONUtil;
import com.rongxin.log.dao.DetectLogMapper;
import com.rongxin.log.pojo.DetectLog;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.ConsumeMode;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j
@RocketMQMessageListener(consumerGroup = "consumer_group",topic="iolog",consumeMode = ConsumeMode.ORDERLY)
public class IOLogConsumer implements RocketMQListener<String> {
    @Autowired
    DetectLogMapper detectLogMapper;
    public void onMessage(String s) {
        System.out.println(s);
        DetectLog detectLog = JSONUtil.toBean(s,DetectLog.class);
        detectLogMapper.save(detectLog);
        log.error("----------{}----------",detectLog);
    }
}
