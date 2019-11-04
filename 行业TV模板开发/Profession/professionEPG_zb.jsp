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
        JSONObject resJson = null;
    resJson = new JSONObject(professionResult);
    String data = resJson.getString("data"); 
    JSONObject resJson1 = null;
     resJson1 = new JSONObject(data);
    String privateImageUrl = resJson1.getString("privateImageUrl");
    String privatePageUrl = resJson1.getString("privatePageUrl");
    String privateLogoUrl = resJson1.getString("privateLogoUrl");
    String boottype = resJson1.getString("boottype");
    String bootdetail = resJson1.getString("bootdetail");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ê×Ò³</title>
    <meta name="Page-View-Size" content="1280*720">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="EPGcss/common.css">

</head>
<body id ="body1" style="width:1280px; height:720px;">
    <img id= "img1" src="">
<script type="text/javascript">
    Authentication.CTCSetConfig("ProfessionFlag","true1111");
    var ProfessionURL = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=<%=providerid%>&hdpath=<%=hdpath%>";
Authentication.CTCSetConfig("ProfessionURL",ProfessionURL);    
var boottype = "<%=boottype%>";
var bootdetail = "<%=bootdetail%>";
if(boottype=="1"){
    //视频窗跳转
     var epgdomain;
     var providerid = "<%=providerid%>";
     var hwhref = "";
     var hdpath = "<%=hdpath%>";
     var channelhref = "";
     var hkhref = "";
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
     channelhref = host+"/zb-channellist_pro.jsp";
     hwhref = host+"/ChanDirectAction_pro_new.jsp?chanNum=8&backUrl="+location.href;
     hkhref = host+"/hk-detail_new.jsp";
}else if(providerid == "zx") {

   var last = hdpath.lastIndexOf("/"); 
 
    var host = hdpath.substr( 0, last );
    channelhref = host+"/channel-hd_pro.jsp";
    hwhref = host+"/channel_detail_pro_new.jsp?mixno=8&backUrl="+location.href; 
    hkhref = host+"/hk-detail_new.jsp";

}
window.location.href = hwhref;
}

</script>
 
</body>
</html>