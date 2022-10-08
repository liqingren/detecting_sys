<%--
  Created by IntelliJ IDEA.
  User: 86158
  Date: 2022/9/29
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
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
        .result{
            width:70%;
            height:600px;
            background-color: white;
            position: absolute;
            top:130px;
            left:230px;
        }
        .search{
            float: right;
            margin:30px 5% 0 0;
        }
        table{
            width:90%;
            /*height:500px;*/
            overflow: scroll;
            margin:0 auto;
            position: relative;
            top:40px;
            border-color: #ececec;
        }
        tr{
            line-height:30px;
        }
        td{
            text-align: center;
        }
        .page{
            position: relative;
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
            margin-left: -35px;
        }
        .one{
            margin-left: 15px;
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
        #search{
            width:200px;
            height:30px;
            font-size: 16px;
        }
        #bt{
            width:60px;
            height:30px;
            font-size: 16px;
            border:none;
            background-color: skyblue;
            color:white;
            margin-left:-4.5px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        //获取地址栏参数
        function getUrlParam(name) {
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r!=null) {
                return unescape(r[2]);
            }
            return null; //返回参数值
        }
        //获取当前页数
        var pageNum=getUrlParam("pageNum");
        //获取搜索关键字
        var result=getUrlParam("keyword");
        var keyword = null;
        if(result!=null){
            var urlinfo = window.location.href;//获取url
            var resultstate = urlinfo.split("?")[1].split("=")[1];//拆分url得到"="后面的参数
            //解码
            keyword = decodeURI(resultstate);
        }
        //点击返回，跳转用户页面
        $(document).ready(function(){
            $(".return").bind("click",function(){
                window.location.href="user.jsp";
            });
        });
        $(document).ready(function(){
            var user=JSON.parse(sessionStorage.getItem("user"));
            $("#username").text(user.name);
            $("#card").text(user.card);
            var id=user.id;
            $.ajax({
                url: "http://127.0.0.1:8222/detectinq/users/getuserresult",
                type: "post",
                data: {
                    "id": id,
                    "pageNum":pageNum,
                    "keyword":keyword
                },
                success: function (data) {
                    var result=data.data.result;
                    var list = result.list;
                    for (var i = 0; i < list.length; i++) {
                        var str = "<tr><td>" + list[i].createTime + "</td><td>" + list[i].resultTime + "</td><td>" +
                            list[i].resultstate + "</td><tr>";
                        $("#tbody").append(str);
                    }
                    //当前页数
                    var pageNum=result.pageNum;
                    //总页数
                    var totalPages=result.pages;
                    //总记录数
                    var total=result.total;
                    //判断是否有上一页
                    var preflag=result.hasPreviousPage;
                    //上一页
                    var prePgae=result.prePage;
                    //下一页
                    var nextPage=result.nextPage;
                    //页号数组
                    var pageNums=result.navigatepageNums
                    //判断是否有下一页
                    var nextflag=result.hasNextPage;
                    //赋值
                    $("#pageNum").text(pageNum);
                    $("#totalPages").text(totalPages);
                    $("#total").text(total);
                    //显示页号
                    for(var i=0;i<pageNums.length;i++){
                        var hrefNum='userresult.jsp?pageNum='+pageNums[i];
                        var str="<li><a href='userresult.jsp?pageNum="+pageNums[i]+"'>"+pageNums[i]+"</a></a></li>";
                        $(".pdiv").append(str);
                    }
                    //如果没有上一页，则不显示首页和上一页
                    if(preflag){
                        $(".first").show();
                        $(".prePage").show();
                        $(".prePage").attr("href","userresult.jsp?pageNum="+prePgae);
                    }else{
                        $(".first").hide();
                        $(".prePage").hide();
                    }
                    //如果没有下一页，则不显示尾页和下一页
                    if(nextflag){
                        $(".last").show();
                        $(".last").attr("href","userresult.jsp?pageNum="+totalPages);
                        $(".next").show();
                        $(".next").attr("href","userresult.jsp?pageNum="+nextPage);
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
        //搜索
        $(document).ready(function(){
            $("#bt").bind("click",function(){
                var result=$("[name='keyword']").val();
                //转编码跳转页面
                window.location.href=encodeURI("userresult.jsp?keyword="+result);
            });
        });
    </script>
</head>
<body bgcolor="#f5f5f5">
    <div class="header">
        <h2>核酸检测系统</h2>
    </div>
    <div class="aside">

        <div class="list-user">
            <span>用户名：</span>
            <span id="username"></span>
            <br/>
            <span>身份证号：</span>
            <span id="card"></span>
        </div>
        <div class="list">
            <label style="color:steelblue">核酸结果</label>
        </div>
        <div class="list">
            <label class="return">返回</label>
        </div>
    </div>
    <div class="result">
        <div class="search">
            <input type="text" name="keyword" id="search" placeholder="根据结果查询">
            <button id="bt">查询</button>
        </div>
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

        <!--分页-->
        <div class="page">
            <div class="page one">
                当前第<span id="pageNum"></span> 页，
                共<span id="totalPages"></span> 页，
                <span id="total"></span>条记录
            </div>
            <ul class="page current" id="page_ul" style="list-style: none">
                <li class="previous"}><!--hasPreviousPage默认值为false， 如果有上一页，则不显示首页-->
                    <a class="first" href="userresult.jsp?pageNum=1">首页</a>
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
