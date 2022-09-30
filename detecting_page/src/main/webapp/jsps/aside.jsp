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

            width:200px;
            height:600px;
            background-color: lightblue;
        }
        .list{
            width:170px;
            line-height: 30px;
            font-size: 20px;
            text-align: left;
            padding-left:10px;
            color:white ;
            position: relative;
            top:50px;
            left:7px;
            margin-bottom: 2px;
            background-color: skyblue;
            text-align: center;
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
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/jump.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            init();
        })
    </script>
</head>
<body bgcolor="#f5f5f5">
    <div class="header">
        <h2>核酸检测系统</h2>
    </div>
    <div class="aside">
        <div class="list-user">
            <span>用户名：</span>
            <span id="username"></span>
            <br/>
            <span>身份证号：</span>
            <span id="card"></span>
        </div>
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
            <label>权限管理</label>
        </div>
        <div class="list">
            <label>核酸记录</label>
        </div>
    </div>
</body>
</html>
