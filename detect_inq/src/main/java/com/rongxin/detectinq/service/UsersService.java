package com.rongxin.detectinq.service;

import com.rongxin.detectinq.entity.Result;
import com.rongxin.detectinq.entity.Users;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
public interface UsersService extends IService<Users> {
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
