package com.rongxin.detecthos.service;

import com.github.pagehelper.PageInfo;
import com.rongxin.detecthos.pojo.Result;
import com.baomidou.mybatisplus.extension.service.IService;
import com.rongxin.detecthos.pojo.vo.UserResult;

import java.util.Date;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
public interface ResultService extends IService<Result> {


    /**
     *
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageInfo<UserResult> getResultByPage(Integer pageNum, Integer pageSize);

    /**
     * 根据试剂编号查询核酸记录
     * @param medicineCode
     * @return
     */
    List<Result> getResultByCode(String medicineCode);
}
