package com.rongxin.detectinq.service;

import com.rongxin.detectinq.entity.Medicine;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ren
 * @since 2022-09-29
 */
public interface MedicineService extends IService<Medicine> {
    /**
     * 根据药品编号获取药品信息
     * @param medicineCode
     * @return
     */
    Medicine getByMedicineCode(String medicineCode);
}
