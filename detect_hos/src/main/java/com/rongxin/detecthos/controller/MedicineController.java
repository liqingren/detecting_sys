package com.rongxin.detecthos.controller;


import com.rongxin.common.R;
import com.rongxin.detecthos.pojo.Meconpany;
import com.rongxin.detecthos.pojo.Medicine;
import com.rongxin.detecthos.service.impl.MeconpanyServiceImpl;
import com.rongxin.detecthos.service.impl.MedicineServiceImpl;
import com.rongxin.detectinq.utils.QRCodeUtils;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

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
@RequestMapping("/detecthos/medicine")
//@CrossOrigin
public class MedicineController {
    @Autowired
    MedicineServiceImpl medicineService;

    @Autowired
    MeconpanyServiceImpl meconpanyService;
    /**
     * 根据药品编号查询药品信息
     * @param code
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/meuser/getmedicine")
    public R test(@RequestParam("code") String code){
        Medicine medicine=new Medicine();
        Meconpany conpany = null;
        if(code!=null){
            medicine = medicineService.getByMedicineCode(code);
            conpany = meconpanyService.getById(medicine.getConpanyId());
        }
        return R.ok().data("medicine",medicine).data("conpany",conpany);
    }

    /**
     * 插入药品
     * @param meconpany
     * @return
     */
    @IOLogRecorder
    @Transactional
    @RequestMapping("/medic/insert")
    public R insert(@RequestBody Meconpany meconpany){
        String strUUID = UUID.randomUUID().toString();
        String code = strUUID.replace("-","");
        meconpany.setCode(code);
        meconpany.setCreateTime(new Date());
        boolean save = meconpanyService.save(meconpany);
        if(save){
            Meconpany conpany = meconpanyService.getMeconpanyByCode(code);
            Integer num = meconpany.getNum();
            List<Medicine> list = new ArrayList<Medicine>();
            //随机生成药品编号
            Boolean flag = false;
            for(int i=0;i<num;i++){
                Medicine medicine = new Medicine();
                medicine.setConpanyId(conpany.getId());
                String str = UUID.randomUUID().toString();
                String medicineCode = str.replace("-","");
                medicine.setMedicineCode(medicineCode);
                medicine.setCreateTime(new Date());
                flag = medicineService.save(medicine);
                list.add(medicine);
            }
//            boolean flag = medicineService.saveBatch(list);
            if(flag){
                for(Medicine me:list){
                    try {
                        //生成黑色二维码
                        Integer color=0xFF000000;
                        //将药品编号转换成二维码
                        QRCodeUtils.encode(me.getMedicineCode(),color);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                return R.ok();
            }
        }
        return R.error();
    }
}

