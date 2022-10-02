package com.rongxin.detectacl.service;

import com.rongxin.detectacl.entity.PreRole;
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
public interface PreRoleService extends IService<PreRole> {

    boolean updateDelete(Integer id);

    List<PreRole> getAllPerRole();

    boolean updateByPId(PreRole preRole);

    boolean updateByRId(PreRole preRole);

    List<PreRole> getAllPerRoleByRId(Integer rId);

    List<PreRole> selectIds(List<Integer> deleteId, Integer roleId);
}
