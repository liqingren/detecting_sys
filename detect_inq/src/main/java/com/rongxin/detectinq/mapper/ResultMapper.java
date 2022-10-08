package com.rongxin.detectinq.mapper;

import com.rongxin.detectinq.entity.Result;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rongxin.detectinq.entity.vo.UserResult;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

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

    /**
     * 查询用户核酸次数
     * @param userId
     * @return
     */
    int getCountByUserId(Integer userId);

    /**
     * 管理员查询所有记录
     * @return
     */
    List<UserResult> selectAllResult();

    /**
     * 条件查询
     * @param
     * @return
     */
    List<UserResult> selectResultByCondition(Map map);

    /**
     * 查询未做核酸的用户
     * @param overDue
     * @return
     */
    List<UserResult> selectOverDueUser(Map overDue);

    /**
     * 更新isDelete状态
     * @param delMsg
     * @return
     */
    Integer updateIsDelete(Map delMsg);

}
