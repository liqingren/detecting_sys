package com.rongxin.log.pojo;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.io.Serializable;
import java.util.Date;

@Builder
@Data
@Document("detect_log")
public class DetectLog implements Serializable {
    @Id
    private String id;
    private String logTime;
    private String ip;
    private String method;
    private String url;
    private String contentType;
    private String args;
    private Object response;
//    private String keyword;
//    private String description;

    public DetectLog() {
    }
    public DetectLog(String id, String logTime, String ip, String method, String url, String contentType, String args, Object response) {
        this.id = id;
        this.logTime = logTime;
        this.ip = ip;
        this.method = method;
        this.url = url;
        this.contentType = contentType;
        this.args = args;
        this.response = response;
    }

}

