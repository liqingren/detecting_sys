package com.rongxin.detectacl.entity.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class RegisterVo implements Serializable {

    private static final long serialVersionUID = 1L;
    private String card;
    private String password;
    private String name;
    private Boolean sex;
    private String email;
    private String address;
}
