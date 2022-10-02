package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.PreRole;
import com.rongxin.detectacl.entity.RoleUser;
import com.rongxin.detectacl.entity.Roles;
import com.rongxin.detectacl.service.PreRoleService;
import com.rongxin.detectacl.service.RoleUserService;
import com.rongxin.detectacl.service.RolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.management.relation.Role;
import java.util.ArrayList;
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
@CrossOrigin
public class RolesController {
    @Autowired
    private RolesService service;
    @Autowired
    private PreRoleService preRoleService;
    @Autowired
    private RoleUserService roleUserService;
    @RequestMapping("/addRole")
    public R addRoleForPer(@RequestBody Roles role){
        role.setCreateTime(new Date());
        role.setUpdateTime(new Date());
        boolean save = service.save(role);
        return save==true?R.ok():R.error();
    }
    @RequestMapping("/remove")
    public R updatePreRole(@RequestParam("deleteRoles") String roles){
        List<Roles> deRoles = new ArrayList<>();
        //处理前端传过来的数字组成的字符串
        if(roles!=null&&!roles.equals("")) {
            String[] split = roles.split(",");
            for (String s : split) {
                Roles role=new Roles();
                role.setId(Integer.valueOf(s));
                role.setIsDeleted(false);
                role.setUpdateTime(new Date());

                PreRole preRole=new PreRole();
                preRole.setIsDeleted(false);
                preRole.setRoleId(Integer.valueOf(s));
                preRole.setUpdateTime(new Date());
                preRoleService.updateByRId(preRole);

                RoleUser roleUser=new RoleUser();
                roleUser.setRoleId(role.getId());
                roleUser.setUpdateTime(new Date());
                roleUser.setIsDelete(false);
                roleUserService.updateByRId(roleUser);

                deRoles.add(role);
            }
        }
        boolean flag=service.updateBatchById(deRoles);
        return flag==true?R.ok():R.error();
    }
    @RequestMapping("/getAllRole")
    public R getAllPermissionRole(){
        List<Roles> roles=service.getAllRole();
        return R.ok().data("roles",roles);
    }
}
