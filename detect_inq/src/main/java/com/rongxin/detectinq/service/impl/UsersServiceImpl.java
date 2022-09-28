package com.rongxin.detectinq.service.impl;

import com.rongxin.detectinq.entity.Users;
import com.rongxin.detectinq.mapper.UsersMapper;
import com.rongxin.detectinq.service.UsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements UsersService {

}
