<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/29
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>录入结果</title>
    <meta charset="utf-8">
    <style type="text/css">
        .income{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
        }
        table{
            width:95%;
            /*height:500px;*/
            overflow: scroll;
            margin:0 auto;
            position: relative;
            top:30px;
            border-color: #ececec;
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
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //当前选择label字体颜色变蓝
            $("label:eq(2)").css("color","steelblue");
        });
    </script>
</head>
<body bgcolor="#f5f5f5">
    <jsp:include page="aside.jsp"></jsp:include>
    <div class="income">
        <div class="search">
            <input type="text" name="keyword">
            <button>查询</button>
        </div>
        <table border="1" cellpadding="0" cellspacing="0">
            <thead>
            <tr>
                <th style="width:50px;"></th>
                <th>姓名</th>
                <th>身份证号</th>
                <th>性别</th>
                <th>采集时间</th>
                <th>状态</th>
            </tr>
            </thead>
            <tbody id="tbody">

            </tbody>
        </table>
    </div>
</body>
</html>
