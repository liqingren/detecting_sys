package com.rongxin.detectacl.mapper;

import com.rongxin.detectacl.entity.PreRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
public interface PreRoleMapper extends BaseMapper<PreRole> {

    boolean updateDelete(Integer id);

    List<PreRole> selectAll();

    boolean updateByPId(PreRole preRole);

    boolean updateByRId(PreRole preRole);

    List<PreRole> selectByRoleId(Integer roleId);


    boolean deleteByPRId(Map<String, Object> map);

    List<PreRole> selectIds(Map<String, Object> map);
}
