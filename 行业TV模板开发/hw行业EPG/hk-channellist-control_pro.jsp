<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ include file = "datajsp/tvod_progBillByRepertoireFocus-hd.jsp"%>
<script>
function loadchanlist(type){
	//绘制页面数据块
	loaddivs(type);
	
	//预留type--区别频道类型  1-全部
	initAndShowData(type);
}
function loaddivs(type){
	var chandivs="";
	var pagenum;
	if(Number(type)==0){
		tpageCount = Math.ceil(channelCount/pageSize);
		typeCountTotal = channelCount;
		pagenum = tpageCount-1;
	}else if(Number(type)==1){
		tpageCount = Math.ceil(channelCount1/pageSize);
		typeCountTotal = channelCount1;
		pagenum = tpageCount;
	}else if(Number(type)==2){
		tpageCount = Math.ceil(channelCount2/pageSize);
		typeCountTotal = channelCount2;
		pagenum = tpageCount
	}else if(Number(type)==3){
		tpageCount = Math.ceil(channelCount3/pageSize);
		typeCountTotal = channelCount3;
		pagenum = tpageCount;
	}else if(Number(type)==4){
		tpageCount = Math.ceil(channelCount4/pageSize);
		typeCountTotal = channelCount4;
		pagenum = tpageCount;
	}else if(Number(type)==5){
		tpageCount = Math.ceil(channelCount5/pageSize);
		typeCountTotal = channelCount5;
		pagenum = tpageCount;
	}else if(Number(type)==6){
		tpageCount = Math.ceil(channelCount6/pageSize);
		typeCountTotal = channelCount6;
		pagenum = tpageCount;
	}else if(Number(type)==7){
		tpageCount = Math.ceil(channelCount7/pageSize);
		typeCountTotal = channelCount7;
		pagenum = tpageCount;
	}
	//document.getElementById("testgs").innerHTML = pagenum+"====="+typeCountTotal;
	for(var i=0;i<pagenum;i++){
		
		var nowindex = i*10;
		if((nowindex+10) > typeCountTotal){
			nowindex = typeCountTotal;
		}else{
			nowindex = nowindex+10;
		}
		for(var j=i*10;j<nowindex;j++){
			chandivs +='<li id="li'+j+'"></li>';
		}
	}
	chandivs = '<ul>'+ chandivs +'</ul>';
	document.getElementById("channel1").innerHTML = chandivs;
	setChannelM()
	area[100].paras = channelMoveParas
}

var tpageCount = 0; // 频道总页数
var chid = [];
var chidNum = 0;
var typeCountTotal = channelCount;//频道数量
var pageSize = 9; // 每页数量
var tIndex = 1;   //频道当前页码
var vIndex = 1; //  节目当前页码
var abc = "";
function initAndShowData(type)
{	
	chid = []
	//tpageCount = Math.ceil(typeCountTotal/pageSize);
	var nowChanIndex = (tIndex-1)*pageSize;
	var showSize = 999;
	if(Number(type)==0){
		typeCountTotal = channelCount;
		tpageCount = Math.ceil(typeCountTotal/pageSize);	
		document.getElementById("allpagenum").innerHTML = tpageCount-1;
	}else if(Number(type)==1){
		typeCountTotal = channelCount1;
		tpageCount = Math.ceil(channelCount1/pageSize);		
		document.getElementById("allpagenum").innerHTML = tpageCount;
	}else if(Number(type)==2){
		typeCountTotal = channelCount2;
		tpageCount = Math.ceil(channelCount2/pageSize);
		document.getElementById("allpagenum").innerHTML = tpageCount;
	}else if(Number(type)==3){
		typeCountTotal = channelCount3;
		tpageCount = Math.ceil(channelCount3/pageSize);	
		document.getElementById("allpagenum").innerHTML = tpageCount;		
	}else if(Number(type)==4){
		typeCountTotal = channelCount4;
		tpageCount = Math.ceil(channelCount4/pageSize);		
		document.getElementById("allpagenum").innerHTML = tpageCount;
	}else if(Number(type)==5){
		typeCountTotal = channelCount5;
		tpageCount = Math.ceil(channelCount5/pageSize);		
		document.getElementById("allpagenum").innerHTML = tpageCount;
	}else if(Number(type)==6){
		typeCountTotal = channelCount6;
		tpageCount = Math.ceil(channelCount6/pageSize);		
		document.getElementById("allpagenum").innerHTML = tpageCount;
	}else if(Number(type)==7){
		typeCountTotal = channelCount7;
		tpageCount = Math.ceil(channelCount7/pageSize);		
		document.getElementById("allpagenum").innerHTML = tpageCount;
	}
	
	//显示总数
	document.getElementById("num").innerHTML = typeCountTotal;
	
	
	if(typeCountTotal < showSize+nowChanIndex)
	{
		showSize = typeCountTotal-nowChanIndex;
	}
	var testdd = "";
	for(var i=0;i<showSize;i++)
	{
		var index = i + nowChanIndex;
		var tempObj;
		if(Number(type)==0){
			tempObj= chanList[index];
		}else if(Number(type)==1){
			tempObj= chanList1[index];
		}else if(Number(type)==2){
			tempObj= chanList2[index];
		}else if(Number(type)==3){
			tempObj= chanList3[index];
		}else if(Number(type)==4){
			tempObj= chanList4[index];
		}else if(Number(type)==5){
			tempObj= chanList5[index];
		}else if(Number(type)==6){
			tempObj= chanList6[index];
		}else if(Number(type)==7){
			tempObj= chanList7[index];
		}
	
		var id = tempObj["channelIndex"];
		var imgurl = tempObj["logourl"];
		var idLength = id.length;
		if(idLength<3)
		{
			for(var m = 0;m<(3-idLength);m++)
			{
				id = "0" + id;
			}
		}
		testdd += imgurl;
		var typeName = tempObj["channelName_cut"];




		document.getElementById("li"+i).innerHTML = typeName + '<span style="opacity:0">'+ tempObj["channelId"] +'</span>';
		chid.push(tempObj["channelId"])

        document.getElementById("li"+i).dataset['cid'] = id;
		document.getElementById("li"+i).setAttribute("data-url","hk-detail.jsp?channum="+tempObj["channelId"]+"&chanid="+id+"&channame="+encodeURI(typeName)+"&chanpic="+imgurl+"&backurl="+compile(location.href));
	}
	setCookie('wn', chid)
}


function setCookie(name,value){
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days*24*60*60*30);
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}


var pwd = "gdyzs";
//加密
function compile(str) {
  if(pwd == null || pwd.length <= 0) {
    
    return null;
  }
  var prand = "";
  for(var i=0; i<pwd.length; i++) {
    prand += pwd.charCodeAt(i).toString();
  }
  var sPos = Math.floor(prand.length / 5);
  var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
  var incr = Math.ceil(pwd.length / 2);
  var modu = Math.pow(2, 31) - 1;
  if(mult < 2) {
    
    return null;
  }
  var salt = Math.round(Math.random() * 1000000000) % 100000000;
  prand += salt;
  while(prand.length > 10) {
    prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
  }
  prand = (mult * prand + incr) % modu;
  var enc_chr = "";
  var enc_str = "";
  for(var i=0; i<str.length; i++) {
    enc_chr = parseInt(str.charCodeAt(i) ^ Math.floor((prand / modu) * 255));
    if(enc_chr < 16) {
      enc_str += "0" + enc_chr.toString(16);
    } else enc_str += enc_chr.toString(16);
    prand = (mult * prand + incr) % modu;
  }
  salt = salt.toString(16);
  while(salt.length < 8)salt = "0" + salt;
  enc_str += salt;
  return enc_str;
}
//解密
function uncompile(str) {
	
  if(str == null || str.length < 8) {
    
    return;
  }
  if(pwd == null || pwd.length <= 0) {
    
    return;
  }
  var prand = "";
  for(var i=0; i<pwd.length; i++) {
    prand += pwd.charCodeAt(i).toString();
  }
  var sPos = Math.floor(prand.length / 5);
  var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
  var incr = Math.round(pwd.length / 2);
  var modu = Math.pow(2, 31) - 1;
  var salt = parseInt(str.substring(str.length - 8, str.length), 16);
  str = str.substring(0, str.length - 8);
  prand += salt;
  while(prand.length > 10) {
    prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
  }
  prand = (mult * prand + incr) % modu;
  var enc_chr = "";
  var enc_str = "";
  for(var i=0; i<str.length; i+=2) {
    enc_chr = parseInt(parseInt(str.substring(i, i+2), 16) ^ Math.floor((prand / modu) * 255));
    enc_str += String.fromCharCode(enc_chr);
    prand = (mult * prand + incr) % modu;
  }
  return enc_str;
}

</script>
