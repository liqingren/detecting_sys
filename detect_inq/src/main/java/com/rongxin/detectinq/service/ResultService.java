package com.rongxin.detectinq.service;

import com.github.pagehelper.PageInfo;
import com.rongxin.detectinq.entity.Result;
import com.baomidou.mybatisplus.extension.service.IService;
import com.rongxin.detectinq.entity.vo.UserResult;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
public interface ResultService extends IService<Result> {

    /**
     * 根据userId获取最近一次的核酸记录
     * @param id
     * @return
     */
    Result getResultByUserId(int id);

    /**
     * 分页
     * @param pageNum
     * @param pageSize
     * @param id
     * @return
     */
    PageInfo<Result> getResultByPage(Integer pageNum,Integer pageSize,Integer id,String keyword);

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
    PageInfo<UserResult> selectAllResult(Integer pageNum, Integer pageSize);

    /**
     * 条件查询
     * @param conditions
     * @return
     */
    PageInfo<UserResult> selectResultByCondition(Map conditions, Integer pageNum, Integer pageSize);

    /**
     * 查询未做核酸的用户
     * @param overDue
     * @return
     */
    PageInfo<UserResult> selectOverDueUser(Map overDue,Integer pageNum,Integer pageSize);

    /**
     * 更新isDelete状态
     * @param delMsg
     * @return
     */
    Integer updateIsDelete(Map delMsg);




}
