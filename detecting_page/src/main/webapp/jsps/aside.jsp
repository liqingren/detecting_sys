<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/28
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>侧边栏</title>
    <meta charset="utf-8">
    <style type="text/css">
        .header{
            width:100%;
            height:120px;
        }
        a{
            text-decoration:none;
            color: white;
        }
        h2{
            font-size: 100px;
            font-family: 华文彩云;
            color: skyblue;
            position: relative;
            top:10px;
            text-align: center;
        }
        .aside{

            width:160px;
            height:600px;
            background-color: lightblue;
        }
        .list{
            width:120px;
            line-height: 30px;
            font-size: 20px;
            text-align: left;
            padding-left:10px;
            color:white ;
            position: relative;
            top:70px;
            left:15px;
            margin-bottom: 2px;
            background-color: skyblue;
        }
        label{
            cursor: pointer;
        }
        .list-user{
            width:170px;
            line-height: 30px;
            font-size: 16px;
            text-align: left;
            padding-left:10px;
            color:white ;
            position: relative;
            top:50px;
            left:7px;
            margin-bottom: 2px;
            background-color: skyblue;
        }
    </style>
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript" src="../js/jquery.cookie-1.4.1.min.js"></script>
    <script type="text/javascript" src="../js/jump.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            init();
            //用户登录之后获取用户名和身份证号
            if(!$.cookie('token')){
                window.location.href="loginTest.jsp";
            }else {
                var roleCode=JSON.parse(sessionStorage.getItem("roleCode"));
                if(roleCode=="admin"){
                    $("#permission").removeAttr("hidden");
                }else if(roleCode=="resultor"){
                    $("#result").removeAttr("hidden");
                }else if(roleCode=="scaner"){
                    $("#sacn").removeAttr("hidden");
                }
            }
        })
        $(document).ready(function (){
            $("#perClick").bind("click",function (){
                var hidden=$("#showList").attr("hidden");
                if(hidden=='undefine'||hidden==null){
                    $("#showList").attr("hidden","hidden");
                }else {
                    $("#showList").removeAttr("hidden");
                }
            })
        })
    </script>
</head>
<body bgcolor="#f5f5f5">
    <div class="header">
        <h2>核酸检测系统</h2>
    </div>
    <div class="aside">
        <div class="list">
            <label>健康码</label>
        </div>
        <div class="list" id="scan" hidden="hidden">
            <label>扫描核酸</label>
        </div>
        <div class="list" id="result" hidden="hidden">
            <label>录入结果</label>
        </div>
        <div class="list" id="permission" hidden="hidden">
            <label id="perClick">权限管理</label>
            <div hidden="hidden" id="showList">
                <li><a href="usermanager.jsp">用户管理</a></li>
                <li><a href="rolemanager.jsp">角色管理</a></li>
                <li><a href="permission.jsp">权限分配</a></li>
            </div>
        </div>
        <div class="list">
            <label>核酸记录</label>
        </div>
        <div class="list" id="medicine" hidden="hidden">
            <label>生产药品</label>
        </div>
    </div>
</body>
</html>
