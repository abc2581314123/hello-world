<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page language="java" import="javax.servlet.http.HttpSession" %>

<%@ page language="java" import="com.besto.util.TurnPage" %>

<%@ page import="org.apache.log4j.Logger" %>

<%@ page language="java" import="com.besto.util.AESUtil"%>

<%@ page language="java" import="java.text.SimpleDateFormat"%>


<%@ page import="com.besto.util.CommonInterface" %>

<%

Logger logger = Logger.getLogger(CommonInterface.class);
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
//AddServicesInterface asi = new AddServicesInterface();
String code= request.getParameter("code");//视频code
String codeList= request.getParameter("codeList");//多集code集合
String num=request.getParameter("num");
String scode= request.getParameter("scode");//节目scode
logger.info("=================scode:"+scode);
if(scode ==null){//电影只有视频code，无节目scode值，将视频code赋值给节目scode
	scode = code;
	logger.info("=================scode:"+scode);
}
String pagejsp= request.getParameter("pagejsp");
String categoryId = request.getParameter("categoryId");
String providerid = request.getParameter("providerid");
String iaspuserid = request.getParameter("iaspuserid");
String serviceFlag= request.getParameter("serviceFlag");
Date logd = new Date();
SimpleDateFormat logsdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
String logstarTimeStr = logsdf.format(logd);
String returnurl = "";
if(serviceFlag == null){
	String param = scode+"@"+categoryId+"@"+providerid+"@"+iaspuserid;
	returnurl = basePath+"epg/"+pagejsp+"?param="+param;
}else{
 	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    String starTimeStr = sdf.format(d);
    String param = code+"@"+categoryId+"@"+serviceFlag+"@"+starTimeStr+"@"+providerid+"@"+iaspuserid;
	returnurl = basePath+"epg/"+pagejsp+"?param="+param;
	
}
returnurl= request.getParameter("backurl");

logger.info("================================="+returnurl);
logger.info("=================================播放code："+code);
returnurl = returnurl+"*macode="+code;
logger.info("=================================播放code11111111111111："+returnurl);
//----------海报位日志采集start---------------------------
SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date date = new Date();
String userId =iaspuserid;//用户id
String timestemp=sim.format(date);//时间
String pageID="play_ehpt.jsp";//页面标识
String orignal="";//供应商5：hw 6:zx
if("hw".equals(providerid)){
	orignal="5";
}else{
	orignal="6";
}
String categoryID="";//节目分类
String adcode=code;//节目code
String adname="";//节目名称
String productid="";//产品编码
String orderNumber="";//订单号
String isgoon="";//0自动续订 1非自动续订
String result="";//0支付成功1支付失败
String adtype="-1";//鉴权类型-1统计页面访问量 0付费会员订购观看视频 1视频直接观看 2搜狐计费结果通知 3狐包月产品退订 
String iaspmac="";//MAC
String iaspip="";//IP
String resolute="hd";//高（hd）标(sd)清标识
String param = "";//参数
String paramString = userId+"|"+timestemp+"|"+pageID+"|"+orignal+"|"+categoryID+"|"+adcode+"|"+adname+"|"+productid+"|"+orderNumber
+"|"+isgoon+"|"+result+"|"+iaspmac+"|"+iaspip+"|"+adtype+"|"+resolute;
param = AESUtil.encrypt(paramString);
//asi.writeToUserLog(param);


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"

        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>

    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>

    <meta name="page-view-size" content="640*530"/>

    <title>视频播放</title>

</head>

<body bgcolor="transparent"> 
<div  id="smallvod"  style="left:0px;  top:0px;  width:640px;  height:530px; position:absolute;"> 

<script language="javascript"> 



document.write('<iframe name="if_smallscreen" width="640px" height="530px" src="'); 

var epgdomain;
var code ='<%=code%>';
var returnurl='<%=returnurl%>';
if (typeof(Authentication) == "object"){

	

			if("CTCSetConfig" in Authentication) {

				epgdomain = Authentication.CTCGetConfig("EPGDomain");

				

			} else {

				epgdomain = Authentication.CUGetConfig("EPGDomain");

			}

}

var stbtype='';
if(epgdomain.indexOf('/en/')>=0){
	stbtype='hw';
}else{
	stbtype='zx';
}

if(stbtype == "hw") {

	var last = epgdomain.lastIndexOf("/"); 

	var host = epgdomain.substr( 0, last );

	document.write( host ); 

	

	window.location.href = host + '/VasToMem_pro_KJ.jsp?vas_info=<vas_action>play_vod</vas_action><mediacode><%=code%></mediacode><vas_back_url><%=returnurl%></vas_back_url><mediatype></mediatype>';

	

}else if(stbtype == "zx") {

   var last = epgdomain.lastIndexOf("/"); 

	var host = epgdomain.substr( 0, last );
	setCookie("codeList",'<%=codeList%>');
	setCookie("num",'<%=num%>');
	var returnurl_1 = "http://218.24.37.2/templets/epg/myplay_ehpt_profession_KJ.jsp?returnurl=<%=returnurl%>";
	
	requrl = host + "/MediaService/SmallScreen?ContentID=<%=code%>&ReturnURL="+returnurl_1+"&ifameFlag=1";
	
	window.location = requrl;
}

document.write(' ></iframe>'); 


	function setCookie(name,value)
	{
		document.cookie = name + "="+ escape (value) + ";expires=";
	}
	function getCookie(name)
	{
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
		else
		return null;
	}
</script> 

</div>

</body> 

</html>

