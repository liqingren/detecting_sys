
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<html>
<head>
    <title>商品管理</title>
    <meta charset="UTF-8">
    <style type="text/css">
        #goodsmanager{
            margin-left:245px;
            width:640px;
            height:450px;
            position: absolute;
            top:148px;
        }
        .u1{
            width:640px;
            height:50px;
            font-size: 14px;
        }
        .u2{
            width:640px;
            height:50px;
            font-size: 14px;
        }
        .u3>table td{
            height:30px;
        }
        button{
            width:60px;
            background-color: beige;
            border:1px solid green;
            border-radius: 5px;
            margin-right:10px;
            cursor: pointer;
        }
        button:hover{
            background-color: #309000;
        }
        .u3>table tr{
            height:30px;
        }
        .u5{
            width:550px;
            height:500px;
            border:1px solid black;
            display:none;
            position: absolute;
            top:50px;
            left:20px;
            z-index:999;
            background-color: white;
        }
        .u5>table td{
            padding-left:20px;
        }
        span{
            color:red;
        }
        #goods-show>table td{
            line-height:30px;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/Goodsjs.js"></script>
    <script type="text/javascript" src="../../js/Jumpjs.js"></script>
    <script type="text/javascript">
        //点击单选框时获取当前的goodsSN,并获取商品信息
        function getGoodsSN(){
            //获取当前被选中的按钮下标
            var index =$("[name='choose']").index();
            //获取当前选中按钮的商品编号
            var goodsSNNode=$(".goodsSN");
            var goodsSN=goodsSNNode[index].innerText;
            //当单选框被改变时获取下标
            $("[name='choose']").bind("click",function(){
                index =$("[name='choose']").index(this);
                //获取当前选中按钮的商品编号
                goodsSN=goodsSNNode[index].innerText;
                ajaxGoods(goodsSN);
            });
            return goodsSN;
        }
        $(document).ready(function(){
            //初始化实现页面跳转
            initJump();
            //初始化显示隐藏增加，修改，查看框
            init();
        });
        //新增
        $(document).ready(function(){
            var goodsSN=null;
            $("[name='goodsSN']").bind("blur",function(){
                //获取商品编号
                goodsSN=$("[name='goodsSN']").val();
                //验证商品编号唯一性
                getGoodsSNOnly(goodsSN);
            });
            //点击保存按钮
            $("#save1").bind("click",function(){
                var goodsName=$("[name='goodsName']").val();
                var marketPrice=$("[name='marketPrice']").val();
                var realPrice=$("[name='realPrice']").val();
                var num=$("[name='num']").val();
                var unit=$("[name='unit']").val();
                var goodsFormat=$("[name='goodsFormat']").val();
                var note=$("[name='note']").val();
                var flag=$("[name='state1']").prop("checked");
                var stateTemp=null;
                var state=1;//上架状态为1
                if(flag){
                    stateTemp=$("[name='state1']").val();
                }
                else{
                    stateTemp=$("[name='state1']").next().val();
                    state=2;//下架状态为2
                }
                var createTime = new Date();
                var createdBy='${auUser.loginCode}';
                //json格式传输商品信息
                var goodsInfo={"goodsSN":goodsSN,"goodsName":goodsName,"goodsFormat":goodsFormat, "marketPrice":marketPrice,
                    "realPrice":realPrice,"state":state,"note":note, "num":num,"unit":unit,"createTime":createTime,
                    "lastUpdateTime":null,"createdBy":createdBy};
                insertGoodsInfo(goodsInfo);
            });
        });
        //点击修改时显示当前被选中单选框的商品信息
        $(document).ready(function(){
            var goodsSN=getGoodsSN();
            //获取被选中单选框的所有信息，并将其显示在修改框
            var flag= $("[name='choose']").prop("checked");
            if(flag) {
                //获取商品信息
                ajaxGoods(goodsSN);
            }
        });
        //修改
        $(document).ready(function(){
            $("[name='goodsSN1']").bind("blur",function(){
                var goodsSN=$("[name='goodsSN1']").val();
                //验证商品编号唯一性
                getGoodsSNOnly(goodsSN);
            });
            $("#save2").bind("click",function(){
                //获取其他信息
                var goodsSN=$("[name='goodsSN1']").val();
                var goodsName=$("[name='goodsName1']").val();
                var marketPrice=$("[name='marketPrice1']").val();
                var realPrice=$("[name='realPrice1']").val();
                var num=$("[name='num1']").val();
                var unit=$("[name='unit1']").val();
                var goodsFormat=$("[name='goodsFormat1']").val();
                var note=$("[name='note1']").val();
                var flag=$("[name='state2']").prop("checked");
                var stateTemp=null;
                var state=1;//上架状态为1
                if(flag){
                    stateTemp=$("[name='state2']").val();
                }
                else{
                    stateTemp=$("[name='state2']").next().val();
                    state=2;//下架状态为2
                }
                var createTime=$("[name='createTime1']").val();
                var id =$("[name='id']").val();
                var lastUpdateTime = new Date();
                var createdBy='${auUser.loginCode}';
                //json格式传输商品信息
                var goodsInfo={"id":id,"goodsSN":goodsSN,"goodsName":goodsName,"goodsFormat":goodsFormat, "marketPrice":marketPrice,
                    "realPrice":realPrice,"state":state,"note":note, "num":num,"unit":unit,"createTime":createTime,
                    "lastUpdateTime":lastUpdateTime,"createdBy":createdBy};
                //修改商品信息
                updateGoodsInfo(goodsInfo);
            });
        });
        //删除
        $(document).ready(function(){
            //获取当前被选中的按钮下标
            var index =$("[name='choose']").index();
            //获取当前选中按钮的商品编号
            var goodsSNNode=$(".goodsSN");
            var goodsSN=goodsSNNode[index].innerText;
            //当单选框被改变时获取下标
            $("[name='choose']").bind("click",function(){
                index =$("[name='choose']").index(this);
                //获取当前选中按钮的商品编号
                goodsSN=goodsSNNode[index].innerText;
            });
            $("#det").bind("click",function(){
                //删除商品
                deleteGoodsInfo(goodsSN);
            });
        });
        //修改商品状态
        $(document).ready(function(){
            $("[type='checkbox']").bind("click",function(){
                var chechkNode=$("[type='checkbox']");
                //获取当前点击多选框的下标
                var index=$("[type='checkbox']").index(this);
                //获取当前商品的id
                var idNode=$("[class='id']");
                var id=idNode[index].innerText;
                //获取当前goodsSN
                var goodsSNNode=$(".goodsSN");
                var goodsSN=goodsSNNode[index].innerText;
                //获取多选框的值
                var flag = chechkNode[index].checked;
                var state=null;
                if(flag){
                    state=1;
                }else{
                    state=2;
                }
                var lastUpdateTime=new Date();
                var goodsInfo={"id":id,"goodsSN":goodsSN,"state":state,"lastUpdateTime":lastUpdateTime};
                $.ajax({
                    url:"/ssm/goodsinfo/updatestate",
                    type:"post",
                    data:JSON.stringify(goodsInfo),
                    success:function(data){
                        if(data===true){
                            alert("状态修改成功");
                            window.location.href="/ssm/goodsinfo/goodsjsp";
                        }else{
                            alert("状态修改失败");
                        }
                    },
                    contentType:"application/json",
                    complete : function(xhr, status) {
                        //拦截器拦截没有权限跳转
                        // 通过xhr取得响应头
                        var REDIRECT = xhr.getResponseHeader("REDIRECT");
                        //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                        if (REDIRECT == "REDIRECT")
                        {
                            document.location.href = xhr.getResponseHeader("CONTEXTPATH");
                        }
                    }
                });
            });
        });
        //查询
        $(document).ready(function(){
            var keyword=null;
            $("[name='keyword']").bind("blur",function () {
                keyword= $("[name='keyword']").val();
            });
            $("#sel").bind("click",function(){
                $.ajax({
                    url:"/ssm/goodsinfo/goodsjsp",
                    type:"post",
                    data:{
                        "keyword":keyword
                    },
                    success:function(data){
                        window.location="/ssm/goodsinfo/goodsmanager";
                    },
                    complete : function(xhr, status) {
                        //拦截器拦截没有权限跳转
                        // 通过xhr取得响应头
                        var REDIRECT = xhr.getResponseHeader("REDIRECT");
                        //如果响应头中包含 REDIRECT 则说明是拦截器返回的
                        if (REDIRECT == "REDIRECT")
                        {
                            document.location.href = xhr.getResponseHeader("CONTEXTPATH");
                        }
                    }
                });
            });


        });

    </script>
</head>
<body style="background-image:url('../../image/bg.jpg');background-repeat: no-repeat">
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="bleft.jsp"></jsp:include>
    <div id="goodsmanager">
        <div class="u1">
            <p style="float:left;margin-left:20px;">商品管理</p>
        </div>
        <div class="u2">
            <button id="add">新增</button>
            <button id="upd">修改</button>
            <button id="det">删除</button>
            <button id="show">查看</button>
            <input type="text" name="keyword" placeholder="请输入关键字" style="margin-left:90px;">
            <button id="sel">查询</button>
        </div>
        <div class="u3">
            <table border="1" cellpadding="0" cellspacing="0" style="width:630px;text-align:center;font-size:14px;">
                <tr>
                    <th>选择</th>
                    <th>商品名称</th>
                    <th>市场价(元)</th>
                    <th>优惠价(元)</th>
                    <th>库存</th>
                    <th>状态(上架/下架)</th>
                    <th>最后修改时间</th>
                </tr>

                <c:forEach var="goods" items="${goodsList}">
                    <span class="id" style="display:none">${goods.id}</span>
                    <span class="goodsSN" style="display: none">${goods.goodsSN}</span>
                    <tr>
                        <td>
                            <input type="radio" name="choose">
                        </td>
                        <td>${goods.goodsName}</td>
                        <td>${goods.marketPrice}</td>
                        <td>${goods.realPrice}</td>
                        <td>${goods.num}</td>
                        <td>
                            <c:choose>
                                <c:when test="${goods.state eq 1}">
                                    <input type="checkbox" checked="checked">
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${goods.lastUpdateTime}</td>

                    </tr>
                </c:forEach>

            </table>
        </div>
        <div class="u4">
            <p style="color:red;font-size: 14px">注：状态上下架，打勾表示上架可出售，且立即生效</p>
        </div>
        <div class="u5" id="goods-add">
            <img src="../../image/rolemanager/u126.png" style="margin:0 5px -3px 10px;width:18px;height:18px;">
            <span style="font-size: 14px;color:black">添加商品</span>
            <button id="quit1" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
            <hr/>
            <table >
                <tr>
                    <td>商品名称：</td>
                    <td>
                        <input type="text" name="goodsName" >
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>商品编号：</td>
                    <td>
                        <input type="text"  name="goodsSN">
                        <span name="msg" style="color:red;display:none;"></span>
                        <span>* 注：验证编码唯一性</span>
                    </td>
                </tr>
                <tr>
                    <td >市场价：</td>
                    <td>
                        <input type="text" name="marketPrice">
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>优惠价：</td>
                    <td>
                        <input type="text" name="realPrice">
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>库存：</td>
                    <td>
                        <input type="text" name="num">
                        <span>*</span>
                    </td>

                </tr>
                <tr>
                    <td>单位：</td>
                    <td>
                        <input type="text" name="unit">
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>状态：</td>
                    <td>
                        <input type="radio" name="state1" checked="checked" value="上架">上架
                        <input type="radio" name="state1" value="下架">下架
                    </td>
                </tr>
                <tr>
                    <td>商品规格：</td>
                    <td>
                        <textarea cols="50" rows="5" name="goodsFormat"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>商品说明：</td>
                    <td>
                        <textarea cols="50" rows="5" name="note"></textarea>
                    </td>
                </tr>
            </table>
            <div style="margin:30px 0 0 100px">
                <button id="save1">保存</button>
                <button id="close1" style="margin-left:100px">关闭</button>
            </div>
        </div>
        <div class="u5" id="goods-upd">
            <img src="../../image/rolemanager/u278.png" style="margin:0 5px -3px 10px;width:18px;height:18px;">
            <span style="font-size: 14px;color:black">修改商品</span>
            <button id="quit2" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
            <hr/>
            <input type="text" name="id" style="display:none">
            <input type="text" name="createdTime1" style="display:none">
            <table >
                <tr>
                    <td>商品名称：</td>
                    <td>
                        <input type="text" name="goodsName1" >
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>商品编号：</td>
                    <td>
                        <input type="text"  name="goodsSN1">
                        <span name="msg" style="color:red;display:none;"></span>
                        <span>* 注：验证编码唯一性</span>
                    </td>
                </tr>
                <tr>
                    <td >市场价：</td>
                    <td>
                        <input type="text" name="marketPrice1">
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>优惠价：</td>
                    <td>
                        <input type="text" name="realPrice1">
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>库存：</td>
                    <td>
                        <input type="text" name="num1">
                        <span>*</span>
                    </td>

                </tr>
                <tr>
                    <td>单位：</td>
                    <td>
                        <input type="text" name="unit1">
                        <span>*</span>
                    </td>
                </tr>
                <tr>
                    <td>状态：</td>
                    <td>
                        <input type="radio" name="state2" checked="checked" value="上架">上架
                        <input type="radio" name="state2" value="下架">下架
                    </td>
                </tr>
                <tr>
                    <td>商品规格：</td>
                    <td>
                        <textarea cols="50" rows="5" name="goodsFormat1"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>商品说明：</td>
                    <td>
                        <textarea cols="50" rows="5" name="note1"></textarea>
                    </td>
                </tr>
            </table>
            <div style="margin:30px 0 0 100px">
                <button id="save2">保存</button>
                <button id="close2" style="margin-left:100px">关闭</button>
            </div>
        </div>
        <div class="u5" id="goods-show" style="">
            <img src="../../image/rolemanager/u278.png" style="margin:0 5px -3px 10px;width:18px;height:18px;">
            <span style="font-size: 14px;color:black">查看商品</span>
            <button id="quit3" style="color:white;border:none;background-color:red;width:20px;float:right;margin-top:5px;border-radius: 0">×</button>
            <hr/>
            <table >
                <tr>
                    <td>商品名称：</td>
                    <td>
                        <input type="text" name="goodsName1" style="border:none">
                    </td>
                </tr>
                <tr>
                    <td>商品编号：</td>
                    <td>
                        <input type="text"  name="goodsSN1" style="border:none">
                    </td>
                </tr>
                <tr>
                    <td >市场价：</td>
                    <td>
                        <input type="text" name="marketPrice1" style="border:none;color:red">
                    </td>
                </tr>
                <tr>
                    <td >优惠价：</td>
                    <td>
                        <input type="text" name="realPrice1" style="color:red;border:none;">
                    </td>
                </tr>
                <tr>
                    <td>库存：</td>
                    <td>
                        <input type="text" name="num1" style="border:none"></input>
                    </td>

                </tr>
                <tr>
                    <td>单位：</td>
                    <td>
                        <input type="text" name="unit1" style="border:none">
                    </td>
                </tr>
                <tr>
                    <td>状态：</td>
                    <td>
                        <input type="text" name="state" style="border:none">
                    </td>
                </tr>
                <tr>
                    <td >商品规格：</td>
                    <td>
                        <textarea cols="50" rows="3" name="goodsFormat1" style="border:none"></textarea>
                    </td>
                </tr>
                <tr>
                    <td >商品说明：</td>
                    <td>
                        <textarea cols="50" rows="3" name="note1" style="border:none"></textarea>
                    </td>
                </tr>
            </table>
            <hr/>
            <div style="margin:30px 0 0 100px">
                <button id="close3" style="margin-left:100px">关闭</button>
            </div>
        </div>

    </div>

</body>
</html>
