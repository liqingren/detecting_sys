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
 * @since 2022-09-28
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Permission implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 功能名称
     */
    @TableField("preName")
    private String preName;

    /**
     * 功能url
     */
    @TableField("preUrl")
    private String preUrl;

    /**
     * 是否被删除，0表示删除，1表示未删除
     */
    @TableField("isDeleted")
    private Boolean isDeleted;

    @TableField("createTime")
    private Date createTime;

    @TableField("updateTime")
    private Date updateTime;


}
