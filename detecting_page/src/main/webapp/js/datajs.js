//初始化实现页面增加、修改框的隐藏显示
function init(){
    //显示后台管理下的列表
    $("ul:eq(0)").show();
    //将权限管理字体颜色变黄
    $("ul li:eq(6)").css("color","yellow");
    //默认选中第一个单选框
    $("[type='radio']:first").prop("checked","true");
    //显示新增框
    $("#add ").bind("click",function(){
        $("#data_add").show();
    });
    //点击关闭或叉掉则隐藏
    $("#close1").bind("click",function(){
        $("#data_add").hide();
    });
    $("#quit1").bind("click",function(){
        $("#data_add").hide();
    });
    //点击修改按钮，显示出需要修改商品的信息
    $("#upd").bind("click",function(){
        //显示修改框
        $("#data_upd").show();
    });
    //点击关闭和叉掉是隐藏修改框
    $("#close2").bind("click",function(){
        $("#data_upd").hide();
    });
    $("#quit2").bind("click",function(){
        $("#data_upd").hide();
    })
}
//分页处理
// function getPage(totalPage,pageNum){
//     if(pageNum>=totalPage) {
//         $("#nextPage").attr("href", "javascript:void");
//         $("#nextPage").css("color", "red");
//         $("#page>a:gt(1):not(a:last)").remove();
//         $("a~span").remove();
//         //添加节点
//         $("#previousPage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
//         $("#page>a:eq(2)").before($("<span> ... </span>"));
//         $("#page>a:eq(2)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-4}'>${pageNum-4} </a>"));
//         $("#page>a:eq(3)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-3}'>${pageNum-3} </a>"));
//         $("#page>a:eq(4)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-2}'>${pageNum-2} </a>"));
//         $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));
//
//     }
//     else if(pageNum+4===totalPage){
//         $("#page>a:eq(6)").remove();
//         $("a~span").remove();
//         //添加节点
//         $("#previousPage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
//         $("#begin").before($("<span> ... </span>"));
//
//     }
//     else if(pageNum+3===totalPage){
//         $("#page>a:eq(5),#page>a:eq(6)").remove();
//         $("a~span").remove();
//         //添加节点
//         $("#previousPage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
//         $("#page>a:eq(2)").before($("<span>... </span>"));
//         $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));
//
//     }
//     else if(pageNum+2===totalPage){
//         $("#page>a:gt(3):not(a:last)").remove();
//         $("a~span").remove();
//         //添加节点
//         $("#previousPage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
//         $("#page>a:eq(2)").before($("<span> ... </span>"));
//         $("#page>a:eq(2)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-2}'>${pageNum-2} </a>"));
//         $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));
//
//     }
//     else if(pageNum+1===totalPage){
//         $("#page>a:gt(2):not(a:last)").remove();
//         $("a~span").remove();
//         //添加节点
//         $("#previousPage").after($("<a href='/ssm/datadict/datajsp?pageNum=1'>首页 </a>"));
//         $("#page>a:eq(2)").before($("<span> ... </span>"));
//         $("#page>a:eq(2)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-3}'>${pageNum-3} </a>"));
//         $("#page>a:eq(3)").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-2}'>${pageNum-2} </a>"));
//         $("#begin").before($("<a href='/ssm/datadict/datajsp?pageNum=${pageNum-1}'>${pageNum-1} </a>"));
//
//     }
// }