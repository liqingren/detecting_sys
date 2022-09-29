package com.rongxin.detectacl.service.impl;

import com.rongxin.detectacl.entity.PreRole;
import com.rongxin.detectacl.mapper.PreRoleMapper;
import com.rongxin.detectacl.service.PreRoleService;
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
public class PreRoleServiceImpl extends ServiceImpl<PreRoleMapper, PreRole> implements PreRoleService {

    @Override
    public boolean updateDelete(Integer id) {
        return baseMapper.updateDelete(id);
    }

    @Override
    public List<PreRole> getAllPerRole() {
        return baseMapper.selectAll();
    }

    @Override
    public boolean updateByPId(PreRole preRole) {
        if(preRole.getPreId()==null||preRole.getIsDeleted()==null){
            return false;
        }
        return baseMapper.updateByPId(preRole);
    }
}
