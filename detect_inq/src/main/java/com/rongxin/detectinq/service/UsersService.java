package com.rongxin.detectinq.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.rongxin.detectinq.entity.LoginVo;
import com.rongxin.detectinq.entity.Users;

import java.util.List;

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
     * @return
     */
    String login(LoginVo loginVo);

    List<String> getAllPermission(LoginVo loginVo);

    String getRoleCodeByCard(String card);
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
