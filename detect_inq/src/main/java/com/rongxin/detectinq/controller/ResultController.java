package com.rongxin.detectinq.controller;


import com.github.pagehelper.PageInfo;
import com.rongxin.common.R;
import com.rongxin.detectinq.entity.vo.UserResult;
import com.rongxin.detectinq.service.impl.ResultServiceImpl;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import javax.servlet.http.HttpSession;
import java.util.*;

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

    @Autowired
    ResultServiceImpl resultService;

    @IOLogRecorder
    @RequestMapping("/test")
    public String test(@RequestParam("medicineCode") String medicineCode,@RequestParam("cardArray") String cardArray){
        System.out.println(medicineCode);
        String[] split = cardArray.split(",");
        System.out.println(split[0]);
        return "testMq";
    }
    /**
     * 查询所有
     * @return
     * http://localhost:8001/detectinq/result/adminSearchResult
     */
    @IOLogRecorder
    @RequestMapping("/adminSearchResult")
    public R adminSearchResult(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                               @RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize,
                               HttpSession session){
        PageInfo<UserResult> resultList = new PageInfo<UserResult>();
        try{
            resultList = resultService.selectAllResult(pageNum,pageSize);
            System.out.println(resultList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return R.ok().data("resultList",resultList);
    }

    /**
     * 条件查询  查询证件号或者用户姓名
     * @param session
     * @return
     * http://localhost:8001/detectinq/result/adminConditionSearch
     */
    @RequestMapping("/adminConditionSearch")
    @IOLogRecorder
    public R adminConditionSearch(@RequestParam("condition")String condition,
                                  @RequestParam("startTime")String startTime,
                                  @RequestParam("endTime")String endTime,
                                  @RequestParam("resultState")String resultState,
                                  @RequestParam("done")String done,
                                  @RequestParam("preDone")String preDone,
                                  @RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                                  @RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize,
                                  HttpSession session){
        Map<String,Object> conditions=new HashMap<String, Object>();
        Map<String,Object> overDue=new HashMap<String, Object>();
        PageInfo<UserResult> resultList=new PageInfo<UserResult>();
        if(done!=null&&done!=""){
            try {
                overDue.put("done",done);
                overDue.put("preDone",preDone);
                resultList=resultService.selectOverDueUser(overDue,pageNum,pageSize);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }else{
            try{
                conditions.put("condition",condition);
                conditions.put("startTime",startTime);
                conditions.put("endTime",endTime);
                conditions.put("resultState",resultState);
                resultList=resultService.selectResultByCondition(conditions,pageNum,pageSize);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return R.ok().data("resultList",resultList).data("condition",condition).data("startTime",startTime).
                data("endTime",endTime).data("resultState",resultState). data("done",done).data("pageNum",pageNum);
    }

    /**
     * 更新isDelete状态
     * @param deleteResultCard
     * @param deleteResultTime
     * @param session
     * @return
     * http://localhost:8001/detectinq/result/adminModifyIsDelete
     */
    @IOLogRecorder
    @RequestMapping("/adminModifyIsDelete")
    public R adminModifyIsDelete(@RequestParam("deleteResultCard")String deleteResultCard,
                                 @RequestParam("deleteResultTime")String deleteResultTime,
                                 HttpSession session){
        Map<String,String> delMsg=new HashMap<String, String>();
        Integer success = null;
        try{
            delMsg.put("deleteResultCard",deleteResultCard);
            delMsg.put("deleteResultTime",deleteResultTime);
            success=resultService.updateIsDelete(delMsg);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return R.ok().data("delResult",success);
    }



}

