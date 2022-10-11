<%--
  Created by IntelliJ IDEA.
  User: 86177
  Date: 2022/9/29
  Time: 15:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>权限管理</title>
    <style>
        .per{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
        }
        .list{
            width:120px;
            line-height: 30px;
            text-align: center;
            color:white ;
            position: relative;
            left:15px;
            margin-bottom: 2px;
            background-color: skyblue;
        }
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        var addFun=new Array();
        var deleteFun=new Array();
        $(document).ready(function () {
            $.ajax({
                url: "http://192.168.190.111:8222/detectacl/roles/getAllRole",
                type: "get",
                success: function (data) {
                    var roles = data.data.roles;
                    for (var i = 0; i < roles.length; i++) {
                        $("#roleShow").append("<span><input type='radio' name='role'/>" +
                            "<span name='roleName'>" + roles[i].roleName + "</span>" +
                            "<span name='roleId' style='display: none'>" + roles[i].id + "</span>"
                            + "</span>")
                    }
                }
            });
            $.ajax({
                url: "http://127.0.0.1:8222/detectacl/permission/getAllPermission",
                type: "get",
                success: function (data) {
                    var permissions = data.data.permissions;
                    for (var i = 0; i < permissions.length; i++) {
                        $("#perShow").append("<span><input type='checkbox' name='permission'/>" +
                            "<span name='perName'>" + permissions[i].preName + "</span>" +
                            "<span name='perId' style='display: none'>" + permissions[i].id + "</span>"
                            + "</span>&nbsp;&nbsp;&nbsp;&nbsp;")
                    }
                }
            });
        });
        $(document).ready(function (){
            $("body").on("click","input[name='role']",function (){
                addFun=[];
                deleteFun=[];
                var node=$(this).parent().find("span[name=roleId]");
                var id = node.text();
                var roleId=parseInt(id);
                $.ajax({
                    url:"http://192.168.190.111:8222/detectacl/prerole/getAllPerRoleByRId",
                    type:"post",
                    data:{"roleId":roleId},
                    success:function (data){
                        $("input[name=permission]").prop("checked",false);
                        $("input[name=permission]").each(function () {
                            var idNode=$(this).parent().find("span[name=perId]");
                            var myFunId=parseInt(idNode.text());
                            for(var i=0;i<data.data.rolePer.length;i++){
                                var id=data.data.rolePer[i].preId;
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
            $("body").on("click","input[name=permission]",function (){
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
                    var idNode = $(this).parent().find("span[name=perId]");
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
            $("#savePer").bind("click",function (){
                var roleId=null;
                $("input[name=role]").each(function () {
                    if($(this).prop("checked")){
                        var node=$(this).parent().find("span[name=roleId]");
                        var id = node.text();
                        roleId=parseInt(id);
                    }
                });
                $.ajax({
                    url: "http://192.168.190.111:8222/detectacl/prerole/saveRolePer",
                    type: "post",
                    data: {
                        "addFun": addFun.toString(),
                        "deleteFun": deleteFun.toString(),
                        "roleId": roleId
                    },
                    success: function (data) {
                        addFun = [];
                        deleteFun = [];
                        if (data.success) {
                            alert("保存成功！！");
                        } else {
                            alert("保存失败！！");
                        }
                    }
                })

            })
        })
    </script>

</head>
<body bgcolor="#f5f5f5">
    <jsp:include page="aside.jsp"></jsp:include>
    <div class="per">
        <div style="font-size: 30px;top: 0px;left: 0px" class="list">权限分配</div>
        <div style="position: relative;left: 95.4%;top: 0px"><button id="savePer">保存</button></div>
        <div>
            <div style="font-size: 20px;top: 20px;left: 0px" class="list">角色列表</div>
            <div id="roleShow" style="position: relative;left: 0px;top: 30px"></div>
        </div>
        <div>
            <div style="font-size: 20px;top: 40px;left: 0px" class="list">权限列表</div>
            <div  style="position: relative;left: 0px;top: 50px">
                <dl id="perShow"></dl>
            </div>
        </div>
    </div>
</body>
</html>
