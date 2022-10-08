package com.rongxin.detectinq.exception;

import com.alibaba.nacos.common.utils.ExceptionUtil;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 全局异常控制类
 */
@ControllerAdvice
public class GlobalExceptionHandler {
    private static final int CUSTOM_ERROR_HTTP_STATUS = 403;            // 自定义异常发生时HTTP状态码
    private static final int SERVER_INTERNAL_ERROR_HTTP_STATUS = 500;   // 服务器内部异常

    /**
     * 自定义异常
     * @param be
     * @param response
     * @return
     */
    @ExceptionHandler(BaseException.class)
    @ResponseBody
    public Map baseExceptionHandler(BaseException be, HttpServletResponse response) {
        response.setStatus(CUSTOM_ERROR_HTTP_STATUS);
        Map<String, Object> data = new HashMap();
        data.put("code",be.getCode());
        data.put("message", be.getMessage());
        data.put("exception", ExceptionUtil.getStackTrace(be));
        return data;
    }


    /**
     * 非自定义异常
     *
     * @param e
     * @param response
     * @return
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Map exceptionHandler(Exception e, HttpServletResponse response) {
        response.setStatus(SERVER_INTERNAL_ERROR_HTTP_STATUS);
        Map<String, Object> data = new HashMap();
        data.put("code", SERVER_INTERNAL_ERROR_HTTP_STATUS);
        data.put("message", "服务器异常,请稍后再试");
        data.put("exception", ExceptionUtil.getStackTrace(e));
        return data;
    }

}