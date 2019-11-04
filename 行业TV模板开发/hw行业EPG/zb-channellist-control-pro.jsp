<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ include file = "datajsp/tvod_progBillByRepertoireFocus.jsp"%>
<script>
function loadchanlist(type){
	//绘制页面数据块
	loaddivs(type);
	//预留type--区别频道类型  1-全部
	initAndShowData(type);
}




function loaddivs(type){
	var chandivs="";
	if(Number(type)==0){
		typeCountTotal = channelCount;
	}else if(Number(type)==1){
		typeCountTotal = channelCount1;
	}else if(Number(type)==2){
		typeCountTotal = channelCount2;
	}else if(Number(type)==3){
		typeCountTotal = channelCount3;
	}else if(Number(type)==4){
		typeCountTotal = channelCount4;
	}else if(Number(type)==5){
		typeCountTotal = channelCount5;
	}else if(Number(type)==6){
		typeCountTotal = channelCount6;
	}else if(Number(type)==7){
		typeCountTotal = channelCount7;
	}else if(Number(type)==8){
		typeCountTotal = channelCount8;
	}else if(Number(type)==9){
		typeCountTotal = channelCount9;
	}
	document.getElementById("num").innerHTML = typeCountTotal;
	document.getElementById("totalline").innerHTML =  Math.ceil(typeCountTotal/4);	
	chandivs += '<div class="channel-list">';
	for(var i=0;i<typeCountTotal;i++){		
		chandivs += '<div class="channel" id="url-1-'+i+'"><div class="channel-content"><div class="channel-id" id="sid-1-'+i+'">223</div><div class="channel-detail"><div class="channel-name" id="s-1-'+i+'">江苏卫视</div><div class="channel-cp" id="programname-1-'+i+'" >我们相爱吧</div></div></div></div>';		
	}
	chandivs += '</div>';
	document.getElementById("part-list").innerHTML = chandivs;
}
var tpageCount = 0; // 频道总页数
var typeCountTotal = channelCount;//频道数量
var pageSize = 9; // 每页数量
var tIndex = 1;   //频道当前页码
var vIndex = 1; //  节目当前页码
function initAndShowData(type)
{
	var nowChanIndex = (tIndex-1)*pageSize;
	var showSize = 999;
	if(Number(type)==0){
		typeCountTotal = channelCount;
	}else if(Number(type)==1){
		typeCountTotal = channelCount1;
	}else if(Number(type)==2){
		typeCountTotal = channelCount2;
	}else if(Number(type)==3){
		typeCountTotal = channelCount3;
	}else if(Number(type)==4){
		typeCountTotal = channelCount4;
	}else if(Number(type)==5){
		typeCountTotal = channelCount5;
	}else if(Number(type)==6){
		typeCountTotal = channelCount6;
	}else if(Number(type)==7){
		typeCountTotal = channelCount7;
	}else if(Number(type)==8){
		typeCountTotal = channelCount8;
	}else if(Number(type)==9){
		typeCountTotal = channelCount9;
	}
	var tempindex = 0;
	//先放高清
	for(var i=0;i<typeCountTotal;i++)
	{
		var tempObj;
		if(Number(type)==0){
			tempObj= chanList[i];
		}else if(Number(type)==1){
			tempObj= chanList1[i];
		}else if(Number(type)==2){
			tempObj= chanList2[i];
		}else if(Number(type)==3){
			tempObj= chanList3[i];
		}else if(Number(type)==4){
			tempObj= chanList4[i];
		}else if(Number(type)==5){
			tempObj= chanList5[i];
		}else if(Number(type)==6){
			tempObj= chanList6[i];
		}else if(Number(type)==7){
			tempObj= chanList7[i];
		}else if(Number(type)==8){
			tempObj= chanList8[i];
		}else if(Number(type)==9){
			tempObj= chanList9[i];
		}
	
		var id = tempObj["channelIndex"];
		var imgurl = tempObj["logourl"];
		var programname = tempObj["progName"];
		var idLength = id.length;
		if(idLength<3)
		{
			for(var m = 0;m<(3-idLength);m++)
			{
				id = "0" + id;
			}
		}
		var typeName = tempObj["channelName_cut"];	
		if(Number(id)<900 && Number(id)>799){
			document.getElementById("sid-1-"+tempindex).innerHTML = id;
			document.getElementById("s-1-"+tempindex).innerHTML = typeName;
			if(programname.length>8){
				document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname.substring(0,8)+"...";
			}else{
				document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname.substring(0,8);
			}
			document.getElementById("lurl-1-"+tempindex).setAttribute("data-url","hk-detail.jsp?channum="+tempObj["channelId"]+"&chanid="+id+"&channame="+encodeURI(typeName)+"&chanpic="+imgurl+"&backurl="+compile(location.href));
			document.getElementById("url-1-"+tempindex).setAttribute("data-url","ChanDirectAction.jsp?chanNum="+Number(id));
			tempindex++;
		}
	}
	
		//再放标清
	for(var i=0;i<typeCountTotal;i++)
	{
		var tempObj;
		if(Number(type)==0){
			tempObj= chanList[i];
		}else if(Number(type)==1){
			tempObj= chanList1[i];
		}else if(Number(type)==2){
			tempObj= chanList2[i];
		}else if(Number(type)==3){
			tempObj= chanList3[i];
		}else if(Number(type)==4){
			tempObj= chanList4[i];
		}else if(Number(type)==5){
			tempObj= chanList5[i];
		}else if(Number(type)==6){
			tempObj= chanList6[i];
		}else if(Number(type)==7){
			tempObj= chanList7[i];
		}else if(Number(type)==8){
			tempObj= chanList8[i];
		}else if(Number(type)==9){
			tempObj= chanList9[i];
		}
	
		var id = tempObj["channelIndex"];
		var imgurl = tempObj["logourl"];
		var programname = tempObj["progName"];
		var idLength = id.length;
		if(idLength<3)
		{
			for(var m = 0;m<(3-idLength);m++)
			{
				id = "0" + id;
			}
		}
		var typeName = tempObj["channelName_cut"];	
		if(Number(id)<800 || Number(id)>899){
			document.getElementById("sid-1-"+tempindex).innerHTML = id;
			document.getElementById("s-1-"+tempindex).innerHTML = typeName;
			if(programname.length>8){
				document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname.substring(0,8)+"...";
			}else{
				document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname.substring(0,8);
			}
			document.getElementById("lurl-1-"+tempindex).setAttribute("data-url","hk-detail.jsp?channum="+tempObj["channelId"]+"&chanid="+id+"&channame="+encodeURI(typeName)+"&chanpic="+imgurl+"&backurl="+compile(location.href));
			document.getElementById("url-1-"+tempindex).setAttribute("data-url","ChanDirectAction.jsp?chanNum="+Number(id));
			tempindex++;
		}
	}
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








