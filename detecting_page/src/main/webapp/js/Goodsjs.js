//初始化
function init(){
    //显示后台管理下的列表
    $("ul:eq(0)").show();
    //将商品管理的字体颜色变黄
    $("ul li:eq(3)").css("color","yellow");
    //默认选中第一个单选框
    $("[type='radio']:first").prop("checked","true");
    //点击新增显示新增商品框
    $("#add ").bind("click",function(){
        $("#goods-add").show();
    });
    //点击关闭或叉掉则隐藏
    $("#close1").bind("click",function(){
        $("#goods-add").hide();
    });
    $("#quit1").bind("click",function(){
        $("#goods-add").hide();
    });
    //点击修改按钮，显示出需要修改商品的信息
    $("#upd").bind("click",function(){
        //显示修改框
        $("#goods-upd").show();
    });
    //点击关闭和叉掉是隐藏修改框
    $("#close2").bind("click",function(){
        $("#goods-upd").hide();
    });
    $("#quit2").bind("click",function(){
        $("#goods-upd").hide();
    })
    //查看按钮
    $("#show").bind("click",function(){
        $("#goods-show").show();
    });
    $("#close3").bind("click",function(){
        $("#goods-show").hide();
    });
    $("#quit3").bind("click",function(){
        $("#goods-show").hide();
    })
}

//验证商品编号唯一性
function getGoodsSNOnly(goodsSN){
    $.ajax({
        url:"/ssm/goodsinfo/only",
        type:"post",
        data:{
            "goodsSN":goodsSN
        },
        success:function(data){
            if(data!==true){
                $("[name='msg']").text("商品编号已存在");
                $("[name='msg']").show();
            } else{
                $("[name='msg']").hide();
            }
        },

    });
}
//判断信息是否规范
function DataJudge(){

}

//插入商品数据
function insertGoodsInfo(goodsInfo){
    $.ajax({
        url:"/ssm/goodsinfo/insert",
        type:"post",
        data:JSON.stringify(goodsInfo),
        success:function(data){
            if(data!==null||data!==""){
                alert("保存成功");
                $("#goods-add").hide();
                window.location.href="/ssm/goodsinfo/goodsjsp";
            }
            else{
                alert("保存失败");
            }
        },
        contentType:"application/json"
    })
}

//通过商品编号获取商品所有信息
function ajaxGoods(goodsSN){
    $.ajax({
        url:"/ssm/goodsinfo/goods",
        type:"post",
        data:{
            "goodsSN":goodsSN
        },
        success:function(data){
            $("[name='id']").val(data.id);
            $("[name='goodsName1']").val(data.goodsName);
            $("[name='goodsSN1']").val(data.goodsSN);
            $("[name='marketPrice1']").val(data.marketPrice);
            $("[name='realPrice1']").val(data.realPrice);
            $("[name='num1']").val(data.num);
            $("[name='unit1']").val(data.unit);
            $("[name='goodsFormat1']").val(data.goodsFormat);
            $("[name='note1']").val(data.note);
            $("[name='createdTime1']").val(data.createTime);
            //状态
            var flag=data.state;
            if(flag===1){
                $("[name='state']").val("上架");
            }
            else{
                $("[name='state']").val("下架");
            }
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
}
//修改商品信息
function updateGoodsInfo(goodsInfo){
    $.ajax({
        url:"/ssm/goodsinfo/update",
        type:"post",
        data:JSON.stringify(goodsInfo),
        success:function(data){
            if(data===true){
                alert("保存成功");
                $("#goods-upd").hide();
                window.location.href="/ssm/goodsinfo/goodsjsp";
            }
            else{
                alert("保存失败");
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
    })
}
//删除商品信息
function deleteGoodsInfo(goodsSN){
    var flag=confirm("确定删除商品吗");
    if(flag){
        $.ajax({
            url:"/ssm/goodsinfo/delete",
            type:"post",
            data:{
                "goodsSN":goodsSN
            },
            success:function(data){
                if(data===true){
                    alert("删除成功");
                    window.location.href="/ssm/goodsinfo/goodsjsp";
                }
                else{
                    alert("删除失败");
                }
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
    }
}

// //修改商品状态
// function updateState(goodsInfo){
//     $.ajax({
//         url:"/ssm/goodsinfo/updatestate",
//         type:"post",
//         data:JSON.stringify(goodsInfo),
//         success:function(data){
//             if(data===true){
//                 alert("状态修改成功");
//                 window.location.href="/ssm/goodsinfo/goodsjsp";
//             }else{
//                 alert("状态修改失败");
//             }
//         },
//         contentType:"application/json"
//     });
// }
