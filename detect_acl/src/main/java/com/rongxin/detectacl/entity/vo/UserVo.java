package com.rongxin.detectacl.entity.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class UserVo implements Serializable {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 身份证号
     */
    private String card;

    /**
     * 姓名
     */
    private String name;

    /**
     * 最新修改时间
     */
    @TableField("updateTime")
    private Date updateTime;

    private String roleName;
    private Integer roleId;
}
