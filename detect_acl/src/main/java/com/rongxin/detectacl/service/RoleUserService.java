package com.rongxin.detectacl.service;

import com.rongxin.detectacl.entity.RoleUser;
import com.baomidou.mybatisplus.extension.service.IService;
import com.rongxin.detectacl.entity.Roles;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-28
 */
public interface RoleUserService extends IService<RoleUser> {

    List<RoleUser> getAllRoleUser();


    Roles getRoleByUserId(Integer userId);

    void updateByRId(RoleUser roleUser);

    void updateByUId(RoleUser roleUser);

    boolean updateByUserIds(List<Integer> userIds);
}
