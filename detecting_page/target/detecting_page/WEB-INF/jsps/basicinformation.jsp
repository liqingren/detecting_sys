<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/5
  Time: 8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>基础信息</title>
    <meta chaset="UTF-8">
    <style type="text/css">
        #basicinformation{
            margin-left:245px;
            width:640px;
            height:450px;
            position: absolute;
            top:148px;
        }
        .u1{
            width:640px;
            height:50px;
            font-size: 14px;
        }
        .u2{
            width:640px;
            height:50px;
            font-size: 14px;
        }
        button{
            width:60px;
            background-color: beige;
            border:1px solid green;
            border-radius: 5px;
            margin-right:10px;
            cursor: pointer;
        }
        button:hover{
            background-color: #309000;
        }
        .u3>table tr{
            height:30px;
        }
        .u4{
            width:440px;
            height:350px;
            border: 1px solid black;
            display:none;
            position: absolute;
            top:80px;
            left:20px;
            background-color: white;

        }
        .u4>table td{
            line-height:35px;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //初始化实现页面跳转
            initJump();
            //显示后台管理下的列表
            $("ul:eq(0)").show();
            //将权限管理字体颜色变黄
            $("ul li:eq(5)").css("color","yellow");
            //默认选中第一个单选框
            $("[type='radio']:first").prop("checked","true");
            //显示新增框
            $("#add ").bind("click",function(){
                $("#basic_add").show();
            });
            //点击关闭或叉掉则隐藏
            $("#close1").bind("click",function(){
                $("#basic_add").hide();
            });
            $("#quit1").bind("click",function(){
                $("#basic_add").hide();
            });
            //点击修改按钮，显示出需要修改商品的信息
            $("#upd").bind("click",function(){
                //显示修改框
                $("#basic_upd").show();
            });
            //点击关闭和叉掉是隐藏修改框
            $("#close2").bind("click",function(){
                $("#basic_upd").hide();
            });
            $("#quit2").bind("click",function(){
                $("#basic_upd").hide();
            })
        });
    </script>
</head>
<body style="background-image:url('../../image/bg.jpg');background-repeat: no-repeat">
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="bleft.jsp"></jsp:include>
    <div id="basicinformation">
        <div class="u1">
            <p style="float:left;margin-left:20px;">基础信息</p>
        </div>
        <div class="u2">
            <button id="add">新增</button>
            <button id="upd">修改</button>
            <button id="det">删除</button>
        </div>
        <div class="u3">
            <table border="1" cellpadding="0" cellspacing="0" style="width:630px;text-align:center;font-size:14px;">
                <tr>
                    <th>选择</th>
                    <th>参数关键字</th>
                    <th>参数编码</th>
                    <th>参数值</th>
                </tr>
                <c:forEach var="basic" items="${basicList}">
                    <tr>
                        <td>
                            <input type="radio" name="choose">
                        </td>
                        <td>${basic.NAME}</td>
                        <td>${basic.CODE}</td>
                        <td>${basic.VALUE}</td>

                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="u4" id="basic_add">
            <div style="height:30px;line-height:30px;background-color: beige;border-style: none none solid none;border-color: lightgrey">
                <img src="../../image/rolemanager/u126.png" style="margin:0 10px -3px 10px;width:18px;height:18px;">
                <span style="font-size: 14px">添加参数</span>
                <button id="quit1" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
            </div>
            <table style="margin:20px 0 0 30px">
                <tr>
                    <td align="right">参数关键字:</td>
                    <td>
                        <input type="text" name="NAME">
                    </td>
                </tr>
                <tr>
                    <td align="right">参数编码:</td>
                    <td>
                        <input type="text" name="CODE">
                        <span name="msg" style="color:red;display:none;"></span>
                        <span style="color:red">* 注：验证编码唯一性</span>
                    </td>
                </tr>
                <tr>
                    <td align="right">参数值:</td>
                    <td>
                        <input type="text" name="VALUE">
                    </td>
                </tr>
                <tr>
                    <td align="right">参数描述:</td>
                    <td>
                        <textarea cols="20" rows="5" name="DESCRIPTION"></textarea>
                    </td>
                </tr>

            </table>
            <div class="u5">&nbsp;
                <button id="close1" style="float:right;margin:30px 50px 0 0;">关闭</button>
                <button style="margin:30px 50px 0 0;float:right" id="save1">保存</button>
            </div>

        </div>
        <div class="u4" id="basic_upd">
            <div style="height:30px;line-height:30px;background-color: beige;border-style: none none solid none;border-color: lightgrey">
                <img src="../../image/rolemanager/u278.png" style="margin:0 10px -3px 10px;width:18px;height:18px;">
                <span style="font-size: 14px">修改参数</span>
                <button id="quit2" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
            </div>
            <table style="margin:20px 0 0 30px">
                <tr>
                    <td align="right">参数关键字:</td>
                    <td>
                        <input type="text" name="NAME">
                    </td>
                </tr>
                <tr>
                    <td align="right">参数编码:</td>
                    <td>
                        <input type="text" name="CODE">
                        <span name="msg" style="color:red;display:none;"></span>
                        <span style="color:red">* 注：验证编码唯一性</span>
                    </td>
                </tr>
                <tr>
                    <td align="right">参数值:</td>
                    <td>
                        <input type="text" name="VALUE">
                    </td>
                </tr>
                <tr>
                    <td align="right">参数描述:</td>
                    <td>
                        <textarea cols="20" rows="5" name="DESCRIPTION"></textarea>
                    </td>
                </tr>

            </table>
            <div class="u5">&nbsp;
                <button id="close2" style="float:right;margin:30px 50px 0 0;">关闭</button>
                <button style="margin:30px 50px 0 0;float:right" id="save2">保存</button>
            </div>

        </div>
    </div>
</body>
</html>
