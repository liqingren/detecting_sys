package com.rongxin.detecthos.mapper;

import com.rongxin.detecthos.pojo.Result;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rongxin.detecthos.pojo.vo.UserResult;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
@Mapper
public interface ResultMapper extends BaseMapper<Result> {

    /**
     * 查询未出结果的核酸记录
     * @return
     */
    List<UserResult> getResultByPage();

    /**
     * 根据试剂编号查询核酸记录
     * @param medicineCode
     * @return
     */
    List<Result> getResultByCode(@Param("medicineCode") String medicineCode);



}
