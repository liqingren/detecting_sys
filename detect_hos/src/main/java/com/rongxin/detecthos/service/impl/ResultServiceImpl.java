package com.rongxin.detecthos.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rongxin.detecthos.pojo.Result;
import com.rongxin.detecthos.mapper.ResultMapper;
import com.rongxin.detecthos.pojo.vo.UserResult;
import com.rongxin.detecthos.service.ResultService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
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


    /**
     * 分页查询未出结果的核酸记录
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public PageInfo<UserResult> getResultByPage(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<UserResult> list = resultMapper.getResultByPage();
        PageInfo<UserResult> pageInfo = new PageInfo<UserResult>(list);
        return pageInfo;
    }

    @Override
    public List<Result> getResultByCode(String medicineCode) {
        return resultMapper.getResultByCode(medicineCode);
    }
}
