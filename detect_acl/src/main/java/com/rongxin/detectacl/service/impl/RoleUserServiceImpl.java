package com.rongxin.detectacl.service.impl;

import com.rongxin.detectacl.entity.RoleUser;
import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.mapper.RoleUserMapper;
import com.rongxin.detectacl.service.RoleUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public Roles getRoleByUserId(Integer userId) {
        return baseMapper.selectRoleByUserId(userId);
    }

    @Override
    public void updateByRId(RoleUser roleUser) {
        baseMapper.updateByRId(roleUser);
    }

    @Override
    public void updateByUId(RoleUser roleUser) {
        baseMapper.updateByUId(roleUser);
    }

    @Override
    public boolean updateByUserIds(List<Integer> userIds) {
        Map<String,Object> map=new HashMap<>();
        map.put("userIds",userIds);
        return baseMapper.updateByUserIds(map);
    }


}
