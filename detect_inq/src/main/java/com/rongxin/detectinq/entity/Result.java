package com.rongxin.detectinq.entity;

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
 * @author ren
 * @since 2022-09-28
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Result implements Serializable {

    private static final long serialVersionUID = 1L;

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


}
