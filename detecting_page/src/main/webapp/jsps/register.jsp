<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/28
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
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
           width:400px;
            height:480px;
            border-color:#ececec;
            border-style: solid;
            margin:0 auto;
            position:relative;
            top:10px;
            background-color: white;
        }
        td{
            line-height: 30px;
            font-size: 20px;
        }
        button{
            width:76%;
            color:white;
            background-color: skyblue;
            font-size: 20px;
            border:none;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //保存数据
            $("#bt").bind("click",function() {
                var card = $("[name='card']").val();
                var password = $("[name='password']").val();
                var name = $("[name='name']").val();
                var sex = $("[name='sex']").prop("checked");
                var email = $("[name='email']").val();
                var address = $("[name='address']").val();
                var user = {
                    "card": card,
                    "password": password,
                    "name": name,
                    "sex": sex,
                    "email": email,
                    "address": address
                };
                if (card == null||card == "") {
                    alert("身份证号不能为空");
                } else if (card.length != 18) {
                    alert("身份证号不足18位");
                }else if(password ==""||password == null){
                    alert("密码不能为空");
                }else if(name==""||name==null){
                    alert("姓名不能为空");
                }else{
                    $.ajax({
                        url:"http://localhost:8001/detectinq/users/register",
                        type:"post",
                        data:JSON.stringify(user),
                        success:function(data){
                            if(data.success){
                                window.location.href="/jsps/login.jsp";
                            }else{
                                alert("注册失败（该身份证号已被注册）");
                            }
                        },
                        contentType:"application/json"

                    });
                }
            });
        });
    </script>
</head>
<body bgcolor="#f5f5f5">
    <div class="register">
        <h2>核酸检测系统</h2>
            <table>
                <tr>
                    <td>
                        <p style="margin-left:20px;font-size: 28px;font-weight: bold;color:skyblue">注册</p>
                    </td>
                </tr>
                <tr>
                    <td align="right">用户名：</td>
                    <td>
                        <input type="text" name="card" placeholder="用户名为身份证号">
                        <br/>
                        <span id="msg1" style="color:red;font-size: 16px;"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">密码：</td>
                    <td>
                        <input type="password" name="password">
                        <br/>
                        <span id="msg2" style="color:red;font-size: 16px;"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">真实姓名：</td>
                    <td>
                        <input type="text" name="name">
                        <br/>
                        <span id="msg3" style="color:red;font-size: 16px;"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">性别：</td>
                    <td>
                        <input type="radio" name="sex" value="男" checked="checked">男
                        <input type="radio" name="sex" value="女">女
                    </td>
                </tr>
                <tr>
                    <td align="right">邮箱号：</td>
                    <td>
                        <input type="email" name="email">
                    </td>
                </tr>
                <tr>
                    <td align="right">现居地址：</td>
                    <td>
                        <input type="text" name="address" placeholder="常住地址">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" >
                        <button id="bt">注 册</button>
                    </td>
                </tr>
            </table>


    </div>

</body>
</html>
