package com.rongxin.detectacl.service.impl;

import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.mapper.RolesMapper;
import com.rongxin.detectacl.service.RolesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-29
 */
@Service
public class RolesServiceImpl extends ServiceImpl<RolesMapper, Roles> implements RolesService {
    @Cacheable(key = "'roles'",value = "roles")
    @Override
    public List<Roles> getAllRole() {
        return baseMapper.selectAll();
    }
}
