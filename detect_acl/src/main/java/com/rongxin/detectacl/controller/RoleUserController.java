package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.RoleUser;
import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.service.RoleUserService;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
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
//@CrossOrigin
public class RoleUserController {
    @Autowired
    private RoleUserService service;

    /**
     * 增加一个用户角色关系
     * @param roleUser
     * @return
     */
    @RequestMapping("/addRoleUser")
//    @IOLogRecorder
    public R addRoleForPer(@RequestBody RoleUser roleUser){
        roleUser.setCreateTime(new Date());
        roleUser.setUpdateTime(new Date());
        boolean save = service.save(roleUser);
        return save==true?R.ok():R.error();
    }

    /**
     * 软删除关系
     * @param role
     * @return
     */
    @RequestMapping("/remove")
//    @IOLogRecorder
    public R updatePreRole(@RequestBody RoleUser role){
        role.setUpdateTime(new Date());
        boolean flag = service.updateById(role);
        return flag==true?R.ok():R.error();
    }

    /**
     * 获取所有关系
     * @return
     */
    @RequestMapping("/getAllRoleUser")
    public R getAllPermissionRole(){
        List<RoleUser> roles=service.getAllRoleUser();
        return R.ok().data("roleUsers",roles);
    }

    /**
     * 获取用户对应的角色
     * @param userId
     * @return
     */
    @RequestMapping("/getUserRole")
    public R getUserRole(Integer userId){
        Roles role=service.getRoleByUserId(userId);
        return R.ok().data("role",role);
    }

    /**
     * 软删除多组关系
     * @param userStr
     * @return
     */
    @RequestMapping("/removeRoleUsers")
//    @IOLogRecorder
    public R removeRoleUsers(@RequestParam("deleteUsers")String userStr){
        //处理传过来的字符串
        if(userStr==null||userStr.equals("")){
            return R.error();
        }
        String[] split = userStr.split(",");
        List<Integer> userIds=new ArrayList<>();
        for (String s : split) {
            //添加到集合统一删除
            userIds.add(Integer.parseInt(s));
        }
        boolean flag=service.updateByUserIds(userIds);
        return flag==true?R.ok():R.error();
    }

    /**
     * 添加多组关系
     * @param addStr
     * @param roleId
     * @return
     */
    @RequestMapping("/saveRoleUser")
//    @IOLogRecorder
    public R saveRoleUser(@RequestParam("addUsers")String addStr,@RequestParam("roleId")Integer roleId){
        if(roleId==null||roleId<=0||addStr==null||addStr.equals("")){
            return R.error();
        }
        List<RoleUser> saveList=new ArrayList<>();
        List<Integer> userIds=new ArrayList<>();
        String[] split = addStr.split(",");
        for (String s : split) {
            RoleUser roleUser=new RoleUser();
            roleUser.setRoleId(roleId);
            roleUser.setUserId(Integer.parseInt(s));
            roleUser.setIsDelete(true);
            roleUser.setCreateTime(new Date());
            roleUser.setUpdateTime(new Date());

            userIds.add(roleUser.getUserId());
            saveList.add(roleUser);
        }
        //删除原来的关系，一个用户对应一个角色
        service.updateByUserIds(userIds);
        boolean b = service.saveBatch(saveList);
        return b==true?R.ok():R.error();
    }
}

