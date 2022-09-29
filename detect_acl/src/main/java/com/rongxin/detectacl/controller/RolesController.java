package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.service.RolesService;
import org.springframework.beans.factory.annotation.Autowired;
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
 * @since 2022-09-29
 */
@RestController
@RequestMapping("/detectacl/roles")
public class RolesController {
    @Autowired
    private RolesService service;
    @RequestMapping("/addRole")
    public R addRoleForPer(@RequestBody Roles role){
        role.setCreateTime(new Date());
        role.setUpdateTime(new Date());
        boolean save = service.save(role);
        return save==true?R.ok():R.error();
    }
    @RequestMapping("/remove")
    public R updatePreRole(@RequestBody Roles role){
        role.setUpdateTime(new Date());
        boolean flag = service.updateById(role);
        return flag==true?R.ok():R.error();
    }
    @RequestMapping("/getAllRole")
    public R getAllPermissionRole(){
        List<Roles> roles=service.getAllRole();
        return R.ok().data("roles",roles);
    }
}

