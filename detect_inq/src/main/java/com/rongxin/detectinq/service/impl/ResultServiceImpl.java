package com.rongxin.detectinq.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rongxin.detectinq.entity.Result;
import com.rongxin.detectinq.entity.vo.UserResult;
import com.rongxin.detectinq.mapper.ResultMapper;
import com.rongxin.detectinq.service.ResultService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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


    @Cacheable(value="getResultByUserId")
    public Result getResultByUserId(int id) {
        return baseMapper.getResultByUserId(id);
    }

    @Override
//    @Cacheable(value="getResultByPage")
    public PageInfo<Result> getResultByPage(Integer pageNum, Integer pageSize, Integer id,String keyword) {
        PageHelper.startPage(pageNum,pageSize);
        List<Result> list = baseMapper.getResultByPage(id,keyword);
        PageInfo<Result> pageInfo = new PageInfo<Result>(list);
        return pageInfo;
    }

    @Override
    public int getCountByUserId(Integer userId) {
        return baseMapper.getCountByUserId(userId);
    }

    @Override
    public PageInfo<UserResult> selectAllResult(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<UserResult> list = baseMapper.selectAllResult();
        PageInfo<UserResult> pageInfo = new PageInfo<UserResult>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<UserResult> selectResultByCondition(Map conditions, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<UserResult> list = baseMapper.selectResultByCondition(conditions);
        PageInfo<UserResult> pageInfo = new PageInfo<UserResult>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<UserResult> selectOverDueUser(Map overDue,Integer pageNum,Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<UserResult> list = baseMapper.selectOverDueUser(overDue);
        PageInfo<UserResult> pageInfo = new PageInfo<UserResult>(list);
        return pageInfo;
    }


    @Override
    public Integer updateIsDelete(Map delMsg) {
        return baseMapper.updateIsDelete(delMsg);
    }

}
