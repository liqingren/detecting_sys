package com.rongxin.detectacl.service.impl;

import com.rongxin.detectacl.entity.Permission;
import com.rongxin.detectacl.mapper.PermissionMapper;
import com.rongxin.detectacl.service.PermissionService;
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
 * @since 2022-09-28
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {

    @Override
    public boolean updateDelete(Integer id) {
        return baseMapper.updateDelete(id);
    }

    @Cacheable(key="'permissionList'",value = "permissionList")
    @Override
    public List<Permission> getAllPermission() {
        return baseMapper.selectAll();
    }

    @Override
    public List<Permission> getByIds(List<Integer> ids) {
        return baseMapper.selectBatchIds(ids);
    }

}
