package com.rongxin.detectinq.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rongxin.detectinq.entity.Result;
import com.rongxin.detectinq.mapper.ResultMapper;
import com.rongxin.detectinq.service.ResultService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@Service
public class ResultServiceImpl extends ServiceImpl<ResultMapper, Result> implements ResultService {
    @Autowired
    ResultMapper resultMapper;

    @Cacheable(value="getResultByUserId")
    public Result getResultByUserId(int id) {
        return resultMapper.getResultByUserId(id);
    }

    @Override
    @Cacheable(value="getResultByPage")
    public PageInfo<Result> getResultByPage(Integer pageNum, Integer pageSize, Integer id,String keyword) {
        PageHelper.startPage(pageNum,pageSize);
        List<Result> list = resultMapper.getResultByPage(id,keyword);
        PageInfo<Result> pageInfo = new PageInfo<Result>(list);
        return pageInfo;
    }

    @Override
    public int getCountByUserId(Integer userId) {
        return resultMapper.getCountByUserId(userId);
    }

}
