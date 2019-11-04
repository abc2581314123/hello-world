<!DOCTYPE html>
<%@ include file="datajsp/tvod_progBillByRepertoireData-zb.jsp"%>
<%@ include file = "zb-channellist-control-pro.jsp"%>
<html lang="zh-CN">
<head>
	<meta charset="UTF-8">
	<title>列表页</title>
	<meta name="Page-View-Size" content="1280*720">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<link rel="stylesheet" href="hd-css/reset.css">
	<link rel="stylesheet" href="hd-css/common.css">
	<link rel="stylesheet" href="hd-css/list-channel-new_pro.css">
</head>
<body style="background: url(./hd-img/bodyNC.jpg);">



<jsp:include page="adload_zb_HD.jsp">
<jsp:param name="pageID" value="zb-channellist.jsp"/>
<jsp:param name="onepageID" value=""/>
</jsp:include>
	<div style="width:200px;height:30px;margin-left:1024px;margin-top:60px;position: absolute;" >
		<font  id="channel_num" color=green size=20></font>
	</div>


	<div><!-- 页面容器开始 -->
		<div class="area area-menu"><!-- 菜单容器开始 -->
			<div class="search" id="search"></div>
			<div class="menu menu-list-container">
				<ul class="menu-list">
					<li>全部</li>
					<li>高清</li>
					<li>央视</li>					
					<li>卫视</li>               
					<li>地方</li>
					<li>少儿</li>
	                <li>电影</li>
					<li>剧场</li>
					<li>购物</li>
					<li>其他</li>
				</ul>
			</div>
		</div><!-- 菜单容器结束 -->
		<div class="area area-main"><!-- 列表容器开始 -->
			<div class="part-info"><!-- 头部信息容器开始 -->
				<div class="part-info-nav">
					<span style="font-size:26px;">直播 <span id="num" class="fcfd0">444</span> 台 &nbsp;&nbsp;&nbsp;&gt;</span>
					<span id="programNav">全部</span>
				</div>
				<div class="part-info-mind">
					<img class="vam" id="arrowUp" src="hd-img/arrow-up.png" data-src="hd-img/arrow-up-sel.png" alt="">
					<img class="vam" id="arrowDown" src="hd-img/arrow-down.png" alt="" data-src="hd-img/arrow-down-sel.png">
					<span class="fcfd0" id="currentPage">1</span>/<span id="totalline">39<span>行
				</div>
			</div><!-- 头部信息容器结束 -->
			<!--纵向滚动条轨道-->
			<div id="orbital"></div>

			<!--滚动条方框-->
			<div id="square"></div>
			<div class="part-list" id="part-list"><!-- 列表展示容器开始 -->
				<div class="channel-list"><!-- 列表容器开始 -->
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>   
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
					<div class="channel">
						<div class="channel-content">
							<div class="channel-id">223</div>
							<div class="channel-detail">
								<div class="channel-name">江苏卫视</div>
								<div class="channel-cp">我们相爱吧</div>
							</div>
						</div>
					</div>
				</div><!-- 列表容器结束 -->
			</div><!-- 列表展示容器结束 -->
		</div><!-- 列表容器结束 -->
	</div><!-- 页面容器结束 -->
	<script src="hd-js/extend_zb.js"></script>
	<script src="hd-js/common_zb.js"></script>
	<script src="hd-js/list-channel-new_pro.js"></script>
	<script src="hd-js/keyPress_zb.js"></script>
	<script>
		// var GOTOType;
		// if ('CTCSetConfig' in Authentication) {
		// 	GOTOType = Authentication.CTCGetConfig("STBType");
		// } else {
		// 	GOTOType = Authentication.CUGetConfig("STBType");
		// }
		// if(GOTOType.indexOf("HG680")>=0){	
		// 	document.documentElement.className='b860'
		// }
			//document.documentElement.className='b860'
			//
				  function keyBack(){
        window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp";
    }


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
setCookie("zbBackurl",location.href);
  setCookie("zbFlag","false");
	</script>
</body>
</html>