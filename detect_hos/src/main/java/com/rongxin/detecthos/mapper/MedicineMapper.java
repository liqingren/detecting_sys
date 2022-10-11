package com.rongxin.detecthos.mapper;

import com.rongxin.detecthos.pojo.Medicine;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author rlq
 * @since 2022-10-10
 */
public interface MedicineMapper extends BaseMapper<Medicine> {
    /**
     * 根据药品编号获取药品信息
     * @param medicineCode
     * @return
     */
    Medicine getByMedicineCode(String medicineCode);
}
