<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="javax.servlet.http.HttpSession" %>
<%@ page language="java" import="com.besto.util.CommonInterface" %>
<%@ page language="java" import="com.besto.util.SecurityTools" %>
<%@ page language="java" import="com.besto.util.ReadProperties" %>
<%@ page language="java" import="com.besto.util.EscapeUnescape" %>
<%@ page language="java" import="com.besto.util.TurnPage" %>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="org.apache.log4j.Logger" %>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="com.besto.util.Base64"%>
<%@ page language="java" import="com.besto.util.Decryptor"%>
<%@ page language="java" import="com.besto.util.Encryptor"%>
<%@ page language="java" import="com.besto.util.MD5"%>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
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
    String providerid1="";
    String providerid="";//供应商类型
    if(request.getParameter("providerid")!=null){
        providerid = request.getParameter("providerid");
        session.setAttribute("providerid",providerid);
    }
    if ("".equals(providerid) || providerid == null) {
        providerid = (String)session.getAttribute("providerid");
    }
    if("hw".equals(providerid)){
    providerid1 = "CNTV_hw";
  }else if("zx".equals(providerid)){
    providerid1 = "CNTV_zx";
}


        String iaspuserid="";//用户帐号
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


        String category_id_get="1001001";//测试数据

        if(request.getParameter("category_id")!=null){



            category_id_get = request.getParameter("category_id");

        }

        String goid = "";
            if(request.getParameter("goid")!=null){



            goid = request.getParameter("goid");

        }

        String filepath = ""; // 文件路径



        String intpath = ""; // 读取配置文件中的接口地址



        String url = ""; // 连接配置文件中的接口地址+参数



        String finalurl = "";//当前页面视频信息



        String jqpath = "";//配置文件中鉴权接口地址



        String jqurl ="";//鉴权请求接口参数



        String bytecode="";



        String finalpath="";//本页视频信息



        String resolution="D1";


        String codeList="";//猜你喜欢code集合


        SecurityTools st = new SecurityTools();



        String key = "besto";





        String isfourkpian = "";




        long time = System.currentTimeMillis();

        String riddle = st.encrypt(key + time);

        intpath = properties.get("requestinterface").toString();



        finalpath = properties.get("tradeSortList").toString();


        String tradeProgramListPath = properties.get("tradeProgramList").toString();

        jqpath = properties.get("jqinterface").toString();


        //以下是本页信息接口开始



        logger.debug("本页信息接口开始");


        finalurl = finalpath + "?time=" + time + "&riddle=" + st.encrypt(key + time)+"&cvo.parentid="+category_id_get+"&cvo.pageid=1&cvo.pagecount=50";

        logger.info("finalapath"+finalurl);

        String finalres = "";
        try {

            finalres = CommonInterface.getInterface(finalurl);//调用共通接口方

        } catch (Exception e) {

            logger.error("list.jsp页面：异常返回信息=||"+e.getMessage()+"||");

            response.getWriter().write("<script>location.href='erro.jsp?providerid="+request.getParameter("providerid")+"';</script>");
        }




        List<HashMap<String,String>> finallist = new ArrayList<HashMap<String,String>>();

        if(finalres !=null && !"".equals(finalres)&&!"null".equals(finalres)) {

            try {

                JSONObject  jsonOject = new JSONObject(finalres);

                JSONArray jsonArrayfinal = jsonOject.getJSONArray("list");

                for (int i = 0; i < jsonArrayfinal.length(); i++) {


                    HashMap<String,String> finala = new HashMap<String,String>();

                    JSONObject jsonObject2final = jsonArrayfinal.getJSONObject(i);


                    if (jsonObject2final.getString("name") != null && !"".equals(jsonObject2final.getString("name"))) {

                        finala.put("name", jsonObject2final.getString("name"));//节目名

                    } else {

                        finala.put("name", "暂无节目名");

                    }

                    finala.put("parentid", jsonObject2final.getString("parentid"));//分类ID


                    finala.put("primaryid", jsonObject2final.getString("primaryid"));//

                    if (jsonObject2final.getString("fileurl") != null && (jsonObject2final.getString("fileurl").toString()).contains("http")) {

                        finala.put("fileurl", jsonObject2final.getString("fileurl"));//节目缩略图地址

                    } else {

                        finala.put("fileurl", "");

                    }

                    finallist.add(finala);

                }

            } catch (Exception e) {
                e.printStackTrace();
            }
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
        var category_id_get = <%=category_id_get%>;
        var totalPage;
         var goid = "<%=goid%>";
         var backListUrl = location.href;
         var currentPage = sessionStorage.getItem("gopage") || 1;
         var count = 0;
         var totalPage = 0;
         backListUrl = backListUrl.replace(/&/g,"*");

        // console.log(<%=finallist.size()%>);

         if(sessionStorage.getItem("goid")) {
             if(sessionStorage.getItem("gopage") > 0) {
                setTimeout(function(){
                    changeProgramForPagination(sessionStorage.getItem("goid") ,sessionStorage.getItem("gopage"))
                }, 300)
                
                } else {
                      changeProgram(goid);   
                }
            
            }else{
                console.log(22)
                if(sessionStorage.getItem("gopage") > 0) {
                setTimeout(function(){
                    changeProgramForPagination(<%=finallist.get(0).get("primaryid")%> ,sessionStorage.getItem("gopage"))
                }, 300)
                
                } else {
                      changeProgram('<%=finallist.get(0).get("primaryid")%>'); 
                }
            
                            }

        function changeProgram(primaryid){
            var XMLHttpRequestObject = false;
            if (window.XMLHttpRequest) {

                XMLHttpRequestObject = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
            }
            var path;

            path = "http://202.97.183.28:9090/cms/trade_programList.do?pvo.category_id="+primaryid+"&pvo.pageid=1&pvo.pagecount=10&pvo.providerid=<%=providerid1%>&time=<%=time%>&riddle=<%=riddle%>";
            // console.log(path);
       
            XMLHttpRequestObject.open("GET", path,true);
            XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
            XMLHttpRequestObject.onreadystatechange = function() {
                if(XMLHttpRequestObject.readyState==4&&XMLHttpRequestObject.status==200){
                    // console.log(XMLHttpRequestObject.status);

                    var dataValue1 = XMLHttpRequestObject.responseText;
                    var dataObj = "";
                    if(dataValue1 != null && dataValue1 != "") {
                        if(dataValue1!="null"){
                            dataObj = JSON.parse(dataValue1);

                            var objList = dataObj.list;
                            count = dataObj.count;
                            totalPage = Math.ceil(count / 10);
                            var divStr = "";


                            for(var p in objList){//遍历json数组时，这么写p为索引，0,1

                                <%--divStr += "<div class='block'> <div class='adp' data-url='/templets/epg/Profession/det.jsp?category_id="+primaryid+"&providerid=<%=providerid%>&code="+objList[p].code+"&pageid=1&backListUrl="+backListUrl+"' ><img src='"+objList[p].fileurl+"' width='150' height='212'></div></div>";--%>
                                divStr += "<div class='block'> <div class='adp' data-currentpage='1' data-categoryid='"+primaryid+"' data-index='"+p+"' data-url='/templets/epg/Profession/det.jsp?category_id="+primaryid+"&providerid=<%=providerid%>&code="+objList[p].code+"&pageid=1&backListUrl="+backListUrl+"' ><img src='"+objList[p].fileurl+"' width='150' height='212'></div></div>";


                            }
                            document.getElementById("div1").innerHTML=divStr;
                            adpM()
                            // if(sessionStorage.getItem("gonum")) {
                            //     area[101].currentIndex = sessionStorage.getItem("gonum")    }
                            // if(sessionStorage.getItem("goid")) {
                            //     for(var j = 0;j < area[100].ele.length; j++) {
                            //         if(area[100].ele[j].dataset['id'] == sessionStorage.getItem("goid")) {
                            //             area[100].currentIndex = j
                            //         }
                            //     }
                            // }
                            fnSetCurrent();
                            //添加样式
                            fnAddEleClass(current.ele,current.area.selStyle);
                            setTimeout("adpLength()",500);
                            area[101].paras = adpMoveParas
                            sessionStorage.setItem("gopage", 1);
                            currentPage = 1;
                            sessionStorage.setItem("goid", primaryid);
                            sessionStorage.setItem("gonum", 0);
                        }
                    }
                }

            }
            XMLHttpRequestObject.send(null);
        }

        //获得地址参数
        function fnGetUrlPara(name) {
            var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"))
            if (result == null || result.length < 1) {
                return ""
            }
            return result[1]
        }
        function changeProgramForPagination(primaryid,currentPage){
            var XMLHttpRequestObject = false;
            if (window.XMLHttpRequest) {

                XMLHttpRequestObject = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
            }
            var path;

            path = "http://202.97.183.28:9090/cms/trade_programList.do?pvo.category_id="+primaryid+"&pvo.pageid="+currentPage+"&pvo.pagecount=10&pvo.providerid=<%=providerid1%>&time=<%=time%>&riddle=<%=riddle%>";
            // console.log(path);
            XMLHttpRequestObject.open("GET", path,true);
            XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
            XMLHttpRequestObject.onreadystatechange = function() {
                if(XMLHttpRequestObject.readyState==4&&XMLHttpRequestObject.status==200){
                    // console.log(XMLHttpRequestObject.status);

                    var dataValue1 = XMLHttpRequestObject.responseText;
                    var dataObj = "";
                    if(dataValue1 != null && dataValue1 != "") {
                        if(dataValue1!="null"){
                            dataObj = JSON.parse(dataValue1);

                            var objList = dataObj.list;

                            var divStr = "";


                            for(var p in objList){//遍历json数组时，这么写p为索引，0,1

                                <%--divStr += "<div class='block'> <div class='adp' data-url='/templets/epg/Profession/det.jsp?category_id="+primaryid+"&providerid=<%=providerid%>&code="+objList[p].code+"&pageid=1&backListUrl="+backListUrl+"' ><img src='"+objList[p].fileurl+"' width='150' height='212'></div></div>";--%>
                                divStr += "<div class='block'> <div class='adp' data-currentpage='"+currentPage+"' data-categoryid='"+primaryid+"' data-index='"+p+"' data-url='/templets/epg/Profession/det.jsp?category_id="+primaryid+"&providerid=<%=providerid%>&code="+objList[p].code+"&pageid=1&backListUrl="+backListUrl+"' ><img src='"+objList[p].fileurl+"' width='150' height='212'></div></div>";


                            }
                            document.getElementById("div1").innerHTML=divStr;
                            adpM()
                            if(sessionStorage.getItem("gonum")) {
                                area[101].currentIndex = sessionStorage.getItem("gonum")    }
                            if(sessionStorage.getItem("goid")) {
                                for(var j = 0;j < area[100].ele.length; j++) {
                                    if(area[100].ele[j].dataset['id'] == sessionStorage.getItem("goid")) {
                                        area[100].currentIndex = j
                                        fnAddEleClass(area[100].ele[area[100].currentIndex],'sel2');
                                    }
                                }
                            }
                            fnSetCurrent();
                            //添加样式
                            fnAddEleClass(current.ele,current.area.selStyle);
                            setTimeout("adpLength()",500);
                            area[101].paras = adpMoveParas
                        }
                    }
                }

            }
            XMLHttpRequestObject.send(null);
        }

function adpLength(){
 document.getElementsByClassName('move_main')[0].style.width = adp.length * (adp[1].offsetWidth + 16) / 2 + 'px';
}        
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
        .move {
            overflow: hidden;
            position: absolute;
            top: 180px;
            left: 380px;
            width: 870px;
            height: 500px;
        }
        .move_main {
            
            position: absolute;
        }
        .move .block {
            float: left;
            margin-left: 16px;
            margin-bottom: 10px;
        }
        .adp {
            border: 4px solid transparent;
        }
        .adp.sel, .tv.sel {
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
        .nav {
            position: absolute;
            top: 120px;
            left: 60px;
            font-size: 26px;
            width: 1183px;
            overflow: hidden;
            height: 44px;
        }
        .nav ul {
            width: 10000px;
            position: absolute;
            left: 0
        }
        .nav ul li {
            float: left;
            margin: 0 25px;
            font-size: 30px;
            padding: 5px;
            border: 2px solid transparent;
        }
        .nav ul li.sel {
            color: #ffae00;
            border: 2px solid #ffae00;
        }
         .nav ul li.sel2 {
            color: #ffae00;
        }
        .search.sel {
            color: #ffae00;
        }
    </style>
</head>
<body style="width:1280px; height:720px; background: url('img/body.jpg') no-repeat">
    <div id="searchDiv" class="search" style="position: absolute; top: 70px; left: 1190px;">搜索</div>
    <div style="position: relative; margin:180px 0 0 60px">

        <!-- 看电视 -->
        <div class="block" style="display: inline-block;">
            <div class="tv" id ="bigdiv"><img id ="bigimg" src="img/seat.png" width="309" height="445"></div>
        </div>

    </div>

    <div class="nav">
        <ul id="u1">
            <%
                for(int i = 0;i<finallist.size();i++){
                    Map m1 = (Map)finallist.get(i);
            %>
            <li data-id='<%=m1.get("primaryid")%>'> <%=m1.get("name")%></li>
            <%
                }
            %>
        </ul>
    </div>

    <div class="move">
            <div id="div1" class="move_main">
            </div>
        </div>


	<script src="EPGjs/keyPress_list.js"></script>
	<script src="EPGjs/master.js"></script>
	<script src="EPGjs/list.js?v=2"></script>
	<script src="EPGjs/common.js"></script>
<script src="http://218.24.37.2:81/templets/epg/js/data/ad/iptv_hyrmys.js" charset="GB2312"></script>
	<script type="text/javascript">
    var providerid = "<%=providerid%>";
            var tempstr ='&providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&backurlnosession='+location.href;       
             //视频窗跳转
     var epgdomain;
     var providerid = "<%=providerid%>";
     var hwhref = "";
     var hdpath = "<%=hdpath%>";
     var channelhref = "";
     var hkhref = "";


    

   function keyBack(){
    
window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp?iaspuserid=<%=iaspuserid%>&providerid=zx&hdpath="+location.href;

   }


   function getGGData(iptv_jpad) {

    

    var platesgd = iptv_jpad.position;

    var adversgd = platesgd[0].plate;

   var adressgd = adversgd[0].advertising;
   var bcd = adressgd.length;




   for(var i = 0;i<1;i++){


   var adstrgd = adressgd[i].adstrategy;


    if (typeof(adstrgd[0]) == "undefined"|| null ==adstrgd[0])
    {

        continue;
    }
   var adregd = adstrgd[0].adresource;
   var pic = adregd[0].imgurl;
   var title = adregd[0].title;
   var dataurl =adregd[0].actionUrl;
    var actionType = adregd[0].actiontype;
   var dataclassic = adregd[0].description;
   var code = adregd[0].guid;
   var categoryid =adregd[0].categoryid;
   if(actionType=="2"){
     dataurl = "/templets/epg/db_zpage_one_hd.jsp?providerid="+providerid+"&code="+code+"&category_id="+categoryid+tempstr;
   }
    
   
}

document.getElementById("bigdiv").dataset['url'] = dataurl;
document.getElementById("bigimg").src = pic;
document.getElementById("searchDiv").dataset['url'] = "/templets/epg/Profession/sosohd.jsp?categoryId="+category_id_get+"&providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>&backListUrl="+backListUrl+"";
}
getGGData(addatas);
	</script>
</body>
</html>