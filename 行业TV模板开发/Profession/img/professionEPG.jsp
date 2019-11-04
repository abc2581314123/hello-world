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


    
    String filePath = "";

    //读取配置文件
    try {
        filePath = this.getClass().getClassLoader().getResource("interface.properties").toURI().getPath();     //获取接口配置文件路径
     }catch (Exception e) { 
        e.printStackTrace();
    }   
    Properties properties = ReadProperties.readProperties(filePath);
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
        .title{
            text-align:center;
        }
        .move {
            overflow: hidden;
            position: absolute;
            top: 120px;
            left: 430px;
            width: 805px;
            height: 500px;
        }
        .move_main {
            width: 10000px;
            position: absolute;
        }
        .move .block {
            float: left;
            margin-left: 16px;
        }
        .adp {
            border: 4px solid transparent;
        }
        .adp.sel {
            border: 4px solid #fff;
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
    </style>
</head>
<body style="width:1280px; height:720px; background: url('img/body.jpg') no-repeat">
    <div style="position: relative; margin:120px 0 0 60px">
        <!-- 看电视 -->
        <div class="tv block" style="display: inline-block;">
            <div class="title">看电视</div>
            <div class="adp" id = "iframego" data-url="www.baidu.com"><img src="img/seat.png" width="360" height="270"></div>
            <div class="adp" id = "iframego2" data-url="www.baidu.com" style="margin-top: 8px;"><img src="img/listChanel.png"></div>
        </div>
    </div>

    <div class="move">
            <div class="move_main">
                <div class="block">
                    <div class="title" >如家信息</div>
                    <div class="adp" id= "div1" data-url = ""><img id= "img1" src="img/seat.png" width="240" height="360"></div>
                </div>
                <div class="block">
                    <div class="title">电视回看</div>
                    <%--<div class="adp" data-url="http://202.97.183.28:9090/templets/epg/Profession/det.jsp?category_id=1001007001&providerid=zx&code=21100056002100011550818277474001&pageid=1&tempFlag=1&lntvlspid=hhb_hqhy&number=00058"><img src="img/seat.png" width="240" height="360"></div>--%>
                    <div class="adp" data-url="/templets/epg/Profession/det.jsp?category_id=1031001&code=21100071009900011558423883038002&pageid=1&providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>"><img src="img/seat.png" width="240" height="360"></div>
                </div>
                <div class="block">
                    <div class="title">热门影视</div>
                    <div class="adp" data-url="/templets/epg/Profession/list.jsp?category_id=1001007&providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>"><img src="img/seat.png" width="240" height="360"></div>
                </div>
                <div class="block">
                    <div class="title">辽视</div>
                    <div class="adp" data-url="/templets/epg/Profession/list.jsp?categoryId=1031&providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>"><img src="img/seat.png" width="240" height="360"></div>
                </div>
            
            
            
            </div>
        </div>

        <div class="showLine">
            <ul>
            </ul>
        </div>
    <script type="text/javascript">;
    //视频窗口
    document.getElementById("iframego").innerHTML = '<iframe src="http://202.97.183.28:9090/templets/epg/vedio_gardenChannel.jsp" width="360" height="270" id="iframego1">';
     //视频窗跳转
     var epgdomain;
     var providerid = "<%=providerid%>";
     var hwhref = "";
     var hdpath = "<%=hdpath%>";
     var channelhref = "";
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
     channelhref = host+"/zb-channellist.jsp";
     hwhref = host+"/ChanDirectAction.jsp?chanNum=1";
}else if(providerid == "zx") {

   var last = hdpath.lastIndexOf("/"); 
 
    var host = hdpath.substr( 0, last );
    channelhref = host+"/channel-hd_new.jsp";
    hwhref = host+"/channel_detail.jsp?mixno=1"; 

}
    document.getElementById("iframego").dataset['url']  = hwhref;
     document.getElementById("iframego2").dataset['url']  = channelhref;
    </script>


    <script type="text/javascript">
var datajson= '{"data": {"yxjssj": "2021-08-05","dqcl": "1","epgUrl":"http://192.168.6.27/lntv/hanting.jsp","privateLogoUrl":"http://192.168.6.27/lntv/hanting.jpg","privateImageUrl": "http://192.168.6.27/lntv/hanting.jpg","privatePageUrl": "http://192.168.6.27/lntv/hanting.jsp","privateVoddetailImageUrl": "http://192.168.6.27/lntv/hanting.jpg","privateVoddetailGageUrl": "http://192.168.6.27/lntv/hanting.jsp","groupId": "000001,000001,000001"}}';
var data = JSON.parse(datajson);
 var data1 = data['data']['privateVoddetailImageUrl'];
  var data2 = data['data']['privateVoddetailGageUrl'];
 document.getElementById("img1").src = "img/seat.png"; 
 document.getElementById("div1").dataset['url'] = "http://www.baidu.com";

    </script>
	<script src="EPGjs/keyPress.js"></script>
	<script src="EPGjs/master.js"></script>
	<script src="EPGjs/index.js"></script>
	<script src="EPGjs/common.js"></script>
</body>
</html>