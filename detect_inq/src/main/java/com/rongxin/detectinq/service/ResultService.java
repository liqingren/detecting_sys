package com.rongxin.detectinq.service;

import com.github.pagehelper.PageInfo;
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
     * 根据userId获取最近一次的核酸记录
     * @param id
     * @return
     */
    Result getResultByUserId(int id);

    /**
     * 分页
     * @param pageNum
     * @param pageSize
     * @param id
     * @return
     */
    PageInfo<Result> getResultByPage(Integer pageNum,Integer pageSize,Integer id,String keyword);
}
