package com.rongxin.detectacl.service;

import com.rongxin.detectacl.entity.Permission;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-28
 */
public interface PermissionService extends IService<Permission> {

    boolean updateDelete(Integer id);

    List<Permission> getAllPermission();

    List<Permission> getByIds(List<Integer> ids);
}
