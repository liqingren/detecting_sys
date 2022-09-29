package com.rongxin.detectacl.mapper;

import com.rongxin.detectacl.entity.PreRole;
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
public interface PreRoleMapper extends BaseMapper<PreRole> {

    boolean updateDelete(Integer id);

    List<PreRole> selectAll();

    boolean updateByPId(PreRole preRole);
}
