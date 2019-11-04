<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:guanfei -->
<%-- CreateAt:2009-02-02 --%>
<%-- FileName:Authorization.jsp --%>
<%-- 
	本页面用与授权
--%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserService" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib uri="/WEB-INF/ca.tld" prefix="ca" %>

<%@ include file="config/config_PlayFilm.jsp"%>
<html>
<head>
<title>SubscribeSelect</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
    TurnPage turnPage = new TurnPage(request);
	turnPage.addUrl();
	ServiceHelp serviceHelp = new ServiceHelp(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	//是否可以预览 1，支持，0不支持
	String sPreviewAble = request.getParameter("PREVIEWFLAG");
	int previewAble = 0 ;
	try
	{
		 previewAble = Integer.parseInt(sPreviewAble);
	}
	catch(Exception e)
	{
		previewAble = 0 ;
	}
	//是否为御览的标示位
	String pigFlag = request.getParameter("PIGFLAG");
	
	//回看节目单过来的时候的频道ID
	String strProChanID = request.getParameter("CHANNELID");
	//要跳转的页面
    String playPageUrl = turnPage.go(0);
	//栏目号
	String typesId = request.getParameter("TYPE_ID")==null?"-1":"null".equals(request.getParameter("TYPE_ID"))?"-1":request.getParameter("TYPE_ID");
	
	//要播放影片的id
    String sProgId = request.getParameter("PROGID"); 
	//电视剧父集ID
	String sFatherSeriesId = request.getParameter("FATHERSERIESID")==null?"-2":"null".equals(request.getParameter("FATHERSERIESID"))?"-2":"-1".equals(request.getParameter("FATHERSERIESID"))?"-2":request.getParameter("FATHERSERIESID");
	
    // 播放类型  内容类型 业务类型  
    String sPlayType = request.getParameter("PLAYTYPE");
    String sContentType = request.getParameter("CONTENTTYPE");
    String sBusinessType = request.getParameter("BUSINESSTYPE");
    //是否续订标示
	String programOrder = request.getParameter("PROGRAM_ORDER");
    //电视剧标志
	String isTVSeriesFlag = request.getParameter("ISTVSERIESFLAG");
	int proChanID = -1;
	if(strProChanID != null)
	{
		proChanID = Integer.parseInt(strProChanID);
	}
    int progId = Integer.parseInt(sProgId);
    int playType = Integer.parseInt(sPlayType);
    int contentType = Integer.parseInt(sContentType);
    int businessType = Integer.parseInt(sBusinessType);
	int fatherSeriesId = -2;
	if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) 
	{
		if (null != sFatherSeriesId && !"".equals(sFatherSeriesId)) 
		{
			fatherSeriesId = Integer.parseInt(sFatherSeriesId);
		}
	}
	
    String serviceType = (String)session.getAttribute("SERVICETYPE");
    
    if ( serviceType == null || serviceType.trim().length() == 0 )
    {
        serviceType = "-1";
		session.setAttribute("SERVICETYPE","-1");
    }
	serviceType = "-1";
	
	%>
	<ca:updateCAEntitlement playType="<%=playType%>" progId="<%=progId%>"/>
	<%
	//再把progId还原成录播频道的节目单ID
    progId = Integer.parseInt(sProgId);
    if(contentType == EPGConstants.CONTENTTYPE_PROGRAM &&(businessType == EPGConstants.BUSINESSTYPE_LIVETV
               || businessType ==  EPGConstants.BUSINESSTYPE_NVOD))
    {
		//增加页面超时的异常保护
		if(null != programOrder && programOrder.equalsIgnoreCase("false")
				&& serviceHelp.isSubscribeProgram(progId,contentType,businessType))
		{
			programOrder = "true";
			%> 
			 <jsp:forward page="<%=turnPage.go(0)%>"/>
			<%
		}
    }
	/*目前直接把ServiceHelp的代码放在页面，后续增加接口，把这些代码放到后台去*/
	UserService userService = new UserService(request);
	UserProfile userProfile = new UserProfile(request);

	String userId = userProfile.getUserId();
	String userToken = userProfile.getUserToken();
	String stbMac = userProfile.getSTBMAC();
	int lang = userProfile.getLang();
	String stbIp = userProfile.getStbIp();
	
	Map retMap = null;






		if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) 
		{
			retMap = serviceHelpHWCTC.authorizationHWCTC(fatherSeriesId,playType, contentType, businessType, typesId,fatherSeriesId);
			
			//retMap = serviceHelpHWCTC.authorizationHWCTC(progId,playType, contentType, businessType, typesId,fatherSeriesId);
		}
		else if (EPGConstants.PLAYTYPE_VAS == playType) 
		{
			retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
		} 
		else if (EPGConstants.PLAYTYPE_TVOD == playType) 
		{
			retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
		} 
		else 
		{	
			retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType,contentType, businessType, typesId, fatherSeriesId);
		}

	int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值

	if(null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE))
    {
        retCode = ((Integer)retMap.get(EPGConstants.KEY_RETCODE)).intValue();
		
    }
    String pageName ="InfoDisplay.jsp";

   
   //授权通过
    if( retCode == EPGErrorCode.SUCCESS )
	//if(true)
    {
		turnPage.removeLast();
		//如果播放一个未到时间的节目单，进入提示页面
		if (contentType == EPGConstants.CONTENTTYPE_PROGRAM)
		{
			String progStartTime = request.getParameter( "PROGSTARTTIME" );
			if (progStartTime == null)
			{
				progStartTime = "";
			}
			String currTime = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
			if(currTime.compareTo(progStartTime) < 0)
			{
				pageName = pageName + "?ERROR_ID=32&ERROR_TYPE=2";
				%>
					<jsp:forward page="<%=pageName%>"/>
				<%
			}
		}
		
		if(out!=null && out.getBufferSize()!=0)
		{
			out.clearBuffer();
		}
		//获取授权通过的产品编号和服务编号
		String sProdId = (String) retMap.get("PROD_CODE");
		String sServiceId = (String) retMap.get("SERVICE_CODE");
		String sPrice = (String) retMap.get("PROD_PRICE");
		
		if(sPrice == null || "".equals(sPrice))
		{
			sPrice = "0";
		}
        
        //由于价格中可能包含中文，需要对价格进行编码
        sPrice = URLEncoder.encode(sPrice,"UTF-8");
		StringBuffer queryStr = new StringBuffer();
		queryStr.append(request.getQueryString());
		queryStr.append("&PRODUCTID=" ).append(sProdId).append("&SERVICEID=").append(sServiceId).append("&ONECEPRICE=").append(sPrice);
		pageName = "play_pageControl_pro.jsp?" + queryStr.toString();
		%>
				<jsp:forward page="<%= pageName %>" />
		<%
	}
	if (retCode == 0x04010004)//0x04010004：用户不存在或非法用户
	{
		turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=157";
%>
		<jsp:forward page="<%=pageName%>"/>
<%
	}
	else if(isChanSubscribe == -1 && (EPGConstants.PLAYTYPE_LIVE == playType || EPGConstants.PLAYTYPE_VAS == playType))
	{		
		turnPage.removeLast();		
		turnPage.removeLast();		
		request.setAttribute("RETMAP",retMap);
		
		String jumpPage = "au_ReviewOrSubscribe.jsp?" + request.getQueryString();
%>
		<jsp:forward page="<%=jumpPage%>"/>
<%
	}
	else if (retCode == 0x07020001)//没有可以订购的产品
	{
		turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=154";
%>
		<jsp:forward page="<%=pageName%>"/>
<%
	}
	else if (retCode == 0x07020100)//0x07020100：数据库异常
	{	
		turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=155";
%>
		<jsp:forward page="<%=pageName%>"/>
<%
	}
	else if (retCode == 0x07020200)//0x07020200：操作超时
	{
		turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=171";
%>
		<jsp:forward page="<%=pageName%>"/>
<%
	}
	else if (retCode == 0x04010899)//0x04010899：用户令牌非法
	{
		turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=158";
%>
		<jsp:forward page="<%=pageName%>"/>
<%
	}
	else if (retCode == 0x07000005) //0x07000005 传入的参数错误
	{	
		
		turnPage.removeLast();	
		
	
		
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=159";
%>
		<jsp:forward page="<%=pageName%>"/>
<%
	}
	else if (retCode == 0x07000006) //0x07000006 解码出现异常
	{
		turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=153";
		//这句打印信息不要删掉，需求就是这样，没有为什么。
		System.out.println("userid="+userId+",stbMac="+stbMac);
%>
<script>
	tempKey = Authentication.CTCGetConfig('identityEncode');
	var pageName =  "<%=pageName%>";
	pageName = pageName + "&tempKey="+ tempKey;
	window.location.href = pageName;
</script>
<%
	}	
	else if (retCode == 400) //BSS限呼的一个问题
	{
		turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=171";
%>
		<jsp:forward page="<%=pageName%>"/>
<%
	}
	//如果是TVOD时跳转到提示页面，不支持在线订购,不能订购该产品，请到营业厅办理或者拨打10000号咨询
	/*else if(EPGConstants.PLAYTYPE_TVOD == playType)
	{
		turnPage.removeLast();
		pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=163";
%>
<script>
		<jsp:forward page="<%=pageName%>"/>
</script>
<%

	}	*/
	else if (retCode == 0x07020002||retCode ==500||retCode ==501||retCode ==502||retCode ==503||retCode ==504)
	{
		ArrayList timeList = (ArrayList) retMap.get("TIMES_LIST");
		ArrayList mouseList = (ArrayList) retMap.get("MONTH_LIST");
		ArrayList pointList = (ArrayList) retMap.get("PREORDERED_PRODLIST");
		

		boolean flag = false ;
		if(timeList!=null && timeList.size()>0)
		{
			flag = true ;
		}
		if(mouseList!=null && mouseList.size()>0)
		{
			flag = true ;
		}
		if(pointList!=null && pointList.size()>0)
		{
			flag = true ;
		}
		if(!flag && retCode == 500)
		{
			turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=135";
		}
		else if(!flag && retCode == 501)//产品不存在或状态不可用
		{
			turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=125";
		} 
		else if(!flag && retCode == 502)//服务不存在或状态不可用
		{
			turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=126";
		}
		else if(!flag && retCode == 503)//订购的产品不在使用期内
		{
			turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=127";
		}
		else if(!flag && retCode == 504)//用户没有订购相应产品或订购关系已失效或未生效
		{
			turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=136";
		} 
		else
		{
			request.setAttribute("RETMAP",retMap);
			pageName = "au_SubscribeSelect.jsp?SHOWPRODUCTTYPE=0&" + request.getQueryString();
			
		}
		%>
			<script>
					<jsp:forward page="<%=pageName%>"/>
			</script>
		<%
	}		
	else
	{
		turnPage.removeLast();		
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=26";
	}
%>
<jsp:forward page="<%=pageName%>"/>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent">
    <table width="640" height="530" border="0">
        <tr>
            <td width="640" height="530"></td>
        </tr>
        <tr>
            <td align="center" style="font-size:15px;color:#FFFFFF; font-family:黑体">处理中. 请稍候...</td>
        </tr>
    </table>
</body>	
</html>
