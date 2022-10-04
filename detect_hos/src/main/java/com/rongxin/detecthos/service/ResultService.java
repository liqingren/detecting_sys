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
}
