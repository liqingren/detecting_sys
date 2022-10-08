<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员查询</title>
    <meta charset="utf-8">
    <style type="text/css">
        .admin{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
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
        .page{
            /*position: absolute;*/
            float: bottom;
            margin-top:20px;
            top:40px;
            left:20px;
        }
        .page .current{
            width: 600px;
            text-align: center;
        }
        ul::after{
            content:"";
            display:block;
            height:0;
            clear:both;
            visibility:hidden;
        }
        ul{
            margin-left: 20px;
            margin-top: 10px;
        }
        .one{
            margin-top:10px;
            margin-left: 25px;
        }
        ul a{
            text-decoration: none;
            display: inline-block;
            width: 50px;
            height: 30px;
            line-height: 30px;
            text-align: center;

        }
        ul li{
            float: left;
            background: #ffc0cb;
            list-style: none;
            margin: 10px;
            border-radius: 10px;
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
        textarea {
            width: 300px;
            height: 130px;
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
            height:140px;
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
        .keyword{
            border: 1px solid #ccc;
            padding: 3px 0px;
            border-radius: 3px;
            padding-left:5px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
        }
        .keyword:focus{
            border-color: #66afe9;
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
        }
        .searchBox{
            border: 1px solid #ccc;
            padding: 3px 0px;
            border-radius: 3px;
            padding-left:5px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
        }
        .searchBox:focus{
            border-color: #66afe9;
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
        }
        .conditionSearch{
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
            padding: 3px 10px;
            text-align: center;
            background-color: skyblue;
            color: white;
            border: 2px solid skyblue;
            border-radius:5px;
        }
        .conditionSearch:focus{
            border-color: #66afe9;
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
        }




    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../js/admin.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            //当前选择label字体颜色变蓝
            $("label:eq(4)").css("color","steelblue");
        });
        //获取地址栏参数
        function getUrlParam(key) {
            // 获取参数
            var url = window.location.search;
            // 正则筛选地址栏
            var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
            // 匹配目标参数
            var result = url.substr(1).match(reg);
            //返回参数值
            return result ? decodeURIComponent(result[2]) : null;
        }
        //获取当前页数
        var pageNum_u=getUrlParam("pageNum");
        var condition_u=getUrlParam("condition");
        var startTime_u=getUrlParam("startTime");
        var endTime_u=getUrlParam("endTime");
        var resultState_u=getUrlParam("resultState");
        var done_u=getUrlParam("done");
        var preDone_u=getUrlParam("preDone");
        var oldDone_u=getUrlParam("oldDone");
        var resultStateMsg_u=getUrlParam("resultStateMsg");

        //页面初始化
        $(document).ready(function() {
            $("#conditionSearchVal").val(condition_u);
            $("#startTime").val(startTime_u);
            $("#endTime").val(endTime_u);
            $("#resultState").val(resultStateMsg_u);
            $("#done").val(oldDone_u);
            $.ajax({
                url:"http://127.0.0.1:8001/detectinq/result/adminConditionSearch",
                type:"POST",
                xhrFields: {
                    withCredentials: true
                },
                crossDomain: true,
                data:{
                    "condition":condition_u,
                    "startTime":startTime_u,
                    "endTime":endTime_u,
                    "resultState":resultState_u,
                    "done":done_u,
                    "preDone":preDone_u,
                    "pageNum":pageNum_u
                },
                error: function () {
                    alert("请重试！");
                },
                success:function(data){
                    var resultList=data.data.resultList;
                    var list=resultList.list;
                    for (var i = 0; i < list.length; i++) {
                        var str = "<tr id=\"hiddenResult"+i+"\"\><td><input type=\"checkbox\" name=\"modify_del\" value='12' onclick='checkOne()'>"+
                            "</td><td>" + list[i].name +
                            "</td><td>" + list[i].card +
                            "</td><td>" + list[i].sex +
                            "</td><td>" + list[i].createTime +
                            "</td><td>" + list[i].resultTime +
                            "</td><td>" + list[i].resultstate +
                            "</td><td><button class=\"adminResultDel\" onclick='deleteResult(this)' id=\"deleteButton"+i+"\">"+"删除</button></td></tr>";
                        $("#tbody").append(str);
                    }
                    var condition=$("#conditionSearchVal").val();
                    var startTime=$("#startTime").val();
                    if(startTime.indexOf('T') != -1){
                        startTime += ':00'
                        startTime = startTime.replace('T',' ')
                        $("#startTime").val(startTime)
                    };
                    var endTime=$("#endTime").val();
                    if(endTime.indexOf('T') != -1){
                        endTime += ':00'
                        endTime = endTime.replace('T',' ')
                        $("#endTime").val(endTime)
                    };
                    var resultState=$("#resultState").val();
                    var resultStateMsg=resultState;
                    if(resultState=="全部"){
                        resultState="";
                    }
                    //处理查询超时未做的用户
                    var date=new Date();
                    var oldDone=$("#done").val();
                    var done=$("#done").val();
                    var preDone=$("#done").val();
                    if(oldDone=="近一天未做"){
                        done = new Date(date.getTime() - 24*60*60*1000);
                        preDone = new Date(date.getTime() - 2*24*60*60*1000);
                        done=formatTime(done);
                        preDone=formatTime(preDone);
                    }else if(oldDone=="近两天未做"){
                        done = new Date(date.getTime() - 2*24*60*60*1000);
                        preDone = new Date(date.getTime() - 3*24*60*60*1000);
                        done=formatTime(done);
                        preDone=formatTime(preDone);
                    }else if(oldDone=="近三天未做"){
                        done = new Date(date.getTime() - 3*24*60*60*1000);
                        preDone = new Date(date.getTime() - 365*24*60*60*1000);
                        done=formatTime(done);
                        preDone=formatTime(preDone);
                    }
                    //当前页数
                    var pageNum=resultList.pageNum;
                    //总页数
                    var totalPages=resultList.pages;
                    //总记录数
                    var total=resultList.total;
                    //判断是否有上一页
                    var preflag=resultList.hasPreviousPage;
                    //上一页
                    var prePgae=resultList.prePage;
                    //下一页
                    var nextPage=resultList.nextPage;
                    //页号数组
                    var pageNums=resultList.navigatepageNums
                    //判断是否有下一页
                    var nextflag=resultList.hasNextPage;
                    //赋值
                    $("#pageNum").text(pageNum);
                    $("#totalPages").text(totalPages);
                    $("#total").text(total);
                    //显示页号
                    for(var i=0;i<pageNums.length;i++){
                        var hrefNum='admin.jsp?pageNum='+pageNums[i];
                        var str="<li><a href='admin.jsp?pageNum="+pageNums[i]+"&condition="+condition+"&startTime="+startTime+"&endTime="+endTime+"&resultState="+resultState+"&done="+done+"&preDone="+preDone+"&oldDone="+oldDone+"&resultStateMsg="+resultStateMsg+"'>"+pageNums[i]+"</a></a></li>";
                        $(".pdiv").append(str);
                    }

                    //如果没有上一页，则不显示首页和上一页
                    if(preflag){
                        $(".first").show();
                        $(".first").attr("href","admin.jsp?pageNum="+1+"&condition="+condition+"&startTime="+startTime+"&endTime="+endTime+"&resultState="+resultState+"&done="+done+"&preDone="+preDone+"&oldDone="+oldDone+"&resultStateMsg="+resultStateMsg);
                        $(".prePage").show();
                        $(".prePage").attr("href","admin.jsp?pageNum="+prePgae+"&condition="+condition+"&startTime="+startTime+"&endTime="+endTime+"&resultState="+resultState+"&done="+done+"&preDone="+preDone+"&oldDone="+oldDone+"&resultStateMsg="+resultStateMsg);
                    }else{
                        $(".first").hide();
                        $(".prePage").hide();
                    }
                    //如果没有下一页，则不显示尾页和下一页
                    if(nextflag){
                        $(".last").show();
                        $(".last").attr("href","admin.jsp?pageNum="+totalPages+"&condition="+condition+"&startTime="+startTime+"&endTime="+endTime+"&resultState="+resultState+"&done="+done+"&preDone="+preDone+"&oldDone="+oldDone+"&resultStateMsg="+resultStateMsg);
                        $(".next").show();
                        $(".next").attr("href","admin.jsp?pageNum="+nextPage+"&condition="+condition+"&startTime="+startTime+"&endTime="+endTime+"&resultState="+resultState+"&done="+done+"&preDone="+preDone+"&oldDone="+oldDone+"&resultStateMsg="+resultStateMsg);
                    }else{
                        $(".last").hide();
                        $(".next").hide();
                    }
                    if(pageNums.length<=1){
                        $("#page_ul").hide();
                    }
                }
            });
        });
        function conditionSearch(){
            var condition=$("#conditionSearchVal").val();
            var startTime=$("#startTime").val();
            if(startTime.indexOf('T') != -1){
                startTime += ':00'
                startTime = startTime.replace('T',' ')
                $("#startTime").val(startTime)
            };
            var endTime=$("#endTime").val();
            if(endTime.indexOf('T') != -1){
                endTime += ':00'
                endTime = endTime.replace('T',' ')
                $("#endTime").val(endTime)
            };
            var resultState=$("#resultState").val();
            var resultStateMsg=resultState;
            if(resultState=="全部"){
                resultState="";
            }
            //处理查询超时未做的用户
            var date=new Date();
            var oldDone=$("#done").val();
            var done=$("#done").val();
            var preDone=$("#done").val();
            if(oldDone=="近一天未做"){
                done = new Date(date.getTime() - 24*60*60*1000);
                preDone = new Date(date.getTime() - 2*24*60*60*1000);
                done=formatTime(done);
                preDone=formatTime(preDone);
            }else if(oldDone=="近两天未做"){
                done = new Date(date.getTime() - 2*24*60*60*1000)
                preDone = new Date(date.getTime() - 3*24*60*60*1000)
                done=formatTime(done);
                preDone=formatTime(preDone);
            }else if(oldDone=="近三天未做"){
                done = new Date(date.getTime() - 3*24*60*60*1000)
                preDone = new Date(date.getTime() - 365*24*60*60*1000)
                done=formatTime(done);
                preDone=formatTime(preDone);
            }
            window.location.href=("admin.jsp?condition="+condition+"&startTime="+startTime+"&endTime="+endTime+"&resultState="+resultState+"&done="+done+"&preDone="+preDone+"&oldDone="+oldDone+"&resultStateMsg="+resultStateMsg);
        }
        function InfoDisplay() {
            document.getElementById("form_1").setAttribute('class','form_1 open')

        }
        function InfoHidden() {
            document.getElementById("form_1").setAttribute('class','form_1')
        }
        function areaClean() {
            $("#content").val("");
        }

        function transInfo() {
            var info= $("#content").val();
            var cards=[];
            var uniqueCards=[];
            $("input:checkbox[name='modify_del']").each(function () { //遍历checkbox的选择状态
                if ($(this).prop("checked")) { //如果值为checked表明选中了
                    var card = $(this).closest('tr').find('td').eq(2).text();
                    cards.push(card);
                }
            })
            //查重
            for (var i = 0; i < cards.length; i++) {
                if(uniqueCards.indexOf(cards[i])==-1){
                    uniqueCards.push(cards[i]);
                }
            }

            for (var infoCard in uniqueCards){
                $.ajax({
                    url: " http://127.0.0.1:8001/detectinq/users/websocket/sendToUser",
                    type: "POST",
                    xhrFields: {
                        withCredentials: true
                    },
                    crossDomain: true,
                    data: {
                        "card": uniqueCards[infoCard],
                        "info": info
                    }
                });
            };
        }
    </script>
</head>
<body bgcolor="#f5f5f5">
<jsp:include page="aside.jsp"></jsp:include>
<div class="admin">
    <div class="search">
        <div class="form_1" id="form_1">
            <form >
                <div class="input_1"><div class="login_logo">信息发布</div><div class="close" id="close" onclick="InfoHidden()">X</div></div>
                <hr>
                <div class="input_2"><textarea id="content" onclick="areaClean()">请在这里输入信息</textarea></div>
                <div style="float: right;margin-right: 20px;"><button class="adminResultDel" onclick="transInfo()">发布</button></div>
            </form>
        </div>
        <input type="datetime-local" class="searchBox" id="startTime" onclick="conditionJudge()"/>~
        <input type="datetime-local" class="searchBox" id="endTime" onclick="conditionJudge()"/>
        <select id="resultState" class="searchBox" onclick="conditionJudge()">
            <option></option>
            <option>阳性</option>
            <option>阴性</option>
            <option>全部</option>
        </select>
        <select id="done" class="searchBox" onclick="conditionDue()">
            <option></option>
            <option>近一天未做</option>
            <option>近两天未做</option>
            <option>近三天未做</option>
        </select>
        <input type="text" class="keyword" name="keyword" id="conditionSearchVal" onclick="conditionJudge()">
        <button id="conditionSearch" class="conditionSearch" onclick="conditionSearch()">查询</button>
    </div>
    <table border="1" cellpadding="0" cellspacing="0">
        <thead>
        <tr>
            <th style="width:60px">全选
                <input type="checkbox" id="all"  onclick="checkAll()">
            </th>
            <th>姓名</th>
            <th>身份证号</th>
            <th>性别</th>
            <th>采集时间</th>
            <th>检测时间</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="tbody">

        </tbody>
    </table>
    <!--分页-->
    <div class="page">
        <div style="margin-top:35px; margin-left:25px;float: bottom ">
            <div style="float: left;margin-right: 20px;">
                <button class="adminResultDel" onclick="delResults()" id="deleteButton">批量删除</button>
            </div>
            <div>
                <button class="adminResultDel" name="inFoButton" onclick="InfoDisplay()">发布信息</button>
            </div>

        </div>
        <div class="page one">
            当前第<span id="pageNum"></span> 页，
            共<span id="totalPages"></span> 页，
            <span id="total"></span>条记录
        </div>
        <ul class="page current" id="page_ul" style="list-style: none">
            <li class="previous"}><!--hasPreviousPage默认值为false， 如果有上一页，则不显示首页-->
                <a class="first">首页</a>
            </li>
            <li class="previous"><!--hasPreviousPage默认值为false， 如果有上一页，则不显示-->
                <a class="prePage">上一页</a>
            </li>
            <div class="pdiv">

            </div>
            <li class="nextPage"><!--hasNextPage默认值为false， 如果没有下一页，则不显示-->
                <a class="next">下一页</a>
            </li>
            <li class="lastPage"><!--如果当前页小于总页数则不显示尾页 -->
                <a class="last">尾页</a>
            </li>
        </ul>
    </div>

</div>
</body>
</html>
