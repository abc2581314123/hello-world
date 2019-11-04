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

    String backUrl = "";
    if(request.getParameter("backUrl")!=null){
        backUrl = request.getParameter("backUrl");
        session.setAttribute("backUrl",backUrl);
    }
    if ("".equals(backUrl) || backUrl == null) {
        backUrl = (String)session.getAttribute("backUrl");
    }

    backUrl = backUrl.replace("*","&");
    logger.info("科室选择页depart.jsp backUrl========"+backUrl);
    logger.info("科室选择页depart.jsp========"+"providerid:"+providerid+"iaspuserid:"+iaspuserid);
%>
<script type="text/javascript">
  var providerid = "<%=providerid%>";
  var iaspuserid = "<%=iaspuserid%>";
  //当前页面返回上级页面路径
  var backUrl = "<%=backUrl%>";


  //当前页面路径
  var backUrlEpg = location.href;
  backUrlEpg = backUrlEpg.replace(/&/g,"*");
</script>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>科室</title>
	<meta name="Page-View-Size" content="1280*720">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body style="width:1280px; height:720px; background: url('img/bg.jpg') no-repeat">
    
    <div id="index" data-area="index">
        <div class="move" style="position: absolute; left: 128px; top: 158px;">
            <div class="enterImg"><img src="./img/nei.jpg"></div>
        </div>
        <div class="move" style="position: absolute; left: 688px; top: 158px;">
            <div class="enterImg"><img src="./img/wai.jpg"></div>
        </div>
    </div>

    <script src="js/base/keyPress.js"></script>
    <script src="js/base/master.js"></script>
    <script src="js/base/bytueTools.js"></script>
    <script type="text/javascript" src="js/category_option.js"></script>
    <script src="js/depart.js"></script>
    <script src="js/base/newDirControl.js"></script>  
</body>
</html>