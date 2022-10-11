var n = null;
var v = null;
var gCtx = null;
var medicineCode = null;
var cardArray = new Array();

function captureToCanvas(){

    try{
        gCtx.drawImage(v,0,0);//在canvas元素中绘出video的某一帧
        try{
            qrcode.decode();//扫描二维码
            //console.log(qrcode.decode());//扫描成功输出二维码的信息
            document.getElementById('loading').style.display = "none";//隐藏掉加载动画
            document.getElementById('outdiv').style.display = "none";
        }
        catch(e){
            console.log(e);//未扫描出二维码，输出错误信息
            setTimeout(captureToCanvas, 500);//500ms之后再重绘canvas
            document.getElementById('loading').style.display = "block";
            document.getElementById('outdiv').style.display = "block";
        }
    }
    catch(e){
        console.log(e);//若失败，输出错误信息
        setTimeout(captureToCanvas, 500);//500ms再重绘canvas
    }
}
//初始化canvas元素，形成一个矩形框
function initCanvas(w,h){

    n = navigator;
    v = document.getElementById("v");
    var gCanvas = document.getElementById("qr-canvas");
    gCanvas.style.width = w + "px";
    gCanvas.style.height = h + "px";
    gCanvas.width = w;
    gCanvas.height = h;
    gCtx = gCanvas.getContext("2d");
    gCtx.clearRect(0, 0, w, h);
}

function setwebcam(){
    var options = true;
    if(navigator.mediaDevices && navigator.mediaDevices.enumerateDevices)
    {
        try{
            navigator.mediaDevices.enumerateDevices().then(function(devices) {
                devices.forEach(function(device) {
                    if (device.kind === 'videoinput') {
                        if(device.label.toLowerCase().search("back") >-1)
                            options={'deviceId': {'exact':device.deviceId}, 'facingMode':'environment'} ;
                    }


                    console.log(device.kind + ": " + device.label +" id = " + device.deviceId);
                });
                setwebcam2(options);

            });
        }
        catch(e)
        {
            console.log(e);
        }
    }
    else{
        console.log("no navigator.mediaDevices.enumerateDevices" );

    }
}

function setwebcam2(options){

    var p = n.mediaDevices.getUserMedia({video: options, audio: false});
    p.then(success, error);
    //  setTimeout(captureToCanvas, 500);

}
function success(stream){
    v.srcObject = stream;
    setTimeout(captureToCanvas(), 500);
}
function error(error){
    console.log(error);
}
function load(){
    initCanvas(800,600);
    qrcode.callback = read;
    setwebcam();
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

function read(code){
    console.log("qrcode info:"+code);//输出扫描后的信息
    $.ajax({
        url:"http://127.0.0.1:8222/detecthos/users/meuser/getuser",
        type:"post",
        data:{
            "code":code
        },
        success:function(data){
            console.log(data.data.userCard);
            $("#user_name").val(data.data.userCard.name);
            if(data.data.userCard.sex){
                $("#user_sex").val("男性");
            }else{
                $("#user_sex").val("女性");
            }
            $("#user_card").val(data.data.userCard.card);
            $("#user").css("display","block");
            $(".close").bind("click",function(){
                $(".result").hide();
            });
            cardArray.push(data.data.userCard.id);
            console.log(cardArray);
            if(cardArray.length>2){
                $(".close").bind("click",function(){
                    $(".result").hide();
                    alert("检测人数已满");
                });
            }
        }

    })
}
function insert() {
    var medicineCode = getUrlParam("medicineCode");
    $.ajax({
        url:"http://127.0.0.1:8222/detecthos/result/meuser/insert",
        type:"post",
        data:{
            "medicineCode":medicineCode,
            "cardArray":cardArray.toString()
        },
        success:function (data) {
            if(data.success){
                alert("核酸信息录入成功");
                window.location.href="scan.jsp";
            }
        }
    })
}
