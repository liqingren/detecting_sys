package com.rongxin.detecthos.filter;

import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//@Component
public class CORSFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpServletRequest req = (HttpServletRequest) request;
        //*表示允许所有域名跨域
        httpResponse.addHeader("Access-Control-Allow-Origin", req.getHeader("origin"));
        httpResponse.addHeader("Access-Control-Allow-Headers",
                "Origin, X-Requested-With, Content-Type, Accept");
        //允许跨域的Http方法
        httpResponse.addHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE");
        httpResponse.addHeader("Access-Control-Max-Age", "0");
        httpResponse.addHeader("Access-Control-Allow-Credentials","true");
        httpResponse.addHeader("XDomainRequestAllowed","1");
        chain.doFilter(request, response);
    }

    public void destroy() {

    }
}
