package com.rongxin.detectinq.entity.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Data
@Document("result")
public class MoResult {
    @Id
    private String id;
    private String medicineCode;
    private Integer userId;
    private String resultstate;
    private String createTime;
    private String resultTime;
    private Boolean isDeleted;

    public MoResult() {
    }

    public MoResult(String id, String medicineCode, Integer userId, String resultstate, String createTime, String resultTime, Boolean isDeleted) {
        this.id = id;
        this.medicineCode = medicineCode;
        this.userId = userId;
        this.resultstate = resultstate;
        this.createTime = createTime;
        this.resultTime = resultTime;
        this.isDeleted = isDeleted;
    }
}
