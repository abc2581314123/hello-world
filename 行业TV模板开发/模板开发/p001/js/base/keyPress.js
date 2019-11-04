var pressFlag = true;


function keyBvod(){
	var url = "chan_RecordList.jsp";
	window.location.href = url;
}

function keyTvod(){
	var url = "tvod_progBillByRepertoire.jsp";
	window.location.href = url;
}

	function keyVod(){
	var url = "vod_Category.jsp ";
	window.location.href = url;
}

keyBlue = function(){
	//var url = "xf_category.html";
	//window.location.href = url;
}

function keyFavourite(){
	//var url = "favorite.jsp";
	//window.location.href = url;
}

//接收机顶盒发送的虚拟事件
keyIptvEvent = function()
{
	eval("eventJson="+Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{	
		case "EVENT_TVMS":
		case "EVENT_TVMS_ERROR":
			top.tvms.dealKeyEvent(eventJson);
			return 0;
		default:
			goUtility(eventJson);
			return 0;
	}
	return true;
}
keyTrack = function (){EPG.keyTrack();}
keyPageUp = function(){EPG.keyPageUp();}
keyPageDown = function(){EPG.keyPageDown();}
keyIME = function(){}
keyFav = function(){}
keyMore = function(){}
keySearch = function(){}

goUtility = function(){EPG.goUtility(eventJson);}
keyPausePlay = function(){EPG.keyPausePlay();}
keyVolUp = function(){EPG.keyVolUp();}
keyVolDown = function(){EPG.keyVolDown();}
keyChannelUp = function(){EPG.keyChannelUp();}
keyChannelDown = function(){EPG.keyChannelDown();}
keyMute = function(){EPG.keyMute();}
keyFastForward = function(){EPG.keyFastForward();}
keyFastRewind = function(){EPG.keyFastRewind();}

keyPreviewTimesOver = function(){EPG.keyPreviewTimesOver();}
keyPreviewTimesUp = function(){EPG.keyPreviewTimesUp();}
keyStbNoChannel= function(){EPG.keyStbNoChannel();}

keyInfo = function(){EPG.keyInfo();}
keyHelp = function(){EPG.keyHelp();}
keyPos = function(){EPG.keyPos();}


//以下代码为输入数字键中转致直播
var ChannelNum = "";
var showNumTimeOut = -1;
var lineArray = ["_","__","___"];
var lineIndex = 0;
var lineTimeout = -1;


 function inputNum(num){
	 inputNumGo(num)
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
	window.location.href = "ChanDirectAction.jsp?chanNum="+ChannelNum;
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

document.onkeydown = grabEvent;
document.onkeydown = grabEvent;

function grabEvent(event)
{	
	//var keycode = event.which;
	var keycode = event.keyCode;
	switch(keycode)
	{
		case  8 :keyBack() ;return 0;break;
		case 270:keyBack() ;return 0;break;
	
		case 37 :keyLeft(); return 0;break;
		case 39 :keyRight() ;return 0;break;
		case 38 :keyUp() ;return 0;break;
		case 40 :keyDown() ;return 0;break;

		case 13 :keyOk() ;return 0;break;
		default:
			//return 0 ;
			//break ;
	}
	
}

