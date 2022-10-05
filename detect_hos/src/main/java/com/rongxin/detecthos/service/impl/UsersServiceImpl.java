package com.rongxin.detecthos.service.impl;

import com.rongxin.common.R;
import com.rongxin.detecthos.pojo.Users;
import com.rongxin.detecthos.mapper.UsersMapper;
import com.rongxin.detecthos.pojo.vo.UserResult;
import com.rongxin.detecthos.service.UsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements UsersService {


}
