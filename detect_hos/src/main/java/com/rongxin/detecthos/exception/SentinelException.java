package com.rongxin.detecthos.exception;

import com.rongxin.common.R;
import com.rongxin.detecthos.service.UsersService;
import org.springframework.stereotype.Component;

@Component
public class SentinelException implements UsersService {
    @Override
    public R getUserByCard(String code) {
        throw new BaseException(403,"服务熔断");
    }
}
