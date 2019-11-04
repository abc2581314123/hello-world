<%@page contentType="text/html; charset =utf-8" language="java" pageEncoding="utf-8" %>
<%@ include file="hk_channellist.jsp"%> 
<%  
String chanId=request.getParameter("ChannelId");
String showId=request.getParameter("showid");
%>  
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>11</title>
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
            font-weight: bold;
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
            font-size: 22px;
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
            font-size: 22px;
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

    <div class="channel" id = "channel1">  

        

    </div>

    <!-- »Ø¿´ÈÕÆÚ -->
    <div class="date">
        <ul>
  
        </ul>
    </div>


    <div class="tvodlist">
        <ul>



        
        </ul>
    </div>






    <div class="curpage"><span id="curpn">1</span>/<span id="totpn">1</span></div>
    <div class="page uppage">上一页</div>
    <div class="page downpage">下一页</div>
    <div id = "text1" ></div>
    <div id = "text2" ></div>
        <div id = "text3" ></div>
      <div id = "div1" ></div>
<iframe src="" id="recommDataIfr" name="recommDataIfr" style="width:0px; height:0px; border:0px;" frameborder="0"></iframe>
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

    </script>
    <script src="EPGjs/keyPress.js"></script>
    <script src="EPGjs/master.js"></script>
    <script src="EPGjs/tvod.js"></script>
    <script src="EPGjs/common.js"></script>
    <script type="text/javascript">
        
     setCookie("mafocusUrl",location.href);
     setCookie("hkBackUrl",location.href);

    var chanCode ="";
    var chanId ="";
    var progCurrentInfo_JS = "";





        setTimeout(function() {
            var abc = 0
            progCurrentInfo_JS ="";  
            if(getCookie("classicid")!=null&&getCookie("classicid")!=""&&getCookie("classicid")!=undefined){
                loadchanlist(getCookie("classicid"));
                area[104].currentIndex = getCookie("classicid")
            }else {
                loadchanlist(0);
            }
            
            var chanTime = area[102].ele[area[102].currentIndex].dataset['day'];

            // var wn = sessionStorage.getItem('wn').split(',')
            // var wn2 = sessionStorage.getItem('wn2').split(',')

            var wn = getCookie('wn').split(',')
            var wn2 = getCookie('wn2').split(',')

            chanCode = 'ch0000000500000000' + wn[0]; 
            chanId = wn2[0];

            if(getCookie("code")!=null&&getCookie("code")!=""&&getCookie("code")!=undefined){
                chanCode=getCookie("code");
            }
            if(getCookie("id")!=null&&getCookie("id")!=""&&getCookie("id")!=undefined){
                chanId=getCookie("id");
            }
            if(getCookie("livetime")!=null&&getCookie("livetime")!=""&&getCookie("livetime")!=undefined){
                chanTime=getCookie("livetime");
                area[102].currentIndex = getCookie("timeIndex");
            }


            getProgramInfo(chanCode,chanId,chanTime);
            var timerLoadData1 = "";
            var results="";
            
        if(getCookie("Length")!=null&&getCookie("Length")!=""&&getCookie("Length")!=undefined){
       
                  document.getElementsByClassName('channel')[0].getElementsByTagName('ul')[0].style.top = getCookie("Length")+"px";
        
                  area[100].currentIndex = getCookie("currentIndex");
                  chidNum  = getCookie("currentIndex");
          }
              
            //找到获取焦点元素
            fnSetCurrent();
            //添加样式
            fnAddEleClass(current.ele,current.area.selStyle);
        }, 500)


function getProgramInfo(chanIds,showid,getDateStr){  
results="0";
loadFilmData(chanIds,showid,getDateStr);

timerLoadData1 = setTimeout(function() {
	//获取数据
	if(results=="1")
	{
	clearTimeout(timerLoadData1)
	showjson();
	}
    },500)
}

function getProgramInfo1(d){  
jsonProgramData.list=[{name:'暂无记录',time:'',type:''}
];
jsonProgramData.currentIndex=0;

}
//获取回看节目
function loadFilmData(chanIds,showid,getDateStr)
{  
//var channelid=menu.menus[1].listEles[menu.menus[1].selIndex+1].getElementsByClassName('menu-list-channel-type')[0].innerHTML;
//var showid=menu.menus[1].listEles[menu.menus[1].selIndex+1].getElementsByClassName('menu-list-channel-id')[0].innerHTML;    
recommDataIfr.location.href = "hk-detaildata.jsp?channelid="+chanIds+"&date="+getDateStr+"&showid="+showid;
}
var curpageNum = 0
function showjson()
{
    var listUl = document.getElementsByClassName('tvodlist')[0].getElementsByTagName('ul')[0];
    listUl.innerHTML = '';
	var data =progCurrentInfo_JS;
    var programname="";
    var type="";
    var bTime = "";
    var eTime = "";
    document.getElementById('curpn').innerHTML = 1
    area[101].currentIndex = 0
    document.getElementById('totpn').innerHTML = Math.ceil(data.length / 24)
  for(var i = 0;  i<data.length; i++){
		     programname=data[i].progName;
		     bTime = data[i].progStartTime;
             eTime = data[i].progEndTime;
			if(programname.length>8){
				programname=programname.substring(0,7)+"...";
			}
			 if (data[i].tvod ==1)
			{
				type="直播";
				xs=i;
			}
			else 
			{   
			if(data[i].palyable=="true"&&data[i].recordsystem=='1'){
				type="回看";
				}
			else{type="无信息";}
			}
			
            //当前时间以后节目设置成灰色 
            if(data[i].palyable=="true"&&data[i].recordsystem=='1') {
                  listUl.innerHTML += '<li><span class="s1">'+ bTime +'</span><span class="s2">'+ programname +'</span></li>'
            } else {
                 listUl.innerHTML += '<li data-outtime="1"><span class="s1 outtime">'+ bTime +'</span><span class="s2 outtime">'+ programname +'</span></li>'
            }

		}
        curpageNum = 0
        setTvodM()
        area[101].paras = tvodMoveParas
        area[101].ele = tvod
        if(data.length > 24) {
            var listLis = listUl.getElementsByTagName('li')
            for(var j = 24; j < data.length; j++ ) {
                listLis[j].style.display = 'none'
            }
        }


}

    // 获取当前时间
    function getSysTime() {
        var d = new Date();
        var my_hours=d.getHours();
        var my_minutes=d.getMinutes();
        return my_hours+':'+my_minutes
    }

    function programGo(index){

        var tempObj = progCurrentInfo_JS[index];
        var palyable = tempObj.palyable;
        var tvod = tempObj.tvod;
        var recordsystem = tempObj.recordsystem;
        var contentcode = tempObj.contentid;
        var columnid = '01';
        // var wn2 = sessionStorage.getItem('wn2').split(',');
        var wn2 = getCookie('wn2').split(',');
        var channelid = wn2[chidNum];    
 

        if(tvod=='1'){
          window.location.href  = "channel_detail.jsp?mixno="+channelid;
        }else{
         if(palyable=="true"&&recordsystem=='1'){
                
            
           window.location.href  = "channel_tv_auth.jsp?columnid="+columnid+'&<%=EpgConstants.CHANNEL_ID%>='+channelid+'&<%=EpgConstants.CONTENT_CODE%>='+contentcode+"&ContentID="+contentcode
           +"&destpage=0&CategoryID="+columnid+"&ContentType=4&FatherContent="+channelid;

       
        }
    }   
        
}

  function keyBack(){
    setCookie("id","");
    setCookie("code","");
    setCookie("Length","");
        window.location.href = "http://218.24.37.2/templets/epg/Profession/professionEPG.jsp";
    }

    </script>
</body>
</html>