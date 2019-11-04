<!DOCTYPE html>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file="datajsp/tvod_progBillByRepertoireData-hd.jsp"%>
<%
String backurl = request.getParameter("backurl");

%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <meta name="Page-View-Size" content="1280*720">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="css/common.css">
    <style type="text/css">
        img { display: inline-block; vertical-align: top; }
        * {
            color: #c2c2c0;
            margin: 0;
            padding: 0;
        }
        
        .channel li.sel {
            color: #ffae00;
            border: 2px solid #ffae00;
        }
        .channel li.focusx {
            color: #ffae00;
        }
        .date {
            position: absolute;
            left: 170px;
            top: 120px;
        }
        .date .sel {
            color: #ffae00;
            border: 2px solid #ffae00;
        }
        .date .focusx {
            color: #ffae00;
        }
        .date ul li {
            line-height: 55px;
            font-size: 24px;
        }
        .tvodlist {
            position: absolute;
            left: 330px;
            width: 860px;
            top: 120px;
        }
        .tvodlist ul li {
            float: left;
            margin: 10px;
        }
       .tvodlist ul li.sel .s1, .tvodlist ul li.sel .s2 {
            background: #ffae00
        }
        .tvodlist ul li.sel span{
            color: #fff;
        }
        .tvodlist ul li span {
            display: inline-block;
            font-size: 24px;
            vertical-align: middle;
        }
        .tvodlist .s1 {
            width: 60px;
            height: 50px;
             line-height: 50px;
            background: #fdc75d;
            text-align: center;
            color: #fff;
        }
        .tvodlist .s2 {
            width: 200px;
            height: 50px;
            line-height: 50px;
            background: ##7cb7d7;
            text-align: center;
            color: #fff;
        }
        .tvodlist .s1.outtime {
            width: 60px;
            height: 50px;
             line-height: 50px;
            background: #999;
            text-align: center;
        }
        .tvodlist .s2.outtime {
            width: 200px;
            height: 50px;
            line-height: 50px;
            background: #999;
            text-align: center;
        }
        .video {
            position: absolute;
            left: 150px;
            top: 535px;
        }
        .page {
            position: absolute;
            width: 50px;
            background: #1c7ebd;
            text-align: center;
            padding: 10px 0;
        }
        .uppage {
            left: 1200px;
            top: 130px;
        }
        .downpage {
            left: 1200px;
            top: 565px;
        }
        .page.sel {
            background: #ffae00;
            color: #026086;
        }
        .curpage {
            position: absolute;
            left: 1200px;
            top: 400px;
        }


        /*8.8修改*/
        .channel { 
            overflow: hidden;
            height: 540px;
            position: absolute;
            top: 120px;
            left: 10px;
            width: 200px;
            text-align: center;
         }
        .channel ul {
            overflow: hidden;
            position: absolute;
        }
        .channel li {
            height: 50px;
            line-height: 50px;
            margin: 0 15px;
            width: 120px;
            border: 2px solid transparent;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }
        .classic {
            position: relative;
            height: 100px;
            background: rgba(0,0,0,.3);
        }
        .classic ul {
            overflow: hidden;
            position: absolute;
            top: 35px;
            left: 325px;
        }
        .classic ul li {
            float: left;
            height: 30px;
            line-height: 30px;
            margin: 0 15px;
            border: 2px solid transparent
        }
        .classic ul li.sel {
            color: #ffae00;
            border: 2px solid #ffae00;
        }
        .classic ul li.focusx {
            color: #ffae00;
        }
        .date li {
            border: 2px solid transparent
        }

    </style>
</head>
<body style="width:1280px; height:720px; background: url('img/bodytvod.jpg') no-repeat">

    <!-- 分类 -->
    <div class="classic">
       <ul>
           <li data-code="0">全部</li>
           <li data-code="1">央视</li>
           <li data-code="2">卫视</li>
           <li data-code="3">地方</li>
           <li data-code="4">少儿</li>
           <li data-code="5">电影</li>
           <li data-code="6">剧场</li>
           <li data-code="7">其他</li>
       </ul> 
    </div>

    <!-- 频道 -->
    
    <div id="xxbs"><%@ include file = "hk-channellist-control_pro.jsp"%></div>

    
    <div class="channel" id = "channel1">   </div>

    <!-- 回看日期 -->
    <div class="date">
        <ul>
   
        </ul>
    </div>

    <!-- 回看节目单 -->
    <div class="tvodlist">
        <ul>



        
        </ul>
    </div>





    <!-- 翻页 -->

    <div class="curpage"><span id="curpn">1</span>/<span id="totpn">10</span></div>
    <div class="page uppage">上一页</div>
    <div class="page downpage">下一页</div>
    <div id = "text1" ></div>
    <div id = "text2" ></div>
        <div id = "text3" ></div>
      <div id = "div1" ></div>
    </iframe></div>
<iframe src="" id="recommDataIfr" name="recommDataIfr" style="width:0px; height:0px; border:0px;" frameborder="0"></iframe>
    <script src="EPGjs/keyPress.js"></script>
    <script src="EPGjs/master.js"></script>
    <script src="EPGjs/tvod.js"></script>
    <script src="EPGjs/common.js"></script>




    <script>


        function getCookie(name){
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
        else
        return null;
    }

    function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*30);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
setCookie("mafocusUrl",location.href);

    var chanId ="";
    var progCurrentInfo_JS = "";





        setTimeout(function() {
            var abc = 0
          progCurrentInfo_JS ="";  

            
            var chanTime = area[102].ele[area[102].currentIndex].dataset['day'];
            var wn = getCookie('wn').split(',')
             chanId = wn[0] || 170; 

            if(getCookie("classicid")!=null&&getCookie("classicid")!=""&&getCookie("classicid")!=undefined){
                loadchanlist(getCookie("classicid"));
                area[104].currentIndex = getCookie("classicid")
            }else {
                loadchanlist(0);
            }
            
            if(getCookie("id")!=null&&getCookie("id")!=""&&getCookie("id")!=undefined){
                chanId=getCookie("id");
            }
             if(getCookie("Length")!=null&&getCookie("Length")!=""&&getCookie("Length")!=undefined){
       
                  document.getElementsByClassName('channel')[0].getElementsByTagName('ul')[0].style.left = getCookie("Length")+"px";
        
                  area[100].currentIndex = getCookie("currentIndex");
                  chidNum  = getCookie("currentIndex");


            }
            if(getCookie("livetime")!=null&&getCookie("livetime")!=""&&getCookie("livetime")!=undefined){
                chanTime=getCookie("livetime");
                area[102].currentIndex = getCookie("timeIndex");
            }
            getProgramInfo(0,chanId,0,chanTime);
            var timerLoadData1 = "";
            var results="";
            

      
            //找到获取焦点元素
            fnSetCurrent();
            //添加样式
            fnAddEleClass(current.ele,current.area.selStyle);
            
        }, 500)

function getProgramInfo(dayIndex,chanIds,issb,getDateStr){  
    //loadFilmData(0,"1151",0,"20171127");

    //document.getElementById("test").innerHTML=chanIds+"//"+menu.menus[1].selIndex;
    results="0";
    loadFilmData(dayIndex,chanIds,issb,getDateStr);
    //document.getElementById("test").innerHTML+="*****"+progCurrentInfo_JS;
    //showjson(1);
    
   timerLoadData1 = setTimeout(function() {
    //获取数据
    if(results=="1")
 {
   clearTimeout(timerLoadData1)
    showjson();
   }
    },500)
    //setTimeout("showjson(2);",1000);
}

  
//获取回看节目
function loadFilmData(dayIndex,chanIds,issb,getDateStr)
{   
    
    recommDataIfr.location.href = "datajsp/tvod_IchanListData-hd2_new.jsp?CHAN_ID="+chanIds+"&ISSUB="+(issb+1)+"&TVODDATEFOCUS="+(dayIndex+2)+"&GETDATE="+getDateStr;
   // document.getElementById("text1").innerHTML = results+"123";
    //recommDataIfr.location.href="datajsp/tvod_IchanListData-hd2_new.jsp?CHAN_ID=1151&ISSUB=1&TVODDATEFOCUS=2&GETDATE=20171127";
  // setTimeout("showjson()",500);
  
}
var curpageNum = 0
function  showjson()
{
//document.getElementById("test").innerHTML="JSON数据："+type+"--"+results+"--"+JSON.stringify(progCurrentInfo_JS); 
    var array = [];
    var listUl = document.getElementsByClassName('tvodlist')[0].getElementsByTagName('ul')[0]
    listUl.innerHTML = ''
    var data =progCurrentInfo_JS;
    var xs=0;
    var programname="";
    var type="";
    var bTime = "";
    document.getElementById('curpn').innerHTML = 1
    area[101].currentIndex = 0
    document.getElementById('totpn').innerHTML = Math.ceil(data.length / 24)
    for(var i = 0;  i<data.length; i++){
         programname=data[i].progName;
         bTime = data[i].progStartTime;
            if(programname.length>10){
                programname=programname.substring(0,8)+"...";
            }
            if (data[i].progStatus == 0)
            {
                type="预约";
            }else if (data[i].progStatus ==3)
            {
                type="直播";
                xs=i;
            }
            else
            {
                type="回看";
            }
            //当前时间以后节目设置成灰色 
            if(getSysTime() <= bTime  && area[102].currentIndex == 0) {
                listUl.innerHTML += '<li data-outtime="1"><span class="s1 outtime">'+ bTime +'</span><span class="s2 outtime">'+ programname.substr(0,7) +'</span></li>'
            } else {
                listUl.innerHTML += '<li><span class="s1">'+ bTime +'</span><span class="s2">'+programname.substr(0,7) +'</span></li>'
            }
            

        }
        curpageNum = 0
        setTvodM()

        if(data.length > 24) {
            var listLis = listUl.getElementsByTagName('li')
            for(var j = 24; j < data.length; j++ ) {
                listLis[j].style.display = 'none'
            }
        }
}

        function programGo(index){
            var prodObj = progCurrentInfo_JS[index];
            var url = getProgURL(prodObj);
            if(url != "")
            {
                top.location.href = "SaveCurrFocus.jsp" + "?currFoucs=" + index+ "&url=" +url; 
            }
    }






    function getProgURL(prodObj)
    {

        var url = '';
        var curchan=chanId;
        //录制成功
        if (prodObj.progStatus == "1")
        {   

             url = "au_ReviewOrSubscribe.jsp?PROGID=" + prodObj.progId
                    + "&PLAYTYPE=" + <%=EPGConstants.PLAYTYPE_TVOD%>
                  + "&CONTENTTYPE=" + <%=EPGConstants.CONTENTTYPE_PROGRAM%>
                  + "&BUSINESSTYPE=" + <%=EPGConstants.BUSINESSTYPE_TVOD%>
                  + "&PROGSTARTTIME=" + prodObj.startTimeStr
                    + "&PROGENDTIME=" + prodObj.endTimeStr
                    +"&ISSUB=0"
                    +"&PREVIEWFLAG=0" 
                    +"&TVOD=1"
                    + "&CHANNELID=" + curchan;
        }
        return url;
    }

    // 获取当前时间
    function getSysTime() {
        var d = new Date();
        var my_hours=d.getHours();
        var my_minutes=d.getMinutes();
        return my_hours+':'+my_minutes
    }
    function keyBack(){
        setCookie("id","");
        setCookie("Length","");
        window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp";
    }
            
    </script>
</body>
</html>