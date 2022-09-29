<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/29
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>核酸结果</title>
    <meta charset="utf-8">
    <style type="text/css">
        .header{
            width:100%;
            height:120px;
        }
        h2{
            font-size: 100px;
            font-family: 华文彩云;
            color: skyblue;
            position: relative;
            top:10px;
            text-align: center;
        }
        .aside{

            width:200px;
            height:600px;
            background-color: lightblue;
        }
        .list{
            width:170px;
            line-height: 30px;
            font-size: 20px;
            text-align: left;
            padding-left:10px;
            color:white ;
            position: relative;
            top:50px;
            left:7px;
            margin-bottom: 2px;
            background-color: skyblue;
        }
        label{
            cursor: pointer;
        }
        .list-user{
            width:170px;
            line-height: 30px;
            font-size: 16px;
            text-align: left;
            padding-left:10px;
            color:white ;
            position: relative;
            top:50px;
            left:7px;
            margin-bottom: 2px;
            background-color: skyblue;
        }
        .result{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:200px;
        }
        table{
            width:90%;
            /*height:500px;*/
            overflow: scroll;
            margin:0 auto;
            position: relative;
            top:80px;
            border-color: #ececec;
        }
        tr{
            line-height:30px;
        }
        td{
            text-align: center;
        }
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var user=JSON.parse(sessionStorage.getItem("user"));
            var card=user.card;
            $.ajax({
                url:"http://localhost:8001/detectinq/users/getuserresult",
                type:"post",
                data:{
                    "card":card
                },
                success:function(data){
                    var user=JSON.parse(sessionStorage.getItem("user"));
                    console.log(data.data.result);
                    $("#username").text(user.name);
                    $("#card").text(user.card);
                    for(var i=0;i<data.data.result.length;i++){
                        var str="<tr><td>"+data.data.result[i].createTime+"</td><td>"+data.data.result[i].resultTime+"</td><td>"+
                            data.data.result[i].resultstate+"</td><tr>";
                        $("#tbody").append(str);
                    }
                }
            })
        })
    </script>
</head>
<body bgcolor="#f5f5f5">
    <div class="header">
        <h2>核酸检测系统</h2>
    </div>
    <div class="aside">
        <div class="list">
            <label>核酸结果</label>
        </div>
        <div class="list-user">
            <span>用户：</span>
            <span id="username"></span>
            <br/>
            <span>身份证号：</span>
            <span id="card"></span>
        </div>
    </div>
    <div style="float: right">
        <input type="text" name="keyword">
        <button>查询</button>
    </div>
    <div class="result">
        <table border="1" cellpadding="0" cellspacing="0">
            <thead>
                <tr>
                    <th>采集时间</th>
                    <th>检测时间</th>
                    <th>状态</th>
                </tr>
            </thead>
            <tbody id="tbody">

            </tbody>
        </table>
    </div>

</body>
</html>
