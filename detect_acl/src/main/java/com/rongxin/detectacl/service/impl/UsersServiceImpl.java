package com.rongxin.detectacl.service.impl;

import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.entity.Users;
import com.rongxin.detectacl.entity.vo.UserVo;
import com.rongxin.detectacl.mapper.UsersMapper;
import com.rongxin.detectacl.service.RoleUserService;
import com.rongxin.detectacl.service.UsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
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
}
