package com.rongxin.detecthos.mapper;

import com.rongxin.detecthos.pojo.Users;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rongxin.detecthos.pojo.vo.UserResult;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
@Mapper
public interface UsersMapper extends BaseMapper<Users> {


}
