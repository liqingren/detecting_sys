<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/30
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>厂商</title>
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
            width:50%;
            /*height:500px;*/
            position: relative;
            top:30px;
            border-color: #ececec;
            position: relative;
            top:70px;
            left:280px;
        }
        tr{
            line-height:60px;
        }
        td{
            font-size: 24px;
        }
        input{
            font-size: 24px;
            width:280px;
            height:36px;
        }
        .save{
            width:50%;
            height:40px;
            line-height:40px;
            font-size: 24px;
            border:none;
            background-color: skyblue;
            color:white;
            margin-left:-80px;
            margin-top:20px;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //当前选择label字体颜色变蓝
            $("label:last").css("color","steelblue");
            //保存
            $(".save").bind("click",function(){
                var medicineName = $("[name='medicineName']").val();
                var conpanyName = $("[name='conpanyName']").val();
                var num = $("[name='num']").val();
                var medicine={"medicineName":medicineName,"conpanyName":conpanyName,"num":num};
                $.ajax({
                    url:"http://192.168.190.111:8222/detecthos/medicine/medic/insert",
                    type:"post",
                    data:JSON.stringify(medicine),
                    success:function(data){
                        if(data.success){
                            alert("药品生产成功");
                            $("[name='medicineName']").val("");
                            $("[name='conpanyName']").val("");
                            $("[name='exp']").val("");

                        }else{
                            alert("药品生产失败");
                        }
                    },
                    contentType:"application/json"
                });
            });
        });
    </script>
</head>
<body bgcolor="#f5f5f5">
    <jsp:include page="aside.jsp"></jsp:include>
    <div class="income">
        <table>
            <tr>
                <td>药品名称：</td>
                <td>
                    <input type="text" name="medicineName">
                </td>
            </tr>
            <tr>
                <td>生产厂商：</td>
                <td>
                    <input type="text" name="conpanyName">
                </td>
            </tr>
            <tr>
                <td>数量：</td>
                <td>
                    <input type="text" name="num">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button class="save">保存</button>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
