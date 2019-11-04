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

    //读取配置文件
    try {
        filePath = this.getClass().getClassLoader().getResource("interface.properties").toURI().getPath();     //获取接口配置文件路径
     }catch (Exception e) { 
        e.printStackTrace();
    }   
    Properties properties = ReadProperties.readProperties(filePath);

    String professionMessage  = properties.get("ProfessionMessage").toString();

    String zxpath="";//zx路径
    if(request.getParameter("zxpath")!=null){
        zxpath = request.getParameter("zxpath");
        session.setAttribute("zxpath", zxpath);
    }
    if(session.getAttribute("zxpath")!=null&&!"".equals(session.getAttribute("zxpath").toString())){
         zxpath =session.getAttribute("zxpath").toString();

       }

    String providerid="";//供应商类型
    if(request.getParameter("providerid")!=null){
        providerid = request.getParameter("providerid");
        session.setAttribute("providerid",providerid);
    }
    if ("".equals(providerid) || providerid == null) {
        providerid = (String)session.getAttribute("providerid");
    }
        String iaspuserid="";//供应商类型
        if(request.getParameter("iaspuserid")!=null){
            iaspuserid = request.getParameter("iaspuserid");
            session.setAttribute("iaspuserid",iaspuserid);
        }
        if ("".equals(iaspuserid) || iaspuserid == null) {
            iaspuserid = (String)session.getAttribute("iaspuserid");
        }
        String iaspadsl="";//宽带账号
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
        String iaspmac="";//宽带账号
        if(request.getParameter("iaspmac")!=null){
            iaspmac = request.getParameter("iaspmac");
            session.setAttribute("iaspmac",iaspmac);
        }
        if ("".equals(iaspmac) || iaspmac == null) {
            iaspmac = (String)session.getAttribute("iaspmac");
        }
    
        String boxCity="";// 区域ID
        if(request.getParameter("boxCity")!=null){
            boxCity = request.getParameter("boxCity");
            session.setAttribute("boxCity",boxCity);
        }
        if ("".equals(boxCity) || boxCity == null) {
            boxCity = (String)session.getAttribute("boxCity");
        }
        String stbId="";//机顶盒ID
        if(request.getParameter("stbId")!=null){
            stbId = request.getParameter("stbId");
            session.setAttribute("stbId",stbId);
        }
        if ("".equals(stbId) || stbId == null) {
            stbId = (String)session.getAttribute("stbId");
        }
        String hdpath="";//1号平台全路径
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
       professionResult = CommonInterface.getInterface(professionMessage1);//调用共通接口方fa
        JSONObject resJson = null;
    resJson = new JSONObject(professionResult);
    String data = resJson.getString("data"); 
    JSONObject resJson1 = null;
     resJson1 = new JSONObject(data);
    String privateImageUrl = resJson1.getString("privateImageUrl");
    String privatePageUrl = resJson1.getString("privatePageUrl");
    String privateLogoUrl = resJson1.getString("privateLogoUrl");
    String bootinfo = resJson1.getString("bootinfo");


%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>首页</title>
	<meta name="Page-View-Size" content="1280*720">
    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href="EPGcss/common.css">
    <script type="text/javascript">
        var iaspmac="<%=iaspmac%>";
        var stbId = "<%=stbId%>";
        var iaspip="<%=iaspip%>";
        var iaspuserid =" <%=iaspuserid%>";
    </script>
    <style type="text/css">
        img { display: inline-block; vertical-align: top; }
        * {
            color: #c2c2c0;
        }
        .block .title {
            font-size: 32px;
            margin-bottom: 30px;
        }
        .block .title.sel {
            color: #dfe200;
        }
        .title{
            text-align:center;
        }
        .move {
            overflow: hidden;
            position: absolute;
            top: 120px;
            left: 430px;
            width: 794px;
            height: 500px;
        }
        .move_main {
            width: 10000px;
            position: absolute;
        }
        .move .block {
            float: left;
            margin-left: 17px;
        }
        .adp {
            border: 2px solid transparent;
        }
        .adp.sel {
            border: 2px solid yellow;
        }
        .showLine {
            position: absolute;
            left: 1055px;
            top: 570px;
        }
        .showLine ul li {
            float: left;
            width: 50px;
            height: 5px;
            background: #fff;
            margin-left: 5px;
        }
        .searchBtn {
            background: url('img/search_c.png');
            position: absolute;
            top: 20px;
            left: 1130px;
        }
        .searchBtn.sel {
            background: url('img/search_s.png');
            position: absolute;
            top: 20px;
            left: 1130px;
        }

    </style>
</head>
<body style="width:1280px; height:720px; background: url('img/body.png') no-repeat">

    <div style="position: relative; margin:120px 0 0 60px">
        <!-- 看电视 -->
        <div class="tv block" style="display: inline-block;">
            <div class="title sel">看电视</div>
            <div class="adp" id="iframego" data-url="www.baidu.com" style="height: 270px; width: 360px;"><img src="img/seat.png" width="360" height="270"></div>
            <div class="adp" id = "iframego2"  data-url="" style="margin-top: 8px;"><img src="img/listChanel.png"></div>
        </div>
    </div>

        <!-- 搜索 -->
        <div id="searchBtn" class="searchBtn" data-url="/templets/epg/Profession/sosohd.jsp?providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>" style="width: 110px; height: 50px;"></div>

        <!-- 左侧联通logo -->
        <div style="position: absolute; top: 38px; left: 50px;"><img src="img/logo_gd.png"></div>

        <!-- 右侧IPTV logo -->
        <div style="position: absolute; top: 20px; left: 980px;"><img src="img/logo_lt.png"></div>

        <div style="position: absolute; top: -3px; width: 100%; text-align: center;">
            <img src="" id ="smallImg" width="300" height="90">
        </div>

         <div style="position: absolute; top: 600px; width: 1200px; height:30px; text-align: center;">
              <marquee behavior="scroll" id="scroll" direction="left" loop="-1" scrollamount="4">1111111111111111111</marquee> 
        </div>

    <div class="move">
            <div class="move_main" id = "move_main1">
                <div class="block" id= "div1">
                    <div class="title" >如家信息</div>
                    <div class="adp" data-url = ""><img id= "img1" src="" width="240" height="360"></div>
                </div>


        
            </div>
        </div>

        <div class="showLine">
            <ul>
            </ul>
        </div>
                        <div style="width:200px;height:30px;left:1000px;top:30px;position: absolute;" >
        <font  id="channel_num"  color=green size=20></font>
        </div>
    <script type="text/javascript">;
    //视频窗口
    setTimeout(function(){
    document.getElementById("iframego").innerHTML = '<iframe src="http://202.97.183.28:9090/templets/epg/vedio_gardenChannel.jsp" frameborder="no" border="0" marginwidth="0" marginheight="0" width="360" height="270" id="iframego1">';
},150);

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
     hwhref = host+"/ChanDirectAction_pro.jsp?chanNum=8&backUrl="+location.href;
     hkhref = host+"/hk-detail_new.jsp";
}else if(providerid == "zx") {

   var last = hdpath.lastIndexOf("/"); 
 
    var host = hdpath.substr( 0, last );
    channelhref = host+"/channel-hd_pro.jsp";
    hwhref = host+"/channel_detail_pro.jsp?mixno=8&backUrl="+location.href; 
    hkhref = host+"/hk-detail_new.jsp";

}
    document.getElementById("iframego").dataset['url']  = hwhref;
    document.getElementById("iframego2").dataset['url']  = channelhref;

    </script>
    <script type="text/javascript">

 document.getElementById("img1").src = "<%=privateImageUrl%>"; 
 document.getElementById("div1").dataset['url'] = "<%=privatePageUrl%>";
 document.getElementById("smallImg").src = "<%=privateLogoUrl%>";
 document.getElementById("scroll").innerHTML = "<%=bootinfo%>";

    </script>
    <script type="text/javascript">
   var privateImageUrl = "<%=privateImageUrl%>";
   var privatePageUrl = "<%=privatePageUrl%>";

    </script>
	<script src="EPGjs/keyPress.js"></script>
	<script src="EPGjs/master.js"></script>
	<script src="EPGjs/index.js"></script>
	<script src="EPGjs/common.js"></script>
    <script src="http://218.24.37.2:81/templets/epg/js/data/ad/iptv_hysy.js" charset="GB2312"></script>
    <script>


        //判断行业EPG右移情况
        if(privateImageUrl=="none"||privatePageUrl=="none"){
        document.getElementById("div1").style.display ="none";
          document.getElementById("showLine").style.display ="none";
}

    </script>
    <script type="text/javascript">
           var tempstr ='&providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>';       
    var bigStr = "";
   function getGGData(iptv_jpad) {

    var platesgd = iptv_jpad.position;

    var adversgd = platesgd[0].plate;

    var adressgd = adversgd[0].advertising;
    var bcd = adressgd.length;

   for(var a = 0;a<bcd;a++){
       var adstrgd = adressgd[a].adstrategy;

        if (typeof(adstrgd[0]) == "undefined"|| null ==adstrgd[0])
        {

            continue;
        }

       var adregd = adstrgd[0].adresource;
       var pic = adregd[0].imgurl;
       var title = adregd[0].title;
       var dataurl =adregd[0].actionUrl+tempstr+"&hdpath=<%=hdpath%>";
       var actionType = adregd[0].actiontype;
       var dataclassic = adregd[0].title;
       var code = adregd[0].guid;
       var categoryid =adregd[0].categoryid;
      if(dataurl.indexOf("hkList.jsp")>0){
      	dataurl += "?1=1"+tempstr+"&hdpath=<%=hdpath%>";
      }
       if(actionType=="2"){
         dataurl = "/templets/epg/db_zpage_one_hd.jsp?providerid="+providerid+"&code="+code+"&category_id="+categoryid+tempstr;
       }

          bigStr = '<div class="block" id= "div'+(a+2)+'"><div class="title" >'+dataclassic+'</div><div class="adp" data-url = '+dataurl+'><img id= "img'+(a+2)+'" src="'+pic+'" width="240" height="360"></div></div>';



        document.getElementById("move_main1").innerHTML+=bigStr;
        adpMoveParas = [];
        for(var i = 0, len = adp.length; i < len; i++) {
            adpMoveParas.push({
                'up': i==1 ? 0: 101,
                'right': i==len-1? -1 : (i==0)?2:i + 1,
                'down': i==0 ? 1: -1,
                'left': i==0 ? -1 : i - 1
            })
        }
        area[100].paras = adpMoveParas;

    }

    var showLineLis = Math.ceil((adp.length - 2) / 3);
    var showLineUl =  document.getElementsByClassName('showLine')[0].getElementsByTagName('ul')[0];
    showLineUl.innerHTML = ''
    console.log(adp.length)
    for(var i = 0; i < showLineLis; i++){
        showLineUl.innerHTML += '<li></li>'
    }
    var onLiWidth = showLineUl.getElementsByTagName('li')[0].offsetWidth + 5;
    var allWidth = onLiWidth * showLineLis
    document.getElementsByClassName('showLine')[0].style.width = allWidth + 'px';
    document.getElementsByClassName('showLine')[0].style.left = (1210 - allWidth*1) + 'px';
}

getGGData(addatas);
  

    </script>
</body>
</html>