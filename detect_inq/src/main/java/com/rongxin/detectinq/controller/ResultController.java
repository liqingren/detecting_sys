package com.rongxin.detectinq.controller;


import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@RestController
@RequestMapping("/detectinq/result")
public class ResultController {

    @RequestMapping("/test")
    public void test(@RequestParam("medicineCode") String medicineCode,@RequestParam("cardArray") String cardArray){
        System.out.println(medicineCode);
        String[] split = cardArray.split(",");
        System.out.println(split[0]);
    }
}

