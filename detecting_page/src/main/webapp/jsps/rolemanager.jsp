<%--
  Created by IntelliJ IDEA.
  User: 86177
  Date: 2022/9/29
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>角色管理</title>
    <style>
        .per{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
        }
        .result{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
        }
        tr{
            line-height:30px;
        }
        td{
            text-align: center;
        }
        .search{
            float: right;
            margin:30px 5% 0 0;
        }
        .delete{
            float: left;
            margin:30px 5% 0 0;
            left: 15%;
        }
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/jquery.cookie-1.4.1.min.js"></script>
    <script type="text/javascript">
        var deleteRole=new Array();
        $(document).ready(function(){
            if(!$.cookie('token')){
                window.location.href="loginTest.jsp";
            }
            $.ajax({
                url:"http://127.0.0.1:8222/detectacl/roles/getAllRole",
                type:"post",
                success:function(data){
                    var roles=data.data.roles;
                    for(var i=0;i<roles.length;i++){
                        var str="<tr>" +
                            "<td><input type='checkbox' name='roleChoose'></td>" +
                            "<td name='roleId'>"+roles[i].id+"</td>" +
                            "<td>"+roles[i].roleCode+"</td>" +
                            "<td>"+roles[i].roleName+"</td>" +
                            "<td>"+roles[i].updateTime+"</td>" +
                            "<tr>";
                        $("#roleBody").append(str);
                    }
                }
            })
        });
        $(document).ready(function (){
            $("body").on("click","input[name=roleChoose]",function (){
                var node = $(this).parent().parent().find("td[name=roleId]");
                var id=parseInt(node.text());
                if($(this).prop("checked")){
                    if(deleteRole.indexOf(id)<0){
                        deleteRole.push(id);
                    }
                }else{
                    if(deleteRole.indexOf(id)>=0){
                        deleteRole.splice($.inArray(id,deleteRole),1);
                    }
                }
            })
        });
        $(document).ready(function (){
            $(".delete").bind("click",function (){
                $.ajax({
                    url:"http://127.0.0.1:8222/detectacl/roles/remove",
                    type:"post",
                    data:{
                        "deleteRoles":deleteRole.toString()
                    },
                    success:function (data){
                        if(data.success()){
                            alert("删除成功");
                        }else {
                            alert("删除失败");
                        }
                        window.location.href="rolemanager.jsp"
                    }
                })
            })
        });
    </script>
</head>
<body bgcolor="#f5f5f5">
<jsp:include page="aside.jsp"></jsp:include>
<div class="per" >

    <div>
        <button class="delete">删除</button>
        <div class="search">
            <input type="text" name="keyword">
            <button>查询</button>
        </div>
        <table border="1" cellpadding="0" cellspacing="0" style="border-color: skyblue;width: 100%">
            <thead>
            <tr>
                <th>选择</th>
                <th>角色id</th>
                <th>角色编号</th>
                <th>角色名称</th>
                <th>最后修改时间</th>
            </tr>
            </thead>
            <tbody id="roleBody">

            </tbody>
        </table>
    </div>
</div>
</body>
</html>
