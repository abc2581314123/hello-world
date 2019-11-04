<!-- Copyright (C), Huawei Tech. Co., Ltd. -->
<!-- Author:duanxiaohui -->
<!-- CreateAt:20050811 -->
<!-- FileName:PlayControleTVod -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.io.*"%>
<%@ include file = "OneKeySwitch.jsp"%>
<%@ include file="statisticsHw.jsp"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp"%>
<script type="text/javascript">
        var isFromVas = false;
</script>
<%

    TurnPage turnPage = new TurnPage(request);
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);



    String productId = request.getParameter("PRODUCTID");
    String serviceId = request.getParameter("SERVICEID");
    String _PROGSTARTTIME = request.getParameter("PROGSTARTTIME");
    String _PROGENDTIME = request.getParameter("PROGENDTIME");
    String progBeginTime = _PROGSTARTTIME;
    String progEndTime = _PROGENDTIME;
    String price = request.getParameter("PRICE");

    String strProgId = request.getParameter("PROGID");
    String strPlayType = request.getParameter("PLAYTYPE");

    int progId = -1;
    int channelId = -1;
    int playType = EPGConstants.PLAYTYPE_TVOD;
    String contentType = EPGConstants.CONTENTTYPE_PROGRAM + "";
    int busiNessType = EPGConstants.BUSINESSTYPE_TVOD;
    String cdrType = EPGConstants.CDRTYPE_BUILDCDR;

    String playUrl = "";
    String cdrUrl = "";

    if(null != strProgId)
    {
        progId = Integer.parseInt(strProgId);
    }
    /*
    if(null != strChannelId)
    {
        channelId = Integer.parseInt(strChannelId);
    }
    */

    String strChannelId = "";
	  String tvodCode = "";
    Map tmpMapInfo = metaData.getProgDetailInfo(progId);
    if(null != tmpMapInfo)
    {
        strChannelId = (String)tmpMapInfo.get("CHANNELID");
        tvodCode = (String)tmpMapInfo.get("CODE");
    }
    if(null != strChannelId)
    {
        channelId = Integer.parseInt(strChannelId);
    }
    playUrl = serviceHelp.getTriggerPlayUrl(playType, channelId, progId, progBeginTime, progEndTime);
    if(playUrl != null && playUrl.length() > 0)
    {
        int tmpPosition = playUrl.indexOf("rtsp");
        if(-1 != tmpPosition)
		{
			playUrl = playUrl.substring(tmpPosition,playUrl.length());
		}
    }
    
    Map chanInfo = metaData.getChannelInfo(strChannelId);
    String channelName = (String) chanInfo.get("CHANNELNAME");

    cdrUrl = serviceHelp.getSubmitCdrUrl(playType,progId,price,productId,serviceId,cdrType,contentType);

//EPGConstants.PLAYTYPE_TVOD +"&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_PROGRAM + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_TVOD + "&PROGSTARTTIME=" + recBrdTime[y] + "&PROGENDTIME=" + recEndTime[y] + "&PROGID=" + tempProg[4] + "&RecordNotPPV=0";    ;
    session.removeAttribute("MEDIAPLAY");
    session.removeAttribute("PROGID");
    session.removeAttribute("PLAYTYPE");
    session.removeAttribute("PRODUCTID");
    session.removeAttribute("SERVICEID");
    session.removeAttribute("PRICE");
    session.removeAttribute("TVODCHANNELID");


    String miniUrl = "MiniInfoTvod.jsp?ProgID=" + progId + "&CHANNELID=" + channelId;

    String backurl = "";
    String returnUrl = "";
    if (session.getAttribute("vas_back_url") != null && !"".equals(session.getAttribute("vas_back_url"))) {
        backurl = (String) session.getAttribute("vas_back_url");
%>
<script type="text/javascript">
        isFromVas = true;
</script>
<%
     } else {
	 if (session.getAttribute("zb_back_url") != null && !"".equals(session.getAttribute("zb_back_url"))) 
	    {backurl = (String) session.getAttribute("zb_back_url");}
        session.removeAttribute("vas_back_url");
     }
     if (!"".equals(backurl)) returnUrl = backurl;

     else 
     {
        returnUrl = turnPage.go(0);
     }
%>

<html>
<head>
<meta   name="page-view-size" content="640*530" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>PlayControleTVod</title>
<script src="js/PlayRecord.js"></script>
<style type="text/css">
.icon{
	position:absolute ;
	width:10px;
	height:40px;
	background:url(images/playcontrol/playChannel/Volume_0.gif);
}
</style>
</head>

<script>
    var returnUrl = '<%=returnUrl%>';
    var cdrUrl = '<%=cdrUrl%>';

	  var infoEnable = true;
	  var showState = false;
    var hideTimer = "";
    var showTimer = "";

    var mp = new MediaPlayer();

    var json = '[{mediaUrl:"<%=playUrl%>",';
	json +=	'mediaCode: "jsoncode1",';
	json +=	'mediaType:2,';
	json +=	'audioType:1,';
	json +=	'videoType:1,';
	json +=	'streamType:1,';
	json +=	'drmType:1,';
	json +=	'fingerPrint:0,';
	json +=	'copyProtection:1,';
	json +=	'allowTrickmode:1,';
	json +=	'startTime:0,';
	json +=	'endTime:100.3,';
	json +=	'entryID:"jsonentry1"}]';

    var speed = 1;
    var playStat = "play";
    var audioIndex = 0;
    var seekTimeString = "|__:__:__";
    var timeIndex = 0;
    var hour = 0;
    var min = 0;
    var sec = 0;
    var state = "";
    //var volume = 20;
    var volume = mp.getVolume();
    var subtitlePIDs = "";
    var subtitleIndex = 0;
    var mediaTime = 0;
    var isJumpTime = 1;//跳转输入框是否显示,1默认显示

    var number = 0;
    var loadFlag = false;

    var pressFavo = 0;//是否按下收藏键而推出
    var pressBookMark = 0;//是否按下书签键而推出
	var playEndFlag = 0 ; // 是否播放结束，0，没有，1：已经播放结束。

    var favoUrl = "FavoAction.jsp?ACTION=show&enterFlag=check";
    //var bookMarkUrl = "BookMark.jsp";
    //var audios = mp.getAudioPIDs().pidArr;
    //var subtitles = mp.getSubtitlePIDs().pidArr;

    //mp.getNativePlayerInstanceId();
    //mp.setSingleMedia(json);



    document.onirkeypress = keyEvent ;
    document.onkeypress = keyEvent;

    function keyEvent()
    {

        var val = event.which ? event.which : event.keyCode;
        return keypress(val);
    }

    function keypress(keyval)
    {
        switch(keyval)
        {
            case <%=KEY_0%>:
				inputNum(0);
				break;
            case <%=KEY_1%>:
				inputNum(1);
				break;
            case <%=KEY_2%>:
				inputNum(2);
				break;
            case <%=KEY_3%>:
				inputNum(3);
				break;
            case <%=KEY_4%>:
				inputNum(4);
				break;
            case <%=KEY_5%>:
				inputNum(5);
				break;
            case <%=KEY_6%>:
				inputNum(6);
				break;
            case <%=KEY_7%>:
				inputNum(7);
				break;
            case <%=KEY_8%>:
				inputNum(8);
				break;
            case <%=KEY_9%>:
				inputNum(9);
				break;
    	    case <%=KEY_PAUSE_PLAY%>:
    		    pauseOrPlay();
        		break;
    	    case <%=KEY_RIGHT%>://快进
                arrowRight();
    		    break;
    	    case <%=KEY_LEFT%>://快退
    	        arrowLeft();
        		break;
            case <%=KEY_MUTE%>://切换声道
    			setMuteFlag();
    			break;
            case <%=KEY_DOWN%>:
    			arrowDown();
    			break;
            case <%=KEY_UP%>:
				arrowUp();
    			break;
			case <%=KEY_PAGEDOWN%>: 
				pageDown();
				break;
			case <%=KEY_PAGEUP%>: 
				pageUp();
				break;
			case <%=KEY_FAST_FORWARD%>: 
				fastForward();
				break;
			case <%=KEY_FAST_REWIND%>: 
				fastRewind();
				break;
			case 1060:
            case <%=KEY_TRACK%>:
    			switchTrack();
    			break;
            case <%=KEY_VOL_UP%>: //+音量
    			incVolume();
    			break;
            case <%=KEY_VOL_DOWN%>://-音量
    			decVolume();
    			break;
            case <%=KEY_BACKSPACE%>:
            case <%=KEY_RETURN%>:
            case <%=KEY_STOP%>:
	        case <%=0x1a4%>:
                goBack();
                return 0;				
            case <%=KEY_IPTV_EVENT%>:
            	goUtility();
            	break;
            case <%=KEY_OK%>:
            	pressOK();
            	break;
            default:
                return videoControl(keyval);
        }
        return true;
    }


    function goUtility()
    {
    	eval("eventJson = " + Utility.getEvent());
    	var typeStr = eventJson.type;
    	switch(typeStr)
        {
            case "EVENT_MEDIA_ERROR":
                //mediaError();
                return false;            
            case "EVENT_MEDIA_END":
                fullSeekStatus();
				return false;
            case "EVENT_MEDIA_BEGINING":
                //resume();
                //displaySeekTable();
				beginning();
                break;
            case "EVENT_PLAYMODE_CHANGE":
                playModeChange(eventJson);
                return false;
            default :
                break;
        }
        return true;
    }


	function beginning()
	{
        //判断进度条是否存在
        if(isSeeking == 1)
        {
			//将进度条晴空
			//processSeek(0);
			EventBeginForSeek();
            document.getElementById("seekDiv").style.display = "none";
            document.getElementById("jumpTimeDiv").style.display = "block";
            
			//并且停掉进度条时间
            clearTimeout(timeID_jumpTime);
            clearTimeout(timeID_check);
            
            isSeeking = 0;
            isJumpTime = 1;   
            
           // document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/pause.gif" width="20" height="22"/>';                       			
        }
        speed = 1;
        playStat = "play";
        //mp.resume();
        if(mp.getNativeUIFlag() == 0)
        {
            document.getElementById("topframe").innerHTML = "";
			var playPic = '<img src="images/playcontrol/play.gif">';
			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + playPic + '</td></tr></table>';
	        topTimer = setTimeout("hideTopFrm()", 5000);			
			
        }
        return;	
	}
	/**
	 * 快退到进度条后 将进度条刷完
	 */
	function EventBeginForSeek()
	{
        if(isSeeking == 0)   //进度条无显示
        {
            return 0;
        }
		isSeeking  = 0;
		
		document.getElementById("progressBar").style.width = "0px";
		
		/*
        var seekTableDef = "";
        seekTableDef = '<table width="500" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';
        seekTableDef +='<td width="500" height="25" bgColor = "#000080" style="border-style:none;"></td>';
        seekTableDef += '</tr></table>';
        document.getElementById("seekTable").innerHTML = seekTableDef;   //进度条显示满
		*/
		
        document.getElementById("seekPercent").innerHTML = '<span style="color:#FFFFFF;">' + 0 + "%</span>";  //显示百分比
		setTimeout("hideSeekDive();",500);
		//document.getElementById("seekDiv").style.display = "none";
	}

    function playModeChange(eventJson)
    {

    	var mode = eventJson.new_play_mode;
    	// 第一次载入时，读取一下内容时间

    	if (mode == 2 && !loadFlag)
    	{
    		loadFlag = true;
    		mediaTime = mp.getMediaDuration();
    	}
    	var pausePic = '<img src="images/playcontrol/pause_top.gif">';
    	var playPic = '<img src="images/playcontrol/play.gif">';
    	var fastPic = '<img src="images/playcontrol/fast.gif">';
    	var rewindPic = '<img src="images/playcontrol/rewind.gif">';

    	if (mp.getNativeUIFlag() == 0)
    	{
    		clearTimeout(topTimer);
	    	// 处理状态切换时的图片

	    	if(mode == 1) // 暂停状态

	    	{
	    		document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + pausePic + '</td></tr></table>';
	    	}

	    	if(mode == 2) // 正常状态

	    	{
	    		document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + playPic + '</td></tr></table>';
	    		topTimer = setTimeout("hideTopFrm()", 5000);
	    	}

	    	if(mode == 3) // 快速状态

	    	{

	    		var playRate = eventJson.new_play_rate;
	    		/*
	    		if (playRate > 0)
	    		{
	    			fastPic = '<img src="images/vodbrowse/playvod/fast' + playRate + '.gif">';
	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100 height=40>' + fastPic + '</td></tr></table>';
	    		}
	    		else
	    		{
	    			rewindPic = '<img src="images/vodbrowse/playvod/rewind' + (-playRate) + '.gif">';
	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100  height=40>' + rewindPic + '</td></tr></table>';
	    		}
	    		*/
        		if (playRate > 0)
        		{
        			fastPic = '<img src="images/playcontrol/_' + playRate + '.gif">';
        			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100 height=40>' + fastPic + '</td></tr></table>';
        		}
        		else
        		{
        			var tmpplayRate = -playRate;
        			rewindPic = '<img src="images/playcontrol/_x' + tmpplayRate + '.gif">';
        			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100  height=40>' + rewindPic + '</td></tr></table>';
        		}
	    	}


    	}
    }


    function hideTopFrm()
    {
    	document.getElementById("topframe").innerHTML = "";
    }
     
      
	/*
	 *弹出错误信息页面
	 */
	function mediaError()
	{
		iPanel.overlayFrame.location ="MediaError_vod_tvod.jsp?PARAM=1"; //断流
		overlayframe();
	}

	/*
	 *设置错误信息页面
	 */
	function overlayframe()
	{
		iPanel.overlayFrame.resizeTo(500,250);
		iPanel.overlayFrame.focus();
	}

      

    var timerTrack = "";
    function switchTrack()
    {
		/*
        mp.switchAudioChannel();
        if (mp.getNatvieUIFlag() == 0 || mp.getAudioTrackUIFlag() == 0)
        {
	        var tabdef = "<table width=120 height=30><tr><td><font color=white size=20>";
	        tabdef += Authentication.CTCGetConfig('AudioChannel');
	        tabdef += "</font></td></tr></table>";
	        document.getElementById("bottomframe").innerHTML = tabdef;
	        clearTimeout(timerTrack);
            timerTrack = setTimeout("hideTrack();",4000)
        }
		*/
		disVolume_sd();

        var currAudio = Authentication.CTCGetConfig('AudioChannel');
		if(currAudio == 2)
		{
		    mp.switchAudioChannel();
			//mp.switchAudioTrack();
		}
		else
		{
			mp.switchAudioChannel();
		}
		
        //mp.switchAudioChannel();

		var leftPic = '<img src="images/voice/leftvoice.png" />';
		var rightPic = '<img src="images/voice/rightvoice.png" />';
		var litisheng = '<img src="images/voice/centervoice.png" />';
        if (mp.getAudioTrackUIFlag() == 0)
        {
			var disPic = "";
			
		    var audio= Authentication.CTCGetConfig('AudioChannel');

			if(audio=="0" || audio=="Left" || audio == 0)
			{//(0);
				audio=0;
			}
			else if(audio=="1" || audio=="3" ||  audio=="Right" || audio == 1)
			{//(1);
				audio=1;	
			}
			else if(audio=="2" || audio=="JointStereo" || audio == 2)
			{//(2);
				audio=2;	
			}
			clearTimeout(voiceflag);
			switch(audio)
			{
				case 0:
				disPic = leftPic;
				break;
				case 1:
				disPic = rightPic;
				break;
				case 2:
				disPic = litisheng;
				break;
				default:
				break;
			}
			clearTimeout (timerTrack) ;
			document.getElementById("TrackImg").innerHTML = disPic ;
			timerTrack = setTimeout("hideTrackImg();",5000)
        }

    }

    function hideTrack()
    {
        document.getElementById("bottomframe1").innerHTML = "";
    }
	 function hideTrackImg()
    {
        document.getElementById("TrackImg").innerHTML = "";
    }


    function switchSubTitle()
    {

        var tabdef = "<table width=120 height=30><tr><td><font color=white size=20>";
        tabdef += mp.getSubtitle();
        tabdef += "</font></td></tr></table>";
        document.getElementById("bottomframe1").innerHTML = tabdef;
    }

    var timeID_volume = "";
	/*
	 * 隐藏音量显示
	 */
	function unVolume()
	{
		document.getElementById("bottomframe").style.display = "none";
	}

	/*
	 * 显示音量显示
	 */
	function disVolume()
	{
		document.getElementById("bottomframe").style.display = "block";
	}


	/*
	 * 声道显示
	 */
	function unVolume_sd()
	{
		document.getElementById("bottomframe1").style.display = "none";
	}	

	/*
	 * 声道显示
	 */
	function disVolume_sd()
	{
		document.getElementById("bottomframe1").style.display = "block";
	}	
	
	
    function incVolume()
    {
		if (showState == true) hideInfo() ;
		var muteFlag = mp.getMuteFlag();
    	if(muteFlag == 1)
    	{
            mp.setMuteFlag(0);
			document.getElementById("bottomframeMute").innerHTML = "";
    	}
		disVolume();
		if (volume == 100) 
		{
			document.getElementById("volumeValue").innerText = 20;	
			showVolumeBar(20); 
            clearTimeout(timeID_volume);
		    timeID_volume = setTimeout("unVolume()",5000);	
						    
		    return;
		}
        volume = volume + 5;
		if(volume >= 100) volume = 100;
        if(mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
        {
		
		   	var width = 500 * volume / 100;
			var showVolume = volume / 5;
			// document.getElementById("volumeBar").style.width = width + "px";
			document.getElementById("volumeValue").innerText = showVolume;
			showVolumeBar(showVolume);
        }

        mp.setVolume(volume);
        clearTimeout(timeID_volume);
		timeID_volume = setTimeout("unVolume()",5000);
		//disVolume();
    }


	/*
	 *减小音量
	 */

	function decVolume()
	{
		if (showState == true) hideInfo() ;
		var muteFlag = mp.getMuteFlag();
    	if(muteFlag == 1)
    	{
            mp.setMuteFlag(0);
			document.getElementById("bottomframeMute").innerHTML = "";
    	}
		disVolume();
		if (volume == 0) 
		{
			document.getElementById("volumeValue").innerText = 0;	
			showVolumeBar(0); 
            clearTimeout(timeID_volume);
		    timeID_volume = setTimeout("unVolume()",5000);	
			 
		    return;
		}
	    volume = volume - 5;
        if(volume <= 0) volume = 0;      
        if(mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
        {
		
            var width = 500 * volume / 100;
			var showVolume = volume / 5;
			// document.getElementById("volumeBar").style.width = width + "px";
			document.getElementById("volumeValue").innerText = showVolume;			
			showVolumeBar(showVolume); 
        }
		//设置音量大小

		mp.setVolume(volume);
		clearTimeout(timeID_volume);
		timeID_volume = setTimeout("unVolume()",5000);
		//disVolume();

	}
	
	function showVolumeBar(Num)
	{
		for (var i = 1 ; i <= 20 ; i ++)
		{
			if (i <= Num)document.getElementById("icon_"+i).style.background = "url(images/playcontrol/playChannel/Volume_1.gif)";
			else document.getElementById("icon_"+i).style.background = "url(images/playcontrol/playChannel/Volume_0.gif)" ;
		}
	} 

    function goBack()
    {
		if (document.getElementById("seekDiv").style.display == "block" && playStat == "pause")
		{
			return 0 ;
		}
		else 
		{
			stop();
			//showQuit();
			//if (isFromVas) 
			//{window.location.href = "backToVisf.jsp";}
			//else 
			//{
     
     var  returnURL = ""

            if(""!=getCookie("mafocusUrl")&&null!=getCookie("mafocusUrl")&&"null"!=getCookie("mafocusUrl")&&"undefined"!=getCookie("mafocusUrl")){
                     returnURL = getCookie("mafocusUrl");
                setCookie("mafocusUrl","");
            window.location.href = returnURL;
            }else{
			window.location.href = returnUrl; 
			//}
			//window.location.href = returnUrl;
     }       //
		}
    }
        function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*30);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
          function getCookie(name){
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
        else
        return null;
    }
 function inputNum(i)
    { 
        /*
        if(state == "seek")
        {
            seekInput(i);
        }
        else
        {
        */
            if(number * 10 >= 1000)
            {
                return 0;
            }
            number = number * 10 + i;

            showChannelNum(number);
            clearTimeout(timeID);
            timeID = setTimeout("playChannel("+ number +")", 1000);
        //}
    }

    function showChannelNum(num)
    {


        var tabdef = '<table width=200 height=30><tr align="right"><td><font color=green size=20>';
        tabdef += num;
        tabdef += '</font></td></tr></table>';
        document.getElementById("topframe").innerHTML=tabdef;
    }

    function playChannel(chanNum)
    {
       var tempUrl = "ChanDirectAction.jsp?chanNum=" + chanNum;
       window.location.href = tempUrl;
    }


    function seekInput(i)
    {
        // 最大时间99:59:59
    	if ((timeIndex == 2 || timeIndex == 4) && i > 5)
    	{
    		return;
    	}

        if(timeIndex%2 == 0)
        {
            if(i > 5)
            {
                return 0;
            }
        }
        timeIndex++;
        switch (timeIndex)
        {
            case 1:
                hour = i;
                seekTimeString = hour + "|_:__:__";
                break;
            case 2:
                hour = hour * 10 + i;
                seekTimeString = hour + ":|__:__";
                break;
            case 3:
                min = i;

                seekTimeString = hour + ":" + min + "|_:__";
                break;
            case 4:
                min = min * 10 + i;
                seekTimeString = hour + ":" + min + ":|__";
                break;
            case 5:
                sec = i;
                seekTimeString = hour + ":" + min + ":" + sec + "|_";
                break;
            case 6:
                sec = sec * 10 + i;
                seekTimeString =  hour + ":" + min + ":" + sec;
                break;
        }
        var tabdef = "<table width=120 height=30><tr><td><font color=blue size=20>";
        tabdef += seekTimeString;
        tabdef += "</font></td></tr></table>";
        document.getElementById("topframe").innerHTML = tabdef;
        if(timeIndex == 6)
        {
            state = "";
            var timeStamp = (hour * 60 * 60 + min * 60 + sec);
            hour = 0;
            min = 0;
            sec = 0;
            timeIndex = 0;
            seekTimeString = "|__:__:__";

            // 一秒钟这后切换频道
            setTimeout("seekPlay(" + timeStamp + ")", 1000);
        }
    }


     function seek()
    {
        if(state == "seek")
        {
            state = "";
            seekTimeString = "|__:__:__";
            hour = 0;
            min = 0;
            sec = 0;
            timeIndex = 0;
            document.getElementById("topframe").innerHTML = "";
        }
        else
        {
            state = "seek";
            var tabdef = "<table width=60 height=30><tr><td><font color=white size=20>";
            tabdef += seekTimeString;
            tabdef += "</font></td></tr></table>";
            document.getElementById("topframe").innerHTML = tabdef;
        }
    }

    function seekPlay(timePos)
    {
    	 mp.playByTime(1,timePos,1);
         document.getElementById("topframe").innerHTML = "";
    }


    function play()
    {
        mp.setVideoDisplayArea(0,0,0,0);
	    mp.setVideoDisplayMode(1);   //1全屏播放
	    mp.refreshVideoDisplay();
	    mp.playFromStart();
    }

    function playByTime(beginTime)
    {
       
        var type = 1;
        var speed = 1;
        //iPanel.debug.debug(beginTime);
        //mp.playFromStart();
        //setTimeout("playByTimeEX(120000)",2000);
        mp.playByTime(type,beginTime,speed);
        currTime = mp.getCurrentPlayTime();
    }

    function gotoEnd()
    {
        mp.gotoEnd();
    }

    function gotoStart()
    {
        mp.gotoStart();
    }

    function gotoPreProg()
    {
        if(!infoEnable)
        {
            return 0;
        }
    	document.getElementById("filmInfo").gotoPreProg();
    }

    function gotoNextProg()
    {
        if(!infoEnable)
        {
            return 0;
        }
    	document.getElementById("filmInfo").gotoNextProg();
    }

    function pause()
    {
        mp.pause();
        playStat = "pause";
        /*
        if(mp.getNativeUIFlag() == 0)
        {
            var tabdef = "<table width=200 height=30><tr><td><font color=white size=20>";
            tabdef += "暂停";
            tabdef += "</font></td></tr></table>";
            document.getElementById("topframe").innerHTML = tabdef;
        }
        */
         return;
    }

    function arrowLeft()
    {
		if (playEndFlag == 1) return 0 ;
        var rc_model = iPanel.ioctlRead("rc_model");
		if(rc_model == 101||rc_model == 106)
		{
			if (!infoEnable || showState || (isJumpTime == 1 && isSeeking == 1))
			{
				return true;
			}
			else
			{
				decVolume();
			}
		}
		else
		{
        	fastRewind();
		}
    }

    function arrowRight()
    {
		if (playEndFlag == 1) return 0 ;
        var rc_model = iPanel.ioctlRead("rc_model");
		if(rc_model == 101||rc_model == 106)
		{
			if (!infoEnable || showState || (isJumpTime == 1 && isSeeking == 1))
			{
				if (showState) showInfo();
				return true;
			}
			else
			{
				incVolume();
			}
		}
		else
		{
        	fastForward();
		}
    }

    function fastForward()
    {
        if(!infoEnable)
        {
            return 0;
        }
        //hideInfo();

        if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0))
        {
            if(isSeeking == 0)
            {
                displaySeekTable(1);
                clearTimeout(timeID_jumpTime);
                isJumpTime = 0;
                document.getElementById("jumpTimeDiv").style.display = "none";
                //document.getElementById("jumpTimeImg").style.display = "none"; //new
            }

            if(speed >= 32 && playStat == "fastforward")
            {
                //resume();
                displaySeekTable();
                return 0;
            }
            else
            {
                if(playStat == "fastrewind") speed = 1;
                speed = speed * 2;
                playStat = "fastforward";
                //iPanel.debug.debug("fastForward();speed="+speed);
                mp.fastForward(speed);
                document.getElementById("statusImg").innerHTML = speed + 'X&nbsp;<img src="images/playcontrol/playChannel/fastForward.gif" width="20" height="20"/>';
            }
        }
    }

    function fastRewind()
    {
        if(!infoEnable)
        {
            return 0;
        }

        hideInfo();

        if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0))
        {
            if(isSeeking == 0)
            {
                displaySeekTable(1);
                clearTimeout(timeID_jumpTime);
                isJumpTime = 0;
                document.getElementById("jumpTimeDiv").style.display = "none";
                //document.getElementById("jumpTimeImg").style.display = "none"; //new

            }
            //////iPanel.debug.debug("fastRewind()");
            if(speed >= 32 && playStat == "fastrewind")
            {
                //resume();
                displaySeekTable();
                return 0;
            }
            else
            {
                if (playStat == "fastforward") speed = 1;
                speed = speed * 2;
                playStat = "fastrewind";
                mp.fastRewind(-speed);
                document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/fastRewind.gif" width="20" height="20"/>&nbsp;X' + speed;
            }
            /*
            if(mp.getNativeUIFlag() == 0)
            {
                var tabdef = "<table width=200 height=30><tr><td><font color=blue size=20>";
                tabdef += "快退" + speed;
                tabdef += "</font></td></tr></table>";
                document.getElementById("topframe").innerHTML = tabdef;
            }
            */
        }
    }

    function resume()
    {
        //判断进度条是否存在

        if(isSeeking == 1)
        {
            document.getElementById("seekDiv").style.display = "none";
			//并且停掉进度条时间
            clearTimeout(timeID_jumpTime);
            clearTimeout(timeID_check);  				
        }

        speed = 1;
        playStat = "play";
        mp.resume();
        if(mp.getNativeUIFlag() == 0)
        {
            document.getElementById("topframe").innerHTML = "";
			      var playPic = '<img src="images/playcontrol/play.gif">';
			      document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + playPic + '</td></tr></table>';
	          topTimer = setTimeout("hideTopFrm()", 5000);	
        }
    }
    function setSpeed(s_speed)
    {
        speed = s_speed;
        if(speed > 0)
        {
            mp.fastForward(speed);
        }
        else if(speed < 0)
        {
            mp.fastRewind(speed);
        }
        if(speed == 0)
        {
            mp.pause();
        }
    }

    function destoryMP()
    {
        mp.stop();
    }

    function goEnd()
    {
    	if(isSeeking == 1)
		{
			return true;
		}
		else
		{
        	mp.gotoEnd();
		}
    }

    function goBeginning()
    {
    	if(isSeeking == 1)
		{
			return true;
		}
		else
		{
        	mp.gotoStart();
		}        
    }
	
	function pageDown()
	{
		if (playEndFlag == 1) return 0 ;
		if (!infoEnable || showState)
		{
			if (showState) showInfo();
			return 0;
		}
		if (document.getElementById("seekDiv").style.display == "block")
		{
			document.getElementById("seekDiv").style.display = "none" ;
			isSeeking = 0 ;
		}
		gotoEnd();
	}
	
	function pageUp()
	{
		if (document.getElementById("endDiv").style.style.display == "block") return 0 ;
		if (!infoEnable || showState)
		{
			if (showState) showInfo();
			return 0;
		}
		if (document.getElementById("seekDiv").style.display == "block")
		{
			document.getElementById("seekDiv").style.display = "none" ;
			isSeeking = 0 ;
		}
		gotoStart();
	}
	function arrowDown()
	{
		if (document.getElementById("endDiv").style.style.display == "block") return 0 ;
		if (!infoEnable || showState)
		{
			return 0;
		}
		var rc_model = iPanel.ioctlRead("rc_model");
		if(rc_model == 101||rc_model == 106)
		{
			return true;
		}
		else
		{
			if (document.getElementById("seekDiv").style.display == "block")
			{
				document.getElementById("seekDiv").style.display = "none" ;
				isSeeking = 0 ;
			}
			gotoStart();
		}
	}
	function arrowUp()
	{
		if (playEndFlag == 1) return 0 ;
		if (!infoEnable || showState || isSeeking == 1)
		{
			return 0;
		}
		var rc_model = iPanel.ioctlRead("rc_model");
		if(rc_model == 101||rc_model == 106)
		{
			return true;
		}
		else
		{
			if (isSeeking == 1)
			{
				document.getElementById("seekDiv").style.display = "none" ;
				isSeeking = 0 ;
			}
			gotoEnd();
		}
	}

    function switchAudioChannel()
    {
        mp.switchAudioChannel();
    }

    function switchAudioTrack()
    {
        mp.switchAudioTrack();
    }

    function switchSubtitle()
    {
        mp.switchSubtitle();
    }

    function stop()
    {
        mp.stop();
    }

    var initMediaTime = 0;
	
	//预约--变量
	var xmlhttp;
    var img;
	var desc;
	var starttime;
	var endtime;
	var twotime = new Array();
	var timearr = new Array();
    function init()
    {
		//预约--start
		//if (window.XMLHttpRequest) {
			//isIE   =   false; 
		//	xmlhttp = new XMLHttpRequest();
		//} else if (window.ActiveXObject) {
			//isIE   =   true; 
		//	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		//}
			
		//var d = new Date();
		//var testtime = d.getTime();
		//var riddle = hex_md5('besto' + testtime);
		//var URL = "http://218.24.37.2/appepg/retrieveWinData?time="+testtime+"&riddle="+riddle+"&win=yyindex&clientType=iptv";
		//xmlhttp.open("GET", URL, true);
		//xmlhttp.onreadystatechange = handleResponse;
		//xmlhttp.setRequestHeader("If-Modified-Since", "0");
		//xmlhttp.send(null);
		
        initMediaPlay();
        mp.setSingleMedia(json);
        mp.setAllowTrickmodeFlag(0);
        //mp.setSingleMedia(jsonstr);
        //mp.setMuteUIFlag(1);
        //mp.setAudioTrackUIFlag(1);
        mp.setNativeUIFlag(1);
        mp.setMuteUIFlag(0);
        mp.setAudioTrackUIFlag(0);
        play();
		iPanel.ioctlWrite("mediacode","<%=tvodCode%>");

        mediaTime = mp.getMediaDuration();
        // 防止一开始读不到，再读一次
        if (mediaTime == 0)
        {
        	mediaTime = mp.getMediaDuration();
        }

        initMediaTime = mediaTime;//有时机顶盒取出的时长不准确，用此变量保存第一次取出的时长
        timePerCell = mediaTime / 100;//进度条中每1%所占的时间
		
		convertTime();  //获取节目时间

        document.getElementById("filmInfo").src ="<%=miniUrl%>";
        document.getElementById("filmInfo1").style.display = "block";
		showState = true ;
		setTimeout (hideInfo,6000) ;
        //showTimer = setTimeout("showInfo();", 5000);
       
        //genSeekTable(); dele by duanxiaohui

        //iPanel.ioctlWrite("hw_op_play_start",cdrUrl);
        cdr.location.href = cdrUrl;

		//增加静音处理
        //if(mp.getMuteFlag() == 1 && (mp.getNativeUIFlag() == 0 && mp.getMuteUIFlag() == 0))
		
    }

	function handleResponse() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
					var result=xmlhttp.responseText;
					
					xmlhttp = null;
					
					 var obj=eval('('+result+')');
					 var adstr = obj.datas;
					 var roomsarr = eval(adstr);
					  for(var j=0;j<roomsarr.length;j++){  
						 var adrooms = roomsarr[j].adRooms;
						 var adarr = eval(adrooms);
						 for(var i=0;i<adarr.length;i++){  
							if(adarr[i].imgurl!=""){
								img = adarr[i].imgurl;
							}
							if(adarr[i].desc!=""){
								desc = adarr[i].desc;
								timearr = desc.split("_");
								starttime = timearr[0];
								endtime = timearr[1];
							}
						}  
					}
					  setTimeout(initdata(),1000);
	
				}
			}
		  function initdata(){
			  var curlong = new Date().getTime();
			  var startlong = new Date(starttime).getTime();
			  var endlong = new Date(endtime).getTime();
			  if(curlong>=startlong && curlong<=endlong){
				  document.getElementById("adimg").src = img;
				  document.getElementById("adimg").style.display = "block";
			  }else{
				  document.getElementById("adimg").style.display = "none";
			  }
		  }
    function initMediaPlay()
    {
        var instanceId = mp.getNativePlayerInstanceID();

        var playListFlag = 0;

        var videoDisplayMode = 1;
        var height = 0;
        var width = 0;
        var left = 0;
        var top = 0;

        var muteFlag = 0;

        var subtitleFlag = 0;

        var videoAlpha = 0;

        var cycleFlag = 1;
        var randomFlag = 0;
        var autoDelFlag = 0;
        var useNativeUIFlag = 1;
        mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);

    }

    function showInfo()
    {
        /*
    	if (!loadFlag)
    	{
    		return false;
    	}
        */


    	if(hideTimer != "")
        {
            clearTimeout(hideTimer);
        }

        if (showTimer != "")
        {
        	clearTimeout(showTimer);
        }
        //document.getElementById("filmInfodiv").innerHTML = tabdef;
        document.getElementById("filmInfo").src = "<%=miniUrl%>";
      	document.getElementById("filmInfo1").style.display = "block";

        showState = true;

        hideTimer = setTimeout("hideInfo()",8000);
    }

    function hideInfo()
    {
    	if(hideTimer != "")
        {
            clearTimeout(hideTimer);
        }

        if (showTimer != "")
        {
        	clearTimeout(showTimer);
        }

        showState = false;

       document.getElementById("filmInfo1").style.display = "none";
       //document.getElementById("filmInfodiv").style.display = "";
    }



    function pauseOrPlay()
    {
		if (playEndFlag == 1) return 0 ;
		clearTimeout(showTimer);
        if(showState)
        {
            clearTimeout(hideTimer);
            displaySeekTable();  //显示进度条
            hideInfo();
            return;
        }

    	speed = 1;
    	if(playStat == "play")
    	{
            //pause();
            displaySeekTable();
            return;
    	}
    	else
    	{
            //resume();
            displaySeekTable();
            return;
        }

    }

    function setMuteFlag()
    {
    	var muteFlag = mp.getMuteFlag();
    	if(muteFlag == 1)
    	{
            mp.setMuteFlag(0);
			var tabdef = '<table width=120 height=30><tr><td><img src="images/playcontrol/playChannel/muteoff.png">';
            tabdef += '</img></td></tr></table>';
            document.getElementById("bottomframeMute").innerHTML = tabdef;
			clearTimeout(muteTimer);
			muteTimer = setTimeout(function(){document.getElementById("bottomframeMute").innerHTML = "";}
			,3000);
    	}
    	else
    	{
			 var tabdef = '<table width=120 height=30><tr><td><img src="images/playcontrol/playChannel/muteon.png">';
            tabdef += '</img></td></tr></table>';
			document.getElementById("bottomframeMute").innerHTML = tabdef;
            mp.setMuteFlag(1);
        }
       
    }

      function showFavourite()
    {
        var tmpUrl = "FavoAction.jsp?ACTION=show&enterFlag=check";
        window.location.href = tmpUrl;
       
        //pr.submit(tmpUrl);
    }

     function showBookmark()
    {
        var nextUrl = "BookMark.jsp";
        pr.submit(nextUrl);
    }

     function pressOK()
    {
        // 如果有提示对话框则直接返回true;
        if (infoEnable == false)
        {
        	return true;
        } 
        
        if (showState == true)
        {
            hideInfo();
        }
        //else if(isSeeking == 1 && isJumpTime == 1)
		else if(isSeeking == 1)
        {
            return;
        }
    	else
    	{
			if (playEndFlag == 1)
			{
				return ;
			}
    		showInfo();
    	}
    }




    var currTime = mp.getCurrentPlayTime();
    //mediaTime = mp.getMediaDuration();节目总时长
    var timePerCell = mediaTime / 100;
    var currCellCount = 0;
    var seekStep = 1;//每次移动的百分比
    var isSeeking = 0;
    var tempCurrTime = 0;
    var timeID_playByTime = 0;

    var timeID_jumpTime = "";


    function displaySeekTable(playFlag)
    {
        mediaTime = mp.getMediaDuration();
        //有时机顶盒取出的vod总时长有问题，在这里重新获取
        if(undefined == mediaTime || typeof(mediaTime) != "number" || mediaTime.length == 0 || 0 == mediaTime || initMediaTime != mediaTime)
        {
            mediaTime = mp.getMediaDuration();
            timePerCell = mediaTime / 100;
        }

        if(isSeeking == 0)
        {
            isSeeking = 1;
            currTime = mp.getCurrentPlayTime();
            processSeek(currTime);

            var fullTimeForShow = "";

            fullTimeForShow = convertTime();
			
            document.getElementById("fullTime").innerHTML = fullTimeForShow;

           // document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/pause.gif" width="20" height="22"/>';

            document.getElementById("seekDiv").style.display = "block";
           //bim 20161008 document.getElementById("jumpTime").focus();


            //5秒后隐藏跳转输入框所在的div
            clearTimeout(timeID_jumpTime);
            //dele by duanxiaohui
            timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);

            checkSeeking();
			if (playFlag != 1)
			{
            	pause();
            }
        }
        else
        {
            clearTimeout(timeID_check);
            resetPara_seek();
			if (playFlag != 2 && playFlag != 3)
			{
            	resume();//恢复播放状态

            }
            document.getElementById("seekDiv").style.display = "none";
        }
    }

    function genSeekTable()
    {
        var seekTableDef = "";
        seekTableDef = '<table width="500" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';
        for(var i = 0; i < 100; i++)
        {
            /*
            if(i < currCellCount)
            {
                seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" bgcolor="yellow"></td>';
            }
            else
            {
                seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" bgcolor="transparent"></td>';
            }
            */

            //seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" style="border-style:none;background-image:url(images/vodbrowse/playvod/seeking.gif);filter:AlphaImageLoader(src=\'images/vodbrowse/playvod/seeking.gif\');"></td>';
            //seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" bgcolor="#DAA520" style="border-style:none;filter:Alpha(opacity=50);"></td>';
            seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="25" style="border-style:none;"></td>';
            //filter:Alpha(opacity=100);
            //seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" style="border-style:none;"><img src="images/vodbrowse/playvod/seeking.gif" width="6" height="30" /></td>';

        }
        seekTableDef += '</tr></table>';

        document.getElementById("seekTable").innerHTML = seekTableDef;

    }

    function fullSeekStatus()
    {
		if(isSeeking == 1)
		{
			isSeeking = 0;
			document.getElementById("seekDiv").style.display = "none";
		}
		playEndFlag = 1;
		document.getElementById("finishedBackground").style.display = "block" ;
		document.getElementById("endDiv").style.display = "block" ;
		//add by chenzhiqiang at 2013.07.09 for 按下页键后再按上页键，播放结束的弹窗不消失
        mp.stop();
		//add end
    }


    function processSeek(_currTime)
    {
        if(null == _currTime || _currTime.length == 0)
        {
            _currTime = mp.getCurrentPlayTime();
        }

        if(_currTime < 0)
        {
            _currTime = 0;
        }
        currCellCount = Math.floor(_currTime / timePerCell);
        //currCellCount = _currTime / timePerCell;

		/*
        var tempIndex = -1;
        tempIndex = (String(_currTime / timePerCell)).indexOf(".");
        if(tempIndex != -1)
        {
            currCellCount = (String(_currTime / timePerCell)).substring(0,tempIndex);
        }
        else
        {
            currCellCount = String(_currTime / timePerCell);
        }
		*/



        if(currCellCount > 100)
        {
            currCellCount = 100;
        }

        if(currCellCount < 0)
        {
            currCellCount = 0;
        }

        if(currCellCount < 49)
        {
            document.getElementById("seekPercent").innerHTML = currCellCount + "%";
        }
        else if(currCellCount >= 49 && currCellCount <= 50)
        {
            document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + (String(currCellCount)).substring(0,1) + '</span><span style="color:white;">' + (String(currCellCount)).substring(1,2) + "%</span>";
        }
        else if(currCellCount >= 51 && currCellCount <= 53)
        {
            document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + currCellCount + '</span><span style="color:white;">%</span>';
        }
        else if(currCellCount >= 54)
        {
            document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + currCellCount + "%</span>";
        }
        var currTimeDisplay = convertTime(_currTime);
        document.getElementById("currTimeShow").innerHTML = currTimeDisplay;

		
		
		document.getElementById("progressBar").style.width = currCellCount / 100 * 420 + "px";
		

        //for(var i = 0; i < 100; i++)
        //{
        //    if(i < currCellCount)
         //   {
         //       document.getElementById("td_" + String(i + 1)).bgColor = "#DAA520";
                //document.getElementById("td_" + String(i + 1)).filters.item("Alpha").Opacity = 20;
                //document.getElementById("td_" + String(i + 1)).style.backgroundImage = "url(images/vodbrowse/playvod/seeking.gif)";
                //document.getElementById("td_" + String(i + 1)).filters.item("AlphaImageLoader").src = "images/vodbrowse/playvod/seeking.gif";
                //document.getElementById("td_" + String(i + 1)).style.filter="progid:DXImageTransform.Microsoft.BasicImage(opacity=0.5)";

          //  }
           // else
           // {
           //     document.getElementById("td_" + String(i + 1)).bgColor = "transparent";
                //document.getElementById("td_" + String(i + 1)).filters.item("Alpha").Opacity = 0;
                //document.getElementById("td_" + String(i + 1)).style.backgroundImage = "url(none)";
                //document.getElementById("td_" + String(i + 1)).filters.item("AlphaImageLoader").src = "images/link-dot.gif";
                //document.getElementById("td_" + String(i + 1)).style.filter="progid:DXImageTransform.Microsoft.BasicImage(opacity=0.0)";
            //}
        //}
    }

    /*
    function leftArrow()
    {

        if(isSeeking == 1)
        {
            //按下左右键时，先重置延迟调用进度条检测方法
            clearTimeout(timeID_check);
            timeID_check = setTimeout("checkSeeking();",1000);

            currTime = mp.getCurrentPlayTime();

            if(tempCurrTime == 0)
            {
                tempCurrTime = currTime;
                setTimeout("playByTime(tempCurrTime);",1000);
            }

            tempCurrTime = String(parseInt(tempCurrTime,10) - seekStep * timePerCell);

            //定位后如果时间早于当前时间，重新播放
            if(tempCurrTime <= 0)
            {
                tempCurrTime = 0;
                isSeeking = 0;
                displaySeekTable();
                mp.playFromStart();
            }
            else
            {
                setTimeout("processSeek(tempCurrTime);",500);

                //clearTimeout(timeID_playByTime);
                //timeID_playByTime = setTimeout("playByTime(tempCurrTime);",1000);
            }

            return 0;
        }
        else
        {
            return 1;
        }

    }

    function rightArrow()
    {
        if(isSeeking == 1)
        {
            //按下左右键时，先重置延迟调用进度条检测方法
            clearTimeout(timeID_check);
            timeID_check = setTimeout("checkSeeking();",1000);

            currTime = mp.getCurrentPlayTime();

            if(tempCurrTime == 0)
            {
                tempCurrTime = currTime;
                setTimeout("playByTime(tempCurrTime);",1000);
            }

            tempCurrTime = String(parseInt(tempCurrTime,10) + seekStep * timePerCell);

            if(tempCurrTime >= mediaTime)
            {
                tempCurrTime = 0;
                isSeeking = 0;
                displaySeekTable();
                //mp.stop();
                finishedPlay();
                return 0;
            }
            else
            {
                processSeek(tempCurrTime);
                //setTimeout("processSeek();",1000);
                //playByTime(tempCurrTime);
                //clearTimeout(timeID_playByTime);
                //timeID_playByTime = setTimeout("playByTime(tempCurrTime);",1000);
            }

            return 0;
        }
        else
        {
            return 1;
        }

    }
    */

    var timeID_check = 0;
    var preInputValue = "";
    function checkSeeking()
    {
        if(isSeeking == 0)
        {
            clearTimeout(timeID_check);
        }
        else
        {

            //下面一行代码的作用：获取不到文本框中的值，动态刷新文本框所在div可以解决
            if(playStat != "fastrewind" && playStat != "fastforward")
            {
               // document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/pause.gif" width="20" height="22"/>';
            }

            var inputValue = "";//bim 20161008 document.getElementById("jumpTime").value;

            currTime = mp.getCurrentPlayTime();

            //每隔1秒检测一次进度条的显示情况
            clearTimeout(timeID_check);
            timeID_check = setTimeout("checkSeeking();",1000);

            if(playStat == "fastrewind" || playStat == "fastforward")
            {
                processSeek(currTime);
            }

            if(preInputValue != inputValue)
            {
                var tempTimeID = timeID_jumpTime;
                //5秒后隐藏跳转输入框所在的div
                clearTimeout(tempTimeID);
                timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
                preInputValue = inputValue;
            }

            /*
            if(isSeeking == 1)
            {
                if(tempCurrTime != 0)
                {
                    //tempCurrTime != 0 时，用户正在移动进度条，重新延迟调用方法
                    clearTimeout(timeID_check);
                    timeID_check = setTimeout("checkSeeking();",1000);
                }
                else
                {
                    processSeek(currTime);
                }

            }
            */
        }

    }
    /***********************************************************/
    /**
     *seek相关的参数及方法end
     */
    function convertTime(_time)
    {
        if(null == _time || _time.length == 0)
        {
            _time = mp.getMediaDuration();
        }

        var returnTime = "";

        var time_min = "";
        var time_hour = "";

		// add second
		
		var time_second = "";
        /*
        time_min = Math.floor(_time / 60);
        time_hour = String(Math.floor(time_min / 60));
        time_min = String(time_min % 60);
        */
        var tempIndex = -1;
        tempIndex = (String(_time / 60)).indexOf(".");
        if(tempIndex != -1)
        {
            time_min = (String(_time / 60)).substring(0,tempIndex);
            tempIndex = -1;
        }
        else
        {
            time_min = String(_time / 60);
        }

        tempIndex = (String(time_min / 60)).indexOf(".");
        if(tempIndex != -1)
        {
            time_hour = (String(time_min / 60)).substring(0,tempIndex);
            tempIndex = -1;
        }
        else
        {
            time_hour = String(time_min / 60);
        }

        time_min = String(time_min % 60);
		time_second = _time % 60; //显示秒




        if("" == time_hour || 0 == time_hour)
        {
            time_hour = "00";
        }

        if("" == time_min || 0 == time_min)
        {
            time_min = "00";
        }
        if("" == time_second || 0 == time_second)
        {
            time_second = "00";
        }		

        if(time_hour.length == 1)
        {
            time_hour = "0" + time_hour;
        }

        if(time_min.length == 1)
        {
            time_min = "0" + time_min;
        }
        if(("" + time_second).length == 1)
        {
            time_second = "0" + time_second;
        }		
		
        returnTime = time_hour + ":" + time_min + ":" + time_second;

        return returnTime;
    }

    function checkJumpTime(pHour, pMin)
{        
    if(isEmpty(pHour)) //如果小时为空，返回false
	{
		return false;
	}
	else if(!isNum(pHour))//如果小时不为数字，返回false
	{
	    return false;
	}
	if(isEmpty(pMin))//如果分钟为空，返回false
	{
	    return false;
	}
	else if(!isNum(pMin))//如果分钟不为数字，返回false
	{
	    return false;
	}
    else if(!isInMediaTime(pHour,pMin))//如果不在播放时长内，返回false
	{
	    return false;
	}
    else  //否则，返回true
	{
	    return true;
	}
        
  }

    function isEmpty(s)
    {
        return ((s == null) || (s.length == 0));
    }

    function isNum(s)
    {
        var nr1=s;
        var flg=0;
        var cmp="0123456789"
        var tst ="";

        for (var i=0;i<nr1.length;i++)
        {
            tst=nr1.substring(i,i+1)
            if (cmp.indexOf(tst)<0)
            {
                flg++;
            }
        }

        if (flg == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    //判断是否在播放时长内
    function isInMediaTime(pHour,pMin)
    {
		pHour = pHour.replace(/^0*/,"");//去掉字符串里的0
		if(pHour == "")
		{
			pHour = "0";
		}
		
		pMin = pMin.replace(/^0*/,"");
		if(pMin == "")
		{
			pMin = "0";
		}
		
		var allTime = pHour * 3600 + pMin * 60;//输入的总时间  输入的小时 + 输入的分钟 = 总时间
		
		mediaTime = mp.getMediaDuration();//影片的总时长
		
		return (allTime <= mediaTime);
    }

    var timeForShow = 0;
	var pauseTimeId = 0;
    function jumpToTime(_time)
    {
        timeForShow = 0;
        _time = parseInt(_time,10);

        playByTime(_time);
        processSeek(_time);
        //pause();
        pauseTimeId = setTimeout("pause();",500);
        //pause();
    }

    /**
     *用户在文本框中输入时，重置调用隐藏文本框所在层的方法的延迟时间
     */
    function inputOnChange()
    {
        var inputValue = "";//bim 20161008 document.getElementById("jumpTime").value;
        if(inputValue.length < 4)
        {
            //5秒后隐藏跳转输入框所在的div
            clearTimeout(timeID_jumpTime);
            timeID_jumpTime = setTimeout("hideJumpTimeDiv();",5000);
        }
    }

    //跳转提示信息隐藏后，重置相关参数
    function resetPara_seek()
    {
        clearTimeout(timeID_jumpTime);
        isSeeking = 0;
        isJumpTime = 1;
        document.getElementById("jumpTimeDiv").style.display = "block";
        //document.getElementById("jumpTimeImg").style.display = "block";
        //bim 20161008 document.getElementById("jumpTime").value = "";
        //document.getElementById("timeError").innerHTML = "请输入时间！";
        document.getElementById("timeError").innerHTML = "";
        //document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/pause.gif" width="20" height="22"/>';
    }



    /**
     * 当输入时间后，跳转框隐藏时不进行跳转
     */
    function hideJumpTimeDiv()
    {
        clearTimeout(timeID_jumpTime);
        isJumpTime = 0;
        preInputValue = "";
        //bim 20161008 document.getElementById("jumpTime").value = "";
        document.getElementById("jumpTimeDiv").style.display = "none";
    }


    /**
     * 判断输入时间格式
     */
    var disErrInfo = ""; //显示的错误提示信息

    function clickJumpBtn()
    {
        clearTimeout(timeID_jumpTime);
       var inputValueHour = document.getElementById("jumpTimeHour").value;
		var inputValueMin = document.getElementById("jumpTimeMin").value;
		if(isEmpty(inputValueHour))
		{
			inputValueHour = "00";
		}
		if(isEmpty(inputValueMin))
		{
			inputValueMin = "00";
		}
	
		//如果输入的时间合法
		if(checkJumpTime(inputValueHour,inputValueMin))
		{
			var hour = parseInt(inputValueHour,10);//将inputValueHour 转换为10进制
			
			var mins = parseInt(inputValueMin,10);//将inputValueMin 转换为10进制
			
			var timeStamp = hour * 3600 + mins * 60+1;
			
			//timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
			
			clearTimeout(timeID_jumpTime);
			timeID_jumpTime = "";
			
			// document.getElementById("jumpTimeDiv").style.display = "none";
			document.getElementById("jumpTimeHour").value = "";
			document.getElementById("jumpTimeMin").value = "";
			
			document.getElementById("seekDiv").style.display = "none";
			isSeeking = 0 ;
			playByTime(timeStamp);
			
		}
		 //校验不通过，提示用户时间输入不合理
		 else
		 {
			 document.getElementById("jumpTimeHour").value = "";
			 document.getElementById("jumpTimeMin").value = "";
			 document.getElementById("timeError").innerHTML =  "<font color='white'>时间输入不合理，请重新输入！</font>";
			
			 jumpPos = 0;
			 preInputValueHour = "";
			 preInputValueMin = "";
			 
			 document.getElementById("jumpTimeHour").focus();
			 
			 //15秒后隐藏跳转输入框所在的div"
			 clearTimeout(timeID_jumpTime);
			 timeID_jumpTime = "";
			 //timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
			 
		 }
    }

    function disErrorInfo()
    {
		    //bim 20161008 document.getElementById("jumpTime").focus();
        //bim 20161008 document.getElementById("jumpTime").value = "";
        document.getElementById("timeError").innerHTML = disErrInfo;
        clearTimeout(timeID_jumpTime);
        preInputValue = "";
        //timeID_jumpTime = setTimeout("hideJumpTimeDiv();",5000);
    }

    /**
     * 跳转进行数据初始化

     */
    function jumpByTime(_time)
    {
        clearTimeout(timeID_jumpTime);
        isJumpTime = 0;
        document.getElementById("jumpTimeDiv").style.display = "none";
        //bim 20161008 document.getElementById("jumpTime").value = "";
        preInputValue = "";
        document.getElementById("timeError").innerHTML = "";
        //jumpToTime(inputValue);
        jumpToTime(_time);
    }


    function showQuit()
    {

        infoEnable = false;
        //hideInfo();
        var tabdef = '';
        tabdef += '<div style="position:absolute; left:0px; top:0px; width:640px; height:150px;">';
        tabdef += '<img src="images/playcontrol/playend_bg2.gif" height="150" width="640">';
        tabdef += '</div>';

        tabdef += '<div style="position:absolute; left:157px; top:92px; width:640px; height:150px;">';
        tabdef += '<a id="type1" href="javascript:ensureQuit()">';
        tabdef += '<img src="images/playcontrol/link-dot.gif" height="33" width="155">';
        tabdef += '</a>';
        tabdef += '</div>';

        tabdef += '<div style="position:absolute; left:337px; top:92px; width:640px; height:150px;">';
        tabdef += '<a id="type0" href="javascript:cancel()">';
        tabdef += '<img src="images/playcontrol/link-dot.gif" height="33" width="158">';
        tabdef += '</a>';
        tabdef += '</div>';

        document.getElementById("playdisplay").innerHTML = tabdef;

        if(isSeeking == 1)
        {
            displaySeekTable();
        }

        pause();

    }

    /**
     * 确认取消
     */
    function cancel()
    {
        //var tabdef = '<div style="position:absolute;left:0px; top:0px; width:646px; height:100px; z-index:1">';
        //tabdef += '<table width="640" height="100" border="0" cellpadding="0" cellspacing="0" bgcolor="transparent"></table>';
        infoEnable = true;
        document.body.bgcolor="transparent";
        document.getElementById("playdisplay").innerHTML = "";
        document.body.bgcolor="transparent";
        resume();
    }

    /**
     * 确认退出

     */
    function ensureQuit()
    {
        mp.stop();
        if (isFromVas) document.location.href = "backToVis.jsp";
        else document.location.href = returnUrl;
    }


</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent" onUnload="javascript:destoryMP()">
<!------加图片-------->
<!--<div style="position:absolute;top:0px;left:0px;"><img id="adimg" src="#" width="136" height="136></div>
-->
<div id="playdisplay" style="position:absolute;left:0px; top:100px; width:635px; height:426px;">
</div>
<div id="filmInfodiv" style="position:absolute;left:0px; top:370px; width:635px; height:156px;">
</div>
<!--div id="topframe" style="position:absolute;left:400px; top:20px; width:200px; height:30px; z-index:1">
</div-->
<div id="topframe" style="position:absolute;left:375px; top:8px; width:200px; height:30px; z-index:1">
</div>
<!--div id="bottomframe" style="position:absolute;left:40px; top:420px; width:600px; height:150px;color:green;font-size:36;">
</div-->
<!-- 左下显示声音相关信息 原来 left == 30 修改进度条备份-->
<!--div id="bottomframe" style="position:absolute;left:50px; top:400px; width:600px; height:150px; z-index:1">
</div-->
<div id="bottomframe" style="position:absolute;left:65px; top:400px; width:600px; height:126px; z-index:1;display:none">
    <div id="volume_bar">
		<div id="volume_num"></div>
		<div id="press" style="background:#330099 ;">
			<div id="icon_1" class="icon" style="left:0px;"></div>
			<div id="icon_2" class="icon" style="left:20px;"></div>
			<div id="icon_3" class="icon" style="left:40px;"></div>
			<div id="icon_4" class="icon" style="left:60px;"></div>
			<div id="icon_5" class="icon" style="left:80px;"></div>
			<div id="icon_6" class="icon" style="left:100px;"></div>
			<div id="icon_7" class="icon" style="left:120px;"></div>
			<div id="icon_8" class="icon" style="left:140px;"></div>
			<div id="icon_9" class="icon" style="left:160px;"></div>
			<div id="icon_10" class="icon" style="left:180px;"></div>
			<div id="icon_11" class="icon" style="left:200px;"></div>
			<div id="icon_12" class="icon" style="left:220px;"></div>
			<div id="icon_13" class="icon" style="left:240px;"></div>
			<div id="icon_14" class="icon" style="left:260px;"></div>
			<div id="icon_15" class="icon" style="left:280px;"></div>
			<div id="icon_16" class="icon" style="left:300px;"></div>
			<div id="icon_17" class="icon" style="left:320px;"></div>
			<div id="icon_18" class="icon" style="left:340px;"></div>
			<div id="icon_19" class="icon" style="left:360px;"></div>
			<div id="icon_20" class="icon" style="left:380px;"></div>
		</div>
		<div id="volumeValue" style="position:absolute;left:420px;top:2;width:40px;color:#FFFFFF;font-size:36px;"></div>
	</div>
</div>
<div id="bottomframe1" style="position:absolute;left:50px; top:400px; width:600px; height:126px; z-index:1">
</div>
<!-- 左下显示静音信息需要特殊处理-->
<div id="bottomframeMute" style="position:absolute;left:15px; top:400px; width:600px; height:126px; z-index:1">

</div>
<div id="TrackImg" style="position:absolute; top:320px; left:15px;">
</div>

<div id="filmInfo1" style="position:absolute;left:0px; top:370px; width:635px; height:156px; z-index:1; display:none">
   <iframe name="filmInfo" id="filmInfo" src="" scroll="no" height="156" width="635" bgcolor="transparent" allowtransparency="true" style="border:0px;" frameborder="0">
  </iframe>
</div>

<!--div id="playRecordDiv" style="position:absolute;left:0px; top:0px; width:0px; height:0px;">
  <iframe name="prFrame" id="prFrame" scroll="no" height="0" width="0"  bgcolor="transparent" allowtransparency="true">
    </iframe>
</div-->


<!--快进快退进度条-->
<div id="seekDiv" style="position:absolute;width:635px;height:200px;left:0px;top:300px; z-index:1;overflow:hidden; display:none;">
    <div id="seekPercent" style="position:absolute;color:#FFFFFF;width:50;height:30;top:24%;left:311;z-index:3; font-size:22px;"></div>
    <div id="" style="position:absolute;width:635px;height:80;left:0;top:0; background-image:url(images/playcontrol/playChannel/bg-seek.gif);z-index:2;color:white;">
        <table width="635" height="80" border="0" cellpadding="0" cellspacing="0">
            <tr height="40">
                <td></td>
				<td></td>
                <td height="40">
                    <table width="420" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td id="currTimeShow" width="275" valign="middle" align="right" style="font-size:22px;"></td>
                            <td id="statusImg" height="40" align="right" style="font-size:22px"></td>
                            <td width="5"></td>
                        </tr>
                    </table>
                </td>
                <td></td>
            </tr>
            <tr>
			    <td width="5">&nbsp;</td>
                <td width="100" height="40" valign="middle" align="center" style="font-size:22px;">00:00:00</td>
                <td width="420" valign="top">
                   <table width="" height="" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="420" height="30" bgcolor="#000080">
							    <table height="30" width="0" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td id="progressBar" bgcolor="#DAA520"></td>
  </tr>
</table>
                            </td>
                        </tr>
                  </table>
                </td>
				<td width="3">&nbsp;</td>
                <td width="100" valign="middle" align="center" id="fullTime" style="font-size:22px;"></td>
            </tr>
        </table>
    </div>

    <!--输入跳转时间-->
	<div id="jumpTimeDiv" style="position:absolute;width:635;height:90; top:82px;left:0;z-index:9;color:white;background-image:url(images/playcontrol/playVod/bg-seek.gif);">
   
   <table width="635" height="83" border="0" cellpadding="0" cellspacing="0" background="images/playcontrol/playVod/bg-seek.gif">
      
	  <tr>
        <td height="10" colspan="6"></td>
      </tr>
     
	  <tr height="36">
        <td width="40"></td>
        <td width="180" height="36" valign="middle" align="center" style="color:#FFF; font-size:22px" >跳转到</td>
		
        
		 <!-- 跳转框的输入时和分的输入框 -->
          <td width="40" valign="middle" align="center">
		      <input id="jumpTimeHour" type="text" width="40" height="28" maxlength="2" size="4" style="color:#000000; font-size:22px" />
          </td>
          <td width="30" valign="middle" align="center" style="color:#FFF;font-size:22px">时</td>
		  
          <td width="40" valign="middle" align="center">
		      <input id="jumpTimeMin" type="text" width="40" height="28" maxlength="2" size="4" style="color:#000000;font-size:22px"/>
          </td>
          <td width="30" valign="middle" align="center" style="color:#FFF;font-size:22px">分</td>
	
		
		 <!-- 跳转框的确认跳转和取消跳转的按钮 -->
        <td width="140" valign="middle" align="center" height="36">
			<a id="ensureJump" href="javascript:clickJumpBtn();"><img src="images/playcontrol/playVod/ensureJump.gif" width="73" height="28"/></a>
		</td> 
		<td width="140" valign="middle" align="left" height="36">
			<a id="cancelJump" href="javascript:pauseOrPlay();"><img src="images/playcontrol/playVod/cancelJump.gif" width="73" height="28"/></a> 
		</td>
      </tr>
     
	  <tr>
        <!-- 跳转框下的提示信息 -->
        <td id="timeError" width="635" height="30" valign="middle" align="center" colspan="7" style="color:DAA520; font-size:22px"></td>
      </tr>
	  
   </table>
	
</div>
</div>
<div>
	<iframe name="cdr" id="cdr" scroll="no" height="0" width="0" src="" style="border:0px;" frameborder="0">
    </iframe>
</div>  

<div id="finishedBackground" style="position:absolute; left:135px; top:135px; width:380px; height:262px; display:none ;" align="center"> <img src="images/playcontrol/playTvod/playFinish.jpg" height="262" width="380"> </div>
<div id="endDiv" style="position:absolute; left:165px; top:193px; width:310px; height:262px; display:none;z-index:2;">
  <table height="72" width="320" border="0">
    <tr>
      <td style="color:#FFFFFF; font-size:36px;" align="center">播放结束 </td>
    </tr>
  </table>
  <a id="end" href="javascript:goBack();" style="position:absolute; left: 80px; top: 4px; width: 160px; height: 60px;"><img src = "images/playcontrol/playTvod/dot.gif" width="160" height="60"/></a>
  <div style="position:absolute;left:-14px; top:102px;"> <img src="images/playcontrol/playTvod/poster.gif" /> </div>
</div>
<div style="visibility:hidden">
<img src="images/playcontrol/playChannel/Volume_1.gif" />
<img src="images/playcontrol/playChannel/Volume_0.gif" />
</div>
</body>
<script>
        init();
</script>

</html>
