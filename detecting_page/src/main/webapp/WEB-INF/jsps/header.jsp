<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/3
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        span{
            font-size: 13px;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //实现页面跳转
            initJump();
        })
    </script>
</head>
<body>
    <div id="header">
        <span style="margin-left:300px;color:black;">你好,</span>
        <span style="color:black;">
            <c:out value="${auUser.loginCode}"></c:out>
        </span>
        <span style="margin-left:15px;color:black;">角色：</span>
        <span style="color:black;">
            <c:out value="${auUser.roleName}"></c:out>
        </span>
        <span class="header" style="margin-left:30px;cursor: pointer;color:black;">【首页】</span>
        <span style="cursor: pointer;color:black;">【修改密码】</span>
        <span class="logout" style="cursor: pointer;color:black;">【注销】</span>

    </div>


</body>
</html>
