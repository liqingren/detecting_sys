package com.rongxin.detectinq.mapper;

import com.rongxin.detectinq.entity.Medicine;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;


/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ren
 * @since 2022-09-29
 */
@Mapper
public interface MedicineMapper extends BaseMapper<Medicine> {
    /**
     * 根据药品编号获取药品信息
     * @param medicineCode
     * @return
     */
    Medicine getByMedicineCode(String medicineCode);
}
