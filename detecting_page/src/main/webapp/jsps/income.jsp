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
        .search{
            float: right;
            margin:30px 5% 0 0;
        }
        .all{
            float: left;
            margin:30px 0 0 5%;
        }
        table{
            width:90%;
            /*height:500px;*/
            overflow: scroll;
            margin:0 auto;
            position: relative;
            top:30px;
            border-color: #ececec;
        }
        tr{
            line-height:40px;
        }
        td{
            text-align: center;
        }
        .bt_enter{
            width:60px;
            height:30px;
            border:none;
            background-color: skyblue;
            color:white;
            margin-right:8px;
            font-size: 18px;
            border-radius: 3px;
            cursor: pointer;
        }
        .bt_failed{
            width:80px;
            height:30px;
            border:none;
            background-color: orangered;
            color:white;
            font-size: 18px;
            border-radius: 3px;
            cursor: pointer;
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
        //修改单个用户的核酸结果
        function modifyOneResult(id,resultstate){
            $.ajax({
                url:"http://192.168.190.111:8222/detecthos/result/meresult/modify",
                type:"post",
                data:{
                    "id":id,
                    "resultstate":resultstate
                },
                success:function(data){
                    console.log(data);
                    window.location.href="income.jsp";
                }
            });
        }
        //修改全部用户的核酸结果
        function modifyAllResult(idArray,resultstate){
            $.ajax({
                url:"http://192.168.190.111:8222/detecthos/result/meresult/modifyAll",
                type:"post",
                data:{
                    "idArray":idArray.toString(),
                    "resultstate":resultstate
                },
                success:function(data){
                    console.log(data);
                    window.location.href="income.jsp";
                }
            });
        }
        //选中多选框
        function getCheckbox(){
            //单选
            $(".choice").bind("change",function(){
                var flag = $(".choice").is(":checked");
                if(flag){
                    //获取被选中的id
                    var id = $(this).val();
                    var resultstate = null;
                    //通过
                    $(".bt_enter").bind("click",function(){
                        resultstate = '阴性';
                        console.log(resultstate);
                        modifyOneResult(id,resultstate);
                    });
                    //不通过
                    $(".bt_failed").bind("click",function(){
                        resultstate = '阳性';
                        modifyOneResult(id,resultstate);
                    });
                }
            });
            //多选
            $("[name='all']").bind("change",function(){
                var flag = $("[name='all']").is(":checked");
                //全选
                if(flag) {
                    $(".choice").prop("checked",flag);
                    var idArray =new Array();//定义一个数组
                    $(".choice:checked").each(function(){//遍历每一个名字为nodes的复选框，其中选中的执行函数
                        idArray.push($(this).val());//将选中的值添加到数组chk_value中
                    });
                    console.log(idArray);
                    var resultstate = null;
                    //通过
                    $(".bt_enter").bind("click",function(){
                        resultstate = '阴性';
                        modifyAllResult(idArray,resultstate);
                    });
                    //不通过
                    $(".bt_failed").bind("click",function(){
                        resultstate = '阳性';
                        modifyAllResult(idArray,resultstate);
                    });
                }
                //取消全选
                else if(!flag){
                    $(".choice").prop("checked",flag);
                }
            })
        }
        //将用户基本信息和结果信息写入表格，并做分页处理
        function getPage(list,result){
            for(var i=0;i<list.length;i++){
                var sex=null;
                if(list[i].sex===true){
                    sex='男';
                }else{
                    sex='女';
                }
                var str = "<tr><td><input type='checkbox' class='choice' value='"+list[i].id+"'></td><td>"+
                    list[i].name+"</td><td>" +list[i].card+"</td><td>"+sex+"</td><td class='ctime'>"+list[i].createTime+
                    "</td><td><button class='bt_enter'>通过</button><button class='bt_failed'>不通过</button>";
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
                var hrefNum='income.jsp?pageNum='+pageNums[i];
                var str="<li><a href='income.jsp?pageNum="+pageNums[i]+"'>"+pageNums[i]+"</a></a></li>";
                $(".pdiv").append(str);
            }
            //如果没有上一页，则不显示首页和上一页
            if(preflag){
                $(".first").show();
                $(".prePage").show();
                $(".prePage").attr("href","income.jsp?pageNum="+prePgae);
            }else{
                $(".first").hide();
                $(".prePage").hide();
            }
            //如果没有下一页，则不显示尾页和下一页
            if(nextflag){
                $(".last").show();
                $(".last").attr("href","income.jsp?pageNum="+totalPages);
                $(".next").show();
                $(".next").attr("href","income.jsp?pageNum="+nextPage);
            }else{
                $(".last").hide();
                $(".next").hide();
            }
            if(pageNums.length<=1){
                $("#page_ul").hide();
            }
            //选中多选框修改核酸结果
            getCheckbox();

        }

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
        var str=getUrlParam("keyword");
        var keyword = null;
        if(str!=null){
            var urlinfo = window.location.href;//获取url
            var resultstate = urlinfo.split("?")[1].split("=")[1];//拆分url得到"="后面的参数
            //解码
            keyword = decodeURI(resultstate);
            // alert(keyword);
        }
        $(document).ready(function(){
            //当前选择label字体颜色变蓝
            $("label:eq(2)").css("color","steelblue");
        });
        $(document).ready(function(){
            $.ajax({
                url:"http://192.168.190.111:8222/detecthos/result/meresult/getresults",
                type:"post",
                data:{
                    "pageNum":pageNum,
                    "keyword":keyword
                },
                success:function(data){
                    console.log(data.data.userresult);
                    var result = data.data.userresult;
                    var list = result.list;
                    getPage(list,result);
                }
            });
        });
        //搜索
        $(document).ready(function(){
            $("#bt").bind("click",function() {
                var name = $("[name='keyword']").val();
                //转编码跳转页面
                window.location.href = encodeURI("income.jsp?keyword=" + name);
            });
        });
                // $(".sel").bind("change",function(){
                // var choice = $(".sel option:selected").val();
                // $("#bt").bind("click",function(){
                //     if(choice==1) {
                //         var name = $("[name='keyword']").val();
                //         //转编码跳转页面
                //         window.location.href = encodeURI("income.jsp?keyword=" + name);
                //     }
                //     else if(choice==2){
                //         var sex = $("[name='keyword']").val();
                //         var keyword=null;
                //         if(sex=="男"){
                //             keyword=true;
                //         }else{
                //             keyword=false;
                //         }
                //         $.ajax({
                //             url:"http://127.0.0.1:8006/detecthos/result/getsex",
                //             type:"post",
                //             data:{
                //                 "pageNum":pageNum,
                //                 "keyword":keyword
                //             },
                //             success:function(data){
                //                 var result = data.data.sexResults;
                //                 var list = result.list;
                //                 getPage(list,result);
                //             }
                //         });
                //     }
                //     else if(choice==3){
                //         var keyword = $("[name='keyword']").val();
                //         $.ajax({
                //             url:"http://127.0.0.1:8006/detecthos/result/getcard",
                //             type:"post",
                //             data:{
                //                 "pageNum":pageNum,
                //                 "keyword":keyword
                //             },
                //             success:function(data){
                //                 var result = data.data.cardResults;
                //                 console.log(result);
                //                 var list = result.list;
                //                 getPage(list,result);
                //             }
                //         });
                //     }
                // });
            // })
        // });
        // $(document).ready(function(){
        //     $(".choice").bind("click",function(){
        //         alert(1);
        //         var flag = $(".choice").is(":checked");
        //         alert(flag);
        //     })
        // })
    </script>
</head>
<body bgcolor="#f5f5f5">
    <jsp:include page="aside.jsp"></jsp:include>
    <div class="income">
        <div class="search">
<%--            <select class="sel" style="width:150px;height:30px;text-align: center;font-size: 14px;">--%>
<%--                <option>--请选择--</option>--%>
<%--                <option value="1">根据姓名查询</option>--%>
<%--                <option value="2">根据性别查询</option>--%>
<%--                <option value="3">根据身份证号查询</option>--%>
<%--            </select>--%>
            <input type="text" name="keyword" id="search" placeholder="根据姓名查询">
            <button id="bt">查询</button>
        </div>
        <div class="all">
            <input type="checkbox" name="all">全选
            <button class="bt_enter" style="margin:0 20px 0 20px ">通过</button>
            <button class="bt_failed">不通过</button>
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

        <!--分页-->
        <div class="page">
            <div class="page one">
                当前第<span id="pageNum"></span> 页，
                共<span id="totalPages"></span> 页，
                <span id="total"></span>条记录
            </div>
            <ul class="page current" id="page_ul" style="list-style: none">
                <li class="previous"}><!--hasPreviousPage默认值为false， 如果有上一页，则不显示首页-->
                    <a class="first" href="income.jsp?pageNum=1">首页</a>
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
