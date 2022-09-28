<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/3
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>用户管理</title>
    <style type="text/css">
        #usermanager{
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
        .u5>table td{
            width:100px;
        }
        .u5{
            wdith:500px;
            height:580px;
            border:1px solid black;
            display:none;
            position:absolute;
            top:0px;
            left:20px;
            z-index:999;
            border-radius: 5px;
            background-color: white;
        }
        a{
            color: black;
            text-decoration:none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript">
        var loginCode="admin";
        $(document).ready(function(){
            //初始化实现页面跳转
           // initJump();
            //显示后台管理下的列表
            $("ul:eq(0)").show();
            //将左侧列表中用户管理的字体颜色变黄
            $("ul li:eq(0)").css("color","yellow");
            //默认选中第一个单选框
            $("[type='radio']:first").prop("checked","true");
        });
        //隐藏和显示增删的信息表
        $(document).ready(function(){
            $("#add ").bind("click",function(){
                $("#user-add").show();
            });
            $("#close1").bind("click",function(){
                $("#user-add").hide();
            });
            $("#quit1").bind("click",function(){
                $("#user-add").hide();
            })
            $("#upd").bind("click",function(){
                if(loginCode != null && loginCode != "" && loginCode != undefined) {
                    var text="loginCode="+loginCode;
                    $.ajax({
                        url:"getAuUserByLoginCode",
                        type:"get",
                        data:text,
                        success:function (data){
                            $("[name='id2']").val(data.id);
                            $("[name='oLoginCode2']").val(data.loginCode);
                            $("[name='userName2']").val(data.userName);
                            $("[name='idCard2']").val(data.idCard);
                            $("[name='mobile2']").val(data.mobile);
                            $("[name='email2']").val(data.email);
                            $("[name='postCode2']").val(data.postCode);
                            $("[name='bankName2']").val(data.bankName);
                            $("[name='bankAccount2']").val(data.bankAccount);
                            $("[name='loginCode2']").val(data.accountHolder);
                            $("[name='userAddress2']").val(data.userAddress);
                            if(data.roleName==null){
                                $("#roleType2").text("请选择");
                            }else{
                                $("#roleType2").text(data.roleName);
                            }
                            if(data.userTypeName==null){
                                $("#userType2").text("请选择");
                            }else{
                                $("#userType2").text(data.userTypeName);
                            }
                            if(data.cardTypeName==null){
                                $("#cardType2").text("请选择");
                            }else{
                                $("#cardType2").text(data.cardTypeName);
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
                    })
                }
                $("#user-upd").show();

            });
            $("#close2").bind("click",function(){
                $("#user-upd").hide();
            });
            $("#quit2").bind("click",function(){
                $("#user-upd").hide();
            })
        });
        $(document).ready(function (){
            $("#save2").bind("click",function (){
                var id=$("[name='id2']").val();
                var roleId=$("[name='roleName2']").val();
                var roleName=$("[name='roleName2']").find("option:selected").text();
                if(isNaN(roleId)){
                    roleId=null;
                    roleName=null;
                }
                var loginCode=$("[name='oLoginCode2']").val();
                var userType=$("[name='userTypeName2']").val();
                var userTypeName=$("[name='userTypeName2']").find("option:selected").text();
                if(isNaN(userType)){
                    userType=null;
                    userTypeName=null;
                }
                var userName=$("[name='userName2']").val();
                var cardType=$("[name='cardTypeName2']").val();
                var cardTypeName=$("[name='cardTypeName2']").find("option:selected").text();
                if(isNaN(cardType)){
                    cardType=null;
                    cardTypeName=null;
                }
                var idCard=$("[name='idCard2']").val();
                var mobile=$("[name='mobile2']").val();
                var email=$("[name='email2']").val();
                var postCode=$("[name='postCode2']").val();
                var bankName=$("[name='bankName2']").val();
                var bankAccount=$("[name='bankAccount2']").val();
                var accountHolder=$("[name='accountHolder2']").val();
                var userAddress=$("[name='userAddress2']").val();
                var userInfo={"id":id,"email":email,"roleName":roleName,"loginCode":loginCode, "userTypeName":userTypeName,
                    "userName":userName,"cardTypeName":cardTypeName,"idCard":idCard, "mobile":mobile,"postCode":postCode,"bankName":bankName,
                    "bankAccount":bankAccount,"accountHolder":accountHolder,"userAddress":userAddress,"cardType":cardType,"userType":userType,
                    "roleId":roleId};
                $.ajax({
                    url:"updateAuUser",
                    type:"post",
                    data:JSON.stringify(userInfo),
                    success:function (){
                        window.location.href="getUserByCondition";
                    },
                    contentType:"application/json",
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
                })
            })
        });
        $(document).ready(function (){
            $("#save1").bind("click",function (){
                var id=null;
                var roleId=$("[name='roleName1']").val();
                var roleName=$("[name='roleName1']").find("option:selected").text();
                if(isNaN(roleId)){
                    roleId=null;
                    roleName=null;
                }
                var loginCode=$("[name='loginCode1']").val();
                var userType=$("[name='userTypeName1']").val();
                var userTypeName=$("[name='userTypeName1']").find("option:selected").text();
                if(isNaN(userType)){
                    userType=null;
                    userTypeName=null;
                }
                var userName=$("[name='userName1']").val();
                var cardType=$("[name='cardTypeName1']").val();
                var cardTypeName=$("[name='cardTypeName1']").find("option:selected").text();
                if(isNaN(cardType)){
                    cardType=null;
                    cardTypeName=null;
                }
                var idCard=$("[name='idCard1']").val();
                var mobile=$("[name='mobile1']").val();
                var email=$("[name='email1']").val();
                var postCode=$("[name='postCode1']").val();
                var bankName=$("[name='bankName1']").val();
                var bankAccount=$("[name='bankAccount1']").val();
                var accountHolder=$("[name='accountHolder1']").val();
                var userAddress=$("[name='userAddress1']").val();
                var userInfo={"id":id,"email":email,"roleName":roleName,"loginCode":loginCode, "userTypeName":userTypeName,
                    "userName":userName,"cardTypeName":cardTypeName,"idCard":idCard, "mobile":mobile,"postCode":postCode,"bankName":bankName,
                    "bankAccount":bankAccount,"accountHolder":accountHolder,"userAddress":userAddress,"cardType":cardType,"userType":userType,
                    "roleId":roleId};
                $.ajax({
                    url:"insertAuUser",
                    type:"post",
                    data:JSON.stringify(userInfo),
                    success:function (data){
                        if(data.flag){
                            alert("添加成功！！");
                        }else {
                            alert("添加失败！！")
                        }
                        window.location.href="getUserByCondition";
                    },
                    contentType:"application/json",
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
                })
            })
        });
        // $(document).ready(function(){
        //     $("#sel").bind("click",function (){
        //         var condition=$("#condition").val();
        //         var text="condition="+condition;
        //         $.ajax({
        //             url:"getUserByCondition",
        //             type:"get",
        //             data:text,
        //         })
        //     })
        // })
        $(document).ready(function(){
            $("#condition").bind("mouseout",function (){
                var condition=$("#condition").val();
                var myHref="getUserByCondition";
                if(condition != null && condition != "" && condition != undefined) {
                    var text = "?condition=" + condition;
                    myHref = myHref + text;
                }
                $("#sel").attr("href",myHref);
            });
        });
        $(document).ready(function(){
            $("input[name=choose]").bind("click",function (){
                var index=$(this).val();
                var loginCodeNode=$("[name=loginCode]");
                loginCode=loginCodeNode[index].innerText;
            })
        });
        $(document).ready(function(){
            $("[name=forbid]").bind("click",function (){
                var isStart=1;
                var index=$(this).attr("class");
                var flag=$(this).prop("checked");
                if(!flag){
                    isStart=0;
                }
                var userInfo={"id":index,"isStart":isStart};
                $.ajax({
                    url:"updateAuUser",
                    type:"post",
                    data:JSON.stringify(userInfo),
                    contentType:"application/json",
                    success:function (data){
                        if(data.flag){
                            alert("修改成功！！")
                        }else{
                            alert("修改失败！！")
                        }
                        window.location.href="getUserByCondition";
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
                })
            })
        });
        $(document).ready(function (){
            $("#det").bind("click",function (){
                if(loginCode != null && loginCode != "" && loginCode != undefined) {
                    $.ajax({
                        url:"delete",
                        type:"get",
                        data:{
                            "loginCode":loginCode
                        },
                        success:function (data){
                            if(data.flag){
                                alert("删除成功！！")
                            }else{
                                alert("删除失败！！")
                            }
                            window.location.href="getUserByCondition";
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
                    })
                }
            })
        });
    </script>
</head>
<body style="background-image:url('../../image/bg.jpg');background-repeat: no-repeat">
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="bleft.jsp"></jsp:include>
<div id="usermanager">
    <div class="u1">
        <p style="float:left;margin-left:20px;">用户管理</p>
    </div>
    <div class="u2">
        <button id="add">新增</button>
        <button id="upd">修改</button>
        <button id="det">删除</button>
        <input  id="condition" type="text" placeholder="请输入关键字" style="margin-left:150px;">
        <button><a id="sel" href="getUserByCondition">查询</a></button>
    </div>
    <div class="u3">
        <table border="1" cellpadding="0" cellspacing="0" style="width:630px;text-align:center;font-size:14px;">
            <tr>
                <th>选择</th>
                <th>用户名</th>
                <th>角色</th>
                <th>会员类型</th>
                <th>推荐人用户名</th>
                <th>状态(启用/禁用)</th>
                <th>最后修改时间</th>
            </tr>
            <c:forEach var="user" items="${userList}" varStatus="st">
                <tr>
                    <td>
                        <input type="radio" name="choose" value="${st.index}">
                    </td>
                    <td name="loginCode">${user.loginCode}</td>
                    <td>${user.roleName}</td>
                    <td>${user.userTypeName}</td>
                    <td>${user.referCode}</td>
                    <td>
                        <input class="${user.id}" type="checkbox" name="forbid" <c:if test="${user.isStart==1}">checked="checked"</c:if> />
                    </td>
                    <td>${user.lastUpdateTime}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="u4">
        <p style="color:red;font-size: 14px">注：状态打钩表示启用并立即生效</p>
    </div>
    <div class="u5" id="user-add">
        <img src="../../image/usermanager/u183.png" style="margin-left:10px;">
        <span style="font-size: 14px;">添加用户</span>
        <button id="quit1" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
        <hr/>
        <table>
            <tr>
                <td align="right">角色：</td>
                <td>
                    <select name="roleName1">
                        <option>请选择</option>
                        <c:forEach var="role" items="${sessionScope.roleList}">
                            <option value="${role.id}">${role.roleName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td align="right">会员类型：</td>
                <td>
                    <select name="userTypeName1">
                        <option>请选择</option>
                        <c:forEach var="userType" items="${sessionScope.userTypeList}">
                            <option value="${userType.valueId}">${userType.valueName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">用户名：</td>
                <td>
                    <input type="text"  name="loginCode1">
                </td>
                <td align="right">姓名：</td>
                <td>
                    <input type="text" name="userName1">
                </td>
            </tr>
            <tr>
                <td align="right">证件类型：</td>
                <td>
                    <select name="cardTypeName1">
                        <option>请选择</option>
                        <c:forEach var="cardType" items="${sessionScope.cardTypeList}">
                            <option value="${cardType.valueId}">${cardType.valueName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td align="right">证件号码：</td>
                <td>
                    <input type="text" name="idCard1">
                </td>
            </tr>
            <tr>
                <td align="right">收货国家（地区）：</td>
                <td>
                    <select name="country1">
                        <option>请选择</option>
                        <option>中国</option>
                        <option>美国</option>
                    </select>
                </td>
                <td align="right">移动电话：</td>
                <td>
                    <input type="text" name="mobile1">
                </td>
            </tr>
            <tr>
                <td align="right">电子邮件：</td>
                <td>
                    <input type="text" name="email1">
                </td>
                <td align="right">邮政编码：</td>
                <td>
                    <input type="text" name="postCode1">
                </td>
            </tr>
            <tr>
                <td align="right">邮政编码：</td>
                <td>
                    <input type="text" name="postCode1">
                </td>
                <td align="right">联系电话：</td>
                <td>
                    <input type="text" name="mobile1">
                </td>
            </tr>
            <tr>
                <td align="right">收货地址:</td>
                <td colspan="3">
                    <textarea cols="20" rows="3"  name="userAddress1"></textarea>
                </td>
            </tr>
            <tr>
                <td align="right">开户行：</td>
                <td>
                    <input type="text" name="bankName1">
                </td>
                <td align="right">开户卡号：</td>
                <td>
                    <input type="text" name="bankAccount1">
                </td>
            </tr>
            <tr>
                <td align="right">开户人：</td>
                <td>
                    <input type="text" name="accountHolder1">
                </td>

            </tr>
            <tr>
                <td align="right" style="display: none">上传身份证图片(正反面)：</td>
                <td>
                    <input type="file">
                </td>

            </tr>
            <tr>
                <td align="right" style="display: none">上传银行卡图片：</td>
                <td>
                    <input type="file">
                </td>
            </tr>
        </table>
        <div style="margin:20px 0 0 10px;">
                    <span style="color:red">
                        注: 1.用户名需验证唯一性<br/>
                        &nbsp;&nbsp; &nbsp;&nbsp;2.推荐人为选填项，默认为当前登录用户。
                    </span>

            <button style="margin-left:20px;" id="save1">保存</button>
            &nbsp;&nbsp;
            <button id="close1">关闭</button>
        </div>
    </div>

    <div class="u5" id="user-upd" hidden="hidden">
        <img src="../../image/usermanager/u278.png" style="margin-left:10px;">
        <span style="font-size: 14px;">修改用户</span>
        <button id="quit2" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
        <hr/>
        <input type="text" name="id2" style="display:none">
        <table>
            <tr>
                <td align="right">角色：</td>
                <td>
                    <select name="roleName2">
                        <option id="roleType2"></option>
                        <c:forEach var="role" items="${sessionScope.roleList}">
                            <option value="${role.id}">${role.roleName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td align="right">会员类型：</td>
                <td>
                    <select name="userTypeName2">
                        <option id="userType2"></option>
                        <c:forEach var="userType" items="${sessionScope.userTypeList}">
                            <option value="${userType.valueId}">${userType.valueName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">用户名：</td>
                <td>
                    <input type="text"  name="oLoginCode2">
                </td>
                <td align="right">姓名：</td>
                <td>
                    <input type="text" name="userName2">
                </td>
            </tr>
            <tr>
                <td align="right">证件类型：</td>
                <td>
                    <select name="cardTypeName2">
                        <option id="cardType2"></option>
                        <c:forEach var="cardType" items="${sessionScope.cardTypeList}">
                            <option value="${cardType.valueId}">${cardType.valueName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td align="right">证件号码：</td>
                <td>
                    <input type="text" name="idCard2">
                </td>
            </tr>
            <tr>
                <td align="right">收货国家（地区）：</td>
                <td>
                    <select name="country2">
                        <option>中国</option>
                        <option>美国</option>
                    </select>
                </td>
                <td align="right">移动电话：</td>
                <td>
                    <input type="text" name="mobile2">
                </td>
            </tr>
            <tr>
                <td align="right">电子邮件：</td>
                <td>
                    <input type="text" name="email2">
                </td>
                <td align="right">邮政编码：</td>
                <td>
                    <input type="text" name="postCode2">
                </td>
            </tr>
            <tr>
                <td align="right">邮政编码：</td>
                <td>
                    <input type="text" name="postCode2">
                </td>
                <td align="right">联系电话：</td>
                <td>
                    <input type="text" name="mobile2">
                </td>
            </tr>
            <tr>
                <td align="right">收货地址:</td>
                <td colspan="3">
                    <textarea cols="20" rows="3"  name="userAddress2"></textarea>
                </td>
            </tr>
            <tr>
                <td align="right">开户行：</td>
                <td>
                    <input type="text" name="bankName2">
                </td>
                <td align="right">开户卡号：</td>
                <td>
                    <input type="text" name="bankAccount2">
                </td>
            </tr>
            <tr>
                <td align="right">开户人：</td>
                <td>
                    <input type="text" name="accountHolder2">
                </td>

            </tr>
            <tr style="display: none">
                <td align="right">上传身份证图片(正反面)：</td>
                <td>
                    <input type="file">
                </td>

            </tr>
            <tr style="display: none">
                <td align="right">上传银行卡图片：</td>
                <td>
                    <input type="file">
                </td>
            </tr>
        </table>
        <div style="margin:20px 0 0 10px;">
                    <span style="color:red">
                        注: 1.用户名需验证唯一性<br/>
                        &nbsp;&nbsp; &nbsp;&nbsp;2.推荐人为选填项，默认为当前登录用户。
                    </span>

            <button style="margin-left:20px;" id="save2">保存</button>
            &nbsp;&nbsp;
            <button id="close2">关闭</button>
        </div>
    </div>

</div>

</body>
</html>
