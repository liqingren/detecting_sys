package com.rongxin.detecthos.service;

import com.rongxin.common.R;
import com.rongxin.detecthos.exception.SentinelException;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * <p>
 *  服务类
 * </p>
 *
 * @author rlq
 * @since 2022-10-04
 */
@FeignClient(value="service-inq",path="/detectinq/users",fallback = SentinelException.class)
public interface UsersService {
    @RequestMapping("/getuser")
    R getUserByCard(@RequestParam("code") String code);
}
