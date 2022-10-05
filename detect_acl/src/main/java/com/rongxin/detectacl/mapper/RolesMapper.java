package com.rongxin.detectacl.mapper;

import com.rongxin.detectacl.entity.Roles;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-29
 */
@Mapper
public interface RolesMapper extends BaseMapper<Roles> {
    List<Roles> selectAll();
}
