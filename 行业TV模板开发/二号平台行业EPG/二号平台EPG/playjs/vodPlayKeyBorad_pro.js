var countDown = false 
var isrecom = false
//***************各个键值所触发的方法********************//

document.onirkeypress = keyEvent;
document.onkeypress = keyEvent;

function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}


function keypress(keyval){
 switch (keyval){
	case(0x8):			// 返回键
	if (isrecom) {
			document.getElementById('rightPop').style.display = 'none';
    		isrecom = false;
    		return;
		}
	    
		//if(isAd){return;}       // 判断是否是视频广告
	    //if(message){return;}   // 手机客户端的甩与支付的标识
	    if(show_progress){ playMovie();}  // 判断是否处于进度条状态,要停止进度条并隐藏
		hidebar();   // 隐藏进度条
	    document.getElementById("apDiv13").style.display = "none";   // 影片的信息图层
	    document.getElementById("apDiv10").style.display = "none";   // 影片的信息图层
	    document.getElementById("apDiv14").style.display="block";    // 显示返回时的图层
	    document.getElementById("apDiv101").style.display = "none";   // 影片的信息图层
	    isrecom = true
		playstatus="pause";
		//document.getElementById("help").style.display="none";    // 显示返回时的图层
        document.getElementById("myplay").focus();
	    //document.getElementById("pause").style.display = "block";   // 影片的信息图层
		helpMessage = true;
		mp.pause();
		OnKeyBack();
		break;
	case(0x270):			// 返回键
	    if (isrecom) {
			document.getElementById('rightPop').style.display = 'none';
    		isrecom = false;
    		return;
		}
		//if(isAd){return;}       // 判断是否是视频广告
	    //if(message){return;}   // 手机客户端的甩与支付的标识
	    if(show_progress){ playMovie();}  // 判断是否处于进度条状态,要停止进度条并隐藏
		hidebar();   // 隐藏进度条
	    document.getElementById("apDiv13").style.display = "none";   // 影片的信息图层
	    document.getElementById("apDiv10").style.display = "none";   // 影片的信息图层
	    document.getElementById("apDiv14").style.display="block";    // 显示返回时的图层
	    isrecom = true
	    document.getElementById("apDiv101").style.display = "none";   // 影片的信息图层
		playstatus="pause";
		document.getElementById("myplay").focus();
		//document.getElementById("help").style.display="none";    // 显示返回时的图层
	    //document.getElementById("pause").style.display = "block";   // 影片的信息图层
		helpMessage = true;
		mp.pause();
		OnKeyBack();
		break;
	case(270):			// 返回键
	    if (isrecom) {
			document.getElementById('rightPop').style.display = 'none';
    		isrecom = false;
    		return;
		}
		//if(isAd){return;}       // 判断是否是视频广告
	    //if(message){return;}   // 手机客户端的甩与支付的标识
	    if(show_progress){ playMovie();}  // 判断是否处于进度条状态,要停止进度条并隐藏
		hidebar();   // 隐藏进度条
	    document.getElementById("apDiv13").style.display = "none";   // 影片的信息图层
	    document.getElementById("apDiv10").style.display = "none";   // 影片的信息图层
	    document.getElementById("apDiv14").style.display="block";    // 显示返回时的图层
	    document.getElementById("apDiv101").style.display = "none";   // 影片的信息图层
		playstatus="pause";
		isrecom = true
		document.getElementById("myplay").focus();
		//document.getElementById("help").style.display="none";    // 显示返回时的图层
	    //document.getElementById("pause").style.display = "block";   // 影片的信息图层
		helpMessage = true;
		mp.pause();
		OnKeyBack();
		break;
	case (0x107):			// 暂停/播放键
	    if(helpMessage){return;} // 判断是否是帮助弹出层
		if(message){return;}   // 手机客户端的甩与支付的标识
	    if(isAd){return;}       // 判断是否是视频广告
		if(backInfo){return;}   // 判断是否处于返回图层状态
		KEY_PLAY();       // 暂停/播放的方法
		break;
    
	case (0x108):			// 快进键
		//if(playstatus=="pause"){return;}
		if (isrecom) {
			return
		}
		if(countDown){
			return false
		}
	    if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}       // 判断是否是视频广告
	    if(message){return;}   // 手机客户端的甩与支付的标识
	 	if(backInfo){return;}  // 判断是否处于返回图层状态
		if(tiaoZhanStatus){   // 判断是否处于跳转图层显示的状态
			window.clearTimeout(tiaoZhanTime);
			tiaoZhanStatus = true;   // 跳转到指定时间图层的标识
			tiaoZhanTimeOut();  // 跳转到指定时间的图层的显示时间
			return;
		}  
		KEY_SPEED();      // 快进的方法
		break;
	case (0x27):			// 快进键
		//if(playstatus=="pause"){return;}

if (isrecom) {
			return
		}
		// 2018/12/10修改弹出倒计时界面不执行快进快退
		if(countDown){
			return false
		}

	    if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}       // 判断是否是视频广告
	    if(message){return;}   // 手机客户端的甩与支付的标识
	 	if(backInfo){return;}  // 判断是否处于返回图层状态
		if(tiaoZhanStatus){   // 判断是否处于跳转图层显示的状态
			window.clearTimeout(tiaoZhanTime);
			tiaoZhanStatus = true;   // 跳转到指定时间图层的标识
			tiaoZhanTimeOut();  // 跳转到指定时间的图层的显示时间
			return;
		}  
		KEY_SPEED();      // 快进的方法
		break;
	case (0x109):			// 后退键
		//if(playstatus=="pause"){return;}
		// 2018/12/10修改弹出倒计时界面不执行快进快退
		if (isrecom) {
			return
		}
		if(countDown){
			return false
		}

	    if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}       // 判断是否是视频广告
	    if(message){return;}   // 手机客户端的甩与支付的标识
	 	if(backInfo){return;}  // 判断是否处于返回图层状态
		if(tiaoZhanStatus){   // 判断是否处于跳转图层显示的状态
			window.clearTimeout(tiaoZhanTime);
			tiaoZhanStatus = true;   // 跳转到指定时间图层的标识
			tiaoZhanTimeOut();  // 跳转到指定时间的图层的显示时间
			return;
		}  
		KEY_REVERSE();   // 后退的方法
		break;
	case (0x25):			// 后退键
	if (isrecom) {
			return
		}
		//if(playstatus=="pause"){return;}
		if(countDown){
			return false
		}
	    if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}       // 判断是否是视频广告
	    if(message){return;}   // 手机客户端的甩与支付的标识
	 	if(backInfo){return;}  // 判断是否处于返回图层状态
		if(tiaoZhanStatus){   // 判断是否处于跳转图层显示的状态
			window.clearTimeout(tiaoZhanTime);
			tiaoZhanStatus = true;   // 跳转到指定时间图层的标识
			tiaoZhanTimeOut();  // 跳转到指定时间的图层的显示时间
			return;
		}  
		KEY_REVERSE();   // 后退的方法
		break;
	case (0x104):			   // 音量- 键
		//if(playstatus=="pause"){return;}
		if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}            // 判断是否是视频广告
        if(show_progress){ return;}  // 判断是否处于进度条的状态
	    if(backInfo){ return;}       // 判断是否处于返回图层状态
		if(message){ return;}       // 弹出层提示的信息层的状态
		hidebar();    // 隐藏进度条
	    //document.getElementById("apDiv14").style.display="none";    // 显示返回时的图层
		currVolume = mp.getVolume();
		volumeAdjust(-5);
		break;
	case (0x25):			   // 音量- 键  华为
		//if(playstatus=="pause"){return;}
		if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}            // 判断是否是视频广告
        if(show_progress){ return;}  // 判断是否处于进度条的状态
	    if(backInfo){ return;}       // 判断是否处于返回图层状态
		if(message){ return;}       // 弹出层提示的信息层的状态
		hidebar();    // 隐藏进度条
	    //document.getElementById("apDiv14").style.display="none";    // 显示返回时的图层
		currVolume = mp.getVolume();
		document.getElementById("volume").style.visibility = "visible";
		volumeAdjust(-5);
		break;
	case (0x27):			// 音量+ 键华为
		//if(playstatus=="pause"){return;}
		if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}       // 判断是否是视频广告
		if(show_progress){ return;}  // 判断是否处于进度条的状态
	    if(backInfo){ return; }   // 判断是否处于返回图层状态
		if(message){ return; }   // 弹出层提示的信息层的状态
		hidebar();    // 隐藏进度条
	    //document.getElementById("apDiv14").style.display="none";    // 显示返回时的图层
	    currVolume = mp.getVolume();
	    volumeAdjust(+5);
	    break;
	case (0x103):			// 音量+ 键
		//if(playstatus=="pause"){return;}
		if(helpMessage){return;} // 判断是否是帮助弹出层
	    if(isAd){return;}       // 判断是否是视频广告
		if(show_progress){ return;}  // 判断是否处于进度条的状态
	    if(backInfo){ return; }   // 判断是否处于返回图层状态
		if(message){ return; }   // 弹出层提示的信息层的状态
		hidebar();    // 隐藏进度条
	    //document.getElementById("apDiv14").style.display="none";    // 显示返回时的图层
	    currVolume = mp.getVolume();
	    volumeAdjust(+5);
	    break;
	case (0x105):			// 静音键
		var mute;
		mute = mp.getMuteFlag();
		if(mute == 0)
			mute = 1;
	    else mute = 0;
			mp.setMuteFlag(mute);
		break;
	case (0x106):    // 声道
	      mp.switchAudioChannel();
		break;
	case (0xd): 			// 确认键 （ 显示视频信息的图层，显示5秒后自动消失）

		if(!isrecom) {
			    getGGData(addatas);
				document.getElementById('ttime').innerHTML = timeFormat(mp.getMediaDuration())
     			document.getElementById('rightPop').style.display = 'block'
         		isrecom = true
         		document.getElementById('tj_1').focus()
         		if(service1flag1!=1 && nextCode1!="0" && document.getElementById('controlD').innerHTML.indexOf('playNext') < 0){
         			document.getElementById('controlD').innerHTML += '<a href="javascript:playNext()"><img src="./img/next.png"></a>'
         		}
         		if(service1flag1!=1 && preCode1!="0"  && document.getElementById('controlD').innerHTML.indexOf('playPre') < 0){
         			document.getElementById('controlD').innerHTML = '<a href="javascript:playPre()"><img src="./img/pre.png"></a>' + document.getElementById('controlD').innerHTML
         		}
         		// document.getElementById("bfmovie").style.display = 'none'
         		setInterval(function(){
         			document.getElementById('ctime').innerHTML = timeFormat(parseInt(mp.getCurrentPlayTime()))
         		},1000)
         		return;
     		}

		if(playstatus=="pause" || playstatus=="pause1"){return;}
		//if(helpMessage){return;} // 判断是否是帮助弹出层
		//if(show_progress){return;} // 判断是否是帮助弹出层
	    //if(isAd){return;}       // 判断是否是视频广告
		//if(message){return;}   // 手机客户端的甩与支付的标识
		//if(show_progress){return; } // 判断是否处于进度条状态
		//if(backInfo){ return;}  // 判断是否处于返回图层状态
		if (playstatus=="play"){
			if(movieInfo){     // 判断影片信息的图片标识
			    movieInfo = false;
				document.getElementById("apDiv13").style.display="block";      // 影片信息的标识的图层显示
				window.clearTimeout(infotimeout);
				infotimeout = window.setTimeout(function(){movieInfo = true;$("apDiv13").style.display="none";},4000);
				document.getElementById("myplayreturnid").focus();
			}else{
				if(document.activeElement=="javascript:tuisong()"){
				
				}else if(document.activeElement=="javascript:tuisongno()"){
				
				}else{
				movieInfo = true;
				document.getElementById("apDiv13").style.display="none";      // 影片信息的标识的图层隐藏
				}
				
			}
		}
		break;
		
	case KEY_HELP:    // 视频推送(帮助按钮)
	    if(channeleng == "interact"){   // 判断是否是互动频道
			if(helpMessage){return;} // 判断是否是帮助弹出层
			if(isAd){return;}       // 判断是否是视频广告
			if(message){return;}   // 手机客户端的甩与支付的标识
			if(show_progress){return; } // 判断是否处于进度条状态
			if(backInfo){ return;}  // 判断是否处于返回图层状态
			
			help();
		}

	    break;

	
	case KEY_TV_MENU:    // 直播键
		window.location.href="live.jsp";
		//  window.location=Authentication.CTCGetConfig('EPGDomain');
		break;
	case KEY_TVOD_MENU:    // 回看键
		window.location.href="playbill.jsp";
		break;
	case KEY_VOD_MENU:    // 点播键
		window.location.href="demand.jsp";
		break;
	case KEY_INFOMENU:   // 信息键
		window.location.href="collect.jsp";
		break;
	case KEY_INFO:     //  信息键
		window.location.href="inboxlist.jsp";
		break;
	case 0x300:		// 虚拟按键定义，EPG页面的js逻辑通过onkeypress函数进行响应。虚拟事件通过Utility对象的getEvent函数获取
	   
		goUtility();
		break;
    }
	return true;
}
