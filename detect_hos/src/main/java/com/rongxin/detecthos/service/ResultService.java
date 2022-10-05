package com.rongxin.detecthos.service;

import com.github.pagehelper.PageInfo;
import com.rongxin.detecthos.pojo.Result;
import com.baomidou.mybatisplus.extension.service.IService;
import com.rongxin.detecthos.pojo.vo.UserResult;

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
     * 两表连查并分页
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageInfo<UserResult> getUserResultByPage(Integer pageNum, Integer pageSize, String keyword);

    /**
     * 根据身份证号模糊查询
     * @param card
     * @return
     */
    PageInfo<UserResult> getUserResultByCard(Integer pageNum, Integer pageSize,String card);

    /**
     * 根据性别查询
     * @param sex
     * @return
     */
    PageInfo<UserResult> getUserResultBySex(Integer pageNum, Integer pageSize,Boolean sex);
}
