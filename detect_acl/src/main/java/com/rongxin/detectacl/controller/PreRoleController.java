package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.PreRole;
import com.rongxin.detectacl.service.PreRoleService;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  权限与角色
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-28
 */
@RestController
@RequestMapping("/detectacl/prerole")
//@CrossOrigin
public class PreRoleController {
    @Autowired
    private PreRoleService service;

    @RequestMapping("/addRolePer")
    @IOLogRecorder
    public R addRoleForPer(@RequestBody PreRole preRole){
        boolean save = service.save(preRole);
        return save==true?R.ok():R.error();
    }

    @RequestMapping("/remove")
    @IOLogRecorder
    public R updatePreRole(@RequestBody PreRole preRole){
        preRole.setUpdateTime(new Date());
        boolean flag = service.updateById(preRole);
        return flag==true?R.ok():R.error();
    }

    /**
     * 获取所有关系
     * @return
     */
    @RequestMapping("/getAllPerRole")
    public R getAllPermissionRole(){
        List<PreRole> perRole=service.getAllPerRole();
        return R.ok().data("perRole",perRole);
    }

    /**
     * 获取某角色对应的所有权限
     * @param rId
     * @return
     */
    @RequestMapping("/getAllPerRoleByRId")
    public R getAllPermissionRoleByRId(@RequestParam("roleId") Integer rId){
        List<PreRole> perRole=service.getAllPerRoleByRId(rId);
        return R.ok().data("rolePer",perRole);
    }

    /**
     * 软删除或者增加权限
     * @param addFun
     * @param deleteFun
     * @param roleId
     * @return
     */
    @RequestMapping("/saveRolePer")
    @IOLogRecorder
    public R saveRolePer(@RequestParam("addFun")String addFun,
                         @RequestParam("deleteFun")String deleteFun,@RequestParam("roleId")Integer roleId){
        List<PreRole> addId=new ArrayList<>();
        List<Integer> deleteId = new ArrayList<>();
        //处理前端传过来的数字组成的字符串
        if(addFun!=null&&!addFun.equals("")) {
            String[] split = addFun.split(",");
            for (String s : split) {
                PreRole addPre=new PreRole();//将要添加的封装到类中
                addPre.setPreId(Integer.parseInt(s));
                addPre.setCreateTime(new Date());
                addPre.setUpdateTime(new Date());
                addPre.setIsDeleted(true);
                addPre.setRoleId(roleId);
                addId.add(addPre);
            }
        }
        if(deleteFun!=null&&!deleteFun.equals("")){
            String[] split1 = deleteFun.split(",");
            for (String s : split1) {
                deleteId.add(Integer.parseInt(s));
            }
        }
        if(roleId==null){
            return R.error();
        }
        boolean flag =true;
        if(addId!=null){
            flag = service.saveBatch(addId);//调用方法添加
        }
        if(flag){
            if(deleteId!=null) {
                List<PreRole> preRoles = service.selectIds(deleteId, roleId);//查询出要进行软删除的数据
                if(preRoles!=null) {
                    for (PreRole preRole : preRoles) {
                        preRole.setIsDeleted(false);
                        preRole.setUpdateTime(new Date());
                    }
                    service.updateBatchById(preRoles);
                }
            }
        }
        return flag==true?R.ok():R.error();
    }
}

