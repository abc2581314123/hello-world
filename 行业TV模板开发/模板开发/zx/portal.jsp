<%@page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*"%>
<%@ page import="com.zte.iptv.epg.content.FirstPageInfoList"%>
<%@ page import="com.zte.iptv.newepg.datasource.EpgFirstPageDatasource"%>
<%@ page import="com.zte.iptv.epg.web.FirstPageInfoQueryValueIn"%>
<%@ page import="com.zte.iptv.epg.account.UserInfo"%>
<%@ page import="com.zte.iptv.epg.web.Result"%>
<%@ page import="com.zte.iptv.epg.content.ChannelInfo"%>
<%@ page import="com.zte.iptv.epg.util.*"%>
<%@ page import="com.zte.iptv.epg.content.VoDQuery"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.zte.iptv.epg.content.*"%>
<%!String replace(HttpServletRequest req, String expression) {
		String ret = expression;
		if (ret == null)
			return "";
		UserInfo userInfo = (UserInfo) req.getSession().getAttribute(
				EpgConstants.USERINFO);
		String pathTemp = PortalUtils.getPath(req.getRequestURI(), req
				.getContextPath());
		HashMap paramTemp = PortalUtils.getParams(pathTemp, "GBK");
		String backepgurl = req.getRequestURL().toString();
		ret = ret.replaceAll("\\{framedir\\}", userInfo.getUserModel());
		ret = ret.replaceAll("\\{frameid\\}", userInfo.getUserModel()
				.substring(5, userInfo.getUserModel().length()));
		ret = ret.replaceAll("\\{epgIp\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{epgip\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{stbId\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{stbid\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{userId\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userid\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userToken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{usertoken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{userTokenExpiretime\\}", userInfo
				.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{usertokenexpiretime\\}", userInfo
				.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{areaCode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{areacode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{returnUrl\\}", backepgurl);
		ret = ret.replaceAll("\\{returnurl\\}", backepgurl);
		return ret;
	}

	String getmac(HttpServletRequest req) {
		UserInfo iaspuserInfo = (UserInfo) req.getSession().getAttribute(
				EpgConstants.USERINFO);
		String iaspmac = "";
		iaspmac = iaspuserInfo.getStbMac();
		return iaspmac;
	}
		String getip(HttpServletRequest req) {
		UserInfo iaspuserInfo = (UserInfo) req.getSession().getAttribute(
				EpgConstants.USERINFO);
		String iaspip = "";
		iaspip = iaspuserInfo.getUserIP();
		return iaspip;
	}
		String getid(HttpServletRequest req) {
		UserInfo iaspuserInfo = (UserInfo) req.getSession().getAttribute(
				EpgConstants.USERINFO);
		String iaspuserid = "";
		iaspuserid = iaspuserInfo.getUserId();
		return iaspuserid;
	}
	String getstbid(HttpServletRequest req) {
		UserInfo iaspuserInfo = (UserInfo) req.getSession().getAttribute(
				EpgConstants.USERINFO);
		String iaspstbid = "";
		iaspstbid = iaspuserInfo.getStbId();
		return iaspstbid;
	}

	%>
		
		<%
		String iaspadsl = "";
	//	iaspadsl = iaspuserInfo.getAccountNo();
		String iaspmac = "";
		iaspmac = getmac(request);
		String iaspip = "";
		iaspip = getip(request);
		String iaspuserid = "";
		iaspuserid = getid(request);
		String stbId = "";
		stbId = getstbid(request);
		String user_platform = "zx";
		String server_address = "218.24.21.82";
		String port = "8080";
	
%>

	    <epg:script/>
    <SCRIPT LANGUAGE="JavaScript" type="">
    
   if ('CTCSetConfig' in Authentication) {
				  
	    Authentication.CTCSetConfig('MESDomain','http://61.176.217.48:5301/MESLoginServer'); 
		Authentication.CTCSetConfig('DLNAGWDomain', 'http://61.176.217.48:8001');
		Authentication.CTCSetConfig("MultiPlayControlDomain", "http://127.0.0.1:8080/iptvepg/frame1004/pushaction.jsp");
		}
		top.jsSetControl("DLNA PUSH RESULT","http://127.0.0.1:8080/iptvepg/frame1083/pushaction.jsp");
	    document.onkeypress = top.doKeyPress;

	function onload()
	{
     
 
    	var GOTOType =Authentication.CTCGetConfig("STBType");
		
		if(GOTOType == null||GOTOType == ""){
			
		    GOTOType =  Authentication.CUGetConfig("device.stbmodel");	
		
		}
		//if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("IP903H")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680")>=0 ||GOTOType.indexOf("HG680-RLK9H-12")>=0){
		if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("EC6109U_lnllt")>=0||GOTOType.indexOf("HG680-L")>=0||GOTOType.indexOf("B860AV2.2 U")>=0||GOTOType.indexOf("B860AV2.1 U")>=0||GOTOType.indexOf("EC6110U_lnllt")>=0){	
			
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
			//	var value =	STBAppManager.startAppByIntent("{\"intentType\":0,\"appName\":\"com.iflytek.xiri2.hal\",\"className\":\"com.iflytek.xiri2.hal.InfoActivity\",\"extra\":[{\"name\":\"iaspmac\",\"value\":\"<%=iaspmac%>\"},{\"name\":\"iaspip\",\"value\":\"<%=iaspip%>\"},{\"name\":\"iaspuserid\",\"value\":\"<%=iaspuserid%>\"}]}");
		//		\"extra\":[{\"name\":\"stbid\",\"value\":\"<%=stbId%>\"},{\"name\":\"user_platform\",\"value\":\"<%=user_platform%>\"},{\"name\":\"server_address\",\"value\":\"<%=server_address%>\"},{\"name\":\"iaspmac\",\"value\":\"<%=iaspmac%>\"},{\"name\":\"iaspip\",\"value\":\"<%=iaspip%>\"},{\"name\":\"iaspuserid\",\"value\":\"<%=iaspuserid%>\"},{\"name\":\"port\",\"value\":\"<%=port%>\"}]
			var appName = "com.iflytek.xiri2.hal";
		      if (STBAppManager.isAppInstalled(appName))
		      {
		var value =	STBAppManager.startAppByIntent("{\"intentType\":0,\"appName\":\"com.iflytek.xiri2.hal\",\"className\":\"com.iflytek.xiri2.hal.InfoActivity\",\"extra\":[{\"name\":\"stbid\",\"value\":\"<%=stbId%>\"},{\"name\":\"user_platform\",\"value\":\"<%=user_platform%>\"},{\"name\":\"server_address\",\"value\":\""+text+"\"},{\"name\":\"iaspmac\",\"value\":\"<%=iaspmac%>\"},{\"name\":\"iaspip\",\"value\":\"<%=iaspip%>\"},{\"name\":\"iaspuserid\",\"value\":\"<%=iaspuserid%>\"},{\"name\":\"port\",\"value\":\"<%=port%>\"},{\"name\":\"reserveone\",\"value\":\"123\"},{\"name\":\"reservetwo\",\"value\":\"123\"},{\"name\":\"reservethree\",\"value\":\"123\"},{\"name\":\"reservefour\",\"value\":\"123\"},{\"name\":\"reservefive\",\"value\":\"123\"}]}");
			}


        var falg = "";
        if ('CTCSetConfig' in Authentication) {
				    falg = Authentication.CTCGetConfig("ProfessionFlag");
				} else {
				    falg = Authentication.CUGetConfig("ProfessionFlag");
				}
     if(falg=="true1111"){
			top.mainWin.document.location = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=zx&hdpath="+location.href;
	}


	//20191028 add by rendd 添加二院首页判断
	else if(falg=="second_college_main"){







		//二院跳转路径	
		top.mainWin.document.location = "http://202.97.183.28:9090/templets/epg/profession_transfer.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=zx&hdpath="+location.href;;
	}
	else{
	     location.href="portalIndexhd_new.jsp";
	}
		

	}
		else{

			               

                          if(GOTOType.indexOf("HG510PG")>=0&&Authentication.CTCGetConfig("ProfessionFlag")=="true1111"){
                             	top.mainWin.document.location = "http://218.24.37.2/templets/epg/Profession/professionEPG.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=zx&hdpath="+location.href;
                          }else{

                          	 location.href="portalbq.jsp?";
                          }


			
	    }
	}
	jumpCategoryIndex();
</SCRIPT>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent" onLoad="javascript:onload();">
<table width="640" height="340" border="0">
    <tr>
        <td width="640" height="300"></td>
    </tr>
    <tr>
        <td align="center" style="font-size:15px;color:#FFFFFF"></td>
    </tr>
</table>
	
</body>
</html>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			