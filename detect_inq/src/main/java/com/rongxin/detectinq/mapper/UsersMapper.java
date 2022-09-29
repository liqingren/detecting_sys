package com.rongxin.detectinq.mapper;

import com.rongxin.detectinq.entity.Result;
import com.rongxin.detectinq.entity.Users;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@Mapper
public interface UsersMapper extends BaseMapper<Users> {
    /**
     * 登录
     * @param user
     * @return
     */
    int login(Users user);

    /**
     * 根据card获取用户信息
     * @param card
     * @return
     */
    Users getByCard(String card);

}
