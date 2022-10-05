package com.rongxin.detectacl.mapper;

import com.rongxin.detectacl.entity.RoleUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rongxin.detectacl.entity.Roles;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-28
 */
@Mapper
public interface RoleUserMapper extends BaseMapper<RoleUser> {

    List<RoleUser> selectAll();

    Roles selectRoleByUserId(Integer userId);

    void updateByRId(RoleUser roleUser);

    void updateByUId(RoleUser roleUser);

    boolean updateByUserIds(Map<String,Object> map);
}
