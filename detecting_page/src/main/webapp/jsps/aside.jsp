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
    </style>
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript">
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
        <div class="list">
            <label>扫描核酸</label>
        </div>
        <div class="list">
            <label>录入结果</label>
        </div>
        <div class="list">
            <label id="perClick">权限管理</label>
            <div hidden="hidden" id="showList">
                <li>用户管理</li>
                <li>角色管理</li>
                <li>权限分配</li>
            </div>
        </div>
        <div class="list">
            <label>核酸记录</label>
        </div>
    </div>
</body>
</html>
