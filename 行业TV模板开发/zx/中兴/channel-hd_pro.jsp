<%@page contentType="text/html; charset=GBK"%> 
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%> 
<%@page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.web.ChannelForeshowQueryValueIn" %>
<%@ page import="com.zte.iptv.newepg.datasource.ChannelOneForeshowDataSource" %>
<%@ page import="com.zte.iptv.newepg.decorator.ChannelOneForeshowDecorator" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zte.iptv.newepg.datasource.EpgResult" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<epg:PageController name="channel-hd.jsp"/>
<%!
	String replaceApp(HttpServletRequest req, String expression) throws Exception{
		
	String ret = expression;
	if(ret == null) return "";
		UserInfo userInfo = (UserInfo)req.getSession().getAttribute(EpgConstants.USERINFO);
		String pathTemp = PortalUtils.getPath(req.getRequestURI(), req.getContextPath());
		HashMap paramTemp = PortalUtils.getParams(pathTemp, "GBK");
		String backepgurl = req.getRequestURL().toString();
		ret = ret.replaceAll("\\{framedir\\}", userInfo.getUserModel());
		ret=ret.replaceAll("\\{frameid\\}",userInfo.getUserModel().substring(5,userInfo.getUserModel().length()));
		ret = ret.replaceAll("\\{epgIp\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{epgip\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{stbId\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{stbid\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{userId\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userid\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userToken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{usertoken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{userTokenExpiretime\\}", userInfo.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{usertokenexpiretime\\}", userInfo.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{areaCode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{areacode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{returnUrl\\}", backepgurl);
		ret = ret.replaceAll("\\{returnurl\\}", backepgurl);
		return ret;
    }
	String getinfoapp1(HttpServletRequest req)
	{
	  	  //update by qiaolinqiang 20160125
	  UserInfo iaspuserInfo = (UserInfo)req.getSession().getAttribute(EpgConstants.USERINFO);
	  String iaspadsl = "";
	  iaspadsl = iaspuserInfo.getAccountNo();//宽带账号
	  String iaspmac = ""; 
	  iaspmac = iaspuserInfo.getStbMac();//MAC信息
	  String iaspip = ""; 
	  iaspip = iaspuserInfo.getUserIP();//IP信息
	  String  iaspuserid = "";
	  iaspuserid = iaspuserInfo.getUserId();//用户信息
	  //update by qiaolinqiang 20160125
	   String returnstr="&iaspmac="+iaspmac+"&iaspip="+iaspip+"&iaspuserid="+iaspuserid;
		return returnstr;
	}
	
	

	public Map getOneChannelTVOD(String date,String startTime,String endTime,String columnid,String channelid,UserInfo userInfo){
		Map rmap = new HashMap();
		try{
            System.out.println("SSSstartTime="+startTime);
            System.out.println("SSSSSendTime="+endTime);
			ChannelOneForeshowDataSource cds = new ChannelOneForeshowDataSource();
			ChannelForeshowQueryValueIn valueIn = (ChannelForeshowQueryValueIn)cds.getValueIn();
			valueIn.setDate(date);
			valueIn.setColumnId(columnid);
			valueIn.setChannelId(channelid);
            valueIn.setStartTime(startTime);
            valueIn.setEndTime(endTime);
			valueIn.setUserInfo(userInfo);
			EpgResult result = cds.getData();
			ChannelOneForeshowDecorator oneDs = new ChannelOneForeshowDecorator();
			EpgResult trueResult = oneDs.decorate(result);
			Map dataOut = (Map) trueResult.getDataOut().get(EpgResult.DATA);
			Vector vstarttime = new Vector();
			Vector vendtime = new Vector();
			Vector vprogramname = new Vector();
			Vector vcontentid = new Vector();
			Vector vplayable = new Vector();
			Vector vstartdate = new Vector();
			Vector venddate = new Vector();
            Vector vrecordsystem = new Vector();
			vstarttime = (Vector)dataOut.get("StartTimeF");
			vplayable = (Vector)dataOut.get("IsPlayable");
			vendtime = (Vector)dataOut.get("EndTimeF");
			vprogramname = (Vector)dataOut.get("Programname");
			vcontentid = (Vector)dataOut.get("ContentId");
			vstartdate = (Vector)dataOut.get("StartTime");
			venddate = (Vector)dataOut.get("EndTime");
            vrecordsystem = (Vector)dataOut.get("Recordsystem");

             rmap.put("recordsystem",vrecordsystem);
			rmap.put("start",vstarttime);
			rmap.put("end",vendtime);
			rmap.put("name",vprogramname);
			rmap.put("contentid",vcontentid);
			rmap.put("playable",vplayable);
			rmap.put("startdate",vstartdate);
			rmap.put("enddate",venddate);

		}catch(Exception ex){
		}
		
		return rmap;
	}

	public String formatname(String name,int num){
		String rname = "";
		if(name.length()>num){
			rname = name.substring(0,num);
		}else{
			rname = name;
		}
		return rname;
	}


	
	
	
	
	
	
%>	
	
	

	<%  
			String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());//获取配置文件路径
		    HashMap param = PortalUtils.getParams(path, "GBK");


			String channelcolumnid = (String)param.get("column00");
			String channelListSql =  " columncode='"+ channelcolumnid + "'";
			String channelOrder = "usermixno asc";
			
		    
		    
		    //查询节目单参数
		    UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
			String startTime = "00:01";
			String endTime = "23:59";
			Date now = new Date();
			SimpleDateFormat curday1 = new SimpleDateFormat("yyyy.MM.dd");
			String nowdate = curday1.format(now);	    
		    SimpleDateFormat curday2 = new SimpleDateFormat("HH:mm");
	        String nowhour = curday2.format(now);
		    String channelid = "";
		    session.setAttribute("pushportal", "0");
		    	
	    //String sql = "status==0";
	%>
<script type="text/javascript">
		
var chanList = [];
var chanList1 = [];
var chanList2 = [];
var chanList3 = [];
var chanList4 = [];
var chanList5 = [];
var chanList6 = [];
var chanList7 = [];
var chanList8 = [];		
var chanList9 = [];
</script>

<ex:search tablename="user_channel" fields="channelname,channelcode,mixno,channeltype" 
	condition="<%=channelListSql%>" curpagenum="1" 
	pagecount="999" order="<%=channelOrder%>" var="list">

		
		<!--${it.channelname }&lt;${it.channelcode }&lt;${it.mixno }&lt;${it.channeltype }-->
		<%
			List channelInfos = (List)pageContext.getAttribute("list");
		    String channelCount = channelInfos.size()+"";

		
		    String program = "";
			if(channelInfos!=null&&channelInfos.size()>0){
				for(int i=0;i<channelInfos.size();i++){
				Map channelInfo=(Map)channelInfos.get(i);
				channelid = channelInfo.get("channelcode").toString();
				Map mmap = new HashMap();	
				mmap = getOneChannelTVOD(nowdate,nowhour,nowhour,"01",channelid,userInfo);	
				Vector mname = (Vector)mmap.get("name");
				Vector vstart = (Vector)mmap.get("start");
	            Vector vend = (Vector)mmap.get("end");
				if(mname.size()>0){
					
				program = (String)mname.get(0);	
				
				if(program.length()>8){
				
				program = program.substring(0,8);
				
				}

				}
				else{
				program="";
				}
			
           %>
           	   
<script type="text/javascript">
           	   
function contains(arr, obj) {
  var i = arr.length;
  while (i--) {
    if (arr[i] === obj) {
      return true;
    }
  }
  return false;
}         	   

var channelCount = '<%=channelCount%>';


var channelCount1 = '<%=channelCount%>';
var channelCount2 = '<%=channelCount%>';
var channelCount3 = '<%=channelCount%>';
var channelCount4 = '<%=channelCount%>';
var channelCount5 = '<%=channelCount%>';
var channelCount6 = '<%=channelCount%>';
var channelCount7 = '<%=channelCount%>';
var channelCount8 = '<%=channelCount%>';
var channelCount9 = '<%=channelCount%>';
	var chan = {};

	
		
	chan["channelIndex"] = '<%=channelInfo.get("mixno")%>';

	chan["channelName_cut"] = '<%=channelInfo.get("channelname")%>';
	chan["logourl"] = '<%=channelInfo.get("filename")%>';

	chan["progName"] = '<%=program%>';
	
    chan["channelcode"] = '<%=channelInfo.get("channelcode")%>';
    //高清
	var gaoqing =["800","801","802","804","807","809","810","812","814"];
   if(contains(gaoqing,chan["channelIndex"])){
		chanList1.push(chan);	
	}
	if(Number(chan["channelIndex"])>=817&&Number(chan["channelIndex"])<=835){
		chanList1.push(chan);
	}
	//高清（新）
   //var gaoqing =["115","116","117","118","119"];
   //if(contains(gaoqing,chan["channelIndex"])){
		
	//       chanList1.push(chan);	
	       
	//     }
	//央视
	if(Number(chan["channelIndex"])>=0 && Number(chan["channelIndex"])<=16){
		chanList2.push(chan);
	}
	//把cctv高清频道放到央视下面
	//update by mawei
	//var yangshi =["801","802","804","807","809","810","812","814","817"]; 
	
	//if(contains(yangshi,chan["channelIndex"])){
		
	//       chanList2.push(chan);	
	       
	//     }
	//卫视  
	if(Number(chan["channelIndex"])>=45 && Number(chan["channelIndex"])<=78){
		chanList3.push(chan);
	}
	//var weishi =["20","45","46","47","48","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","821","822","823","824","825","826","827","828","829","830","831","833","118","800","851","852"];
         
    //if(contains(weishi,chan["channelIndex"])){
         		
    //   chanList3.push(chan);
         	
    // }
	//地方
	if(Number(chan["channelIndex"])>=18 && Number(chan["channelIndex"])<=28){
		chanList4.push(chan);
	}
    if(Number(chan["channelIndex"])>=700 && Number(chan["channelIndex"])<=723){
		chanList4.push(chan);
	}		
	//var difang = ["20","21","22","23","24","25","26","31","32","31","701","702","703","704","705","706","707","708","709","710","712","713","714","711","716","717","718","719","720","116","722"];
         
    //if(contains(difang,chan["channelIndex"])){
         		
    //   chanList4.push(chan);
         	
    // }
     
    //少儿
	if(Number(chan["channelIndex"])>=128 && Number(chan["channelIndex"])<=136){
		chanList5.push(chan);
	}
    	
    // 	var shaoer = ["132","133","134","131","130","401","14","135","136","128","129"];
         
    //if(contains(shaoer,chan["channelIndex"])){
         		
    //   chanList5.push(chan);
         	
    // }
     
     
    //电影 
      var dianying = ["103","104","105","106","108","110","112","113","114","117"];
         
    if(contains(dianying,chan["channelIndex"])){
         		
       chanList6.push(chan);
         	
     }
     
     //剧场
     var juchang = ["100","101","102","107","109","111","115","116"];
         
    if(contains(juchang,chan["channelIndex"])){
         		
       chanList7.push(chan);
         	
     }
    //购物
	var gouwu = ["29","30","31","32","33","34","35","36"];


         
    if(contains(gouwu,chan["channelIndex"])){
         		
       chanList8.push(chan);
         	
     } 
    //其他
	if(Number(chan["channelIndex"])>=120 && Number(chan["channelIndex"])<=127){
		chanList9.push(chan);
	}
	if(Number(chan["channelIndex"])>=137 && Number(chan["channelIndex"])<=156){
		chanList9.push(chan);
	}
    var qita = ["909"];
         
    if(contains(qita,chan["channelIndex"])){
         		
       chanList9.push(chan);
         	
     }


	chanList.push(chan);
	channelCount1 = chanList1.length;
    channelCount2 = chanList2.length;
    channelCount3 = chanList3.length;
    channelCount4 = chanList4.length;
    channelCount5 = chanList5.length;
    channelCount6 = chanList6.length;
    channelCount7 = chanList7.length;
	channelCount8 = chanList8.length;
	channelCount9 = chanList9.length;
	   
           		   
           	   
           </script>	   
			<%
			
			
			
					
				}
			}
		%>

</ex:search>
<!DOCTYPE html>

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
<script type="text/javascript">
	



var tpageCount = 0; // 频道总页数
var typeCountTotal = '19';//频道数量
var pageSize = 9; // 每页数量
var tIndex = 1;   //频道当前页码
var vIndex = 1; //  节目当前页码


function GetDateStr(AddDayCount) { 
var dd = new Date(); 
dd.setDate(dd.getDate()-AddDayCount);//获取AddDayCount天前的日期 

var d = dd.getDate();
var y = dd.getFullYear(); 
var m = dd.getMonth()+1;//获取当前月份的日期 
if(m<10){
m="0"+m; 
}   

if(d<10){

d="0"+d; 
}   
return y+"."+m+"."+d; 
}


	
var date = GetDateStr(0);



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
	}
	else if(Number(type)==8){
		typeCountTotal = channelCount8;
	}
	else if(Number(type)==9){
		typeCountTotal = channelCount9;
	}
	document.getElementById("num").innerHTML = typeCountTotal;
	document.getElementById("totalline").innerHTML =  Math.ceil(typeCountTotal/3);	
	chandivs += '<div class="channel-list">';
	for(var i=0;i<typeCountTotal;i++){		
		chandivs += '<div class="channel" id="url-1-'+i+'"><div class="channel-content"><div class="channel-id" id="sid-1-'+i+'">223</div><div class="channel-detail"><div class="channel-name" id="s-1-'+i+'">江苏卫视</div><div class="channel-cp" id="programname-1-'+i+'" >我们相爱吧</div></div></div></div>';		
	}
	chandivs += '</div>'; 
	document.getElementById("part-list").innerHTML = chandivs;
}
var tpageCount = 0; // 频道总页数

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
	}
	else if(Number(type)==8){
		typeCountTotal = channelCount8;
	}
	else if(Number(type)==9){
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
		}
	else if(Number(type)==8){
			tempObj= chanList8[i];
		}
		else if(Number(type)==9){
			tempObj= chanList9[i];
		}
		var id = tempObj["channelIndex"];
		var imgurl = tempObj["logourl"];
		var programname = tempObj["progName"];
		var channelcode = tempObj["channelcode"];
		
		
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
			document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname;
			document.getElementById("lurl-1-"+tempindex).setAttribute("data-url","hk-detail.jsp?channelid="+channelcode+"&date="+date+"&showid="+id+"&showname="+typeName+"&showpic="+imgurl+"&initsel=6&backurl="+compile(location.href));
			document.getElementById("url-1-"+tempindex).setAttribute("data-url","channel_detail.jsp?mixno="+Number(id));
			
	
			
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
		}
	else if(Number(type)==8){
			tempObj= chanList8[i];
		}
		else if(Number(type)==9){
			tempObj= chanList9[i];
		}
		var id = tempObj["channelIndex"];
		var imgurl = tempObj["logourl"];
		var programname = tempObj["progName"];
		var channelcode = tempObj["channelcode"];
		
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
			document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname;
			document.getElementById("lurl-1-"+tempindex).setAttribute("data-url","hk-detail.jsp?channelid="+channelcode+"&date="+date+"&showid="+id+"&showname="+typeName+"&showpic="+imgurl+"&initsel=6&backurl="+compile(location.href));
			document.getElementById("url-1-"+tempindex).setAttribute("data-url","channel_detail.jsp?mixno="+Number(id));
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


<body style="background: url(./hd-img/bodyNC.jpg);">
<jsp:include page="adloadzx_zb_HD.jsp">
<jsp:param name="pageID" value="channel-hd.jsp"/>
<jsp:param name="onepageID" value=""/>
</jsp:include>	
	





	
		         <div style="width:200px;height:30px;margin-left:1024px;margin-top:60px;position: absolute;" >
		<font  id="channel_num" color=green size=20></font>
		</div>
	         
	<div> 
		<!-- 页面容器开始 --> 
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
					<span style="font-size: 26px;">直播 <span id="num" class="fcfd0">444</span> 台 &nbsp;&nbsp;&nbsp;&gt;</span> 
					<span id="programNav">全部</span> 
				</div> 
				<div class="part-info-mind"> 
					<img class="vam" id="arrowUp" src="hd-img/arrow-up.png" data-src="hd-img/arrow-up-sel.png" alt=""> 
					<img class="vam" id="arrowDown" src="hd-img/arrow-down.png" alt="" data-src="hd-img/arrow-down-sel.png"> 
					<span class="fcfd0" id="currentPage">1</span>/<span id="totalline">39<span>行 
				</span></span></div> 
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
	<script src="hd-js/Util.js"></script>	
	<script src="hd-js/extend_zb.js"></script>
	<script src="hd-js/common_zb.js"></script>
	<script src="hd-js/list-channel-new_pro.js"></script>
	<script src="hd-js/keyPress_zb.js"></script>
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
setCookie("zbBackUrl",location.href);
setCookie("zbFlag","false");

	function keyBack(){
        window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp";
    }
	</script>
</body>
</html>