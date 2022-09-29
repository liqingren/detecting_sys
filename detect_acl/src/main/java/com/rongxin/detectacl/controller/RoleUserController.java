package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.RoleUser;
import com.rongxin.detectacl.service.RoleUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-28
 */
@RestController
@RequestMapping("/detectacl/roleuser")
@CrossOrigin
public class RoleUserController {
    @Autowired
    private RoleUserService service;
    @RequestMapping("/addRoleUser")
    public R addRoleForPer(@RequestBody RoleUser roleUser){
        roleUser.setCreateTime(new Date());
        roleUser.setUpdateTime(new Date());
        boolean save = service.save(roleUser);
        return save==true?R.ok():R.error();
    }
    @RequestMapping("/remove")
    public R updatePreRole(@RequestBody RoleUser role){
        role.setUpdateTime(new Date());
        boolean flag = service.updateById(role);
        return flag==true?R.ok():R.error();
    }
    @RequestMapping("/getAllRoleUser")
    public R getAllPermissionRole(){
        List<RoleUser> roles=service.getAllRoleUser();
        return R.ok().data("roleUsers",roles);
    }
    @RequestMapping("/getUserRole")
    public R getUserRole(Integer userId){
//        RoleUser roleUser=service.getRoleByUserId();
        return R.ok();
    }
}

