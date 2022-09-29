package com.rongxin.detectinq.controller;


import com.rongxin.common.R;
import com.rongxin.detectinq.entity.Result;
import com.rongxin.detectinq.entity.Users;
import com.rongxin.detectinq.service.impl.ResultServiceImpl;
import com.rongxin.detectinq.service.impl.UsersServiceImpl;
import com.rongxin.detectinq.utils.QRCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@RestController
@CrossOrigin
@RequestMapping("/detectinq/users")
public class UsersController {
    @Autowired
    UsersServiceImpl usersService;
    @Autowired
    ResultServiceImpl resultService;
    @RequestMapping("/register")
    public R register(@RequestBody Users user){
        Date date = new Date();
        user.setCreateTime(date);
        boolean flag = usersService.save(user);
        if(flag) {
            //根据身份证号查询用户信息
            Users userCard = usersService.getByCard(user.getCard());
            try {
                //将健康码存入文件并返回文件名
                String codePath = QRCodeUtils.encode(user.getCard());
                //将健康码文件名存入用户表
                userCard.setCodePath(codePath);
                usersService.updateById(userCard);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return R.ok();
        }
        else{
            return R.error();
        }
    }
    @RequestMapping("/login")
    public R login(@RequestParam("card") String card, @RequestParam("password") String password, HttpServletRequest request) {
        Users user = new Users();
        user.setCard(card);
        user.setPassword(password);
        int count = usersService.login(user);
        if(count>0) {
            //根据身份证号查询用户信息
            Users userCard = usersService.getByCard(card);
            return R.ok().data("user",userCard);
        }
        else{
            return R.error();
        }
    }

    @RequestMapping("/getuserresult")
    public R GetUserResult(@RequestParam("card") String card){
        //根据身份证号查询核酸结果
        List<Result> result = resultService.getResultByCard(card);
        return R.ok().data("result",result);
    }
}

