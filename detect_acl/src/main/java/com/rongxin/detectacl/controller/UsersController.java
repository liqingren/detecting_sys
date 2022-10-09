package com.rongxin.detectacl.controller;


import com.rongxin.common.R;
import com.rongxin.detectacl.entity.*;
import com.rongxin.detectacl.entity.vo.LoginVo;
import com.rongxin.detectacl.entity.vo.RegisterVo;
import com.rongxin.detectacl.entity.vo.UserVo;
import com.rongxin.detectacl.service.RoleUserService;
import com.rongxin.detectacl.service.UsersService;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
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
//@CrossOrigin
public class UsersController {
    @Qualifier("redisTemplate")
    @Autowired
    RedisTemplate redisTemplate;
    @Autowired
    private UsersService service;
    @Autowired
    private RoleUserService roleUserService;

    /**
     * 软删除用户
     * @param users
     * @return
     */
    @RequestMapping("/remove")
    @IOLogRecorder
    public R updatePreRole(@RequestParam("deleteUsers") String users) {
         List<Users> deRoles = new ArrayList<>();
        //处理前端传过来的数字组成的字符串
        if (users != null && !users.equals("")) {
            String[] split = users.split(",");
            for (String s : split) {
                Users user = new Users();
                user.setId(Integer.valueOf(s));
                user.setIsDeleted(false);
                user.setUpdateTime(new Date());

                RoleUser roleUser = new RoleUser();
                roleUser.setUserId(user.getId());
                roleUser.setUpdateTime(new Date());
                roleUser.setIsDelete(false);
                roleUserService.updateByUId(roleUser);

                deRoles.add(user);
            }
        }
        boolean flag = service.updateBatchById(deRoles);
        return flag == true ? R.ok() : R.error();
    }

    /**
     * 条件查询，并且分页获取数据
     * @param pageNum
     * @param condition
     * @return
     */
    @RequestMapping("/getUserVoPage")
    public R getUserVoPage(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                    @RequestParam(required = false,defaultValue = "")String condition){
        List<UserVo> userList=service.getByCondition(pageNum,condition);
        Integer count=service.selectCount(condition);
        return R.ok().data("userList",userList).data("pageNum",pageNum).data("count",count).data("totalPage",count/8+1);
    }
    //登录
//    @PostMapping("/login")
//    @IOLogRecorder
//    public R login(@RequestBody LoginVo loginVo){
//        //返回token，使用jwt生成
//        String token = service.login(loginVo);
//        List<String> list=service.getAllPermission(loginVo);
//        if(list!=null) {
//            redisTemplate.opsForValue().set("permissions", list);
//        }
//        String code=service.getRoleCodeByCard(loginVo.getCard());
//        System.out.println(list);
//        return R.ok().data("token",token).data("roleCode",code);
//    }
//    //注册
//    @PostMapping("/register")
//    public R register(@RequestBody RegisterVo registerVo){
//        service.register(registerVo);
//        return R.ok();
//    }

}

