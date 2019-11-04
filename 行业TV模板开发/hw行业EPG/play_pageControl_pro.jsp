<!-- Copyright (C), Huawei Tech. Co., Ltd. -->
<!-- Author:guolc -->
<!-- ModifBy:20090204 -->
<!-- FileName:playPageControl.jsp -->
	
<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>

<%	
    ServiceHelp serviceHelp = new ServiceHelp(request);
	//内容类型
	String sContentType = request.getParameter("CONTENTTYPE");
	
    //业务类型
	String sBusinessType = request.getParameter("BUSINESSTYPE");
    //url special链接
	String specialUrl = request.getParameter("specialUrl");
	
    int contentType = Integer.parseInt(sContentType);    
    int businessType = Integer.parseInt(sBusinessType); 
      
	String pageName = "";
	
	String queryStr = request.getQueryString();

    if (contentType == EPGConstants.CONTENTTYPE_VOD  
            || contentType == EPGConstants.CONTENTTYPE_VOD_VIDEO 
            || contentType == EPGConstants.CONTENTTYPE_VOD_AUDIO)
    {%>
    <script type="text/javascript">
    var GOTOType =Authentication.CTCGetConfig("STBType");

    if(GOTOType == null||GOTOType == ""){

    GOTOType =  Authentication.CUGetConfig("device.stbmodel");	

      }
    if(GOTOType.indexOf("E900")>=0||GOTOType.indexOf("B860AV1.1")>=0){	
    <%
    pageName = "play_controlVod_bf_new.jsp?" + queryStr;
%>
   }else{
<%
    pageName = "play_controlVod_bf_new.jsp?" + queryStr;
%>}
   </script>
    
    <%
    }
    else if (contentType == EPGConstants.CONTENTTYPE_CHANNEL
            || contentType == EPGConstants.CONTENTTYPE_CHANNEL_VIDEO
            || contentType == EPGConstants.CONTENTTYPE_CHANNEL_AUDIO)
    {
        pageName = "play_ControlChannel.jsp?" + queryStr;

    }
    else if (contentType == EPGConstants.CONTENTTYPE_VAS)
    {
		if(null == specialUrl)
		{
			//获取增值业务的URL，如果为空将提示用户精彩节目即将播出。
			String chanId = request.getParameter("PROGID");
			int progId = Integer.parseInt(chanId);
			String url = (String)serviceHelp.getVasUrl(progId);
			specialUrl = url ;
			pageName = "play_ControlWebChannel.jsp?jumuUrl=" +url ;
		}
		else
		{
        	pageName = specialUrl + "?ISFIRST=1";
		}
    }
	else if (contentType == EPGConstants.CONTENTTYPE_PROGRAM)
    {
        pageName = "play_controlTVod.jsp?" + queryStr;
    }
    else
    {
        pageName = "InfoDisplay.jsp?ERROR_ID=46&ERROR_TYPE=2";
    }
	response.sendRedirect(pageName);
%>

	
	
	
	
	
	