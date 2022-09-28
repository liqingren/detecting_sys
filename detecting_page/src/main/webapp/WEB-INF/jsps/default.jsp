<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/2
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统登录默认页</title>
    <style type="text/css">
        #bright{
            margin-left:245px;
            width:640px;
            height:450px;
            position: relative;
            top:-70px;
        }
        .u1{
            width:640px;
            height:50px;
            font-size: 14px;
        }
        .u2{
            width:640px;
            height:20px;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //初始化实现页面跳转
            initJump();
        })
    </script>

</head>
<body style="background-image:url('../../image/bg.jpg');background-repeat: no-repeat">
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="bleft.jsp"></jsp:include>
    <div id="bright">
        <div class="u1">
            <p style="float:left;margin-left:20px;">公告栏</p>
            <p style="float:right;margin-right:30px;">>>更多</p>
        </div>
        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>关于加盟店级别取消政策</span>
                <span style="margin-left:380px;">2013-12-13</span>
            </p>
        </div>
        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>关于加盟店政策补充说明</span>
                <span style="margin-left:380px;">2013-12-13</span>
            </p>
        </div>
        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>全球信用卡支付系统已经开通</span>
                <span style="margin-left:354px;">2013-12-13</span>
            </p>
        </div>
        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>2011年度奖励方案</span>
                <span style="margin-left:415px;">2013-12-13</span>
            </p>
        </div>
        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>关于加强市场管理的通知</span>
                <span style="margin-left:380px;">2013-12-13</span>
            </p>
        </div>

        <div class="u1" style="margin:20px 0 0 -15px;">
            <img src="../../image/defalutimg/u41.jpg">
        </div>

        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>新世纪新品发布会花絮(视频)</span>
                <span style="margin-left:358px;">2013-12-13</span>
            </p>
        </div>
        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>《我心飞扬.幸福启航》发布会照片</span>
                <span style="margin-left:325px;">2013-12-13</span>
            </p>
        </div>

        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>全球信用卡系统已经开通</span>
                <span style="margin-left:380px;">2013-12-13</span>
            </p>
        </div>

        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>Roova平衡液晶专题片(视频)</span>
                <span style="margin-left:358px;">2013-12-13</span>
            </p>
        </div>
        <div class="u2">
            <p>
                <img src="../../image/defalutimg/u55.png">
                &nbsp;&nbsp;<span>好专访(视频)</span>
                <span style="margin-left:448px;">2013-12-13</span>
            </p>
        </div>


    </div>
</body>
</html>
