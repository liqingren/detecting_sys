package com.rongxin.detectacl.mapper;

import com.rongxin.detectacl.entity.Users;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-30
 */
@Mapper
public interface UsersMapper extends BaseMapper<Users> {

    List<Users> selectByCondition(@Param("pageNum") Integer pageNum, @Param("condition") String condition);

    Integer selectCountPage(@Param("condition") String condition);

    Users selectUser(String card);

    Users getUserByCard(String card);

    String selectRoleCode(String card);
}
