package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.Permission;
import com.rongxin.detectacl.entity.PreRole;
import com.rongxin.detectacl.service.PermissionService;
import com.rongxin.detectacl.service.PreRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
@RequestMapping("/detectacl/permission")
@CrossOrigin
public class PermissionController {
    @Autowired
    private PermissionService service;
    @Autowired
    private PreRoleService preRoleService;

    @RequestMapping("/addPermission")
    public R addRoleForPer(@RequestBody Permission pre){
        pre.setCreateTime(new Date());
        pre.setUpdateTime(new Date());
        boolean save = service.save(pre);
        return save==true?R.ok():R.error();
    }
    @RequestMapping("/updatePreRole")
    public R updatePreRole(@RequestBody Permission pre){
        pre.setUpdateTime(new Date());
        boolean flag = service.updateById(pre);
        return flag==true?R.ok():R.error();
    }
    @RequestMapping("/remove")
    public R removePreRole(@RequestBody Permission pre){
        pre.setUpdateTime(new Date());
        PreRole preRole=new PreRole();
        preRole.setUpdateTime(new Date());
        preRole.setPreId(pre.getId());
        preRole.setIsDeleted(pre.getIsDeleted());

        boolean flag=preRoleService.updateByPId(preRole);
        if(flag) {
            flag = service.updateById(pre);
        }

        return flag==true?R.ok():R.error();
    }

    @RequestMapping("/getAllPermission")
    public R getAllPermissionRole(){
        List<Permission> perRole=service.getAllPermission();
        return R.ok().data("permissions",perRole);
    }
}

