package com.rongxin.detectacl.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Users implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 身份证号
     */
    private String card;

    /**
     * 密码
     */
    private String password;

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
     * 创建时间
     */
    @TableField("createTime")
    private Date createTime;

    /**
     * 最新修改时间
     */
    @TableField("updateTime")
    private Date updateTime;

    /**
     * 是否删除，0表示删除，1表示未删除
     */
    @TableField("isDeleted")
    private Boolean isDeleted;


}
