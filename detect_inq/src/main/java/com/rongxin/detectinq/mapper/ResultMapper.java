package com.rongxin.detectinq.mapper;

import com.rongxin.detectinq.entity.Result;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
     * 分页获取核酸结果
     * @param id
     * @return
     */
    List<Result> getResultByPage(@Param("id") Integer id, @Param("keyword") String keyword);

    /**
     * 根据userId获取最近一次的核酸记录
     * @param id
     * @return
     */
    Result getResultByUserId(int id);

}
