package com.rongxin.detectacl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.rongxin.common.JwtUtils;
import com.rongxin.detectacl.entity.Permission;
import com.rongxin.detectacl.entity.PreRole;
import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.entity.Users;
import com.rongxin.detectacl.entity.vo.LoginVo;
import com.rongxin.detectacl.entity.vo.RegisterVo;
import com.rongxin.detectacl.entity.vo.UserVo;
import com.rongxin.detectacl.exception.MyException;
import com.rongxin.detectacl.mapper.UsersMapper;
import com.rongxin.detectacl.service.PermissionService;
import com.rongxin.detectacl.service.RoleUserService;
import com.rongxin.detectacl.service.UsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
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
 * @author yuezhik
 * @since 2022-09-30
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements UsersService {
    @Autowired
    private RoleUserService roleUserService;
    @Autowired
    private PreRoleServiceImpl preRoleService;
    @Autowired
    private PermissionService permissionService;
    @Override
    public List<UserVo> getByCondition(Integer pageNum, String condition) {
        if(condition==""){
            condition=null;
        }
        List<Users> users = baseMapper.selectByCondition((pageNum-1)*8, condition);
        List<UserVo> userVoList=new ArrayList<>();
        for (Users user : users) {
            UserVo userVo=new UserVo();
            Roles role = roleUserService.getRoleByUserId(user.getId());

            userVo.setId(user.getId());
            userVo.setUpdateTime(user.getUpdateTime());
            userVo.setCard(user.getCard());
            userVo.setName(user.getName());
            if(role==null){
                userVo.setRoleId(-1);
                userVo.setRoleName("普通用户");
            }else {
                userVo.setRoleName(role.getRoleName());
                userVo.setRoleId(role.getId());
            }
            userVoList.add(userVo);
        }
        return userVoList;
    }

    @Override
    public Integer selectCount(String condition) {
        return baseMapper.selectCountPage(condition);
    }

    @Override
    public String login(LoginVo loginVo) {
        String card = loginVo.getCard();
        String password = loginVo.getPassword();
        if(card==null||password==null){
            throw new MyException();
        }
        Users loginUser=baseMapper.selectUser(card);
        if(!password.equals(loginUser.getPassword())){
            throw new MyException();
        }
        String token= JwtUtils.getJwtToken(loginUser.getCard(),loginUser.getName());
        return token;
    }
    @Override
    public List<String> getAllPermission(LoginVo loginVo) {
        Users users=baseMapper.getUserByCard(loginVo.getCard());
        Roles role = roleUserService.getRoleByUserId(users.getId());
        List<PreRole> list = preRoleService.getAllPerRoleByRId(role.getId());
        List<Integer> ids=new ArrayList<>();
        for (PreRole preRole : list) {
            ids.add(preRole.getPreId());
        }
        List<String> acls=new ArrayList<>();
        List<Permission> permissions=permissionService.getByIds(ids);
        for (Permission permission : permissions) {
            acls.add(permission.getPreUrl());
        }
        return acls;
    }

    @Override
    public String getRoleCodeByCard(String card) {
        return baseMapper.selectRoleCode(card);
    }

}
