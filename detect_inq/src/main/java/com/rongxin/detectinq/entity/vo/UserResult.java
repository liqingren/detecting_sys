package com.rongxin.detectinq.entity.vo;


import lombok.Data;

import java.util.Date;

@Data
public class UserResult {

    /**
     * 药品编号
     */
    private String medicineCode;

    /**
     * 检测结果
     */
    private String resultstate;

    /**
     * 采样时间
     */
    private Date createTime;

    /**
     * 检测时间
     */
    private Date resultTime;


    /**
     * 身份证号
     */
    private String card;


    /**
     * 姓名
     */
    private String name;

    /**
     * 性别，0表示男，1表示女
     */
    private Boolean sex;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 地址
     */
    private String address;

    /**
     * 二维码状态，0表示绿码，1表示黄码，2表示红码
     */
    private Integer state;

}
