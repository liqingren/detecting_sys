package com.rongxin.detectinq.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rongxin.detectinq.entity.Users;
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

    /**
     * 验证身份证号唯一性
     * @param card
     * @return
     */
    int getOnlyUser(String card);

}
