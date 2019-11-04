<!-- Copyright (C), Huawei Tech. Co., Ltd. -->
<!-- Author:guanfei -->
<!-- CreateAt:20090202 -->
<!-- FileName:playfilm.jsp -->

<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.*" %>
<%@page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ include file="config/config_PlayFilm.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<TITLE>PlayFilm</TITLE>
</head>
<%	

	// 影片ID
    String sProgId = request.getParameter("PROGID"); 
	// 播放类型
	String sPlayType = request.getParameter("PLAYTYPE");
    // 内容类型
	String sContentType = request.getParameter("CONTENTTYPE");
    // 业务类型
	String sBusinessType = request.getParameter("BUSINESSTYPE");
    
	String pageName = "";
	
		
		
	//验证影片的编号是否为数字 如果不是数字则给出提示
    if ( !EPGUtil.strIsNumber(sProgId) || !EPGUtil.strIsNumber(sPlayType)
	        || !EPGUtil.strIsNumber(sContentType)  || !EPGUtil.strIsNumber(sBusinessType))
	{
	
%>
        <jsp:forward page="InfoDisplay.jsp?ERROR_TYPE=2&ERROR_ID=159" />
<%
	}
	

    int progId = Integer.parseInt(sProgId);
    int playType = Integer.parseInt(sPlayType);
    int contentType = Integer.parseInt(sContentType);    
    int businessType = Integer.parseInt(sBusinessType); 
	
    MetaData metaData = new MetaData(request);
    ServiceHelp serviceHelp = new ServiceHelp(request);
    Map progInfoMap = null;

	//获取影片的信息 验证影片是否存在  如果不存在给出提示信息，如果存在的话验证父母控制。
    if (contentType == EPGConstants.CONTENTTYPE_VOD  
            || contentType == EPGConstants.CONTENTTYPE_VOD_VIDEO 
            || contentType == EPGConstants.CONTENTTYPE_VOD_AUDIO)
    {
        progInfoMap = metaData.getVodDetailInfo(progId);
    }
    else if ( contentType == EPGConstants.CONTENTTYPE_CHANNEL
            || contentType == EPGConstants.CONTENTTYPE_CHANNEL_VIDEO
            || contentType == EPGConstants.CONTENTTYPE_CHANNEL_AUDIO)
    {
        progInfoMap = metaData.getChannelInfo(String.valueOf(progId));
    }
    else if ( contentType == EPGConstants.CONTENTTYPE_PROGRAM )
    {
        progInfoMap = metaData.getProgDetailInfo(progId);
    }
    else if ( contentType == EPGConstants.CONTENTTYPE_VAS )
    {
        progInfoMap = metaData.getVasDetailInfo(progId);
    }
    if ( playType != EPGConstants.PLAYTYPE_ASSESS &&
            ( progInfoMap == null || progInfoMap.size() == 0) )
    {
%>
<script>
	parent.location.href = "InfoDisplay.jsp?ERROR_TYPE=2&ERROR_ID=70";
</script>
<%

    }
    else
    {
		//验证父母控制级别及锁管理
        boolean isControlled = true;
        //needPwdBeforeSub 在配置文件config.jsp中配置
		if(needPwdBeforeSub == 0)
		{
			isControlled = false;
		}
		else if(needPwdBeforeSub == 1)
		{
			isControlled = true;
		}
		else
		{
			if (playType == EPGConstants.PLAYTYPE_ASSESS)
			{
				int fatherProgId = -1;
				try
				{
					fatherProgId = Integer.parseInt(request.getParameter("FATHERPROGID"));
				}
				catch(Exception e)
				{
					fatherProgId = -1;
				}
				//判断用户播放的节目是否受限
				isControlled = serviceHelp.isControlledOrLocked(true, true, contentType, fatherProgId);
			}
			else
			{
				//判断用户播放的节目是否受限
				isControlled = serviceHelp.isControlledOrLocked(true, true, contentType, progId);
			}
        }   
        pageName = "au_Authorization_pro.jsp?" + request.getQueryString();
		

       
        //存在锁管理或父母控制的话进入密码认证页面，不存在的话进入授权认证页面进行授权认证。
        if ( isControlled )
        {
            pageName = "au_PassCheck.jsp?"+request.getQueryString()+"&returnurl="+pageName ;
			
			%>
		
						<jsp:forward page="<%=pageName%>"/>;
	
			<%
        }
%>
    <jsp:forward page="<%=pageName%>"/>;
<%		
    }
	
%>

	

    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent">
    <table width="720" height="340" border="0">
        <tr>
            <td width="720" height="300"></td>
        </tr>
        <tr>
            <td align="center" style="font-size:15px;color:#FFFFFF; font-family:黑体">处理中. 请稍候...</td>
        </tr>
    </table>
    </body>	
</html>