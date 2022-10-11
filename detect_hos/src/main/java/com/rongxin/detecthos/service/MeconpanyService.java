package com.rongxin.detecthos.service;

import com.rongxin.detecthos.pojo.Meconpany;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author rlq
 * @since 2022-10-10
 */
public interface MeconpanyService extends IService<Meconpany> {
    /**
     * 根据编号查找药品信息
     * @param code
     * @return
     */
    Meconpany getMeconpanyByCode(String code);
}
