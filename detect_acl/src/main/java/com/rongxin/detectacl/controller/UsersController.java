package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.PreRole;
import com.rongxin.detectacl.entity.RoleUser;
import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.entity.Users;
import com.rongxin.detectacl.entity.vo.UserVo;
import com.rongxin.detectacl.service.RoleUserService;
import com.rongxin.detectacl.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-30
 */
@RestController
@RequestMapping("/detectacl/users")
@CrossOrigin
public class UsersController {
    @Autowired
    private UsersService service;
    @Autowired
    private RoleUserService roleUserService;
    @RequestMapping("/remove")
    public R updatePreRole(@RequestParam("deleteUsers") String users) {
        List<Users> deRoles = new ArrayList<>();
        //处理前端传过来的数字组成的字符串
        if (users != null && !users.equals("")) {
            String[] split = users.split(",");
            for (String s : split) {
                Users role = new Users();
                role.setId(Integer.valueOf(s));
                role.setIsDeleted(false);
                role.setUpdateTime(new Date());

                RoleUser roleUser = new RoleUser();
                roleUser.setRoleId(role.getId());
                roleUser.setUpdateTime(new Date());
                roleUser.setIsDelete(false);
                roleUserService.updateByUId(roleUser);

                deRoles.add(role);
            }
        }
        boolean flag = service.updateBatchById(deRoles);
        return flag == true ? R.ok() : R.error();
    }
    @RequestMapping("/getUserVoPage")
    public R getUserVoPage(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                    @RequestParam(required = false,defaultValue = "")String condition){
        List<UserVo> userList=service.getByCondition(pageNum,condition);
        return R.ok().data("userList",userList);
    }
}

