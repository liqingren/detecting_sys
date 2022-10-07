package com.rongxin.detectinq.exception;

import lombok.Data;

@Data
public class BaseException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    private int code = 0;

    public BaseException(int code, String message) {
        super(message);
        this.code = code;
    }
}
