package com.rongxin.detecthos.mapper;

import com.rongxin.detecthos.pojo.Meconpany;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author rlq
 * @since 2022-10-10
 */
public interface MeconpanyMapper extends BaseMapper<Meconpany> {

    /**
     * 根据编号查找药品信息
     * @param code
     * @return
     */
    Meconpany getMeconpanyByCode(String code);

}
