package com.rongxin.detecthos.mapper;

import com.rongxin.detecthos.pojo.Result;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rongxin.detecthos.pojo.vo.UserResult;
import org.apache.ibatis.annotations.Mapper;

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
     * 两表联查
     * @return
     */
//    List<UserResult> getUserResult();

    List<UserResult> getUserResult(String keyword);
}
