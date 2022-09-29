package com.rongxin.detectinq.service;

import com.rongxin.detectinq.entity.Result;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
public interface ResultService extends IService<Result> {
    /**
     * 根据card获取核酸结果
     * @param card
     * @return
     */
    List<Result> getResultByCard(String card);
}
