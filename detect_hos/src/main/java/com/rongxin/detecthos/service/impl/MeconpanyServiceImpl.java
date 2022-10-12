package com.rongxin.detecthos.service.impl;

import com.rongxin.detecthos.pojo.Meconpany;
import com.rongxin.detecthos.mapper.MeconpanyMapper;
import com.rongxin.detecthos.service.MeconpanyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author rlq
 * @since 2022-10-10
 */
@Service
public class MeconpanyServiceImpl extends ServiceImpl<MeconpanyMapper, Meconpany> implements MeconpanyService {
    @Override
    public Meconpany getMeconpanyByCode(String code) {
        return baseMapper.getMeconpanyByCode(code);
    }
}
