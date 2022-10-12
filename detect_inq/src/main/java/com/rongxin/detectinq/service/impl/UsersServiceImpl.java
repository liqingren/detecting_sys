package com.rongxin.detectinq.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.rongxin.common.JwtUtils;
import com.rongxin.detectinq.entity.LoginVo;
import com.rongxin.detectinq.entity.Users;
import com.rongxin.detectinq.exception.BaseException;
import com.rongxin.detectinq.exception.GlobalExceptionHandler;
import com.rongxin.detectinq.mapper.UsersMapper;
import com.rongxin.detectinq.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements UsersService {


    @Override
    public String login(LoginVo loginVo) {
        String card = loginVo.getCard();
        String password = loginVo.getPassword();
        if(card==null||password==null){
            throw new BaseException(416,"账号或密码有误");
        }
        Users loginUser=baseMapper.selectUser(card);
        if(!password.equals(loginUser.getPassword())){
            throw new BaseException(416,"账号或密码有误");
        }
        String token= JwtUtils.getJwtToken(loginUser.getCard(),loginUser.getName());
        return token;
    }
    @Override
    public List<String> getAllPermission(LoginVo loginVo) {
        String roleCode = baseMapper.selectRoleCode(loginVo.getCard());
        List<String> acls=baseMapper.getPermissionUrl(roleCode);
        return acls;
    }

    @Override
    public String getRoleCodeByCard(String card) {
        return baseMapper.selectRoleCode(card);
    }

    @Cacheable(value="getByCard")
    public Users getByCard(String card) {
        return baseMapper.getByCard(card);
    }

    @Override
    public int getOnlyUser(String card) {
        return baseMapper.getOnlyUser(card);
    }
}
