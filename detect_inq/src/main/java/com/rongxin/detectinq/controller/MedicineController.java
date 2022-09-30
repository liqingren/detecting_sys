package com.rongxin.detectinq.controller;


import com.rongxin.common.R;
import com.rongxin.detectinq.entity.Medicine;
import com.rongxin.detectinq.service.impl.MedicineServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
        Medicine medicine = medicineService.getByMedicineCode(code);
        return R.ok().data("medicine",medicine);
    }
}

