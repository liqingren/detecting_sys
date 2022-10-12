package com.rongxin.detecthos.controller;


import com.github.pagehelper.PageInfo;
import com.rongxin.common.R;
import com.rongxin.detecthos.pojo.Meconpany;
import com.rongxin.detecthos.pojo.Medicine;
import com.rongxin.detecthos.pojo.Result;
import com.rongxin.detecthos.pojo.vo.UserResult;
import com.rongxin.detecthos.service.impl.MeconpanyServiceImpl;
import com.rongxin.detecthos.service.impl.MedicineServiceImpl;
import com.rongxin.detecthos.service.impl.ResultServiceImpl;
import com.rongxin.detecthos.utils.finalClass;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
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

    @Autowired
    MedicineServiceImpl medicineService;

    @Autowired
    MeconpanyServiceImpl meconpanyService;

    /**
     * 扫码录入数据
     * @param medicineCode
     * @param cardArray
     * @return
     */
    @IOLogRecorder
//    @Transactional
    @RequestMapping("/meuser/insert")
    public R insertResult(@RequestParam("medicineCode") String medicineCode, @RequestParam("cardArray") String cardArray){
        Medicine medicine = new Medicine();
        //将userId字符串分割成数组
        String[] userIds = cardArray.split(",");
        List<Result> list = new ArrayList<Result>();
        //将药品二维码和用户id以及采样时间add进list集合
        for(int i=0;i<userIds.length;i++){
            Result result = new Result();
            result.setMedicineCode(medicineCode);
            result.setUserId(Integer.parseInt(userIds[i]));
            Date date = new Date();
            result.setCreateTime(date);
            list.add(result);
        }
        System.out.println(list);
        //向result表中批量插入数据
        boolean flag = resultService.saveBatch(list);
        if(flag){
            //获取当前项目路径
            File file = new File("");
            String filePath ="";
            try {
                filePath = file.getCanonicalPath();
            } catch (IOException e) {
                e.printStackTrace();
            }
            //获取试剂二维码的路径
            String codePath = filePath+ finalClass.MECODE_PATH+medicineCode+".jpg";
            file = new File(codePath);
            //删除被扫描过的试剂二维码
            if (file.isFile() && file.exists()) {
                file.delete();
            }
            //获取试剂信息
            medicine = medicineService.getByMedicineCode(medicineCode);
            if(medicine!=null) {
                medicine.setIsDeleted(false);
                //该试剂已被使用，软删除该试剂
                medicineService.updateById(medicine);
                //获取这一批次药品信息
                Meconpany conpany = meconpanyService.getById(medicine.getConpanyId());
                Integer num = conpany.getNum();
                //已被使用掉一罐试剂，药品总数量-1
                conpany.setNum(num - 1);
                //当药品数量为0时，软删除该药品
                if (num - 1 == 0) {
                    conpany.setIsDeleted(false);
                }
                boolean conflag = meconpanyService.updateById(conpany);
                if (conflag) {
                    return R.ok();
                }
            }
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
                        @RequestParam(value="pageSize",required = false,defaultValue = "5") Integer pageSize){
        PageInfo<UserResult> result = resultService.getResultByPage(pageNum, pageSize);
        return R.ok().data("userresult",result);
    }

    /**
     * 录入单个试剂的核酸结果
     * @param code
     * @param resultstate
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meresult/modify")
    public R mpdifyResultByOne(@RequestParam(value="code",required = false) String code,
                               @RequestParam(value="resultstate",required = false) String resultstate){
        //根据medicineCode获取result对象
        List<Result> list = resultService.getResultByCode(code);
        for(Result re:list){
            re.setResultstate(resultstate);
            Date date = new Date();
            re.setResultTime(date);
        }
        //修改result表中对应的数据信息
        boolean flag = resultService.updateBatchById(list);
        if(flag){
            return R.ok();
        }else{
            return R.error();
        }
    }

    /**
     * 批量录入试剂的核酸结果
     * @param codeArray
     * @param resultstate
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meresult/modifyAll")
    public R mpdifyResult(@RequestParam(value="codeArray",required = false) String codeArray,
                          @RequestParam(value="resultstate",required = false) String resultstate){
        //将id放进list集合中
        List<Integer> idList = new ArrayList<Integer>();
        //试剂编号
        String[] CodeArray = codeArray.split(",");
        for(int i=0;i<CodeArray.length;i++){
            List<Result> list = resultService.getResultByCode(CodeArray[i]);
            for(Result re:list){
                idList.add(re.getId());
            }
        }
        System.out.println(idList.size());
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
        //批量修改result表中对应的数据信息
        boolean flag = resultService.updateBatchById(list);
        if(flag){
            return R.ok();
        }else{
            return R.error();
        }
    }

}

