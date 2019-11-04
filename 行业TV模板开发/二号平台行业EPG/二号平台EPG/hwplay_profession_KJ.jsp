<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="javax.servlet.http.HttpSession" %>
<%@ page language="java" import="com.besto.util.TurnPage" %>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
<%
String stbtype="";
String code= request.getParameter("code");
String name="";
if(request.getParameter("name")!=null){
	name=AESUtil.desEncrypt(request.getParameter("name").toString());
}
String hwType="";
if(request.getParameter("hwType")!=null){
	hwType=request.getParameter("hwType");
}
String videotype = request.getParameter("videotype");
if(videotype.indexOf("hw") != -1 || videotype.indexOf("zx") != -1) {
	if(videotype.indexOf("zx") == -1 ) {
		stbtype =  "hw";
	}else{
		stbtype =  "zx";
	}
}
String playtype ="";
if(request.getParameter("playtype")!=null||!"".equals(request.getParameter("playtype"))){
	playtype = request.getParameter("playtype");
}
String foucsid ="";
if(request.getParameter("foucsid")!=null||!"".equals(request.getParameter("foucsid"))){
	foucsid = request.getParameter("foucsid");
}
if(playtype=="2"||"2".equals(playtype)){
	TurnPage.addCurrFoucs(session, foucsid);
	
}
String returnurl=request.getParameter("backurl");
returnurl = returnurl+"*backflag=1";
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
String returnurl_1 = basePath + "epg/finalpage.jsp?iptvwarchloginsert_returnurl=" + returnurl;
//拼写log值
    String timestemp="";//时间戳   
 	String ip="";//ip地址
 	String tempToken="";//用户的临时标识      
 	String deviceToken="";//用户标识  	
    String nickName = "";//昵称             
    String pageID="";//页面标识         
    String categoryType="2";//访问类型         
    String categoryID="";//访问类型栏目唯一ID 
    String contentID="";//内容唯一ID 
    String contentName="";//节目名称    
    String adType="";  //ad类型                           
    String plateID="";//板块标识   
    String positionID="";//广告位置标识   
    String operationType="";//操作类型 
    String keyword="";//关键词
    String orignal="";//日志来源 
 	String mac ="";	//msc地址
	String protal="";//网络接入类型
	    
	SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date date = new Date();
    timestemp=sim.format(date);
  	ip=request.getLocalAddr();
  	session = request.getSession();
  	if (session.getAttribute("iaspuserid")!= null && !"".equals(session.getAttribute("iaspuserid").toString())) {
  		deviceToken=session.getAttribute("iaspuserid").toString(); 
      
  	} else {
  		deviceToken="2108" + timestemp;
  	}
    pageID="iptv_hwplay.jsp"; 
    contentID=code;
    contentName=name;
    if ("zx".equals(stbtype)) {
    	orignal = "6";
    } else {
    	orignal = "5";
    }
    if (session.getAttribute("MAC") != null && !"".equals(session.getAttribute("MAC").toString())) {
  		mac = session.getAttribute("MAC").toString();
  	} else {
  		mac="2108mac";
  	} 
  	String param=ip+"|"+tempToken+"|"+deviceToken+"|"+nickName+"|"+pageID+"|"+categoryType+"|"+categoryID+
  		 "|"+contentID+"|"+contentName+"|"+adType+"|"+plateID+"|"+positionID+"|"+operationType+"|"+keyword+"|"+orignal+"|"+
  	 	  mac+"|"+protal+"|"+timestemp;
	param = AESUtil.encrypt(param);
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
<jsp:include page="ca.jsp">
<jsp:param name="param" value="<%=param%>"/>
</jsp:include>
<div  id="smallvod"  style="left:0px;  top:0px;  width:640px;  height:530px; position:absolute;"> 
<script language="javascript"> 


       function H5_spstatistics(){
        var adlog ="";
      var GOTOType1 =Authentication.CTCGetConfig("STBType");
    if(GOTOType1.indexOf("B860AV1.1")>=0 ||GOTOType1.indexOf("HG680-RLK9H-12")>=0||GOTOType1.indexOf("EC6108V9")>=0||GOTOType1.indexOf("E900")>=0||GOTOType1.indexOf("EC6109U")>=0||GOTOType1.indexOf("B860")>=0){  
  
         adlog ='http://202.97.183.77:91/loginterface/irts?platform=<%=stbtype%>&version=1.5&userId=<%=deviceToken%>&rtsType=1';
        
    }else{
             adlog ='http://202.97.183.77:91/loginterface/irts?platform=<%=stbtype%>&version=1.0&userId=<%=deviceToken%>&rtsType=1';
    }
        
        var xmlhttpforadlog; 
             if (window.XMLHttpRequest) 
             { 
                  xmlhttpforadlog   =   new   XMLHttpRequest(); 
             } 
             else if (window.ActiveXObject) 
             { 
                  xmlhttpforadlog   =   new   ActiveXObject("Microsoft.XMLHTTP"); 
             } 
             
             xmlhttpforadlog.open("GET",adlog, true); 
             xmlhttpforadlog.onreadystatechange = handlelogResponse1; 
             xmlhttpforadlog.setRequestHeader("If-Modified-Since", "0");
             xmlhttpforadlog.send(null); 
  
   }
              function handlelogResponse1() 
             { 
                 if(xmlhttpforadlog.readyState == 4 && xmlhttpforadlog.status==200) 
                 { 
                 } 
             } 
           H5_spstatistics();  

var epgdomain;
if (typeof(Authentication) == "object"){
	
			if("CTCSetConfig" in Authentication) {
				epgdomain = Authentication.CTCGetConfig("EPGDomain");
				
			} else {
				epgdomain = Authentication.CUGetConfig("EPGDomain");
			}
}


if('<%=stbtype%>' == "hw") {
	var last = epgdomain.lastIndexOf("/"); 
	var host = epgdomain.substr( 0, last );
	document.write( host ); 

	//alert(host + '/VasToMem.jsp?vas_info=<vas_action>play_vod</vas_action><mediacode><%=code%></mediacode><vas_back_url><%=returnurl_1%></vas_back_url>');
window.location.href = host + '/VasToMem_pro_KJ.jsp?vas_info=<vas_action>play_vod</vas_action><mediacode><%=code%></mediacode><vas_back_url><%=returnurl_1%></vas_back_url><mediatype></mediatype><hwType><%=hwType%></hwType>';
	
}else if('<%=stbtype%>' == "zx") {

	var last = epgdomain.lastIndexOf("/"); 
	var host = epgdomain.substr( 0, last );
	//document.write( host ); 
	//document.write('/MediaService/FullScreen?ContentID=<%=code%>&ReturnURL=<%=returnurl_1%>"');
	window.location.href = "play_ehpt_profession_KJ.jsp?code=<%=code%>&backurl=<%=returnurl%>";


}


</script> 
</div>
</body> 
</html>
