<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/3
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>角色管理</title>
    <style type="text/css">
        #rolemanager{
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
        table td{
            height:50px;
        }
        .u5{
            width:400px;
            height:300px;
            border:1px solid black;
            display:none;
            position:absolute;
            top:100px;
            left:100px;
            z-index:999;
            border-radius: 5px;
            background-color: white;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript">
        function updateRolePage(){
            window.location.href = "/ssm/auRole/rolejsp";
        }

        $(document).ready(function(){
            //初始化实现页面跳转
            initJump();
            //显示后台管理下的列表
            $("ul:eq(0)").show();
            //将左侧列表中角色管理的字体颜色变黄
            $("ul li:eq(1)").css("color","yellow");
            //默认选中第一个单选框
            $("[type='radio']:first").prop("checked","true");
        });
        //显示和隐藏增删的信息框
        $(document).ready(function(){
            $("#add ").bind("click",function(){
                $("#role-add").show();
            });
            $("#close1").bind("click",function(){
                $("#role-add").hide();
            });
            $("#quit1").bind("click",function(){
                $("#role-add").hide();
            })
            $("#upd").bind("click",function(){
                $("input:checkbox[name='modify_del']").each(function () { //遍历checkbox的选择状态
                    if ($(this).prop("checked")) { //如果值为checked表明选中了
                        // alert("选中该行的角色名"+$(this).closest('tr').find('td').eq(2).text());
                        var id = $(this).closest('tr').find('td').eq(1).text()
                        var roleCode = $(this).closest('tr').find('td').eq(2).text();//获取当前行的roleCode
                        var roleName = $(this).closest('tr').find('td').eq(3).text();//获取当前行的roleName
                        //将获取到的信息设置到弹出框中
                        document.getElementById("modifyId").innerText=id;
                        document.getElementById("oldRoleCode").value=roleCode;
                        document.getElementById("oldRoleName").value=roleName;
                    }
                });
                $("#role-upd").show();
            });

            $("#close2").bind("click",function(){
                $("#role-upd").hide();
            });
            $("#quit2").bind("click",function(){
                $("#role-upd").hide();
            })
        });



        $(document).ready(function () {
            $("#addRole").bind("click",function (){
                var role=new Object();
                role.roleCode = $("#add_roleCode").val();  //获取添加角色文本框输入内容
                role.roleName = $("#add_roleName").val();
                if(role.roleCode == "" || role.roleCode == null){   //判断是否为空
                    $("#add_roleCode").focus();
                    alert("角色编码不能为空。");
                }else if(role.roleName == "" || role.roleName == null){
                    $("#add_roleName").focus();
                    alert("角色名称不能为空。");
                }else {
                    $.ajax({
                        url: "/ssm/auRole/addRole",
                        type: "POST",
                        data: {role: JSON.stringify(role)},  //转换成json
                        dataType: "text",
                        error: function () {
                            alert("角色添加失败！请重试。");
                        },
                        success: function (result) {
                            if (result != "" && "addSuccess" == result) {
                                alert("角色添加成功！");
                                updateRolePage();
                            } else if ("contentDuplicate" == result) {
                                alert("角色添加失败！角色编码和角色名称不能重复，请重试！");
                            }
                        },
                        complete : function(xhr, status) {
                            //拦截器拦截没有权限跳转
                            // 通过xhr取得响应头
                            var REDIRECT = xhr.getResponseHeader("REDIRECT");
                            //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                            if (REDIRECT == "REDIRECT")
                            {
                                document.location.href = xhr.getResponseHeader("CONTEXTPATH");
                            }
                        }
                    });
                }
            });
        });



        $(document).ready(function (){
            $("#modifyRole").bind("click",function () {
                var role=new Object();
                role.id = document.getElementById("modifyId").innerText;  //获取当前角色的id
                role.roleCode = $("#oldRoleCode").val();   //获取修改的信息
                role.roleName = $("#oldRoleName").val();
                if(role.roleCode == "" || role.roleCode == null){
                    alert("角色编码不能为空！");
                }else if(role.roleName == "" || role.roleName == null){
                    alert("角色名称不能为空！");
                }else {
                    $.ajax({
                        url: "/ssm/auRole/modifyRole",
                        type: "POST",
                        data: {role: JSON.stringify(role)},
                        dataType: "text",
                        error: function () {
                            alert("角色修改失败！请重试！");
                        },
                        success: function (result) {
                            if (result != "" && "modifySuccess" == result) {
                                alert("角色修改成功！");
                                updateRolePage();
                            } else if ("contentDuplicate" == result) {
                                alert("角色编码或者角色名称不能重复，请重试！");
                            }
                        },
                        complete : function(xhr, status) {
                            //拦截器拦截没有权限跳转
                            // 通过xhr取得响应头
                            var REDIRECT = xhr.getResponseHeader("REDIRECT");
                            //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                            if (REDIRECT == "REDIRECT")
                            {
                                document.location.href = xhr.getResponseHeader("CONTEXTPATH");
                            }
                        }
                    });
                }
            });
        });

        $(document).ready(function () {
            $("#det").bind("click", function () {
                $("input:checkbox[name='modify_del']").each(function () { //遍历checkbox的选择状态
                    if ($(this).prop("checked")) { //如果值为checked表明选中了
                        // alert("选中该行的角色名"+$(this).closest('tr').find('td').eq(2).text());
                        var id = $(this).closest('tr').find('td').eq(1).text();
                        var role=new Object();
                        role.id=id;
                        $.ajax({
                            url: "/ssm/auRole/deleteRole",
                            type: "POST",
                            data: {role: JSON.stringify(role)},
                            dataType: "text",
                            error: function () {
                                alert("角色删除失败！请重试！");
                            },
                            success: function (result) {
                                if (result != "" && "deleteSuccess" == result) {
                                    alert("角色删除成功！");
                                    updateRolePage();
                                }
                            },
                            complete : function(xhr, status) {
                                //拦截器拦截没有权限跳转
                                // 通过xhr取得响应头
                                var REDIRECT = xhr.getResponseHeader("REDIRECT");
                                //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                                if (REDIRECT == "REDIRECT")
                                {
                                    document.location.href = xhr.getResponseHeader("CONTEXTPATH");
                                }
                            }
                        });
                    }
                });
            });
        });

        //状态更新操做
        $(document).ready(function () {
            $(".isStart").bind("click", function () {
                var modifyIsStartRole=new Object();
                var id=$(this).attr("modifyIsStartRoleId");
                var isstart=$(this).attr("isStart");
                modifyIsStartRole.id=id;
                if(isstart == "1"){
                    modifyIsStartRole.isStart=0;
                }else {
                    modifyIsStartRole.isStart=1;
                };
                $.ajax({
                    url: "/ssm/auRole/modifyIsStartRole",
                    type: "POST",
                    data: {role: JSON.stringify(modifyIsStartRole)},
                    dataType: "text",
                    error: function () {
                        alert("角色状态修改失败！请重试！");
                    },
                    success: function (result) {
                        if (result != "" && "modifyIsStartSuccess" == result) {
                            alert("角色状态修改成功！");
                            updateRolePage();
                            if(isstart == "1"){
                                $(this).attr("isStart","0");
                            }else {
                                $(this).attr("isStart","1");
                            };
                        }
                    },
                    complete : function(xhr, status) {
                        //拦截器拦截没有权限跳转
                        // 通过xhr取得响应头
                        var REDIRECT = xhr.getResponseHeader("REDIRECT");
                        //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                        if (REDIRECT == "REDIRECT")
                        {
                            document.location.href = xhr.getResponseHeader("CONTEXTPATH");
                        }
                    }
                });
            });
        });



    </script>
</head>
<body style="background-image:url('../../image/bg.jpg');background-repeat: no-repeat">
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="bleft.jsp"></jsp:include>
<div id="rolemanager">
    <div class="u1">
        <p style="float:left;margin-left:20px;">会员管理</p>
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
                <th>角色id</th>
                <th>角色编号</th>
                <th>角色名称</th>
                <th>创建人</th>
                <th>状态(启用/禁用)</th>
                <th>最后修改时间</th>
            </tr>
            <c:forEach var="role" items="${roleList}">
                <tr>
                    <td>
                        <input type="checkbox" name="modify_del">
                    </td>
                    <td>${role.id}</td>
                    <td>${role.roleCode}</td>
                    <td>${role.roleName}</td>
                    <td>${role.createdBy}</td>
                    <td>
                        <input type="checkbox"  <c:if test="${role.isStart == 1}">checked="checked" </c:if> class="isStart" modifyIsStartRoleId="${role.id}" isStart="${role.isStart}"/>
                    </td>
                    <td>${role.createDate}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="u4">
        <p style="color:red;font-size: 14px">注：状态打钩表示启用并立即生效</p>
    </div>
    <div class="u5" id="role-add">
        <div style="height:30px;line-height:30px;background-color: beige;border-style: none none solid none;border-color: lightgrey">
            <img src="../../image/rolemanager/u126.png" style="margin:0 10px -3px 10px;width:18px;height:18px;">
            <span style="font-size: 14px">添加角色</span>
            <button id="quit1" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
        </div>
        <table style="width:350px ;margin-left:50px;">
            <tr>
                <td>角色编号:</td>
                <td>
                    <input type="text" id="add_roleCode">
                </td>
            </tr>
            <tr>
                <td>角色名称:</td>
                <td>
                    <input type="text" id="add_roleName">
                </td>
            </tr>
            <tr>
                <td>角色状态：</td>
                <td>
                    <input type="radio" name="isStart1" checked="checked">启用
                    <input type="radio" name="isStart1">禁用
                </td>
            </tr>
            <tr>
                <td colspan="2" style="color:red" id="tips">
                    注: 用户名需验证唯一性
                </td>
            </tr>
        </table>
        <div>&nbsp;
            <button id="close1" style="float:right;margin-right:50px;">关闭</button>
            <button style="margin-right:50px;float:right" id="addRole">保存</button>
        </div>
    </div>
    <div class="u5" id="role-upd">
        <div style="height:30px;line-height:30px;background-color: beige;border-style: none none solid none;border-color: lightgrey">
            <img src="../../image/rolemanager/u278.png" style="margin:0 10px -3px 10px;width:18px;height:18px;">
            <span style="font-size: 14px">修改角色</span>
            <button id="quit2" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
        </div>
        <table style="width:350px ;margin-left:50px;">
            <tr>
                <td>角色编号:</td>
                <td>
                    <input type="text" id="oldRoleCode">
                </td>
            </tr>
            <tr>
                <td>角色名称:</td>
                <td>
                    <input type="text" id="oldRoleName">
                </td>
            </tr>
            <tr>
                <td>角色状态：</td>
                <td>
                    <input type="radio" name="isStart2" checked="checked">启用
                    <input type="radio" name="isStart2">禁用
                </td>
            </tr>
            <tr>
                <td colspan="2" style="color:red">
                    注: 用户名需验证唯一性 当前角色id:<span id="modifyId"></span>
                </td>
            </tr>
        </table>
        <div>&nbsp;
            <button id="close2" style="float:right;margin-right:50px;">关闭</button>
            <button style="margin-right:50px;float:right" id="modifyRole">保存</button>
        </div>
    </div>
</div>
</body>
</html>
