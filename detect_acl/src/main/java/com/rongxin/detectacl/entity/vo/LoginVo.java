package com.rongxin.detectacl.entity.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class LoginVo implements Serializable {

    private static final long serialVersionUID = 1L;
    private String card;
    private String password;
}
