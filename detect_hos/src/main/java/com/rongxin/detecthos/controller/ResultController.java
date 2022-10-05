package com.rongxin.detecthos.controller;


import com.github.pagehelper.PageInfo;
import com.rongxin.common.R;
import com.rongxin.detecthos.pojo.Medicine;
import com.rongxin.detecthos.pojo.Result;
import com.rongxin.detecthos.pojo.vo.UserResult;
import com.rongxin.detecthos.service.impl.ResultServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
@RestController
@RequestMapping("/detecthos/result")
public class ResultController {

    @Autowired
    ResultServiceImpl resultService;

    /**
     * 获取未出结果的核酸记录
     * @return
     */
    @RequestMapping("/getresults")
    public R getResults(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value="pageSize",required = false,defaultValue = "10") Integer pageSize,
                        @RequestParam(value="keyword",required = false) String keyword){
        PageInfo<UserResult> userResult = resultService.getUserResultByPage(pageNum, pageSize, keyword);
        return R.ok().data("userresult",userResult);
    }

    @RequestMapping("/getsex")
    public R getResultsBySex(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value="pageSize",required = false,defaultValue = "10") Integer pageSize,
                        @RequestParam(value="keyword",required = false) Boolean keyword){
        PageInfo<UserResult> userResult = resultService.getUserResultBySex(pageNum, pageSize, keyword);
        return R.ok().data("userresult",userResult);
    }

    @RequestMapping("/getcard")
    public R getResultsByCard(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value="pageSize",required = false,defaultValue = "10") Integer pageSize,
                        @RequestParam(value="keyword",required = false) String keyword){
        PageInfo<UserResult> userResult = resultService.getUserResultByCard(pageNum, pageSize, keyword);
        return R.ok().data("userresult",userResult);
    }

    @RequestMapping("/test")
    public R test(@RequestParam("medicineCode") String medicineCode, @RequestParam("cardArray") String cardArray){
        System.out.println(medicineCode);
        String[] userIds = cardArray.split(",");
        List<Result> list = new ArrayList<Result>();
        for(int i=0;i<userIds.length;i++){
            Result result = new Result();
            result.setMedicineCode(medicineCode);
            result.setUserId(Integer.parseInt(userIds[i]));
            Date date = new Date();
            result.setCreateTime(date);
            list.add(result);
        }
        System.out.println(list);
        boolean flag = resultService.saveBatch(list);
        if(flag){
            return R.ok();
        }
        return R.error();
    }
}

