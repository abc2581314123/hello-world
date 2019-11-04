<%@page contentType="text/html; charset=GBK" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    String pathforcokorkey = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());//»ñÈ¡ÅäÖÃÎÄ¼þÂ·¾¶
    HashMap paramforcokorkey = PortalUtils.getParams(pathforcokorkey, "GBK");
    String action = request.getParameter("Action");
    Date now = new Date();
	SimpleDateFormat curday1 = new SimpleDateFormat("yyyy.MM.dd");
	String date = curday1.format(now);
    String tvodurl =  "tvod_new.jsp?columnid=" + paramforcokorkey.get("column02")+"&date="+date;
%>
<html>
<head>
<meta name="page-view-size" content="644*534"/>	
    <title>Ê×Ò³</title>
</head>
<script language="javascript" type="" >
//zte_sml
		//½øÈë4É«¼ü£¬ÊÓÆµÁ÷¹Ø±Õ

	top.clearVideoKeyFunction();
   var state = top.isPlay();
   if(state == true)
   {
       top.doStopVideo();
   }
   
   	var GOTOType =Authentication.CTCGetConfig("STBType");
	
		if(GOTOType == null||GOTOType == ""){
			
		    GOTOType =  Authentication.CUGetConfig("device.stbmodel");	
		
		}

   
   
    var action="<%=action%>";
    var url;
    if(action=="1"){
    	
    	if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-L")>=0||GOTOType.indexOf("B860AV2.2 U")>=0||GOTOType.indexOf("EC6109U")>=0||GOTOType.indexOf("B860AV2.1 U")>=0||GOTOType.indexOf("EC6110U_lnllt")>=0){	
		url="channel-hd.jsp?columnid=" + <%=paramforcokorkey.get("column00")%>;//"mySpace.jsp";
		}else{
		url="channel.jsp?columnid=" + <%=paramforcokorkey.get("column00")%>;//"mySpace.jsp";	
	    }
    	
        
    }else if(action=="2"){
    	
    	if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-L")>=0||GOTOType.indexOf("B860AV2.2 U")>=0||GOTOType.indexOf("EC6109U")>=0||GOTOType.indexOf("B860AV2.1 U")>=0||GOTOType.indexOf("EC6110U_lnllt")>=0){	
		url="tvod_new-hd.jsp?";//"mySpace.jsp";
		}else{
	    url="<%=tvodurl%>";
	    }
    	
       
        <%--"vod_search.jsp?columnid=<%=paramforcokorkey.get("column01")%>";--%>
    }else if(action=="3"){
    	
    	if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-L")>=0||GOTOType.indexOf("B860AV2.2 U")>=0||GOTOType.indexOf("EC6109U")>=0||GOTOType.indexOf("B860AV2.1 U")>=0||GOTOType.indexOf("EC6110U_lnllt")>=0){	
		url="movielist.jsp?";
		}else{
	    url="vod_portal.jsp";
	    }
    	
    	
        
    }else{

            	if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-L")>=0||GOTOType.indexOf("B860AV2.2 U")>=0||GOTOType.indexOf("EC6109U")>=0||GOTOType.indexOf("B860AV2.1 U")>=0||GOTOType.indexOf("EC6110U_lnllt")>=0){	
		url="favor.jsp?&downindex=1" ;
		}else{
		url="mySpace.jsp?" ;//"mySpace.jsp";	
	    }
    	
    }

      var falg = Authentication.CTCGetConfig("ProfessionFlag");
        if(falg=="true1111"){
      top.mainWin.document.location = "http://218.24.37.2/templets/epg/Profession/professionEPG.jsp?providerid=zx&hdpath="+location.href;
        }




        //add by rendd 增加行业二院判断 20191031
        else if(falg=="second_college_main"){
           top.mainWin.document.location = "http://218.24.37.2/templets/epg/p001/main.jsp?providerid=zx&hdpath="+location.href;
        }
        else{
        top.jsEPGChange(url);
      }
  //document.location=url;
</script>

<body bgcolor="#000000">
</body></html>