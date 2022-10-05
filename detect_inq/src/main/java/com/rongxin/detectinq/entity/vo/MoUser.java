package com.rongxin.detectinq.entity.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Data
@Document("user")
public class MoUser {
    @Id
    private String id;
    private Integer userId;
    private String card;
    private String password;
    private String name;
    private Boolean sex;
    private String email;
    private String address;
    private String codePath;
    private Integer state;
    private String createTime;
    private String updateTime;
    private Boolean isDeleted;

    public MoUser() {

    }

}
