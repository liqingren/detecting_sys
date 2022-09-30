package com.rongxin.detectinq.service.impl;

import com.rongxin.detectinq.entity.Result;
import com.rongxin.detectinq.mapper.ResultMapper;
import com.rongxin.detectinq.service.ResultService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
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
    public List<Result> getResultByCard(int id) {
        return resultMapper.getResultByCard(id);
    }

}
