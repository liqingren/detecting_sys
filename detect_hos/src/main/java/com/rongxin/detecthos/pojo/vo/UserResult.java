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

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 试剂编号
     */
    @TableField("medicineCode")
    private String medicineCode;

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

    private Integer count;



}
