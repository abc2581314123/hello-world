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

    logger.info("second_college_main.jsp========"+"providerid:"+providerid+"iaspuserid:"+iaspuserid);



    //原行业EPG跳转路径
    String profession_url = "";
    if(session.getAttribute("profession_url")!=null){
       profession_url = session.getAttribute("profession_url").toString();
    }
    
    logger.info("原行业EPG跳转路径=============="+profession_url);

%>
<script type="text/javascript">
  
    var iaspuserid = "<%=iaspuserid%>";
    var providerid = "<%=providerid%>";
    var profession_url = "<%=profession_url%>";


    //缓存行业EPG

    var backUrlEpg = location.href;

   if('CTCSetConfig' in Authentication) {
      Authentication.CTCSetConfig("ProfessionFlag","second_college_main");            
   }else{
      Authentication.CUSetConfig("ProfessionFlag","second_college_main");
   }

    backUrlEpg = backUrlEpg.replace(/&/g,"*");
</script>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>首页</title>
	<meta name="Page-View-Size" content="1280*720">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body style="width:1280px; height:720px; background: url('img/bg.jpg') no-repeat">
    
    <div id="index" data-area="index">
        <div class="move" style="position: absolute; left: 128px; top: 158px;">
            <div class="enterImg"><img src="./img/hos.jpg"></div>
        </div>
        <div class="move" style="position: absolute; left: 688px; top: 158px;">
            <div class="enterImg"><img src="./img/tv.jpg"></div>
        </div>
    </div>

    <script src="js/base/keyPress.js"></script>
    <script src="js/base/master.js"></script>
    <script src="js/base/bytueTools.js"></script>
    <script src="js/index.js?ver=1"></script>
    <script src="js/base/newDirControl.js"></script>  
</body>
</html>