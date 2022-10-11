package com.rongxin.detecthos.service;

import com.rongxin.detecthos.pojo.Medicine;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author rlq
 * @since 2022-10-10
 */
public interface MedicineService extends IService<Medicine> {
    /**
     * 根据药品编号获取药品信息
     * @param medicineCode
     * @return
     */
    Medicine getByMedicineCode(String medicineCode);
}
