package com.rongxin.detectinq.service.impl;

import com.rongxin.detectinq.entity.Medicine;
import com.rongxin.detectinq.mapper.MedicineMapper;
import com.rongxin.detectinq.service.MedicineService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ren
 * @since 2022-09-29
 */
@Service
public class MedicineServiceImpl extends ServiceImpl<MedicineMapper, Medicine> implements MedicineService {
    @Autowired
    MedicineMapper medicineMapper;
    public Medicine getByMedicineCode(String medicineCode) {
        return medicineMapper.getByMedicineCode(medicineCode);
    }
}
