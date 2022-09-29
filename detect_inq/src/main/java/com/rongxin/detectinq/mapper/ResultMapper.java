package com.rongxin.detectinq.mapper;

import com.rongxin.detectinq.entity.Result;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@Mapper
public interface ResultMapper extends BaseMapper<Result> {
    /**
     * 根据card获取核酸结果
     * @param card
     * @return
     */
    List<Result> getResultByCard(String card);
}
