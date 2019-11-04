<%@page contentType="text/html; charset =UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="channel-hd_new.jsp"%> 
<%  
String chanId=request.getParameter("ChannelId");
String showId=request.getParameter("showid");
%>  
<head>
	<meta charset="UTF-8">  
	<title>播放页</title>
	<meta name="Page-View-Size" content="1280*720">
	<link rel="stylesheet" href="css/play/reset.css">
	<link rel="stylesheet" href="css/play/common.css">
	<link rel="stylesheet" href="css/play/menu.css">
	<link rel="stylesheet" href="css/play/vol.css">
	<link rel="stylesheet" href="css/play/playbar.css">
	<link rel="stylesheet" href="css/play/channel.css">
	<style>
		.vedio{
			width: 1280px;
			height: 720px;
		}
		.menu-container{
			position: absolute;
			top: 0;
			left: -451px;
			height: 720px;
		}
		.menu-list-channel-type{
			position: absolute;
			left: 200px;
			top: 20px;
			font-size: 14px;
			color: #fff;
			background-color: #f30;
			border-radius: 2px;
			line-height: 1;
			display:none;
		}
	</style>
</head>
<body>
	<div style="position: relative;overflow: hidden;width: 1280px;height: 720px;">
<!-- 		<div class="vedio"> -->
<!-- 			<video width="100%" height="100%" autoplay preload="none" loop poster="img/bg_menu_gap_1_1.png" id="vp" src="sounds/hk.mp4"> -->
<!-- 			</video> -->
<!-- 		</div> -->
		<div class="menu-container"><!-- 菜单容器开始 -->
			<div class="menu menu-list-container menu-list-container-narrow"><!-- 频道类型菜单容器开始 -->
				<ul class="menu-list">
				</ul>
			</div><!-- 频道类型菜单容器结束 -->
			<div class="menu menu-gap"></div><!-- 菜单缝隙 -->
			<div class="menu menu-list-container menu-list-container-wide"><!-- 频道菜单容器开始 -->
				<ul class="menu-list">
				</ul>
			</div><!-- 频道菜单容器结束 -->
			<div class="menu menu-gap dn"></div><!-- 菜单缝隙 -->
			<div class="menu menu-list-container menu-list-container-wide" style="width:0"><!-- 节目菜单容器开始 -->
				<ul class="menu-list">
				</ul>
			</div><!-- 节目菜单容器结束 -->
			<div class="menu menu-gap dn"></div><!-- 菜单缝隙 -->
			<div class="menu menu-list-container menu-list-container-narrow" style="width:0"><!-- 日期菜单容器开始 -->
				<ul class="menu-list">
				</ul>
			</div><!-- 日期菜单容器结束 -->
			<div class="menu menu-gap dn"></div><!-- 菜单缝隙 -->
			<div class="menu menu-hint-right dn" id="arrowRight"><!-- → -->
				<img src="img/arrow-right.png" width="35px" height="24px" alt="">
			</div>
		</div><!-- 菜单容器结束 -->
		<div class="menu-hint-left dn"><!-- <容器开始 -->
			<img src="img/arrow-left.png" width="35px" height="24px" alt="">
		</div><!-- <容器结束 -->
		<div class="bar-container dn" id="volLayer">
			<div class="left-container" id="leftContainer"></div>
			<div class="left" id="volBarLeft"></div>
			<div class="right vh" id="volBarRight"></div>
			<div class="bar-center" id="icoVol"></div>
		</div>
		<div class="current-info" id="currentInfo">
			<div class="current-info-cid">
				<ul>
					<li class="channel-num num1"></li>
					<li class="channel-num num2"></li>
					<li class="channel-num num3"></li>
				</ul>
			</div>
			<div class="current-info-channel">CCTV-15音乐</div>
			<div class="current-info-program">正在直播：MV《空白格》</div>
		</div>
		<div class="playbar-container dn" id="playBarContainer"><!-- 播放进度层开始 -->
			<div class="playstate playstate-play"></div>
			<div class="playbar-bg">
				<div class="playbar">
					<div class="playtime">
					</div>
				</div>
			</div>
		</div><!-- 播放进度层结束 -->
		<div class="loading" id="loadingLayer"></div>
		<div class="back dn" id="back"></div>
	</div>
	<iframe src="" id="recommDataIfr" name="recommDataIfr" style="width:0px; height:0px; border:0px;" frameborder="0"></iframe>
	<script src="js/play/extend.js"></script>
	<script src="js/play/common.js"></script>
	<script src="js/play/master-bf.js"></script>
	<script src="js/play/log.js"></script>
	<script src="js/play/vol.js"></script>
	<script src="js/play/loading.js"></script>
	<script src="js/play/playbar.js"></script>
	<script src="js/play/channel.js"></script>
	<script src="js/play/playMenu.js"></script>
	<script src="js/play/keyPress.js"></script>
	<script>
	var chanId='<%=chanId%>';
	var showId='<%=showId%>';
		var channels=[
			"http://10.19.1.11/hls/tjcsl/index.m3u8",//天津
			"http://10.19.1.11/hls/4kcq/index.m3u8",//北京4k电影
			"http://10.19.1.11/hls/tj4k/index.m3u8"//天津4k
		]
		function inputNum(num){
			document.getElementById("vp").src=channels[num-1]
			console.log(document.getElementById("vp").src)
		}

		 function getCookie(name){
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
        else
        return null;
    }
function programGo(index){

		var tempObj = progCurrentInfo_JS[index];
		var palyable = tempObj.palyable;
		var tvod = tempObj.tvod;
		var recordsystem = tempObj.recordsystem;
		var contentcode = tempObj.contentid;
	    var columnid = '01';
	    var zb = getCookie('zb').split(',');
        var channelid = zb[menu.menus[1].selIndex]; 
		

		if(tvod=='1'){
		  window.location.href  = "channel_detail.jsp?mixno="+channelid;
		}else{
		 if(palyable=="true"&&recordsystem=='1'){
				
			
	       window.location.href  = "channel_tv_auth.jsp?columnid="+columnid+'&<%=EpgConstants.CHANNEL_ID%>='+channelid+'&<%=EpgConstants.CONTENT_CODE%>='+contentcode+"&ContentID="+contentcode
	       +"&destpage=0&CategoryID="+columnid+"&ContentType=4&FatherContent="+channelid;

	   
		}
	}	
		
}

	
	</script>
</body>
</html>
