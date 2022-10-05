package com.rongxin.detectacl.mapper;

import com.rongxin.detectacl.entity.Permission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-28
 */
@Mapper
public interface PermissionMapper extends BaseMapper<Permission> {

    boolean updateDelete(Integer id);

    List<Permission> selectAll();
}
