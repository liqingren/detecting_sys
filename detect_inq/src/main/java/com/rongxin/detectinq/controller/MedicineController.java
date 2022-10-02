package com.rongxin.detectinq.controller;


import com.rongxin.common.R;
import com.rongxin.detectinq.entity.Medicine;
import com.rongxin.detectinq.service.impl.MedicineServiceImpl;
import com.rongxin.detectinq.utils.QRCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.UUID;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ren
 * @since 2022-09-29
 */
@RestController
@RequestMapping("/detectinq/medicine")
public class MedicineController {
    @Autowired
    MedicineServiceImpl medicineService;

    /**
     * 根据药品编号查询药品信息
     * @param code
     * @return
     */
    @RequestMapping("/getmedicine")
    public R test(@RequestParam("code") String code){
        Medicine medicine=new Medicine();
        if(code!=null){
            medicine = medicineService.getByMedicineCode(code);
        }
        return R.ok().data("medicine",medicine);
    }

    /**
     * 插入药品
     * @param medicine
     * @return
     */
    @RequestMapping("/insert")
    public R insert(@RequestBody Medicine medicine){
        //随机生成ya药品编号
        String str = UUID.randomUUID().toString();
        String medicineCode = str.replace("-","");
        System.out.println(medicineCode);
        medicine.setMedicineCode(medicineCode);
        //获取当前日期
        Date date = new Date();
        medicine.setCreateTime(date);
        boolean save = medicineService.save(medicine);
        if(save){
            try {
                //生成黑色二维码
                Integer color=0xFF000000;
                //将药品编号转换成二维码
                String encode = QRCodeUtils.encode(medicineCode,color);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return R.ok();
        }
        return R.error();
    }
}

