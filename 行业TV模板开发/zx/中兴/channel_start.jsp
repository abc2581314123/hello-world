<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.zte.iptv.epg.account.UserInfo"%>
<%@page import="com.zte.iptv.epg.util.EpgConstants"%>
<%@page import="java.util.*"%>
<%@page import="com.zte.iptv.epg.util.*"%>
<%@page import="com.zte.iptv.newepg.tag.PageReturnStack" %>
<%!
    public String getFrameCode(String uri) {
        String result = "";
        int begin = uri.indexOf("frame");
        int end = uri.lastIndexOf("/");
        if (begin > 0) {
            result = uri.substring(begin, end);
        }
        return result;
    }
%>
<%!
  public String getPath(String uri){
    String path = "";
    int begin = 0;
    int end = uri.lastIndexOf('/');
    if(end > 0){
      path = uri.substring(begin, end + 1) + path;
    }
    return path;
  }
%>
<html>
<head>
    <%
	 String path=getPath(request.getRequestURI());
     System.out.println("====  11111111111111111111   ====");

        String thisFrame = getFrameCode(request.getRequestURI());
        UserInfo userInfo = (UserInfo) pageContext.getSession().getAttribute(EpgConstants.USERINFO);
        String userFrame = userInfo.getUserMainUrl();
            
	  String iaspadsl = "";
	  iaspadsl = userInfo.getAccountNo();
	  String iaspmac = ""; 
	  iaspmac = userInfo.getStbMac();
	  String iaspip = ""; 
	  iaspip = userInfo.getUserIP();
	  String  iaspuserid = "";
	  iaspuserid = userInfo.getUserId();
	  String temstr="&iaspmac="+iaspmac+"&iaspip="+iaspip+"&iaspuserid="+iaspuserid;
      String areaId = userInfo.getAreaNo();
      String stbId = userInfo.getStbId();//机顶盒ID
System.out.println("====  thisFrame   ===="+thisFrame);
        if (!userFrame.equals(thisFrame)) {
            userInfo.setUserMainUrl(thisFrame);
    %>
    <script language="javascript" type="">
        top.jsSetControl("UserModel", "<%=thisFrame%>");
    </script>
    <%
        }
    %>
    <script language="javascript" type="">
        Authentication.CTCSetConfig('SetEpgMode', 'SD');
        top.setBwAlpha(0);
        top.writeConfig("show_pageloadingbar","no");
        Authentication.CTCSetConfig("KeyValue", "0x110");
    </script>
    <script language="javascript" type="">
        function start_channel(){
        <%
        // Unable to get userinfo,please re-login
        if (userInfo == null){
            pageContext.setAttribute(EpgConstants.TIPS, "EPGPgE0013", PageContext.REQUEST_SCOPE);
            pageContext.forward("/errorHandler.jsp");
            return;
        }
        String isMenu = (String)session.getAttribute("is_menu");
        String frameMainUrl = "";
           // goto portal
           String framecode = userInfo.getUserModel();
           if(framecode.indexOf("frame") > -1){
                 frameMainUrl = "/iptvepg/"+ framecode + "/portal.jsp";
            }else{
                frameMainUrl = "/iptvepg/frame" + framecode + "/portal.jsp";
          }
System.out.println("====   frameMainUrl =="+frameMainUrl);

    if(null != isMenu){
      //Stack Clear
      PageReturnStack stack = (PageReturnStack)pageContext.getAttribute(EpgConstants.STACK, PageContext.SESSION_SCOPE);
      if (null!=stack){
        pageContext.setAttribute(EpgConstants.STACK, null, PageContext.SESSION_SCOPE);
      }
    
	String tempno =request.getParameter("tempno");
	int mixno=-1;
	if(tempno!= "" && tempno!=null){
		mixno=Integer.parseInt(tempno);
	}
      if(mixno > -1){
        %>
            top.jsRedirectChannel("<%=mixno%>");
        <%
          }else{
        %>
            top.mainWin.document.location = "<%=frameMainUrl%>";
        <%
          }
        }else{
        %>
            top.mainWin.document.location = "<%=frameMainUrl%>";
        <%}%>
        }
        window.setTimeout("start_channel()",500);
    </script>
    <script language="javascript" type="text/javascript">

   function H5_spstatistics(){
        var adlog ="";
var GOTOType1 =Authentication.CTCGetConfig("STBType");
        if(GOTOType1.indexOf("B860AV")>=0 ||GOTOType1.indexOf("HG680-RLK9H-12")>=0||GOTOType1.indexOf("EC6108V9")>=0||GOTOType1.indexOf("E900")>=0||GOTOType1.indexOf("EC6109U")>=0){        
    
         adlog ='http://202.97.183.77:91/loginterface/irts?platform=zx&version=1.5&userId=<%=iaspuserid%>&rtsType=0';
        
        }else{
         adlog ='http://202.97.183.77:91/loginterface/irts?platform=zx&version=1.0&userId=<%=iaspuserid%>&rtsType=0';
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



      function spstatistics(){
            var boxType = Authentication.CTCGetConfig("STBType");

        var hdType = "1";

        var boxCity = "<%=areaId%>";

        var stbId = "<%=stbId%>";
        var pageID="firstStartStb.jsp";
        
        
        
        var adlog= 'http://218.24.37.2/templets/epg/spstatistics_HD.jsp?deviceToken=<%=iaspuserid%>&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&boxType='+boxType+'&hdType='+hdType+'&boxCity='+boxCity+'&stbId='+stbId+'&pageID='+pageID+'&orignal=5';
        
        
        
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
			 <%  
			     System.out.println("====  11111111111111111111   ====");%>
                 if(xmlhttpforadlog.readyState == 4 && xmlhttpforadlog.status==200) 
                 { 
                 } 
             }



    window.onload= function(){
          Authentication.CTCSetConfig("ZbType","true");
    	 H5_spstatistics();
    	 spstatistics();

	var GOTOType =Authentication.CTCGetConfig("STBType");
		
		if(GOTOType == null||GOTOType == ""){
			
		    GOTOType =  Authentication.CUGetConfig("device.stbmodel");	
		
		}

   		if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("EC6109U_lnllt")>=0||GOTOType.indexOf("HG680-L")>=0||GOTOType.indexOf("B860AV2.2 U")>=0||GOTOType.indexOf("B860AV2.1 U")>=0||GOTOType.indexOf("EC6110U_lnllt")>=0||GOTOType.indexOf("HG510PG")>=0){	
            var falg = Authentication.CTCGetConfig("ProfessionFlag");
                 Authentication.CTCSetConfig("ZbType","true");
             top.mainWin.document.location = "<%=path%>firstStartStb.jsp?";
}
		}
    

        function setCookie(name,value)
    {
        document.cookie = name + "="+ escape (value) + ";expires=";
    }

    </script>
</head>
<body bgcolor="#000000">
<div style=" left:0; top:0; width:1280px; height:720px; position:absolute;  ">
    
</div>
<div style="visibility: hidden; left:0; top:0; width:1280px; height:720px; position:absolute;  ">

</div>
</body>
</html>
