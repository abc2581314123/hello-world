<!-- 文件名：Category.jsp -->
<!-- 版  权：Copyright 2005-2007 Huawei Tech. Co. Ltd. All Rights Reserved. -->
<!-- 描  述：EPG首页过度页面,主要完成全局按键下发 -->
<!-- 修改人：关飞 -->
<!-- 修改时间：2009-4-15 -->
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="java.util.*"%>
<%@include file = "../../lang.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ include file="../../keyboard_A2/keydefine.jsp"%>




<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
</head>
<%
	//接口
	ServiceHelp serviceHelp = new ServiceHelp(request);
	MetaData metaData = new MetaData(request);
	
	//获取用户信息
	UserProfile userProfile = new UserProfile(request);
	//区域编号
    int areaId = userProfile.getAreaId();
    
    		String iaspuserid = userProfile.getUserId();//用户名
    		String stbId = userProfile.getStbId();//机顶盒ID
		String iaspadsl = "";//userProfile.toString();//宽带账号
		String iaspip = userProfile.getStbIp();//机顶盒IP
		String iaspmac = userProfile.getSTBMAC();//机顶盒mac地址
		String user_platform = "hw";
		String server_address = "60.19.28.163";
		String port = "8082";
     


	//用户组编号
	String userGroupId = userProfile.getUserGroupId();
	
	//检测并返回用户可用的当前模板首页路径
	Map retMap = serviceHelp.checkAndGetFirstPage(LANG1_NAME, LANG2_NAME);
	String strUrl=(String)retMap.get("FIRSTPAGE");
	
	String GlobalFirstLogin = (String)session.getAttribute("GlobalFirstLogin");
	String isComeFromPredeal = (String)request.getParameter("isComeFromPredeal");
	String joinFlag = request.getParameter("joinFlag");
	String abc = (String)session.getAttribute("abc");
	//定义开机进入待进入的页面
	String directPageName = "category_Index_epghd_new.jsp";
	if(GlobalFirstLogin == null)
	{
		//add 为将全局按键表只下发一次，只在首次进入该页面时才下发
     //   directPageName ="firstStartStb.jsp";
        //add 为将全局按键表只下发一次，只在首次进入该页面时才下发
		if(abc == null){
			 directPageName ="firstStartStb.jsp?iaspmac="+iaspmac+"&iaspuserid="+iaspuserid+"&areaId="+areaId;
		}else{
				directPageName = "category_Index_epghd_new.jsp?area=1";
		}
	}



	//上次播放的频道id
	String lastChannelId = (String)request.getParameter("lastchannelNo");
	//判断开机播放
	String directplay = (String)request.getParameter("directplay");
	int channelId = -1;
	if (lastChannelId != null && !lastChannelId.equals(""))
	{
		try
		{
			channelId= Integer.parseInt(lastChannelId);
		}
		catch(Exception e)
		{
			channelId = -1;
		}		
		channelId = metaData.getLastChannelNum(channelId,0);
	}
	//directPageName = "category_Index_epg.jsp?" + request.getQueryString() ;
	//首次进入时，前台跳转，全局按键下发
	/*if(GlobalFirstLogin == null && isComeFromPredeal!=null && isComeFromPredeal.equals("1"))
	{		
		if("0".equals(joinFlag) && "1".equals(directplay) && channelId!=-1)
		{	
			//设置频道为1 ，这里做测试
			//channelId = 1;
			directPageName = "category_DirectPlay.jsp?channelNum=" + channelId; 
		}*/
		/*else if(strUserGroupId.equals(userGroupId))
		{
			directPageName = "category_Sub.jsp"; 
		}*/
		/*else
		{
			directPageName = "category_Index_epg.jsp?" + request.getQueryString() ;
		}
	}
	else
	{	*/	
		/*if(!strUserGroupId.equals(userGroupId))
		{
			response.sendRedirect("category_Sub.jsp");
		}
		else
		{
			response.sendRedirect("category_Index.jsp?" + request.getQueryString());
		}*/
	/*	response.sendRedirect("category_Index_epg.jsp?" + request.getQueryString());
	}*/
%>

<script src="js/registerGlobalKey.js"  language="javascript"></script>
<script>
var abc = "<%=abc%>";
if(abc == null){
	H5_spstatistics();
}
	var epgdomain='';

    if ('CTCSetConfig' in Authentication) {
	    epgdomain = Authentication.CTCGetConfig("EPGDomain");
	} else {
	    epgdomain = Authentication.CUGetConfig("EPGDomain");
	}
	var last = epgdomain.lastIndexOf("/"); 
	var host = epgdomain.substr( 0, last ) ;
    var ip = /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/;
    var text = ip.exec(host);
 //var temp1=host.substring(host.indexOf("//")+2);
 //var port = temp1.substr(temp1.indexOf(":"),temp1.firstIndexOf("/"));
    var hostepg=host.replace(text, "127.0.0.1");
    var pushurl=hostepg+"/pushactionhw.jsp";
	Authentication.CTCSetConfig('MESDomain','http://61.176.217.48:5301/MESLoginServer'); 
	Authentication.CTCSetConfig('DLNAGWDomain', 'http://61.176.217.48:8001');
	Authentication.CTCSetConfig("MultiPlayControlDomain", pushurl );
	
	
	
	var directPageName = "<%=directPageName%>";
	//正常探针
		var boxType = Authentication.CTCGetConfig("STBType");
       	var hdType = "2";
	    var boxCity = "<%=areaId%>";
		var stbId = "<%=stbId%>";
		var pageID="category_Action.jsp";
		var parentcategoryID ="";
		var adlog= 'http://218.24.37.2/templets/epg/spstatistics_HD.jsp?deviceToken=<%=iaspuserid%>&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&boxType='+boxType+'&hdType='+hdType+'&boxCity='+boxCity+'&stbId='+stbId+'&pageID='+pageID+'&orignal=5&adType=3';
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
			 xmlhttpforadlog.onreadystatechange = handlelogResponse; 
			 xmlhttpforadlog.setRequestHeader("If-Modified-Since", "0");
			 xmlhttpforadlog.send(null); 
			function handlelogResponse() 
			 { 
				 if(xmlhttpforadlog.readyState == 4 && xmlhttpforadlog.status==200) 
				 { 
				 } 
			 }
	function jumpCategoryIndex()
	{
		var GOTOType =Authentication.CTCGetConfig("STBType");
		//if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("IP903H")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680")>=0 ||GOTOType.indexOf("HG680-RLK9H-12")>=0){
		//if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0 ||GOTOType.indexOf("HG680-RLK9H-12")>=0){
			
			
		if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0 ||GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("EC6109U")>=0||GOTOType.indexOf("HG680-L")>=0||GOTOType.indexOf("B860AV2.2 U")>=0||GOTOType.indexOf("B860AV2.1 U")>=0||GOTOType.indexOf("EC6110U_lnllt")>=0||GOTOType.indexOf("HG510PG")>=0){	
	
			var appName = "com.iflytek.xiri2.hal";
		      if (STBAppManager.isAppInstalled(appName))
		      {
				var value =	STBAppManager.startAppByIntent("{\"intentType\":0,\"appName\":\"com.iflytek.xiri2.hal\",\"className\":\"com.iflytek.xiri2.hal.InfoActivity\",\"extra\":[{\"name\":\"stbid\",\"value\":\"<%=stbId%>\"},{\"name\":\"user_platform\",\"value\":\"<%=user_platform%>\"},{\"name\":\"server_address\",\"value\":\""+text+"\"},{\"name\":\"iaspmac\",\"value\":\"<%=iaspmac%>\"},{\"name\":\"iaspip\",\"value\":\"<%=iaspip%>\"},{\"name\":\"iaspuserid\",\"value\":\"<%=iaspuserid%>\"},{\"name\":\"port\",\"value\":\"<%=port%>\"},{\"name\":\"reserveone\",\"value\":\"123\"},{\"name\":\"reservetwo\",\"value\":\"123\"},{\"name\":\"reservethree\",\"value\":\"123\"},{\"name\":\"reservefour\",\"value\":\"123\"},{\"name\":\"reservefive\",\"value\":\"123\"}]}");
		      }
	             focus();
	             var falg = Authentication.CTCGetConfig("ProfessionFlag");
	             if(falg=="true1111"){
	             	window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=hw"
	             }




             	//20191029 add by rendd 添加二院首页判断
				else if(falg=="second_college_main"){





					//跳转行业中转页 add by rendd updateTime 20191029
 					window.location.href = "http://202.97.183.28:9090/templets/epg/profession_transfer.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=hw";

				}

	             else{
				window.location.href=directPageName;
		}
			}else{
				window.location.href = "category_Index_epg.jsp?<%request.getQueryString();%>";
			}

	}


	   function H5_spstatistics(){
        var adlog ="";
       
    
         adlog ='http://202.97.183.77:91/loginterface/irts?platform=hw&version=1.5&userId=<%=iaspuserid%>&rtsType=0';
        
        
        
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
//	jumpCategoryIndex();
	 focus();
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent" onLoad="javascript:jumpCategoryIndex();">
<table width="640" height="340" border="0">
    <tr>
        <td width="640" height="300"></td>
    </tr>
    <tr>
        <td align="center" style="font-size:15px;color:#FFFFFF">正在处理，请稍候...</td>
    </tr>
</table>
</body>
</html>






