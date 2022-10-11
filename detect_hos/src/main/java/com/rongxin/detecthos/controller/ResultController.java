package com.rongxin.detecthos.controller;


import com.github.pagehelper.PageInfo;
import com.rongxin.common.R;
import com.rongxin.detecthos.pojo.Medicine;
import com.rongxin.detecthos.pojo.Result;
import com.rongxin.detecthos.pojo.vo.UserResult;
import com.rongxin.detecthos.service.impl.ResultServiceImpl;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Wrapper;
import java.util.*;

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
//@CrossOrigin
public class ResultController {

    @Autowired
    ResultServiceImpl resultService;

    /**
     * 扫码录入数据
     * @param medicineCode
     * @param cardArray
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meuser/insert")
    public R insertResult(@RequestParam("medicineCode") String medicineCode, @RequestParam("cardArray") String cardArray){
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

    /**
     * 获取未出结果的核酸记录（根据姓名查询）
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meresult/getresults")
    public R getResults(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value="pageSize",required = false,defaultValue = "5") Integer pageSize,
                        @RequestParam(value="keyword",required = false) String keyword){
        PageInfo<UserResult> userResult = resultService.getUserResultByPage(pageNum, pageSize, keyword);
        return R.ok().data("userresult",userResult);
    }

    /**
     * 根据性别查询
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meresult/getsex")
    public R getResultsBySex(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value="pageSize",required = false,defaultValue = "5") Integer pageSize,
                        @RequestParam(value="keyword",required = false) Boolean keyword){
        PageInfo<UserResult> userResult = resultService.getUserResultBySex(pageNum, pageSize, keyword);
        return R.ok().data("sexResults",userResult);
    }

    /**
     * 根据card查询
     * @param pageNum
     * @param pageSize
     * @param keyword
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meresult/getcard")
    public R getResultsByCard(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value="pageSize",required = false,defaultValue = "5") Integer pageSize,
                        @RequestParam(value="keyword",required = false) String keyword){
        PageInfo<UserResult> userResult = resultService.getUserResultByCard(pageNum, pageSize, keyword);
        return R.ok().data("cardResults",userResult);
    }

    /**
     * 录入单个用户的核酸结果
     * @param id
     * @param resultstate
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meresult/modify")
    public R mpdifyResultByOne(@RequestParam(value="id",required = false) Integer id,
                               @RequestParam(value="resultstate",required = false) String resultstate){
        //根据id获取result对象
        Result result = resultService.getById(id);
        //修改核酸结果和检测时间
        result.setResultstate(resultstate);
        Date date = new Date();
        result.setResultTime(date);
        boolean flag = resultService.updateById(result);
        if(flag){
            return R.ok();
        }else{
            return R.error();
        }
    }

    /**
     * 批量录入用户的核酸结果
     * @param idArray
     * @param resultstate
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meresult/modifyAll")
    public R mpdifyResult(@RequestParam(value="idArray",required = false) String idArray,
                          @RequestParam(value="resultstate",required = false) String resultstate){
        //将id放进list集合中
        List<Integer> idList = new ArrayList<Integer>();
        String[] IdArray = idArray.split(",");
        for(int i=0;i<IdArray.length;i++){
            idList.add(Integer.parseInt(IdArray[i]));
        }
        //根据id集合查询result对象集合
        Collection<Result> results = resultService.listByIds(idList);
        Iterator<Result> it = results.iterator();
        List<Result> list = new ArrayList<Result>();
        //将核酸结果已经检测时间修改
        while(it.hasNext()){
            Result result = it.next();
            result.setResultstate(resultstate);
            Date date = new Date();
            result.setResultTime(date);
            list.add(result);
        }
        boolean flag = resultService.updateBatchById(list);
        if(flag){
            return R.ok();
        }else{
            return R.error();
        }
    }

}

