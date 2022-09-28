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
    <title>Title</title>
    <style type="text/css">
        ul{
            display:none;
        }
        .list-lable{
            width:130px;
            /*height:30px;*/
            line-height: 30px;
            text-align: left;
            padding-left:10px;
            color:white ;
            position: relative;
            top:150px;
            left:40px;
            border:0.1px solid darkgreen;
            background-color: #309000;
        }
        label{
            cursor: pointer;
        }
        ul{
            margin-left:-15px;
        }
        li{
            width:90px;
            font-size: 14px;
            cursor: pointer;
        }

    </style>
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>

</head>
<body>

    <div>
        <div id="u1" class="list-lable">
            <label>后台管理</label>
            <ul>
                <li>用户管理</li>
                <li>角色管理</li>
                <li>权限管理</li>
                <li>商品管理</li>
                <li>商品套餐管理</li>
                <li>基础信息</li>
                <li>数据字典</li>
            </ul>
        </div>
        <div id="u2" class="list-lable">
            <label>会员管理</label>
            <ul>
                <li>注册新会员</li>
                <li>新会员管理</li>
                <li>修改本人资料</li>
                <li>修改本人密码</li>
            </ul>
        </div>
        <div id="u3" class="list-lable">
            <label>电子银行</label>
            <ul>
                <li>汇款充值</li>
                <li>基本账户</li>
                <li>消费账户</li>
                <li>内部转账</li>
                <li>申请提现</li>
                <li>提现明细</li>
            </ul>
        </div>
        <div id="u4" class="list-lable">
            <label>购物管理</label>
            <ul>
                <li>报单购货</li>
                <li>确认激活</li>
                <li>重消购货</li>
                <li>辅消购货</li>
                <li>购货管理</li>
            </ul>
        </div>
        <div id="u5" class="list-lable">
            <label>信息查询</label>
            <ul>
                <li>奖励查询</li>
                <li>推荐查询</li>
                <li>区域查询</li>
                <li>操作须知</li>
            </ul>
        </div>
        <div id="u6" class="list-lable">
            <label>资讯管理</label>
            <ul>
                <li>公告管理</li>
                <li>资讯管理</li>
                <li>下载中心</li>
                <li>留言管理</li>
            </ul>
        </div>
    </div>
</body>
</html>
