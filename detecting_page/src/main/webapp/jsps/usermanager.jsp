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
    <title>Title</title>
    <style>
        .per{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:200px;
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
            margin:40px 0 0 0;
        }
        .delete{
            float: left;
            margin:40px 0 0 0;
            left: 15%;
        }
        .virtual_body {
            width:100%;
            height:100%;
            overflow-y:scroll;
            overflow-x:auto;
        }
        .fixed_div {
            position:absolute;
            z-index:2008;
            /*border:1px solid black;*/
        }
        a{
            text-decoration:none;
            color: coral;
        }
    </style>
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript">
        var deleteOrAddRole=new Array();
        var roleUserId=-1;
        $(document).ready(function () {
            $.ajax({
                url: "http://localhost:8004/detectacl/roles/getAllRole",
                type: "get",
                success: function (data) {
                    var roles = data.data.roles;
                    for (let i = 0; i < roles.length; i++) {
                        $("#roleShow").append("<span><input type='radio' name='role'/>" +
                            "<span name='roleName'>" + roles[i].roleName + "</span>" +
                            "<span name='roleId' style='display: none'>" + roles[i].id + "</span>"
                            + "</span>")
                    }
                }
            });
            $.ajax({
                url: "http://localhost:8004/detectacl/users/getUserVoPage",
                type: "post",
                success: function (data) {
                    var users=data.data.userList;
                    for(var i=0;i<users.length;i++){
                        var str="<tr>" +
                            "<td><input type='checkbox' name='userChoose'></td>" +
                            "<td name='userId'>"+users[i].id+"</td>" +
                            "<td>"+users[i].card+"</td>" +
                            "<td>"+users[i].name+"</td>" +
                            "<td name='role'>"+"<span style='display: none' name='roleId'>"+users[i].roleId+"</span>"+
                            users[i].roleName+"</td>" +
                            "<td>"+users[i].updateTime+"</td>" +
                            "<tr>";
                        $("#userBody").append(str);
                    }
                }
            });
        });
        $(document).ready(function (){
            $("body").on("click","input[name=userChoose]",function (){
                var nodeUser = $(this).parent().parent().find("td[name=userId]");
                var id=parseInt(nodeUser.text());
                alert(id);
                if($(this).prop("checked")){
                    if(deleteOrAddRole.indexOf(id)<0){
                        deleteOrAddRole.push(id);
                    }
                }else{
                    if(deleteOrAddRole.indexOf(id)>=0){
                        deleteOrAddRole.splice($.inArray(id,deleteRole),1);
                    }
                }
            })
        });
        $(document).ready(function (){
            $("body").on("click","input[name=role]",function (){
                var node=$(this).parent().find("span[name=roleId]");
                roleUserId=parseInt(node.text());
                alert(roleUserId);
            })
        })
        $(document).ready(function (){
            $(".delete").bind("click",function (){
                $.ajax({
                    url:"http://localhost:8004/detectacl/roleuser/removeRoleUsers",
                    type:"post",
                    data:{
                        "deleteUsers":deleteOrAddRole.toString()
                    },
                    success:function (data){
                        if(data.data.success()){
                            alert("删除成功");
                        }else {
                            alert("删除失败");
                        }
                        window.location.href="/jsps/usermanager.jsp"
                    }
                })
            })
            $("#saveRole").bind("click",function (){
                if(roleUserId==-1){
                    alert("请选中角色")
                }else{
                    if(deleteOrAddRole.length==0){
                        alert("请选中用户")
                    }else{
                        $.ajax({
                            url:"http://localhost:8004/detectacl/roleuser/saveRoleUser",
                            type:"post",
                            date:{
                                "addUsers":deleteOrAddRole.toString(),
                                "roleId":roleUserId
                            },
                            success:function (data){
                                if(data.data.success()){
                                    alert("删除成功");
                                }else {
                                    alert("删除失败");
                                }
                                window.location.href="/jsps/usermanager.jsp"
                            }
                        })
                    }
                }
            })
        });
    </script>
</head>
<body bgcolor="#f5f5f5">
<div><jsp:include page="aside.jsp"></jsp:include></div>
<div class="per" >
    <div style="font-size: 30px;top: 0px;left: 0px" class="list">角色分配</div>
    <div style="position: relative;left: 95.4%;top: 0px"><button id="saveRole">保存</button></div>
    <div>
        <div style="font-size: 20px;top: 20px;left: 0px" class="list">角色列表</div>
        <div id="roleShow" style="position: relative;left: 20px;top: 30px"></div>
    </div>
    <div>
        <div style="font-size: 20px;top: 40px;left: 0px" class="list">用户列表</div>
    </div>
    <button class="delete">删除角色</button>
    <div class="search">
        <input type="text" name="keyword">
        <button>查询</button>
    </div>
    <div>
    <table border="1" cellpadding="0" cellspacing="0" style="border-color: skyblue;width: 100%">
        <thead>
        <tr>
            <th>选择</th>
            <th>用户id</th>
            <th>身份证号</th>
            <th>用户姓名</th>
            <th>用户角色</th>
            <th>修改时间</th>
        </tr>
        </thead>
        <tbody id="userBody">

        </tbody>
    </table>
        <table id="pageList" style="table-layout: fixed;width: 100%;" align="center" hidden="hidden"><tr><td width="100%" align="center">
            <a href="allComServlet?pageNum=${sessionScope.pageNum-1}" id="pre">上一页</a>
            <a href="allComServlet?pageNum=${sessionScope.pageNum-2}" id="hiden1">${sessionScope.pageNum-2}</a>
            <a href="allComServlet?pageNum=${sessionScope.pageNum-1}" id="hiden2">${sessionScope.pageNum-1}</a>
            <a href="allComServlet?pageNum=${sessionScope.pageNum}" style="color: crimson">${sessionScope.pageNum}</a>
            <a href="allComServlet?pageNum=${sessionScope.pageNum+1}" id="hiden3">${sessionScope.pageNum+1}</a>
            <a href="allComServlet?pageNum=${sessionScope.pageNum+2}" id="hiden4">${sessionScope.pageNum+2}</a>
            <span id="hiden5">...</span>
            <a href="allComServlet?pageNum=${sessionScope.pageNum+1}" id="next">下一页</a>
            <form>
                转到：<input name="pageNum" type="text" style="width: 30px"/>页
            </form>
            总共${sessionScope.total}条,&nbsp;&nbsp;
            <span id="jspPages">${sessionScope.pages}</span>页,&nbsp;&nbsp;
            当前第<span id="jspPageNum">${sessionScope.pageNum}</span>页&nbsp;&nbsp;
        </td></tr></table>
    </div>
</div>
</body>
</html>
