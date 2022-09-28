<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/2
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <meta charset="utf-8">
    <style type="text/css">
        .u1{
            position: absolute;
            top:294px;
            left:310px;
        }
    </style>
    <script type="text/javascript" src="js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        // $(document).ready(function(){
        //     $("button:first").bind("click",function(){
        //         alert(1);
        //     })
        // })
    </script>
</head>
<body style="background-image: url('../../image/login/bg.jpg');background-repeat: no-repeat">
    <div class="u1">
        <form action="/ssm/auUser/login" method="post">
            <input type="text" name="loginCode" style="height:28px;width:140px">
            <input type="password" name="password" style="margin-left:94px;height:28px;width:140px">
            <button style="width:100px;margin:0 20px 0 20px">
                <img src="../../image/login/u4.png">
                登录
            </button>
            <input type="button" value="取消" style="width:100px"></input>
        </form>
    </div>
</body>
</html>
