package com.rongxin.detecthos.controller;


import com.rongxin.common.R;
import com.rongxin.detecthos.service.UsersService;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
@RestController
@RequestMapping("/detecthos/users")
//@CrossOrigin
public class UsersController {
    @Autowired
    UsersService usersService;
    @IOLogRecorder
    @RequestMapping("/meuser/getuser")
    public R getUser(@RequestParam("code") String code) {
        return usersService.getUserByCard(code);
    }
    @RequestMapping("/test")
    public String test(){
        return "192.168.190.111---------岳志坤";
    }

}

