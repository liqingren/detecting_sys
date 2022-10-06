<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/29
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>扫描二维码</title>
    <meta charset="utf-8">
    <style type="text/css">
        .scan{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
        }
        a{
            text-decoration:none;
            color:#fff;
        }
        #v{
            width:400px;
            height:400px;
            position: relative;
            top:-50px;

        }
        #qr-canvas{
            display:none;
        }
        .scanning_frame{
            margin:5rem auto;
            width:400px;
            height:300px;
            border: 3px solid #000;
            position: relative;
            /*display: none;*/
            /*z-index:999;*/
            background-color: white;
        }
        .infor{
            width:12rem;
            height: 4rem;
            text-align: center;
            line-height: 4rem;
            background:skyblue;
            color: #fff;
            font-size: 24px;
            border-radius: 2rem;
            border:none;
            position: relative;
            top:-30px;
            left:32%;
            cursor: pointer;
            margin-right:10px;
        }
        /*加载动画效果*/
        .spinner {
            width: 60px;
            height: 60px;
            position: absolute;
            top:90px;
            left: 130px;
            /*background-color: #fff;*/
        }

        .double-bounce1, .double-bounce2 {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background-color: #d81e06;
            opacity: 0.6;
            position: absolute;
            top: 30px;
            left: 30px;
            display: none;
            -webkit-animation: bounce 2.0s infinite ease-in-out;
            animation: bounce 2.0s infinite ease-in-out;
        }

        .double-bounce2 {
            -webkit-animation-delay: -1.0s;
            animation-delay: -1.0s;
        }

        @-webkit-keyframes bounce {
            0%, 100% { -webkit-transform: scale(0.0) }
            50% { -webkit-transform: scale(1.0) }
        }

        @keyframes bounce {
            0%, 100% {
                transform: scale(0.0);
                -webkit-transform: scale(0.0);
            }
            50% {
                transform: scale(1.0);
                -webkit-transform: scale(1.0);
            }
        }
        .result{
            width:550px;
            height:310px;
            margin:0 auto;
            background-color: #ececec;
            position: absolute;
            top:80px;
            left:260px;
            z-index: 10;
            display: none;
        }
        table{
            margin:0 auto;
            padding-top: 30px;
        }
        tr{
            line-height: 60px;
            font-size: 24px;
            padding-left:20px;
        }
        input{
            border:none;
            font-size: 24px;
            background-color: #ececec;
        }
        .close{
            border:none;
            background-color: skyblue;
            width:100px;
            height:35px;
            line-height: 35px;
            font-size: 18px;
            color:white;
            border-radius: 8px;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/scan/grid.js"></script>
    <script type="text/javascript" src="../js/scan/version.js"></script>
    <script type="text/javascript" src="../js/scan/detector.js"></script>
    <script type="text/javascript" src="../js/scan/formatinf.js"></script>
    <script type="text/javascript" src="../js/scan/errorlevel.js"></script>
    <script type="text/javascript" src="../js/scan/bitmat.js"></script>
    <script type="text/javascript" src="../js/scan/datablock.js"></script>
    <script type="text/javascript" src="../js/scan/bmparser.js"></script>
    <script type="text/javascript" src="../js/scan/datamask.js"></script>
    <script type="text/javascript" src="../js/scan/rsdecoder.js"></script>
    <script type="text/javascript" src="../js/scan/gf256poly.js"></script>
    <script type="text/javascript" src="../js/scan/gf256.js"></script>
    <script type="text/javascript" src="../js/scan/decoder.js"></script>
    <script type="text/javascript" src="../js/scan/qrcode.js"></script>
    <script type="text/javascript" src="../js/scan/findpat.js"></script>
    <script type="text/javascript" src="../js/scan/alignpat.js"></script>
    <script type="text/javascript" src="../js/scan/databr.js"></script>
    <script type="text/javascript" src="../js/scan/webcam.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var num=0;
            //当前选择label字体颜色变蓝
            $("label:eq(1)").css("color","steelblue");

            $("#infoscan").bind("click",function(){
                $(".double-bounce1").show();
                $(".double-bounce2").show();
                load();
                // if(num>2){
                //     alert("请扫描药品编号");
                //     num=0;
                // }else {
                //     $(".double-bounce1").show();
                //     $(".double-bounce2").show();
                //     load();
                //     num++;
                // }
            });
            $(".close").bind("click",function(){
                $(".result").hide();
            });
            $("#sub").bind("click",function(){
                insert()
            })

        });
    </script>
</head>
<body bgcolor="#f5f5f5">
    <jsp:include page="aside.jsp"></jsp:include>
    <div class="scan">
        <!-- 扫码区域 -->
        <div  id="scandiv"  class="scanning_frame">
            <div id="outdiv">
                <video id="v" autoplay></video>
                <canvas id="qr-canvas"></canvas>
            </div>
            <!--加载动画-->
            <div class="spinner" id="loading">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
        <div class="bt">
            <button class="infor" id="sub">提交数据</button>
            <button class="infor" id="infoscan">扫一扫</button>
        </div>

        <!-- 展示扫码结果 -->
        <div class="result" id="medicine">
            <table>
                <tr>
                    <td>药品名称：</td>
                    <td>
                        <input type="text" name="me_name" id="me_name">
                    </td>
                </tr>
                <tr>
                    <td>药品编号：</td>
                    <td>
                        <input type="text" name="me_code" id="me_code" size="40" style="font-size:18px">
                    </td>
                </tr>
                <tr>
                    <td>生产厂商：</td>
                    <td>
                        <input type="text" name="me_conpany" id="me_conpany">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <button class="close">确定</button>
                    </td>
                </tr>
            </table>
        </div>
        <div class="result" id="user" >
            <table>
                <tr>
                    <td>姓名：</td>
                    <td>
                        <input type="text" name="user_name" id="user_name">
                    </td>
                </tr>
                <tr>
                    <td>性别：</td>
                    <td>
                        <input type="text" name="user_sex" id="user_sex">
                    </td>
                </tr>
                <tr>
                    <td>身份证号：</td>
                    <td>
                        <input type="text" name="user_card" id="user_card">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <button class="close">确定</button>
                    </td>
                </tr>
            </table>
        </div>

    </div>
</body>
</html>
