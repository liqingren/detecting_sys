package com.rongxin.detectacl.service;

import com.rongxin.detectacl.entity.Permission;
import com.rongxin.detectacl.entity.Users;
import com.baomidou.mybatisplus.extension.service.IService;
import com.rongxin.detectacl.entity.vo.LoginVo;
import com.rongxin.detectacl.entity.vo.RegisterVo;
import com.rongxin.detectacl.entity.vo.UserVo;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yuezhik
 * @since 2022-09-30
 */
public interface UsersService extends IService<Users> {

    List<UserVo> getByCondition(Integer pageNum, String condition);

    Integer selectCount(String condition);

    String login(LoginVo loginVo);

    List<String> getAllPermission(LoginVo loginVo);

    String getRoleCodeByCard(String card);
}
