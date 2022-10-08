package com.rongxin.detectinq.entity.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.util.Date;

@Data
public class ResultUser {
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
     * 健康码路径
     */
    @TableField("codePath")
    private String codePath;

    /**
     * 二维码状态，0表示绿码，1表示黄码，2表示红码
     */
    private Integer state;


    /**
     * 检测结果
     */
    private String resultstate;

    /**
     * 采样时间
     */
    @TableField("createTime")
    private Date createTime;

    /**
     * 检测时间
     */
    @TableField("resultTime")
    private Date resultTime;


}
