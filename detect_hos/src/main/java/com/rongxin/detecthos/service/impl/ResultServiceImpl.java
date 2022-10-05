package com.rongxin.detecthos.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rongxin.detecthos.pojo.Result;
import com.rongxin.detecthos.mapper.ResultMapper;
import com.rongxin.detecthos.pojo.vo.UserResult;
import com.rongxin.detecthos.service.ResultService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
@Service
public class ResultServiceImpl extends ServiceImpl<ResultMapper, Result> implements ResultService {

    @Autowired
    ResultMapper resultMapper;

    @Override
    public PageInfo<UserResult> getUserResultByPage(Integer pageNum, Integer pageSize, String keyword) {
        PageHelper.startPage(pageNum,pageSize);
        List<UserResult> list = resultMapper.getUserResult(keyword);
        PageInfo<UserResult> pageInfo = new PageInfo<UserResult>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<UserResult> getUserResultByCard(Integer pageNum, Integer pageSize,String card) {
        PageHelper.startPage(pageNum,pageSize);
        List<UserResult> list = resultMapper.getUserResultByCard(card);
        PageInfo<UserResult> pageInfo = new PageInfo<UserResult>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<UserResult> getUserResultBySex(Integer pageNum, Integer pageSize,Boolean sex) {
        PageHelper.startPage(pageNum,pageSize);
        List<UserResult> list = resultMapper.getUserResultBySex(sex);
        PageInfo<UserResult> pageInfo = new PageInfo<UserResult>(list);
        return pageInfo;
    }

}
