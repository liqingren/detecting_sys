<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/5
  Time: 22:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>数据字典</title>
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
        .u6>a{
            color:darkolivegreen;
            font-family: 等线;
            font-size: 18px;
        }
        .u6>a:first-child{
            color:darkgreen;
            font-family: 等线;
            font-weight: bolder;
        }
        .u6>a:last-child{
            color:darkgreen;
            font-family: 等线;
            font-weight: bolder;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript" src="../../js/datajs.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //初始化实现页面跳转
            initJump();
            //初始化
            init();

        });
        //分页处理
        $(document).ready(function(){
            var totalPage = ${totalPage};
            var pageNum = ${pageNum};
            // alert(pageNum);
            //当前为第一页时不能在前一页
            if(pageNum<=1){
                $("#prePage").attr("href","javascript:void");
                $("#prePage").css("color","gray");

            }
            //处理next
            if(pageNum>=totalPage) {
                $("#nextPage").attr("href", "javascript:void");
                $("#nextPage").css("color", "gray");
                $("#page>a:gt(1):not(a:last)").remove();
                $("a~span").remove();
                //添加节点
                $("#prePage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
                $("#page>a:eq(2)").before($("<span> ... </span>"));
                $("#page>a:eq(2)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-4}'>${pageNum-4} </a>"));
                $("#page>a:eq(3)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-3}'>${pageNum-3} </a>"));
                $("#page>a:eq(4)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-2}'>${pageNum-2} </a>"));
                $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));

            }
            else if(pageNum+4===totalPage){
                $("#page>a:eq(6)").remove();
                $("a~span").remove();
                //添加节点
                $("#prePage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
                $("#begin").before($("<span> ... </span>"));

            }
            else if(pageNum+3===totalPage){
                $("#page>a:eq(5),#page>a:eq(6)").remove();
                $("a~span").remove();
                //添加节点
                $("#prePage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
                $("#page>a:eq(2)").before($("<span>... </span>"));
                $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));

            }
            else if(pageNum+2===totalPage){
                $("#page>a:gt(3):not(a:last)").remove();
                $("a~span").remove();
                //添加节点
                $("#prePage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
                $("#page>a:eq(2)").before($("<span> ... </span>"));
                $("#page>a:eq(2)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-2}'>${pageNum-2} </a>"));
                $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));

            }
            else if(pageNum+1===totalPage){
                $("#page>a:gt(2):not(a:last)").remove();
                $("a~span").remove();
                //添加节点
                $("#prePage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
                $("#page>a:eq(2)").before($("<span> ... </span>"));
                $("#page>a:eq(2)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-3}'>${pageNum-3} </a>"));
                $("#page>a:eq(3)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-2}'>${pageNum-2} </a>"));
                $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));

            }
        });
        ////新增
        // $(document).ready(function(){
        //     $("#save1").bind("click",function(){
        //         var typaName = $("[name='typeName']").val();
        //         var valueName = $("[name='valueName']").val();
        //         var typeCode = $("[name='typeCode']").val();
        //         var valueId = $("[name='valueId']").val();
        //         if(typeCode!=null){
        //             $.ajax({
        //                 url:"/ssm/datadict/",
        //                 type:"post",
        //                 data:JSON.stringify(dataDict),
        //                 success:function(data){
        //
        //                 }
        //             })
        //         }
        //
        //     })
        // })
    </script>
</head>
<body style="background-image:url('../../image/bg.jpg');background-repeat: no-repeat">
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="bleft.jsp"></jsp:include>
    <div id="basicinformation">
        <div class="u1">
            <p style="float:left;margin-left:20px;">数据字典</p>
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
                    <th>类型</th>
                    <th>名称</th>
                    <th>编码</th>
                    <th>数据值</th>
                </tr>
                <c:forEach var="dict" items="${dictList}">
                    <tr>
                        <td>
                            <input type="radio" name="choose">
                        </td>
                        <td>${dict.typeName}</td>
                        <td>${dict.valueName}</td>
                        <td>${dict.typeCode}</td>
                        <td>${dict.valueId}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="u4" id="data_add">
            <div style="height:30px;line-height:30px;background-color: beige;border-style: none none solid none;border-color: lightgrey">
                <img src="../../image/rolemanager/u126.png" style="margin:0 10px -3px 10px;width:18px;height:18px;">
                <span style="font-size: 14px">添加数据字典</span>
                <button id="quit1" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
            </div>
            <table style="margin:20px 0 0 30px">
                <tr>
                    <td>类型:</td>
                    <td>
                        <input type="text" name="typeName">
                    </td>
                </tr>
                <tr>
                    <td>名称:</td>
                    <td>
                        <input type="text" name="valueName">
                    </td>
                </tr>
                <tr>
                    <td>编码:</td>
                    <td>
                        <input type="text" name="typeCode">
                        <span name="msg" style="color:red;display:none;"></span>
                        <span style="color:red">* 注：验证编码唯一性</span>
                    </td>
                </tr>
                <tr>
                    <td>数据值:</td>
                    <td>
                        <input type="text" name="valueId">
                    </td>
                </tr>
            </table>
            <div class="u5">&nbsp;
                <button id="close1" style="float:right;margin:30px 50px 0 0;">关闭</button>
                <button style="margin:30px 50px 0 0;float:right" id="save1">保存</button>
            </div>

        </div>
        <div class="u4" id="data_upd">
            <div style="height:30px;line-height:30px;background-color: beige;border-style: none none solid none;border-color: lightgrey">
                <img src="../../image/rolemanager/u126.png" style="margin:0 10px -3px 10px;width:18px;height:18px;">
                <span style="font-size: 14px">修改数据字典</span>
                <button id="quit2" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
            </div>
            <table style="margin:20px 0 0 30px">
                <tr>
                    <td>类型:</td>
                    <td>
                        <input type="text" name="typeName">
                    </td>
                </tr>
                <tr>
                    <td>名称:</td>
                    <td>
                        <input type="text" name="valueName">
                    </td>
                </tr>
                <tr>
                    <td>编码:</td>
                    <td>
                        <input type="text" name="typeCode">
                        <span name="msg" style="color:red;display:none;"></span>
                        <span style="color:red">* 注：验证编码唯一性</span>
                    </td>
                </tr>
                <tr>
                    <td>数据值:</td>
                    <td>
                        <input type="text" name="valueId">
                    </td>
                </tr>
            </table>
            <div class="u5">&nbsp;
                <button id="close2" style="float:right;margin:30px 50px 0 0;">关闭</button>
                <button style="margin:30px 50px 0 0;float:right" id="save2">保存</button>
            </div>
        </div>
        <div class="u6" id="page" style="float:right;width:250px;line-height:60px;">
            <a href="/ssm/datadict/datajsp?pageNum=${pageNum-1}" id="prePage">Previous</a>
            <a href="/ssm/datadict/datajsp?pageNum=${pageNum}" id="begin">${pageNum}</a>
            <a href="/ssm/datadict/datajsp?pageNum=${pageNum+1}">${pageNum+1}</a>
            <a href="/ssm/datadict/datajsp?pageNum=${pageNum+2}">${pageNum+2}</a>
            <a href="/ssm/datadict/datajsp?pageNum=${pageNum+4}">${pageNum+3}</a>
            <a href="/ssm/datadict/datajsp?pageNum=${pageNum+3}">${pageNum+4}</a>
            <span>...</span>
            <a href="/ssm/datadict/datajsp?pageNum=${totalPage}" id="end">${totalPage}</a>
            <a href="/ssm/datadict/datajsp?pageNum=${pageNum+1}" id="nextPage">Next</a>
        </div>

    </div>
</body>
</html>
