package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.PreRole;
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
@RequestMapping("/detectacl/prerole")
@CrossOrigin
public class PreRoleController {
    @Autowired
    private PreRoleService service;

    @RequestMapping("/addRolePer")
    public R addRoleForPer(@RequestBody PreRole preRole){
        boolean save = service.save(preRole);
        return save==true?R.ok():R.error();
    }
    @RequestMapping("/remove")
    public R updatePreRole(@RequestBody PreRole preRole){
        preRole.setUpdateTime(new Date());
        boolean flag = service.updateById(preRole);
        return flag==true?R.ok():R.error();
    }
    @RequestMapping("/getAllPerRole")
    public R getAllPermissionRole(){
        List<PreRole> perRole=service.getAllPerRole();
        return R.ok().data("perRole",perRole);
    }
}

