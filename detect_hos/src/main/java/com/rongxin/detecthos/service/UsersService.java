package com.rongxin.detecthos.service;

import com.rongxin.common.R;
import com.rongxin.detecthos.pojo.Users;
import com.baomidou.mybatisplus.extension.service.IService;
import com.rongxin.detecthos.pojo.vo.UserResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
public interface UsersService extends IService<Users> {

}
