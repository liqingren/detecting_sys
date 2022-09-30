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
 * @since 2022-09-29
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Medicine implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 厂商名称
     */
    @TableField("conpanyName")
    private String conpanyName;

    /**
     * 药品编号
     */
    @TableField("medicineCode")
    private String medicineCode;

    /**
     * 药品名称
     */
    @TableField("medicineName")
    private String medicineName;

    /**
     * 药品生产日期
     */
    @TableField("createTime")
    private Date createTime;

    /**
     * 保质期
     */
    private Integer exp;

    /**
     * 是否删除，0表示删除，1表示未删除
     */
    @TableField("isDeleted")
    private Boolean isDeleted;


}
