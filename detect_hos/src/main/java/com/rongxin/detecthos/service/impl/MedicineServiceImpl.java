package com.rongxin.detecthos.service.impl;

import com.rongxin.detecthos.pojo.Medicine;
import com.rongxin.detecthos.mapper.MedicineMapper;
import com.rongxin.detecthos.service.MedicineService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author rlq
 * @since 2022-10-10
 */
@Service
public class MedicineServiceImpl extends ServiceImpl<MedicineMapper, Medicine> implements MedicineService {
    @Override
    public Medicine getByMedicineCode(String medicineCode) {
        if(medicineCode==null||medicineCode.equals("")){
            return null;
        }
        return baseMapper.getByMedicineCode(medicineCode);
    }
}
