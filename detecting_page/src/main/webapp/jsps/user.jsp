<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/28
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>用户界面</title>
    <meta charset="utf-8">
    <style type="text/css">
        .user{
            width:70%;
            height:500px;
            background-color: white;
            position: absolute;
            top:130px;
            left:200px;
        }
        img{
            width:350px;
            height:350px;
            position: relative;
            top:50px;
            left:350px;
        }
        button{
            width:320px;
            height:50px;
            font-size: 30px;
            position: relative;
            top:60px;
            left:365px;
            border:none;
            background-color: forestgreen;
            color:white;
            cursor: pointer;
        }
        .result{
            width:500px;
            height:410px;
            background-color: #f5f5f5;
            border:1px solid #ececec;
            position: absolute;
            top:50px;
            left:260px;
            display: none;
        }
        table{
            margin:0 auto;
            position: relative;
            top:15px;
        }
        tr{
            line-height:70px;
            font-size: 28px;
        }
        input{
            height:40px;
            width:220px;
            font-size: 26px;
            border:none;
            background-color:#f5f5f5 ;
        }
        #re{
            width:100px;
            height:100px;
            border: none;
            text-align: center;
            border-radius: 50%;
            background-color: darkseagreen;
            color:darkgreen;
        }
        .msg{
            width:500px;
            height:80px;
            padding-left:20px;
        }
        #quit{
            float: right;
            width:20px;
            height:20px;
            line-height: 20px;
            position: relative;
            top:-15px;
            left:-25px;
            font-size: 20px;
            background-color: skyblue;
        }
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var user=JSON.parse(sessionStorage.getItem("user"));
            //显示本人健康码
            var str="../image/"+user.codePath;
            $(".imgcode").attr("src",str);
            //点击核酸结果按钮跳转页面
            $("#result ").bind("click",function(){
                window.location.href="/jsps/userresult.jsp";
            });
        })
    </script>
</head>
<body bgcolor="#f5f5f5">
    <jsp:include page="aside.jsp"></jsp:include>
    <div class="user">
        <div class="code">
            <img class="imgcode">
        </div>
        <button id="result">核酸结果</button>
        <h3>${card}</h3>
        <div class="result">
            <div class="msg">
                <button id="quit">×</button>
                <p style="font-size: 20px;">查询人员：</p>
                <span style="font-size: 20px;margin-right:20px;">张三</span>
                <span style="font-size: 20px;">511602200039348976</span>
            </div>
            <hr color="#ececec">
            <table>
                <tr>
                    <td colspan="2" align="center">
                        <input id="re" type="text" name="resultstate" value="阴性">
                    </td>
                </tr>
                <tr>
                    <td>采样时间：</td>
                    <td>
                        <input type="text" name="createTime" value="2022-09-29 09时">
                    </td>
                </tr>
                <tr>
                    <td>检测时间：</td>
                    <td>
                        <input type="text" name="resultTime">
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
