package com.rongxin.detecthos.pojo;

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
 * @author rlq
 * @since 2022-10-10
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Medicine implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 厂商id
     */
    @TableField("conpanyId")
    private Integer conpanyId;

    /**
     * 药品编号
     */
    @TableField("medicineCode")
    private String medicineCode;

    /**
     * 药品生产日期
     */
    @TableField("createTime")
    private Date createTime;

    /**
     * 是否删除，0表示删除，1表示未删除
     */
    @TableField("isDeleted")
    private Boolean isDeleted;


}
