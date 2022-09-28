<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/3
  Time: 22:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>权限管理</title>
    <style type="text/css">
        #rightsmanager{
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
            height:85px;
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
        .u4{
            width:200px;
            height:220px;
            float:left;

        }
        dt,dd{
            height:25px;
            font-size: 14px;
        }
        dd{
            margin-left:20px;
        }
        .u5{
            width:200px;
            height:400px;
            float:left;
        }
        dl>li{
            margin-left:40px;
            list-style-type: none;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript">
        var addFun=new Array();
        var deleteFun=new Array();

        $(document).ready(function(){
            //初始化实现页面跳转
            initJump();
            //显示后台管理下的列表
            $("ul:eq(0)").show();
            //将权限管理字体颜色变黄
            $("ul li:eq(2)").css("color","yellow");
        });
        $(document).ready(function (){
           $("input[name=role]").bind("click",function (){
               addFun=[];
               deleteFun=[];
               var node=$(this).parent().find("span[name=roleId]");
               var id = node.text();
               var roleId=parseInt(id);
               $.ajax({
                   url:"getFunctionIds",
                   type:"post",
                   data:{"roleId":roleId},
                   success:function (data){
                       $("input[name=function]").prop("checked",false);
                       $("input[name=function]").each(function () {
                           var idNode=$(this).parent().find("span[name=funId]");
                           var myFunId=parseInt(idNode.text());
                           for(let i=0;i<data.length;i++){
                               var id=data[i];
                               if(myFunId==id){
                                   $(this).prop("checked",true);
                               }
                           }
                       })
                   }
               })
           })
        });
        $(document).ready(function (){
            $("input[name=function]").bind("click",function (){
                var roleId=null;
                $("input[name=role]").each(function () {
                    if($(this).prop("checked")){
                        var node=$(this).parent().find("span[name=roleId]");
                        var id = node.text();
                        roleId=parseInt(id);
                    }
                });
                if(roleId==null){
                    alert("请选择角色进行添加或删除权限！！")
                }else {
                    var idNode = $(this).parent().find("span[name=funId]");
                    var funId = parseInt(idNode.text());
                    if ($(this).prop("checked")) {
                        if (deleteFun.indexOf(funId) >= 0) {
                            deleteFun.splice($.inArray(funId, deleteFun), 1);
                        } else {
                            if (!(addFun.indexOf(funId) >= 0)) {
                                addFun.push(funId);
                            }
                        }
                    } else {
                        if (addFun.indexOf(funId) >= 0) {
                            addFun.splice($.inArray(funId, addFun), 1);
                        } else {
                            if (!(deleteFun.indexOf(funId) >= 0)) {
                                deleteFun.push(funId);
                            }
                        }
                    }
                }
            })
        });

        $(document).ready(function (){
            $("#saveFun").bind("click",function (){
                var roleId=null;
                $("input[name=role]").each(function () {
                    if($(this).prop("checked")){
                        var node=$(this).parent().find("span[name=roleId]");
                        var id = node.text();
                        roleId=parseInt(id);
                    }
                });
                var auRole=${sessionScope.auUser.roleId};
                if(auRole==roleId){
                    alert("没有权限修改自己的角色对应的权限")
                }else {
                    $.ajax({
                        url: "updateRoleFunction",
                        type: "post",
                        data: {
                            "addFun": addFun.toString(),
                            "deleteFun": deleteFun.toString(),
                            "roleId": roleId
                        },
                        success: function (data) {
                            addFun = [];
                            deleteFun = [];
                            if (data.flag) {
                                alert("保存成功！！");
                            } else {
                                alert(data.msg);
                            }
                        }
                    })
                }
            })
        })
    </script>
</head>
<body style="background-image:url('../../image/bg.jpg');background-repeat: no-repeat">
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="bleft.jsp"></jsp:include>
    <div id="rightsmanager">
        <div class="u1">
            <p style="float:left;margin-left:20px;">权限管理</p>
        </div>
        <div class="u2">
            <img src="../../image/rightmanager/u64.png" style="width:18px;height:18px;margin-right:3px;">
            <span style="font-size: 16px;font-weight: bold;font-family: 等线">角色列表：</span>
            <p>
                <c:forEach var="role" items="${requestScope.roleList}">
                <span>
                    <input type="radio" name="role"/>
                    <span name="roleName">${role.roleName}</span>
                    <span name="roleId" style="display: none">${role.id}</span>
                </span>
                </c:forEach>
            </p>
            <hr/>
        </div>
        <div class="u3">
           <img src="../../image/rightmanager/u66.png" style="width:18px;height:18px;margin-right:3px;">
            <span style="font-size: 16px;font-weight: bold;font-family: 等线">权限列表：</span>
            <button id="saveFun">保存</button>
        </div>
        <div class="rights">
            <c:forEach var="permission" items="${requestScope.permissionVoList}" varStatus="st">
                <div class="u4">
                    <dl class="c3">
                        <dt class="c4">
                            <input type="checkbox" name="function"/>
                            <span name="funName">${permission.functionName}</span>
                            <span name="funId" style="display: none">${permission.id}</span>
                        </dt>
                        <c:forEach var="child" items="${permission.children}">
                            <dd class="c5">
                                <input type="checkbox" name="function"/>
                                <span name="funName">${child.functionName}</span>
                                <span name="funId" style="display: none">${child.id}</span>
                            </dd>
                            <c:if test="${permission.id==6}">
                                <c:forEach var="childb" items="${child.children}">
                                    <li class="c6">
                                        <input type="checkbox" name="function"/>
                                        <span name="funName">${childb.functionName}</span>
                                        <span name="funId" style="display: none">${childb.id}</span>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </dl>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
