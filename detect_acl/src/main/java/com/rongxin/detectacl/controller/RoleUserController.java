package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.RoleUser;
import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.service.RoleUserService;
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
        Roles role=service.getRoleByUserId(userId);
        return R.ok().data("role",role);
    }
    @RequestMapping("/removeRoleUsers")
    public R removeRoleUsers(@RequestParam("deleteUsers")String userStr){
        if(userStr==null||userStr.equals("")){
            return R.error();
        }
        String[] split = userStr.split(",");
        List<Integer> userIds=new ArrayList<>();
        for (String s : split) {
            userIds.add(Integer.parseInt(s));
        }
        boolean flag=service.updateByUserIds(userIds);
        return flag==true?R.ok():R.error();
    }
    @RequestMapping("/saveRoleUser")
    public R saveRoleUser(@RequestParam("addUsers")String addStr,@RequestParam("roleId")Integer roleId){
        if(roleId==null||roleId<=0||addStr==null||addStr.equals("")){
            return R.error();
        }
        List<RoleUser> saveList=new ArrayList<>();
        String[] split = addStr.split(",");
        for (String s : split) {
            RoleUser roleUser=new RoleUser();
            roleUser.setRoleId(roleId);
            roleUser.setUserId(Integer.parseInt(s));
            roleUser.setIsDelete(true);
            roleUser.setCreateTime(new Date());
            roleUser.setUpdateTime(new Date());

            saveList.add(roleUser);
        }
        boolean b = service.saveBatch(saveList);
        return b==true?R.ok():R.error();
    }
}

