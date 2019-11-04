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
    String professionMessage1 = "";



    professionMessage1 = professionMessage+"time="+time+"&riddle="+riddle+"&userid="+iaspuserid;
    String professionResult = "";
    professionResult = CommonInterface.getInterface(professionMessage1);//µ÷ÓÃ¹²Í¨½Ó¿Ú·½fa

    if(professionResult == null){
      logger.info("该用户不是行业EPG用户============professionResult："+professionResult);

      return;
    }
    JSONObject resJson = null;
    resJson = new JSONObject(professionResult);
    String data = resJson.getString("data"); 
    JSONObject resJson1 = null;
    resJson1 = new JSONObject(data);


     String epgUrl = resJson1.getString("epgUrl");

     logger.info("profession_transfer.jsp epgUrl=============="+epgUrl);
     logger.info("profession_transfer.jsp providerid "+providerid+" iaspuserid "+iaspuserid );

    // String profession_url = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp?iaspuserid="+iaspuserid+"&iaspmac="+iaspmac+"&providerid="+providerid+"&hdpath="+hdpath;

    String profession_url ="http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp?iaspuserid="+iaspuserid+"&iaspmac="+iaspmac+"&providerid="+providerid+"&hdpath="+hdpath;
      session.setAttribute("profession_url",profession_url);

    logger.info("profession_transfer.jsp "+session.getAttribute("profession_url"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>中转页</title>
    <meta name="Page-View-Size" content="1280*720">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body id ="body1" style="width:1280px; height:720px;">
    
<script type="text/javascript">

   //中转页跳转地址
   var epgUrl = "<%=epgUrl%>";
   //行业epg首页地址
   var profession_url ="<%=profession_url%>";


   //二院页面地址
   var second_college_url = "p001/main.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=<%=providerid%>";


   //作为原行业EPG返回二院首页用
   var professionTransferUrl = "../p001/main.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=<%=providerid%>&hdpath=<%=hdpath%>";

   //中转页初始化盒子二院首页路径
   if('CTCSetConfig' in Authentication) {
      Authentication.CTCSetConfig("second_college_url",null);  

      //缓存行业中转页
      Authentication.CTCSetConfig("professionTransfer",professionTransferUrl);          
   }else{
      Authentication.CUSetConfig("second_college_url",null);
       //缓存行业中转页
      Authentication.CUSetConfig("professionTransfer",professionTransferUrl);   
   }

   //初始化二院缓存
   sessionStorage.setItem("index", 0);
   sessionStorage.setItem("index1",0);
   sessionStorage.setItem("index2", 0);
   sessionStorage.setItem("index3",0);
   sessionStorage.setItem("item",0);

   //如果epgUrl包含二院页面跳转二院首页，否则全视为行业EPG首页
   if(epgUrl.indexOf("p001/main.jsp")>-1){
      window.location.href = second_college_url;
   }else{
      //原行业epg中转页
      window.location.href = profession_url;
   }

</script>
 
</body>
</html>