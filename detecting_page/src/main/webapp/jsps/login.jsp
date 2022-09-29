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
        h2{
            font-size: 100px;
            font-family: 华文彩云;
            color: skyblue;
            position: relative;
            top:50px;
            text-align: center;
        }
        table{
            width:380px;
            height:350px;
            border-color:#ececec;
            border-style: solid;
            margin:0 auto;
            position:relative;
            top:20px;
            background-color: white;
        }
        td{
            line-height: 30px;
            font-size: 22px;
            width:100px;
        }
        button{
            width:76%;
            color:white;
            background-color: skyblue;
            font-size: 20px;
            border:none;
            cursor: pointer;
        }
        a{
            cursor: pointer;
        }
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#bt").bind("click",function(){
                var card=$("[name='card']").val();
                var password=$("[name='password']").val();
                $.ajax({
                    url:"http://localhost:8001/detectinq/users/login",
                    type:"POST",
                    xhrFields: {
                        withCredentials: true
                    },
                    crossDomain: true,
                    data:{
                        "card":card,
                        "password":password
                    },
                    success:function(data){
                        if(data.success){
                            sessionStorage.setItem("user",JSON.stringify(data.data.user));
                            window.location.href="/jsps/user.jsp";
                        }else{
                            alert("用户名或密码错误");
                        }
                    }
                })
            })
        })
    </script>
</head>
<body bgcolor="#f5f5f5">
    <div class="login">
        <h2>核酸检测系统</h2>
        <table>
            <tr>
                <td>
                    <p style="margin-left:20px;font-size: 28px;font-weight: bold;color:skyblue">登录</p>
                </td>
                <td  align="right">
                    <a href="/jsps/register.jsp" style="font-size: 20px;font-weight: bold;color:cornflowerblue">没有账户？请先注册</a>
                </td>
            </tr>

            <tr>
                <td align="right">用户名：</td>
                <td>
                    <input type="text" name="card" placeholder="用户名为身份证号">
                </td>
            </tr>
            <tr>
                <td align="right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
                <td>
                    <input type="password" name="password">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button id="bt">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
