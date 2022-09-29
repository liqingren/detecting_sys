package com.rongxin.detectacl.service.impl;

import com.rongxin.detectacl.entity.RoleUser;
import com.rongxin.detectacl.mapper.RoleUserMapper;
import com.rongxin.detectacl.service.RoleUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-28
 */
@Service
public class RoleUserServiceImpl extends ServiceImpl<RoleUserMapper, RoleUser> implements RoleUserService {

    @Override
    public List<RoleUser> getAllRoleUser() {
        return baseMapper.selectAll();
    }
}
