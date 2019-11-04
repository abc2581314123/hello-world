<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="javax.servlet.http.HttpSession" %>
<%@ page language="java" import="com.besto.util.CommonInterface" %>
<%@ page language="java" import="com.besto.util.SecurityTools" %>
<%@ page language="java" import="com.besto.util.ReadProperties" %>
<%@ page language="java" import="com.besto.util.EscapeUnescape" %>
<%@ page language="java" import="com.besto.util.TurnPage" %>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="org.apache.log4j.Logger" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="com.besto.util.Base64"%>
<%@ page language="java" import="com.besto.util.Decryptor"%>
<%@ page language="java" import="com.besto.util.Encryptor"%>
<%@ page language="java" import="com.besto.util.MD5"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.dom4j.Document"%>
<%@ page import="org.dom4j.Element"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="org.dom4j.DocumentHelper"%>
<%@ page language="java" import="org.json.*" %>





    <%
    Logger logger = Logger.getLogger(CommonInterface.class);
    String path = request.getContextPath();

    SecurityTools st = new SecurityTools();

    long time = System.currentTimeMillis();

    String key = "gl";
    String riddle = st.encrypt(key + time);
    
    String filePath = "";

    //¶ÁÈ¡ÅäÖÃÎÄ¼þ
    try {
        filePath = this.getClass().getClassLoader().getResource("interface.properties").toURI().getPath();     //»ñÈ¡½Ó¿ÚÅäÖÃÎÄ¼þÂ·¾¶
     }catch (Exception e) { 
        e.printStackTrace();
    }   
    Properties properties = ReadProperties.readProperties(filePath);

    String professionMessage  = properties.get("ProfessionMessage").toString();

    String zxpath="";//zxÂ·¾¶
    if(request.getParameter("zxpath")!=null){
        zxpath = request.getParameter("zxpath");
        session.setAttribute("zxpath", zxpath);
    }
    if(session.getAttribute("zxpath")!=null&&!"".equals(session.getAttribute("zxpath").toString())){
         zxpath =session.getAttribute("zxpath").toString();

       }

    String providerid="";//¹©Ó¦ÉÌÀàÐÍ
    if(request.getParameter("providerid")!=null){
        providerid = request.getParameter("providerid");
        session.setAttribute("providerid",providerid);
    }
    if ("".equals(providerid) || providerid == null) {
        providerid = (String)session.getAttribute("providerid");
    }
        String iaspuserid="";//¹©Ó¦ÉÌÀàÐÍ
        if(request.getParameter("iaspuserid")!=null){
            iaspuserid = request.getParameter("iaspuserid");
            session.setAttribute("iaspuserid",iaspuserid);
        }
        if ("".equals(iaspuserid) || iaspuserid == null) {
            iaspuserid = (String)session.getAttribute("iaspuserid");
        }
        String iaspadsl="";//¿í´øÕËºÅ
        if(request.getParameter("iaspadsl")!=null){
            iaspadsl = request.getParameter("iaspadsl");
            session.setAttribute("iaspadsl",iaspadsl);
        }
        if ("".equals(iaspadsl) || iaspadsl == null) {
            iaspadsl = (String)session.getAttribute("iaspadsl");
        }
        String iaspip="";//
        if(request.getParameter("iaspip")!=null){
            iaspip = request.getParameter("iaspip");
            session.setAttribute("iaspip",iaspip);
        }
        if ("".equals(iaspip) || iaspip == null) {
            iaspip = (String)session.getAttribute("iaspip");
        }
        String iaspmac="";//¿í´øÕËºÅ
        if(request.getParameter("iaspmac")!=null){
            iaspmac = request.getParameter("iaspmac");
            session.setAttribute("iaspmac",iaspmac);
        }
        if ("".equals(iaspmac) || iaspmac == null) {
            iaspmac = (String)session.getAttribute("iaspmac");
        }
    
        String boxCity="";// ÇøÓòID
        if(request.getParameter("boxCity")!=null){
            boxCity = request.getParameter("boxCity");
            session.setAttribute("boxCity",boxCity);
        }
        if ("".equals(boxCity) || boxCity == null) {
            boxCity = (String)session.getAttribute("boxCity");
        }
        String stbId="";//»ú¶¥ºÐID
        if(request.getParameter("stbId")!=null){
            stbId = request.getParameter("stbId");
            session.setAttribute("stbId",stbId);
        }
        if ("".equals(stbId) || stbId == null) {
            stbId = (String)session.getAttribute("stbId");
        }
        String hdpath="";//1ºÅÆ½Ì¨È«Â·¾¶
        if(request.getParameter("hdpath")!=null){
            hdpath = request.getParameter("hdpath");
            session.setAttribute("hdpath",hdpath);
        }
        if ("".equals(hdpath) || hdpath == null) {
            hdpath = (String)session.getAttribute("hdpath");
        }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>111</title>
    <meta name="Page-View-Size" content="1280*720">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="EPGcss/common.css">

</head>
<body id ="body1" style="width:1280px; height:720px;">
  
<script type="text/javascript">
	var epgdomain="";
    var hdpath = "<%=hdpath%>";
	var hkhref = "";
	var providerid = "<%=providerid%>";
if (typeof(Authentication) == "object"){

    

            if("CTCSetConfig" in Authentication) {

                epgdomain = Authentication.CTCGetConfig("EPGDomain");

                

            } else {

                epgdomain = Authentication.CUGetConfig("EPGDomain");

            }
            

}

   

if(providerid == "hw") {

    var last = epgdomain.lastIndexOf("/"); 

    var host = epgdomain.substr( 0, last );

     hkhref = host+"/hk-detail_new.jsp";
}else if(providerid == "zx") {

   var last = hdpath.lastIndexOf("/"); 
 
    var host = hdpath.substr( 0, last );

    hkhref = host+"/hk-detail_new.jsp";

}
 window.location.href = hkhref;
</script>
 
</body>
</html>