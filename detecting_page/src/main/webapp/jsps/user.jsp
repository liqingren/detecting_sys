<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/28
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>用户界面</title>
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
            text-align: center;
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
        .user{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
        }
        img{
            width:350px;
            height:350px;
            position: relative;
            top:50px;
            left:350px;
        }
        button{
            width:320px;
            height:50px;
            font-size: 30px;
            position: relative;
            top:60px;
            left:365px;
            border:none;
            background-color: forestgreen;
            color:white;
            cursor: pointer;
        }
        table{
            margin:0 auto;
            position: relative;
            top:15px;
        }
        tr{
            line-height:70px;
            font-size: 28px;
        }
        input{
            height:40px;
            width:220px;
            font-size: 26px;
            border:none;
            background-color:#f5f5f5 ;
        }
        #datediv{
            width:350px;
           position: relative;
            top:20px;
            left:40px;
            margin:0 auto;
        }
        .date{
            font-size:24px;
            font-weight: bold;
            color:dodgerblue;
            margin-right:30px;
        }
        .form_1{
            width:320px;
            height:240px;
            border:3px solid #f8f8f8;
            visibility: hidden;
            position: absolute;
            z-index: 999;
            opacity: 1;
            overflow: hidden;
            background-color: white;
            text-align: center;
            margin-top: 10%;
            margin-left: 1%;
            border-radius: 10px;
        }
        .text1 {
            width: 300px;
            height: 150px;
            padding: 12px 20px;
            box-sizing: border-box;
            border: 2px solid #ccc;
            border-radius: 4px;
            background-color: #f8f8f8;
            font-size: 16px;
            resize: none;
        }
        .text2 {
            width: 300px;
            height: 50px;
            padding: 12px 20px;
            box-sizing: border-box;
            border: 2px solid #ccc;
            border-radius: 4px;
            background-color: #f8f8f8;
            font-size: 16px;
            resize: none;
        }
        .open{
            visibility: visible;
            opacity: 1;
        }
        .input_1{
            margin-top: 15px;
            width:100%;
            height:30px;
        }
        .input_2{
            width:100%;
            height:160px;
        }
        .input_3{
            width:100%;
            height:52px;
        }
        .input_1 .login_logo{
            text-align: left;
            font-size: 20px;
            font-weight: 300;
            padding-left: 30px;
            float: left;
        }
        .input_1 .close{
            width:20px;
            height:20px;
            color:#5d5d5d;
            text-align: center;
            line-height: 20px;
            border:1px solid  #5d5d5d;
            border-radius: 50%;
            float: right;
            padding-top: 0px;
            margin-right: 10px;
            font-size: 12px;
        }
        .input_1 .close:hover{
            cursor:pointer;
        }
        .adminResultDel {
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
            padding: 3px 13px;
            margin: 2px 0px;
            text-align: center;
            background-color: skyblue;
            color: white;
            border: 2px solid skyblue;
            border-radius:5px;
        }
        .adminResultDel:hover {
            background-color: red;
            color: white;
            border: 2px solid red;
        }

    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script src="http://cdn.bootcss.com/jquery/3.1.0/jquery.min.js" type="text/javascript"></script>
    <script src="http://cdn.bootcss.com/sockjs-client/1.1.1/sockjs.js" type="text/javascript"></script>
    <script src="../js/socket.js"></script>

    <script type="text/javascript">
        function initDate(){
            var date = new Date();
            var html="<span class='date'>"+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()+
                "</span><span class='date'>"+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+"</span>";
            $("#datediv").html(html);
        }

        $(document).ready(function(){
            //当前选择label字体颜色变蓝
            $("label:eq(0)").css("color","steelblue");
            //刷新时间
            setInterval(initDate,1000);
            var user=JSON.parse(sessionStorage.getItem("user"));
            //显示本人健康码
            var str="../image/code/"+user.codePath;
            var socket = createScoket(user.card);

            // $.session.set("SESSION_USERNAME",user.card);
            $(".imgcode").attr("src",str);
            //点击核酸结果按钮跳转页面
            $("#result ").bind("click",function(){
                window.location.href="/jsps/userresult.jsp";
            });
        });
        $(document).ready(function (){
            var roleCode=JSON.parse(sessionStorage.getItem("roleCode"));
            if(roleCode!=null&&roleCode!=""){
                $("#admin").removeAttr("hidden");
            }
            $("#admin").bind("click",function (){
                window.location.href="adminlogin.jsp";
            })
        })
        // $(document).ready(function(){
        //     var user=JSON.parse(sessionStorage.getItem("user"));
        //     var id = user.id;
        //     $.ajax({
        //         url:"http://localhost:8001/detectinq/mouser/getcode",
        //         type:"post",
        //         data:{
        //             "id":id
        //         },
        //         success:function(data){
        //             var user=JSON.parse(sessionStorage.getItem("user"));
        //             //显示本人健康码
        //             var str="../image/code/"+user.codePath;
        //             $(".imgcode").attr("src",str);
        //             //点击核酸结果按钮跳转页面
        //             $("#result ").bind("click",function(){
        //                 window.location.href="/jsps/userresult.jsp";
        //             });
        //         }
        //     });
        // });


        function createScoket(token){
            var socket;
            if(typeof(WebSocket) == "undefined") {
                console.log("您的浏览器不支持WebSocket");
            }else{
                var host = window.location.origin.replace("http:","ws:")
                //实现化WebSocket对象，指定要连接的服务器地址与端口  建立连接
                socket = new WebSocket("ws://localhost:8001/"+token);
                //打开事件
                socket.onopen = function() {
                    console.log("Socket 已打开");
                    //socket.send("这是来自客户端的消息" + location.href + new Date());
                };
                //获得消息事件
                socket.onmessage = function(result) {
                    console.log(result);
                    $("#systemMsg").val(result.data)
                };
                //关闭事件
                socket.onclose = function() {
                    console.log("Socket已关闭");
                };
                //发生了错误事件
                socket.onerror = function() {
                    console.log("Socket发生了错误");
                }
                //窗口关闭
                $(window).unload(function(event){
                    socket.close();
                });
            }
            return socket;
        }
    </script>

</head>
<body bgcolor="#f5f5f5">
<div class="user">
    <div class="form_1 open" id="form_1 open">
        <form >
            <div class="input_1"><div class="login_logo">消息通知</div><div class="close" id="close" onclick="InfoHidden()">X</div></div>
            <hr>
            <div class="input_2"><textarea class="text1" id="systemMsg"></textarea></div>
        </form>
    </div>
    <div>
        <div id="datediv">
        </div>
        <div class="code">
            <img class="imgcode">
        </div>
        <button id="result">核酸结果</button>
    </div>
    <div>
        <button hidden="hidden" id="admin" style="top: 90px;left: 365px">后台系统</button>
    </div>
</div>
</body>
</html>
