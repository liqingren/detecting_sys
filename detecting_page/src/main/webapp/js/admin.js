function conditionJudge() {
    $("#done").val("");
}
function conditionDue() {
    $("#conditionSearchVal").val("");
    $("#startTime").val("");
    $("#endTime").val("");
    $("#resultState").val("");
}

//日期格式转换
function formatTime(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    m = m < 10 ? ('0' + m) : m;
    var d = date.getDate();
    d = d < 10 ? ('0' + d) : d;
    var h = date.getHours();
    h=h < 10 ? ('0' + h) : h;
    var minute = date.getMinutes();
    minute = minute < 10 ? ('0' + minute) : minute;
    var second=date.getSeconds();
    second=second < 10 ? ('0' + second) : second;
    return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
};


//全选按钮的点击事件
function checkAll(){
    //获取id的dom元素
    let Id = document.getElementById('all');
    //获取类名为chBox的dom元素
    let chBox = document.getElementsByName('modify_del');
    let len = chBox.length;
    //输出观察
    console.log(Id.checked);
    console.log(chBox);
    for(let i=0;i<len;i++){
        //当全选按钮为true时，全部按钮都为true，否则相反
        if(Id.checked){
            chBox[i].checked=true;
        }
        else {
            chBox[i].checked=false;
        }
    }
}
//单个按钮的点击事件
function checkOne(){
    let count=0;
    let chBox = document.getElementsByName('modify_del');
    let len = chBox.length;
    for(let i=0;i<len;i++){
        //记录单选按钮为true的数量
        if(chBox[i].checked){
            count++;
        }
    }
    //当单选按钮都为true时，全选按钮也为true，否则为false
    if(count==len){
        document.getElementById('all').checked = true;
    }else {
        document.getElementById('all').checked = false;
    }
}


//删除 修改单个isDelete状态
function deleteResult(val){
    var value = $(val).parent().parent().find("td");
    var deleteResultCard=value.eq(2).text();//得到第三列的数据身份证号
    var deleteResultTime=value.eq(5).text();//第五列结果时间
    $.ajax({
        url:"http://127.0.0.1:8001/detectinq/result/adminModifyIsDelete",
        type:"POST",
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true,
        data:{
            "deleteResultCard":deleteResultCard,
            "deleteResultTime":deleteResultTime,
        },
        error: function () {
            alert("请重试！");
        },
        success:function(data){
            conditionSearch();
        }
    });
}

// 批量删除
function delResults(){
    $("input:checkbox[name='modify_del']").each(function () { //遍历checkbox的选择状态
        if ($(this).prop("checked")) { //如果值为checked表明选中了
            // alert("选中该行的角色名"+$(this).closest('tr').find('td').eq(2).text());
            var deleteResultCard = $(this).closest('tr').find('td').eq(2).text();
            var deleteResultTime = $(this).closest('tr').find('td').eq(5).text();
            if(deleteResultTime=="null" || deleteResultTime=="" || deleteResultTime==null){
                alert("包含未出结果，不能删除");
                return false;
            }
            $.ajax({
                url:"http://127.0.0.1:8001/detectinq/result/adminModifyIsDelete",
                type:"POST",
                xhrFields: {
                    withCredentials: true
                },
                crossDomain: true,
                data:{
                    "deleteResultCard":deleteResultCard,
                    "deleteResultTime":deleteResultTime,
                },
                error: function () {
                    alert("请重试！");
                },
                success:function(data){
                }
            });
        }
    });
    conditionSearch();
}



