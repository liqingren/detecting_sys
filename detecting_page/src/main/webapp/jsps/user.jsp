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
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script src="http://cdn.bootcss.com/jquery/3.1.0/jquery.min.js" type="text/javascript"></script>
    <script src="http://cdn.bootcss.com/sockjs-client/1.1.1/sockjs.js" type="text/javascript"></script>
    <script type="text/javascript">
        var websocket = null;
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://127.0.0.1:8001/websocket/server");
        } else if ('MozWebSocket' in window) {
            websocket = new MozWebSocket("ws://127.0.0.1:8001/websocket/server");
        } else {
            websocket = new SockJS("http://127.0.0.1:8001/sockjs/server");
        }
        websocket.onopen = onOpen;
        websocket.onmessage = onMessage;
        websocket.onerror = onError;
        websocket.onclose = onClose;

        function onOpen(event) {
            //  alert(event.type);
        }

        function onMessage(messageEvent) {
            alert(messageEvent.data);
        }

        function onError(event) {
        }

        function onClose(closeEvent) {
            // alert(closeEvent.reason);
        }

        function doSendUser() {
            if (websocket.readyState === websocket.OPEN) {
                var msg = document.getElementById("inputMsg").value;
                websocket.send(msg);//发送消息
                alert("发送成功!");
            } else {
                alert("连接失败!");
            }
        }

        window.close = function () {
            websocket.onclose();
        };

        function websocketClose() {
            websocket.close();
            alert("连接关闭");
        }
    </script>
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
            $(".imgcode").attr("src",str);
            //点击核酸结果按钮跳转页面
            $("#result ").bind("click",function(){
                window.location.href="/jsps/userresult.jsp";
            });
        });
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


    </script>
</head>
<body bgcolor="#f5f5f5">
    <jsp:include page="aside.jsp"></jsp:include>
    <div class="user">
        <div id="datediv">

        </div>
        <div class="code">
            <img class="imgcode">
        </div>
        <button id="result">核酸结果</button>
    </div>
</body>
</html>
