package com.rongxin.detectacl.service;

import com.rongxin.detectacl.entity.Roles;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-29
 */
public interface RolesService extends IService<Roles> {
    List<Roles> getAllRole();
}
