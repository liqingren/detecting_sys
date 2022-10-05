package com.rongxin.detecthos.pojo.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.rongxin.detecthos.pojo.Result;
import com.rongxin.detecthos.pojo.Users;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.apache.tomcat.jni.User;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class UserResult implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 身份证号
     */
    private String card;

    /**
     * 姓名
     */
    private String name;

    /**
     * 性别，1表示男，0表示女
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


    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 药品编号
     */
    @TableField("medicineCode")
    private String medicineCode;

    /**
     * 用户id
     */
    @TableField("userId")
    private Integer userId;

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

    /**
     * 是否被删除，0表示删除，1表示未删除
     */
    @TableField("isDelete")
    private Boolean isDelete;

//    private List<Users> users;



}
