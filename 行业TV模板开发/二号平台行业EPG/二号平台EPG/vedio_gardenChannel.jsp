<%@ page language="java" pageEncoding="utf-8"%>
<HTML xmlns="http://www.w3.org/TR/REC-html40" xmlns:v = 
"urn:schemas-microsoft-com:vml" xmlns:o = 
"urn:schemas-microsoft-com:office:office">

<HEAD>

<TITLE>IP</TITLE>

<%
	String channelnum = "8";//频道号
%>

<style type="text/css">

#ad_downtimes{position:absolute; color:#FFFFFF; line-height:30px; left:460px; top:10px; background-image:url(images/djsbg.png); text-align:center; width:170px; height:30px;}  /* 倒计时*/



.ad2{position:absolute; width:300px; height:375px; z-index:30;}/*返回图片层*/



.ad4{position:absolute; width:308px; height:232px; top:23px; left:40px;z-index:10;} /*视频广告后的3秒图片层*/

#bottom { position:absolute;z-index:9999; bottom:0px; top:440px; background-color:#E6E8FA; width:308px; height:86px; display:none;} 
#left{position:absolute; z-index:9999; background-color:#0573a6; width:110px; height:440px; top:0px; filter:gray;opacity:0.4;display:none;}
#left_xia{position:absolute; z-index:9999; width:88px; height:250px; top:204px; background-color:#0033FF;display:none;}

img{ border:0px;}
a{ text-decoration:none; color:#FFFFFF;}
a:link{ text-decoration:none; color:#FFFFFF;}
a:hover{ text-decoration:none; color:#FFFFFF;}
.bb1{ font-size:22px; color: #b6c3d6;}
.bb2{ font-size:22px; color: #b6c3d6;}
.bb3{ font-size:22px; color: #b6c3d6;}
.bb4{ font-size:24px; color:#FFFFFF;}
.bb5{ font-size:22px; color:#FFFFFF;}
.bb6{ font-size:22px; color:#FFFFFF;}
.orange{ color:#ff9900;}
.red{ color:#ff3333}
.green{ color:#33ff00;}
body,td,th {
	font-family: "??";
	font-size: 22px;
}
</style>

<%      
	  String videopoint = request.getParameter("videopoint");  //获得开始时间点
	   
	  if(videopoint==null || videopoint.equals("")){
		   
			  videopoint = "0";
	  }
%>

<META http-equiv=Content-Language content=zh-cn>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.2800.1522" name=GENERATOR>
<meta name="Page-View-Size" content="1280*720">
<style type="text/css">
#bottom { position:absolute;z-index:9999; bottom:0px; top:440px; background-color:#E6E8FA; width:308px; height:86px; display:none;} 
#left{position:absolute; z-index:9999; background-color:#0573a6; width:110px; height:440px; top:0px; filter:gray;opacity:0.4;display:none;}
#left_xia{position:absolute; z-index:9999; width:88px; height:250px; top:204px; background-color:#0033FF;display:none;}

</style>
<link href="css/play.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
function OnKeyBack() {
    window.history.back();//返回上一页
}
var ChannelCount = Authentication.CTCGetConfig ("ChannelCount");   // 获取直播频道总数


var can_ward=true;
var can_info=true;
//var currVolume = mp.getVolume();   //bm wangxg20160925
var volumeBarVisible=false;
var volumeBarTimeout = -1;
var duration = 0;

var shiftState = false;         // 时移的状态
var hideNumTimer = "";		//频道号清空计时器
var totalChannel = 100;		//最大频道号
var channelIds = new Array();		//频道id号
var channelNumsShow = new Array();	//用来显示的频道号数
var currChannelNum = '<%=channelnum%>';		//当前频道号
var number = 0;						//数字切换频道
var numCount = 0;
var tempNumber = "";

var shiftStateOnehours = false;   // 直播视频时移到一小时之前的时间点处，用来控制在时移前一小时处不能后退
var helpMessage = false;    // 视频的帮助提示层标识
var isNotSubFlag = false;    // 频道号不存在
var leaveStatus = false;      // 暂离功能的图层
var message = false;          // 电视短信信息提示层的标识
var propramlistState=false;  // 节目列表状态
var livelistState=false;   // 直播列表的状态
var movieInfo = true;          // 按确认键后，出现的影片信息的标识
var tiaoZhanStatus = false;   // 跳转到指定的时间播放的图层
var show_progress = false;    // 进度条的显示标识

var backInfo = false;         // 返回的图层

var infotimeout;                // 视频信息图片的setTimeout的值

var playimgtimeout;             // 视频右上角图标的settimeout的值

var playstatus = "play";        //播放状态    play：播放 / pause：暂停
 

function onLoadMehtod(){
	setInter();
    initplayer();
    setTimeout("hideChannelInfo()", 4000);
}
















</script>
<SCRIPT language="JavaScript"> 
var currChannelNum = '<%=channelnum%>';	
var totalChannel = 100;		//最大频道号
var mp;
var bindresult; 
var presscount=1;
var presscountshow=1;
var NativePlayerInstanceID;
function initplayer(){
	mp = new MediaPlayer();
	NativePlayerInstanceID = mp.getNativePlayerInstanceID();
	mp.setVideoDisplayMode(0);
	mp.setVideoDisplayArea(55,170,365,285);     //  联通的盒子
		// var STBType =Authentication.CTCGetConfig("STBType");
		// if(STBType == "EC2108"){
		// 	mp.setVideoDisplayArea(8,110,436,348); 
		// }
		// if(STBType == "EC1308G"){
		// 	mp.setVideoDisplayArea(60,130,436,348); 
		// }
		// if(STBType == "YX5631D"){
		// 	mp.setVideoDisplayArea(8,110,436,348); 
		// }
	     //  
	mp.refreshVideoDisplay();
	mp.setProgressBarUIFlag(0);       // 首页本地ui （视频下面的快进倒退的滚动条的显示）
	mp.setAllowTrickmodeFlag(0);		//0不允许媒体快进，快退，暂停	            1本地控制
	mp.setChannelNoUIFlag(0);			//0不使频道号本地显示					    1本地显示
	mp.setNativeUIFlag(1);					//0不使UI本地显示						1本地显示
	mp.setMuteUIFlag(1);						//0静音图标不显示					1本地显示
	mp.setAudioVolumeUIFlag(0);			//设置音量调节本地UI的显示标志 0:不允许 1：允许
	mp.setAudioTrackUIFlag(1);
	mp.setMuteFlag(0);
	joinChannel(currChannelNum);
}
</SCRIPT>

<script type="text/javascript" src="playjs/movievolumevod.js"></script> 
<script type="text/javascript">

 //  键值逻辑
     document.onirkeypress = keyEvent ;

    document.onkeypress = keyEvent;



    function keyEvent()

    {

        var val = event.which ? event.which : event.keyCode;



       keypress(val);
    }

function keypress(val1)
{	

	switch(val1)
	{
		case  8 :keyBack() ;return 0;break;
		case 270:keyBack() ;return 0;break;
		case 275:keyBvod() ;return 0;break;
		case 276:keyTvod() ;return 0;break;
		case 277:keyVod() ;return 0;break;
		case 278:loadMiniInfo() ;return 0;break;
		case 281:keyFavourite() ;return 0;break;
		case 271:keyPos() ;return 0;break;
		case 1108:keyBvod() ;return 0;break;
		case 1110:keyTvod() ;return 0;break;
		case 1109:keyVod() ;return 0;break;
		case 1111:keyComm() ;return 0;break;
		case 262 :keyTrack() ;return 0;break;
		case 268 :keyInfo() ;return 0;break;
		case 284 :keyHelp() ;return 0;break;
		case 768 :keyIptvEvent() ;return 0;break;
		case 263 : keyPausePlay() ;return 0;break;
		case 259:keyVolUp() ;return 0;break;
		case 260:keyVolDown() ;return 0;break;
		case 257:addchannel() ;return 0;break;
		case 258:delchannel() ;return 0;break;
		case 261:keyMute() ;return 0;break;
		case 264:keyFastForward() ;return 0;break;
		case 265:keyFastRewind() ;return 0;break;
		case 283:keyBottomLine() ;return 0;break;
		case 39170:keyPreviewTimesOver() ;return 0;break;
		case 39171:keyPreviewTimesUp() ;return 0;break;
		case 39172:keyStbNoChannel() ;return 0;break;
		case 37 :keyLeft(); return 0;break;
		case 39 :keyRight() ;return 0;break;
		case 38 :keyUp() ;return 0;break;
		case 40 :keyDown() ;return 0;break;
		case 48 :inputNum(0) ;return 0;break;
		case 49 :inputNum(1) ;return 0;break;
		case 50 :inputNum(2) ;return 0;break;
		case 51 :inputNum(3) ;return 0;break;
		case 52 :inputNum(4) ;return 0;break;
		case 53 :inputNum(5) ;return 0;break;
		case 54 :inputNum(6) ;return 0;break;
		case 55 :inputNum(7) ;return 0;break;
		case 56 :inputNum(8) ;return 0;break;
		case 57 :inputNum(9) ;return 0;break;
		case 272:keyPortal() ;return 0;break;
		case 33 :keyPageUp() ;return 0;break;
		case 34 :keyPageDown() ;return 0;break;
		case 13 :keyOk() ;return 0;break;
		default:
			//return 0 ;
			//break ;
	}
	
}
//视频快进
 function keyRight(){
 	speedMovie();
 }
 function keyLeft(){
 	reverseMovie();
 }

//播放暂停方法
function keyPausePlay(){
playMovie();
}
var currVolume = "";
//音量加
function keyVolUp(){
		hidebar();    // 隐藏进度条
	    //document.getElementById("apDiv14").style.display="none";    // 显示返回时的图层
	    currVolume = mp.getVolume();
	    volumeAdjust(+5);

}
//音量减
function keyVolDown(){
		hidebar();    // 隐藏进度条
	    //document.getElementById("apDiv14").style.display="none";    // 显示返回时的图层
		currVolume = mp.getVolume();
		volumeAdjust(-5);
}
//返回方法
function keyBack(){

history.back();
}
//加频道
 function addchannel(){

 	currChannelNum = currChannelNum*1+1;
 		if(currChannelNum==999){
     currChannelNum = 1;
 	}

 	joinChannel1(currChannelNum);

 }
 //减频道
 function delchannel(){
 	currChannelNum = currChannelNum*1-1;
 	if(currChannelNum==0){
     currChannelNum = 1;
 	}

 	joinChannel1(currChannelNum);


 }

// 指定数字键进入相应的频道
function joinChannel1(num){
	mp = new MediaPlayer();
	NativePlayerInstanceID = mp.getNativePlayerInstanceID();
	mp.setVideoDisplayMode(0);
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
			var STBType =Authentication.CTCGetConfig("STBType");
		if(STBType == "EC2108"){
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
		}
		if(STBType == "EC1308G"){
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
		}
		if(STBType == "YX5631D"){
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
		}
	mp.refreshVideoDisplay();
	mp.setProgressBarUIFlag(0);       // 首页本地ui （视频下面的快进倒退的滚动条的显示）
	mp.setAllowTrickmodeFlag(0);		//0不允许媒体快进，快退，暂停	            1本地控制
	mp.setChannelNoUIFlag(0);			//0不使频道号本地显示					    1本地显示
	mp.setNativeUIFlag(1);					//0不使UI本地显示						1本地显示
	mp.setMuteUIFlag(1);						//0静音图标不显示					1本地显示
	mp.setAudioVolumeUIFlag(1);			//设置音量调节本地UI的显示标志 0:不允许 1：允许
	mp.setMuteFlag(0);
	joinChannel(num);
}
function joinChannel2(num){
	mp = new MediaPlayer();
	NativePlayerInstanceID = mp.getNativePlayerInstanceID();
	mp.setVideoDisplayMode(0);
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
			var STBType =Authentication.CTCGetConfig("STBType");
		if(STBType == "EC2108"){
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
		}
		if(STBType == "EC1308G"){
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
		}
		if(STBType == "YX5631D"){
	mp.setVideoDisplayArea(50,215,360,285);     //  联通的盒子
		}
	mp.refreshVideoDisplay();
	mp.setProgressBarUIFlag(0);       // 首页本地ui （视频下面的快进倒退的滚动条的显示）
	mp.setAllowTrickmodeFlag(0);		//0不允许媒体快进，快退，暂停	            1本地控制
	mp.setChannelNoUIFlag(0);			//0不使频道号本地显示					    1本地显示
	mp.setNativeUIFlag(1);					//0不使UI本地显示						1本地显示
	mp.setMuteUIFlag(1);						//0静音图标不显示					1本地显示
	mp.setAudioVolumeUIFlag(0);			//设置音量调节本地UI的显示标志 0:不允许 1：允许
	mp.setMuteFlag(0);
	joinChannel(num);
}
// 指定数字键进入相应的频道
function joinChannel(num){  
	 //channelNumAction(num);	 	
	 mp.joinChannel(num);
}
//	离开当前频道
function stopChannel(){
	hideChannelNum();  //清空频道号
}
//频道号显示
function channelNumAction(chanNum){ 
	 // 直播中右上角的视频号码的显示
	 var channelNumDef = '<table width=200 height=30><tr align="right"><td><font color=green size=20>';
	 channelNumDef += chanNum;
	 channelNumDef += '</font></td></tr></table>';
	 $("topframe").innerHTML = channelNumDef;
	 clearTimeout(hideNumTimer);    // 八秒钟后隐藏频道号
	 hideNumTimer = setTimeout("hideChannelNum()", 2000);
}

function playByChannelNum(chanNum){
     
	 updateChannelFromNum(chanNum);
}  //用户输入的频道号时的处理

function getChanIndexByNum(chanNum)//通过频道号比对出索引
{
	var chanIndexTemp = -1;
	for (var i=0; i<=parseInt(ChannelCount); i++)
	{   
	    if(chanNum > channelNums[i]){   // 给频道号索引赋值
			chanIndex = i;
		}
		if (chanNum == channelNums[i])
		{   
		    chanIndex = i;
			chanIndexTemp = i;
			break;
		}

	}
	return chanIndexTemp;
}

function updateChannelFromNum(chanNum)		//数字播放
{
	if (chanNum == currChannelNum)  return;		//判断当前输入的频道号是否是正在播放的频道
	//stopChannel();	  //离开上一个频道
	//var returnIndex = getChanIndexByNum(chanNum);		//通过用户输入的频道号判断频道是否存在，加锁，父母控制等等
	
	//if (-1 == returnIndex)	channelIsNotExist(chanNum);		//频道不存在
	//else
	//{
		currChannelNum = returnIndex;			//把频道号和所对应的索引赋给currChannelNum 修改
		currChannelNum = chanNum;
		joinChannel2(chanNum);
	//}
}
function channelIsNotExist(chanNum)//频道不存在
{   
    $("num").innerHTML = chanNum;
	$("isNotSubFlag").style.display = "block";
	clearTimeout(hiddenDiv);
	hiddenDiv = setTimeout("$('isNotSubFlag').style.display = 'none';",4000);
	isNotSubFlag = "true";
	
}

//隐藏频道号
function hideChannelNum(){
	numCount = 0;
	number = 0;
	tempNumber = "";
	$("topframe").innerHTML = "";
}  
//隐藏信息层
function hideChannelInfo(){
	$("apDiv13").style.display = "none";   // 影片的信息图层
}  

// 按返回键触发的方法
function backinfo(){    
	 backInfo = true;         // 返回的图层的标识
	 volumeBarVisible = false;    // 音量进度条的显示标识
	 $("volume").style.visibility = "hidden";   // 隐藏音量进度条
	 closeMp();
	 
	 window.history.go(-1);// 返回时触发的方法 
}
var tiaoZhanTime;
window.clearTimeout(tiaoZhanTime);
function tiaoZhanTimeOut(){   // 跳转到指定时间的图层的显示时间
	tiaoZhanTime = window.setTimeout(function(){tiaoZhanStatus = false; $("apDiv101").style.display="none";},80000);
}


function playMovie(){       //  暂停/播放的方法
	window.clearTimeout(playimgtimeout);	
	if (playstatus =="play"){
		
		/**-------------播放状态，暂停事件处理事件------------------**/
		show_progress = true;    // 进度条的显示标识
      	setInter();  // 循环调用进度条的图层的方法
		$("volume").style.visibility = "hidden";   //  影片音量的图层隐藏
		$("apDiv13").style.display = "none";   // 影片的信息图层
		$("apDiv101").style.display = "block";  // 显示跳转到指定时间的图层
		//window.clearTimeout(tiaoZhanTime);
		tiaoZhanStatus = true;   // 跳转到指定时间图层的标识
		tiaoZhanTimeOut();  // 跳转到指定时间的图层的显示时间
		playstatus ="pause";  //赋值播放状态为 pause
		showbar();    // 显示进度条
		mp.pause();   // 视频暂停
	}else if (playstatus=="pause"){
		show_progress = false;    // 进度条的显示标识
		playstatus ="play";  //赋值播放状态为 play
		mp.resume();
		presscount=1;
		$("volume").style.visibility = "hidden";   //  影片音量的图层隐藏
		$("apDiv13").style.display = "none";   // 影片的信息图层
		hidebar();    // 隐藏进度条
		playImg();		
	}
}
// 视频快进
function speedMovie(){ 
		shiftStateOnehours = false;  // 能快进，说明没有在一小时的地方 
		show_progress = true;    // 进度条的显示标识
        playstatus ="pause";  //赋值播放状态为 pause
		setInter();  // 循环调用进度条的图层的方法	
		$("volume").style.visibility = "hidden";   //  影片音量的图层隐藏
		$("apDiv13").style.display = "none";   // 影片的信息图层
		showbar();    // 显示进度条
		
		if(presscount == 1 || presscount < 0) {
			mp.fastForward(2);
			presscountshow = 2;
			presscount = 2;
		}else if(presscount == 2) {
			mp.fastForward(4);
			presscountshow = 4;
			presscount = 3;
		}else if(presscount == 3) {
			mp.fastForward(8);
			presscountshow = 8;
			presscount = 4;
		}else if(presscount == 4) {
			mp.fastForward(16);
			presscountshow = 16;
			presscount = 5;
		}else if(presscount == 5) {
			mp.fastForward(32);
			presscountshow = 32;
			presscount = 6;
		} else if(presscount == 6) {
			presscount = 1;
			presscountshow = 1;
			playMovie();
		}
}
// 视频后退
function  reverseMovie(){   
		show_progress = true;    // 进度条的显示标识
		playstatus ="pause";  //赋值播放状态为 pause
		shiftState = true;   // 进入时移状态
		setInter(presscount);  // 循环调用进度条的图层的方法
		$("volume").style.visibility = "hidden";   //  影片音量的图层隐藏
		$("apDiv13").style.display = "none";   // 影片的信息图层
		showbar();    // 显示进度条
		if(presscount > 0 || presscount == -1) {
			mp.fastRewind(-2);
			presscountshow = -2;
			presscount = -2;
		} else if(presscount == -2) {
			mp.fastRewind(-4);
			presscountshow = -4;
			presscount = -3;
		}else if(presscount == -3){
			mp.fastRewind(-8);
			presscountshow = -8;
			presscount = -4;
		}else if(presscount == -4){
			mp.fastRewind(-16);
			presscountshow = -16;
			presscount = -5;
		} else if(presscount == -5){
			mp.fastRewind(-32);
			presscountshow = -32;
			presscount = -6;
		} else if(presscount == -6) {
			presscount = 1;
			presscountshow = 1;
			playMovie();
		}		
}

function $(id){ return document.getElementById(id); }   // 获取指定id的对象

// 进度条
function time(){        
		// 直播视频的当前时间
		var UTChh_curtime = 8 + 1 * mp.getCurrentPlayTime().substring(mp.getCurrentPlayTime().indexOf("T")+1,mp.getCurrentPlayTime().indexOf("T")+3); 
	    var UTCmm_curtime = mp.getCurrentPlayTime().substring(mp.getCurrentPlayTime().indexOf("T")+3,mp.getCurrentPlayTime().indexOf("T")+5); 
		var UTCss_curtime = mp.getCurrentPlayTime().substring(mp.getCurrentPlayTime().indexOf("T")+5,mp.getCurrentPlayTime().indexOf("T")+7); 
		var datetime = new Date();                     // 系统当前时间
		var hh = datetime.getHours();                  // 获取系统当前时间的小时减去8小时		
		var UTChh_nowtime= datetime.getHours();        // 获取系统当前时间的小时减去8小时
	
		if(hh < 10){hh = "0" + hh;}
		if(UTChh_nowtime < 10){UTChh_nowtime = "0"+UTChh_nowtime;}

		var mm = datetime.getMinutes();              // 获取系统当前时间的分数 
		var ss = datetime.getSeconds();              // 获取系统当前时间的秒数 
		
		if(mm < 10){mm = "0" + mm;}
				
		$("endtime").innerHTML = hh+":"+mm;
        var endhh = hh*1-1;
        if (endhh < 10) {
        	endhh = "0" + endhh;
       	}
		$("begintime").innerHTML = endhh +":"+mm;
		
        var time = UTChh_nowtime*3600 + mm*60 + ss*1;     // 获取当前的系统时间
		
	    var videotime = UTChh_curtime*3600 + UTCmm_curtime*60 + UTCss_curtime*1;   // 获取视频播放的当前时间
		
		// 用1小时减去系统时间与视频播放的时间的差值后除以1小时，获取百分比
		var percentage = Number((3600 - (time*1 - videotime*1)) / 3600 * 100)+"";    //bm wangxg20160925
		
		// 获取的百分比去整数
		var num = (3600 - (time*1 - videotime*1)) / 3600 * 100;   
		num = Math.floor(num);
		var percentagestr = percentage.substring(percentage.indexOf(".")+1,percentage.indexOf(".")+2);   // 获取百分比数字小数点后的数字
		
		var numInt = percentagestr*1; 
		
		// 判断小数点后的数字是否大于5（四舍五入）
		if(numInt >= 5){ num = num*1 + 1;}
		
	    $("barimg").style.width = num + "%";          // 进度条上面蓝线的长度

		var cur_hh = UTChh_curtime;    
		
		if(cur_hh < 10){ cur_hh = "0"+ cur_hh;}
		$("play_Div12").innerHTML = cur_hh+":"+UTCmm_curtime + " / "+ num + "%"  + " " + presscountshow + "X";    // 视频播放的时间
		
		$("play_Div12").style.left = 10 + 3 * (num);    // 视频播放的当前时间的图层位置要随着滚动条的长度而改变
		if((cur_hh+":"+UTCmm_curtime+":"+UTCss_curtime) == (hh+":"+mm+":"+ss) || num == 100){          // 判断视频是否播放到了系统的当前时间处
			shiftState = false;   // 退出时移状态
		    show_progress = false;    // 进度条的显示标识
			presscount = 1;
			//hidebar();
		} 
		if((cur_hh+":"+UTCmm_curtime+":"+UTCss_curtime) == ($("begintime").innerHTML) || num == 0){     // 判断视频是否播放到了直播时移前的一小时处
		    shiftState = true;        // 时移状态
		    show_progress = false;    // 进度条的显示标识
			shiftStateOnehours = true;  // 进入时移状态前一小时处
			presscount = 1;
			//hidebar();
		}
		
}

// 循环调用进度条的图层的方法
function setInter(){ setInterval("time()",5000); }

function playImg(){
	var stime = 4;
	var timeIntervalPlay = setInterval(function (){
	  if (stime == 0) { 
		  clearInterval(timeIntervalPlay);  
		  show_progress = false;    // 进度条的显示标识
		  //hidebar();       // 隐藏进度条
		  return; 
		}
		stime -= 1;
	  }, 1000);
}

function showbar(){ $("apDiv10").style.display = "block";}   // 显示进度条的图层

// 隐藏进度条的图层
function hidebar(){
	$("apDiv10").style.display = "none";
	$("apDiv101").style.display = "none";  // 隐藏跳转到指定时间的图层
	window.clearTimeout(tiaoZhanTime);
	tiaoZhanStatus = false;   // 跳转到指定时间图层的标识
} 
// 进度条中添加问跳转时间后按确定按钮触发的事件
function submittime(){ 
    var end_hh = $("endtime").innerHTML.substring(0,2); 
	var end_mm = $("endtime").innerHTML.substring(3,5);
	//var end_hh_mm_val = parseInt(end_hh)*60+parseInt(end_mm);   // 时移结束的时长
	var end_hh_mm_val = end_hh*60+end_mm*1;   // 时移结束的时长
	var statr_hh = $("begintime").innerHTML.substring(0,2); 
	var statr_mm = $("begintime").innerHTML.substring(3,5);
	//var statr_hh_mm_val = parseInt(statr_hh)*60+parseInt(statr_mm);  // 时移开始的时长
	var statr_hh_mm_val = statr_hh*60+statr_mm*1;  // 时移开始的时长
    if($("hh").value == null || $("hh").value == ""){$("hh").value = "00";}
	if($("mm").value == null || $("mm").value == ""){$("mm").value = "00";}
	//var hh_mm_val_input = parseInt($("hh").value)*60+parseInt($("mm").value);
	var hh_mm_val_input = $("hh").value*60+$("mm").value*1;
	
	if(hh_mm_val_input*1 <= end_hh_mm_val*1 && hh_mm_val_input*1 >= statr_hh_mm_val*1){
	    var UTCtime_s = mp.getCurrentPlayTime().substring(0,mp.getCurrentPlayTime().indexOf("T")+1); 
        var UTCmm_e = mp.getCurrentPlayTime().substring(mp.getCurrentPlayTime().indexOf("T")+5); 
		var jumphh = $("hh").value*1-8;
		if (jumphh < 10) {
			jumphh = "0" + jumphh;
		}
		var video_time = "" +  UTCtime_s + jumphh + $("mm").value + "00" + "Z";
		show_progress = false;    // 进度条的显示标识
		hidebar();      // 隐藏进度条
		playstatus = "play";     //播放状态    play：播放 / pause：暂停 
		mp.playByTime(2,video_time,1); 
	}else{
		$("error").innerHTML = "时间输入不合理，请重新输入";
	}

}

function quxiao_bar(){    // 进度条跳转时的取消按钮
	$("hh").value = "";
	$("mm").value = "";
}

function closeMp(){         //页面离开时的方法
    mp.leaveChannel();
	mp.stop();     
}

//操作方法
function help(){
	
	window.clearTimeout(infotimeout);
	$("apDiv13").style.display = "none";   // 影片的信息图层
	movieInfo = true;

	if(helpMessage){
		helpMessage = false;
		$("help").style.display = "none";
	}else{
		helpMessage = true;
		$("help").style.display = "block";
	}
}

function leave(){
   leaveStatus = true;    // 暂离功能图层的状态
   $("leave").style.display="block";  // 显示暂离的图层
   $("sub").focus();
}




//以下代码为输入数字键中转致直播
var ChannelNum = "";
var showNumTimeOut = -1;
var lineArray = ["_","__","___"];
var lineIndex = 0;
var lineTimeout = -1;


 function inputNum(num){
	 if (playmode == "pause")return ;
	// createDiv("channel_num","50px","36px");
	ChannelNum = ChannelNum + num;
	//没下划线时输入数字的最大长度为3,有下划线时输入的最大长度为下划线的长度
	if(ChannelNum.length == 4 || (checkChanNumShow() && ChannelNum.length == (lineIndex+2)))
	{
		ChannelNum = num + "";
	}
	// window.frames["EPG"].window.document.getElementById("channel_num").innerText = ChannelNum;
	document.getElementById("channel_num").innerText = ChannelNum;
	showChanNumDiv("channel_num");
	clearTimeout(showNumTimeOut);
	clearTimeout(lineTimeout);
	showNumTimeOut = setTimeout(function (){
	if(!checkChanNumShow() || ChannelNum.length == (lineIndex+1))//判断输入的数字是否等于下划线的长度
	{
		playChannel();
	}
	},2000);
}

//上下左右键扩展方法
/*	keyUp = function(){}
	keyDown = function(){}
	keyLeft = function(){}
	keyRight = function(){}*/

function closeIframe()
{
	document.getElementById("tvmsInfo").style.display = "none";
	document.getElementById("close").blur();
	
}

function playChannel()
{
	if(ChannelNum == "")
	{
		return;
	}
	if(typeof(changeChannelByNum) == "undefined")
	{
		goToPlayChannel(ChannelNum);
	}
	else
	{
		changeChannelByNum(ChannelNum);
		hiddenChanNumDiv("channel_num");
		hiddenChanNumDiv("channel_line");
	}
	ChannelNum = "";
}
function goToPlayChannel(ChannelNum)
{
	setTimeout(function(){hiddenChanNumDiv("channel_num");},2000);
	currChannelNum = ChannelNum;
	joinChannel1(ChannelNum);

}
function keyBottomLine()
{
	createDiv("channel_line","35px","48px");
	clearTimeout(lineTimeout);

	if(checkChanNumShow())
	{
		lineIndex++;
		if(lineIndex == lineArray.length)
		lineIndex=0;
	}
	
	ChannelNum = "";
	document.getElementById("channel_num").innerText = ChannelNum;
	document.getElementById("channel_line").innerText = lineArray[lineIndex];

	showChanNumDiv("channel_line");
	lineTimeout = setTimeout(function(){hiddenChanNumDiv("channel_line");},2000);
}
function showChanNumDiv(divName)
{
	document.getElementById(divName).style.display = "block";
}
function hiddenChanNumDiv(divName)
{
	document.getElementById(divName).style.display = "none";
}
function checkChanNumShow()
{
	return document.getElementById("channel_line").style.display == "block";
}










</script>
<style>
*{ padding:0; margin:0;}
</style>
</HEAD>
<!-- //bm wangxg20160925  -->
<BODY bgcolor=transparent onUnload="closeMp()" onLoad="onLoadMehtod()" >    

<!-- 进度?-->
			    <div style="width:200px;height:30px;margin-left:1000px;margin-top:80px;position: absolute;" >
		<font  id="channel_num"  color=green size=20></font>
		</div>
<div id="apDviv010">
<div id="apDiv10" style="display:none;top:350px;">
  <table width="500" height="70" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="70" background="images/liveendbg.png"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" colspan="3" valign="top" class="livebg" id="begintime2"><div id="play_Div12"></div></td>
          </tr>
          <tr>
            <td id="begintime" width="9%" height="30" class="livebb3">
             00:00
            </td>
            <td width="72%" height="30"><table width="98%" height="20" background="images/greyline.png" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><div id="barimg" style="overflow:hidden;width:1%; height:30px;"><img src="images/blueline.png"></div></td>
              </tr>
            </table></td>
            <td width="19%" height="30" class="livebb3"><div id="endtime">00:00</div></td>
          </tr>
        </table></td>
      </tr>

  </table>
</div>
</div>
<!--  跳转到指定的时间 -->
<div id="apDiv101" style="display:none;">
<table width="500" height="63" border="0" cellspacing="0" cellpadding="0">
<form action="" method="post" id="form1">
  <tr>
    <td height="63" background="images/liveendbg1.png"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="6" class="livebg"><font color="#FF9900">
              <div id="error"></div>
            </font></td>
          </tr>
          <tr>
            <td width="18%" class="livebb4">跳转到</td>
            <td width="15%"><input type="text" name="hh" id="hh" maxlength="2" style="height:30px; width:60px;line-height:30px; text-align:center; font-size:20px;  background:#babab9; border:1px #babab9 solid;"></td>
            <td width="11%" class="livebb4">时</td>
            <td width="15%"><input type="text" name="mm" id="mm" maxlength="2" style="height:30px; width:60px;  line-height:30px; text-align:center; font-size:20px; background:#babab9; border:1px #babab9 solid;"></td>
            <td width="11%" class="livebb4">分</td>
            <td width="20%"><a href="javascript:submittime()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image28','','images/sure1.png',1)"><img src="images/sure.png" name="Image28" width="86" height="43" border="0"></a></td>
            <td width="21%"><a href="javascript:quxiao_bar()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image32','','images/quxiao1.png',1)"><img src="images/quxiao.png" name="Image32" width="86" height="43" border="0"></a></td>
          </tr>
        </table></td>
      </tr>

</table>
</div>
<!--  音量的进度图 -->
<div id="volume" style="visibility: hidden;" >
<table width="402" height="69" background="images/liveinfobg.png"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center">
        <div style="width:355px;height:19px;background-image: url(images/volume_bg.png);">
            <div style="margin-left:21px;" align="left" id="volumeBar"></div>
        </div>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</div>

<!-- 影片信息图层 -->
<div id="apDiv13" style="display:none;">

  <table width="308" border="0" height="107" background="images/playinfobg.png" cellspacing="0" cellpadding="0">
    <tr>
      <td height="47"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="5" class="bb1">
        <tr>
          <td width="31%">下一个节目：</td>
          <td width="69%"><span id="programNext"></span></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td valign="top" ><table width="98%" border="0" align="center" cellpadding="0" cellspacing="5" class="livebb4">
        <tr>
          <td width="21%" height="60" align="center"><span id="startAndEnd"></span></td>
          <td width="36%" align="center"><span id="program"></span></td>
          <td width="17%" align="center"><span id="duration"></span>分钟</td>
          <td width="26%" align="center"><span id="channelName"></span></td>
        </tr>
      </table>
        </td>
    </tr>
  </table>

</div>

<script type="text/javascript">

function backupdate(type){     // 关闭信息图层的方法
	if(type == 'payOrthrow'){
		 message = false;    // 手机客户端的甩与支付的标识
		 document.getElementById("div5").style.display = "none";    // 获取层的对象
		 testServicePlayId = setInterval("callServerPlay()",3000);  // 回复手机客户端甩与支付的监听
	}else if(type == 'message'){
		message = false;    // 电视短信图层的标识
		document.getElementById('div6').style.display = 'none';   // 电视短信层消失
		testServicePlayId = setInterval("callServerPlay()",3000);   // 回复电视短信的监听
	}
}
</script>

<!--  频道不存在的图层 -->
<div id="isNotSubFlag" style="display:none;">
<table width="428" border="0" height="322" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="66">&nbsp;</td>
  </tr>
  <tr>
    <td height="256" align="center" valign="middle"  background="images/outwindows.jpg"><table width="400" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td height="140" align="center" valign="middle"><font color="#FFFFFF">频道<span id="num"></span>不存在，<br />
          请切换到其它频道收看。</font></td>
      </tr>
      <tr>
        <td><table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td align="center"></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>



</BODY> 
</HTML>