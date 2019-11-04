<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="org.json.*" %>
<%@ page language="java" import="javax.servlet.http.HttpSession" %>
<%@ page language="java" import="com.besto.util.CommonInterface" %>
<%@ page language="java" import="com.besto.util.SecurityTools" %>
<%@ page language="java" import="com.besto.util.ReadProperties" %>
<%@ page language="java" import="com.besto.util.TurnPage" %>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="org.apache.log4j.Logger" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="com.besto.util.Base64"%>
<%@ page language="java" import="com.besto.util.Decryptor"%>
<%@ page language="java" import="com.besto.util.Encryptor"%>
<%@ page language="java" import="com.besto.util.MD5"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.dom4j.Document"%>
<%@ page import="org.dom4j.Element"%>
<%@ page import="org.dom4j.DocumentHelper"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%
    Logger logger = Logger.getLogger(CommonInterface.class);

    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/epg/";
    String primaryid_get="besto1434696576400";//测试数据
    String category_id_get="1001001";//测试数据
    String backListUrl = ""; //返回地址
      if(request.getParameter("backListUrl")!=null){
        backListUrl = request.getParameter("backListUrl");  
    }
    String providerid="";//供应商类型
    String jumpflag = "";
    if(request.getParameter("jumpflag")!=null){
        jumpflag = request.getParameter("jumpflag");
    }
    if(request.getParameter("providerid")!=null){

        providerid = request.getParameter("providerid");

        logger.info("详情页request的providerid====================="+providerid);

    }

    if ("".equals(providerid) || providerid == null) {



        providerid = session.getAttribute("providerid").toString();

        logger.info("详情页session的providerid====================="+providerid);

    }
    logger.info("详情页的providerid====================="+providerid);

    if(request.getParameter("code")!=null){

        primaryid_get = request.getParameter("code");
    }


    if(request.getParameter("category_id")!=null){

        category_id_get = request.getParameter("category_id");
    }

    String sosoflag = "";//搜索标志位



    if (request.getParameter("sosoflag") != null) {



        sosoflag = request.getParameter("sosoflag");

    }



    session = request.getSession(); 

    String curfoucsid = "";

    String backUrl = "";

    if(!"one".equals(jumpflag)){

        //backUrl = TurnPage.getLast(session);

    }
    String backUrlEpg = "";
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
    try {

            filepath = this.getClass().getClassLoader().getResource("interface.properties").toURI().getPath();

        } catch (Exception e) { 

        e.printStackTrace();

    }
    SecurityTools st = new SecurityTools();
    String key = "besto";
    String isfourkpian = "";
    long time = System.currentTimeMillis();
    Properties properties = ReadProperties.readProperties(filepath);
    logger.info("db_zpage_one.jsp:获取配置文件路径");
    intpath = properties.get("requestinterface").toString();        
    finalpath = properties.get("tradeProgramDetails").toString();
    jqpath = properties.get("jqinterface").toString();
    //以下是本页信息接口开始
    logger.debug("本页信息接口开始");
    finalurl = finalpath + "?time=" + time + "&riddle=" + st.encrypt(key + time)+"&pvo.code="+primaryid_get+"&pvo.providerid="+providerid;
    logger.info("finalapath-------------"+finalurl);
    String finalres = "";
    try {
       finalres = CommonInterface.getInterface(finalurl);//调用共通接口方
    } catch (Exception e) {

        logger.error("db_zpage_one.jsp页面：异常返回信息=||"+e.getMessage()+"||");

        response.getWriter().write("<script>location.href='erro.jsp?providerid="+request.getParameter("providerid")+"';</script>");
    }
    HashMap<String,String> finala = new HashMap<String,String>();
    List<HashMap<String,String>> finallist = new ArrayList<HashMap<String,String>>();
    if(finalres !=null && !"".equals(finalres)&&!"null".equals(finalres)){
            try {

            JSONArray jsonArrayfinal = new JSONArray(finalres);

            for(int i = 0; i < jsonArrayfinal.length(); i++) {


                JSONObject jsonObject2final = jsonArrayfinal.getJSONObject(i);

                if (jsonObject2final.getString("name") != null && !"".equals(jsonObject2final.getString("name"))) {

                    finala.put("name", jsonObject2final.getString("name"));//节目名

                } else {

                    finala.put("name", "暂无节目名");

                }

                finala.put("category_id", jsonObject2final.getString("category_id"));//分类ID


                finala.put("primaryid", jsonObject2final.getString("primaryid"));//

                if (jsonObject2final.getString("fileurl") != null && (jsonObject2final.getString("fileurl").toString()).contains("http")) {

                    finala.put("fileurl", jsonObject2final.getString("fileurl"));//节目缩略图地址

                } else {

                    finala.put("fileurl", "");

                }

                finala.put("originalname", jsonObject2final.getString("originalname"));//原名


                finala.put("director", jsonObject2final.getString("director"));//导演


                finala.put("kpeople", jsonObject2final.getString("kpeople"));//主要任务


                finala.put("description", jsonObject2final.getString("description"));//节目描述


                finala.put("duration", jsonObject2final.getString("duration"));  //时长


                finala.put("releaseyear", jsonObject2final.getString("releaseyear"));//上映年份


                finala.put("orgairdate", jsonObject2final.getString("orgairdate"));  //首播时间


                finala.put("category_name", jsonObject2final.getString("category_name"));//分类名称


                finala.put("seriesflag", jsonObject2final.getString("seriesflag"));//剧集标识0单集1多集


                //session 中存入剧集标识

                session.setAttribute("tuisong_seriesflag", jsonObject2final.getString("seriesflag"));


                finala.put("volumncount", jsonObject2final.getString("volumncount"));//总集数


                finala.put("code", jsonObject2final.getString("code"));


                finala.put("originalcountry", jsonObject2final.getString("originalcountry"));

                if ("1".equals(finala.get("seriesflag"))) {

                    String namelist = jsonObject2final.getString("serieslist");//获取剧集JSON

                    JSONArray namejson = new JSONArray(namelist);

                    for (int s = 0; s < namejson.length(); s++) {

                        JSONObject jsonObject2 = namejson.getJSONObject(s);

                        HashMap<String, String> namemap = new HashMap<String, String>();

                        namemap.put("sequence", jsonObject2.getString("sequence"));

                        namemap.put("code", jsonObject2.getString("code"));

                        namemap.put("name", jsonObject2.getString("name"));

                        finallist.add(namemap);

                    }

                }
            }

        } catch (JSONException e) {

            logger.error("db_zpage_one.jsp页面：异常返回信息=||"+e.getMessage()+"||");
            finala.put("name","暂无节目名");
            //e.printStackTrace();
            response.getWriter().write("<script>location.href='erro.jsp?providerid="+request.getParameter("providerid")+"';</script>");
        }

    }else{

        finala.put("name","暂无节目");

    }

    logger.info("本页信息接口结束"+finala.get("code"));

     if(request.getParameter("category_id") == null){
        category_id_get=finala.get("category_id");
    }

     logger.info("db_zpage_one_hd.jsp----------category_id_get"+category_id_get);

    //以下是推荐位置视频信息

    logger.info("推荐位置接口开始"+primaryid_get+"参数"+category_id_get);

    url = intpath + "?time=" + time + "&riddle=" + st.encrypt(key + time)+"&vo.code="+primaryid_get+"&vo.category_id="+category_id_get+"&vo.providerid="+providerid+"&resolution="+resolution+"&vo.temp_field1=8";

    logger.info("url:"+url); 


    String res = CommonInterface.getInterface(url);//调用共通接口方法

    logger.info("db_zpage_one.jsp:解析接口返回JSON数据"+res);


    JSONObject resJson = null;

    List<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();

    if(res!=null&&!"null".equals(res)){



        try {



            JSONArray jsonArray = new JSONArray(res);



            for(int i = 0; i < jsonArray.length(); i++){



                JSONObject jsonObject2 = jsonArray.getJSONObject(i);



                HashMap<String,String> a = new HashMap<String,String>();

                if(jsonObject2.getString("name") != null && !"".equals(jsonObject2.getString("name").toString())){

                    a.put("name",jsonObject2.getString("name"));

                }else{

                    a.put("name","暂无节目名");

                }

                a.put("picture_id",jsonObject2.getString("picture_id"));



                a.put("primaryid",jsonObject2.getString("primaryid"));



                a.put("fileurl",jsonObject2.getString("fileurl"));



                a.put("code",jsonObject2.getString("code"));


                
                list.add(a);            
                codeList+=jsonObject2.getString("code")+"@@";
            }
        logger.debug("推荐位置接口解析结束");

        } catch (JSONException e) {

            logger.error("db_zpage_one.jsp页面：异常返回信息=||"+e.getMessage()+"||");
        }

    }
    String volumncount="0";
    //读取session参数     

    String userip = "";

    String usermac = "";

    String useradsl = "";

    String iaspuserid = "";

    String jqresFirstFlag = "0";

    if (session.getAttribute("iaspmac") != null) {

        usermac = session.getAttribute("iaspmac").toString();

    }

    if (session.getAttribute("iaspuserid") != null) {

        iaspuserid = session.getAttribute("iaspuserid").toString();

    }

    if (session.getAttribute("iaspadsl") != null) {

        useradsl = session.getAttribute("iaspadsl").toString();

    }

    if (session.getAttribute("iaspip") != null) {

        userip = session.getAttribute("iaspip").toString();

    }

    if("".equals(usermac) && request.getParameter("iaspmac") != null){

        usermac = request.getParameter("iaspmac");//MAC信息

        session.setAttribute("iaspmac",usermac);

    }

    if("".equals(iaspuserid) && request.getParameter("iaspuserid") != null){

        iaspuserid = request.getParameter("iaspuserid");

        session.setAttribute("iaspuserid",iaspuserid);

    }

    if("".equals(useradsl) && request.getParameter("iaspadsl") != null){

        useradsl = request.getParameter("iaspadsl");

        session.setAttribute("iaspadsl",useradsl);

    }

    if("".equals(userip) && request.getParameter("iaspip") != null){

        userip = request.getParameter("iaspip");

        session.setAttribute("iaspip",userip);

    }

    String riddle = st.encrypt(key + time);
    //暂用
    String returnurl_1 = basePath + "finalpage.jsp?iptvwarchloginsert_returnurl=";

%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>首页</title>
	<meta name="Page-View-Size" content="1280*720">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="EPGcss/common.css">
    <style type="text/css">
        img { display: inline-block; vertical-align: top; }
        * {
            color: #c2c2c0;
            margin: 0;
            padding: 0;
        }
        .pic {
            position: absolute;
            left: 70px;
            top: 110px;
        }
        .play {
            width: 150px;
            height: 60px;
            text-align: center;
            background: #229ccf;
            line-height: 60px;
            position: absolute;
            top: 510px;
            left: 440px;
        }
        .ser {
            position: absolute;
            left: 438px;
            top: 430px;
            overflow: hidden; 
            height: 50px;
            width: 550px;
        }
        .ser ul {
            position: absolute; width: 10000px;
        }
        .ser ul li {
            float: left;
             width: 50px;
             height: 50px;
             text-align: center;
             background: #229ccf;
             line-height: 50px;
             margin-right: 5px; 
        }
        .ser ul li.sel, .play.sel {
            background: #ffae00;
            color: #333
        }
    </style>
</head>
<body style="width:1280px; height:720px; background: url('img/body1.jpg') no-repeat">
    <!-- 电影海报 -->
    <div class="pic">
        <img src="<%=finala.get("fileurl")%>" width="320" height="460">
    </div>

    <!-- 电影名称 -->
    <div style="position: absolute; left: 440px; top: 110px; font-size: 30px;"><%=finala.get("name")%></div>
    
    <!-- 导演 -->
    <div style="position: absolute; left: 440px; font-size: 24px; top: 160px;">导演： <%=finala.get("director")%></div>

    <!-- 导演 -->
    <div style="position: absolute; left: 840px; font-size: 24px; top: 160px;">演员： <%=finala.get("kpeople")%></div>

    <!-- 简介 -->
    <div style="position: absolute; font-size: 22px; width: 750px; left: 445px; top: 235px; "><%=finala.get("description")%></div>


    <%
        if ("1".equals(finala.get("seriesflag"))){
    %>

    <div class="ser">
        <ul>
            <%
                for(int i = 0;i<finallist.size();i++){
                    Map m1 = (Map)finallist.get(i);
            %>
            <li data-code="<%=m1.get("code")%>" name="<%=AESUtil.encrypt(m1.get("name").toString())%>"><%=m1.get("sequence")%></li>
            <%}%>
        </ul>
    </div>

    <%
        }
    %>

    <%
        if("1".equals(finala.get("seriesflag")) && finallist.size() > 10) {
    %>
    <div class="leftArrow" style="position: absolute; left: 1000px; top: 443px;"><img src="img/leftA.png"></div>
    <%
        }
    %>


    <div class="play">播放</div>
    <script type="text/javascript">
        var seriesflag = <%=finala.get("seriesflag")%>;
        
    </script>
    <script src="EPGjs/keyPress_list.js"></script>
    <script src="EPGjs/master.js"></script>
    <script src="EPGjs/det.js"></script>
    <script src="EPGjs/common.js"></script>
    <script type="text/javascript">
        var backListUrl = "<%=backListUrl%>";
        var category_id_get='<%=category_id_get%>';
         var name1 = '<%=finala.get("name").toString()%>';
         var providerid =  '<%=providerid%>';

      Authentication.CTCSetConfig("name1",name1);

        function play(code) {
            // 为多集单集区分  ，单集传入""
            if ("" == code){
                code = "<%=finala.get("code")%>";
            }
            if('<%=providerid%>'=='zx') {
                //中兴点击播放时就加入历史记录
                // setHistory();
              zxPlay(code);
            }
            else {
                var backUrlEpg = location.href;
                backUrlEpg = backUrlEpg.replace(/&/g,"*");
        
                    var url = "http://202.97.183.28:9090/templets/epg/hwplay_profession.jsp?code="+code+"&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=<%=isfourkpian%>&videotype=<%=providerid%>&hwType=1&isFree=0&backurl="+backUrlEpg;
                    
                window.location.href=url;
            }
        }

        function zxPlay(code){
            var backUrlEpg = location.href;
            backUrlEpg = backUrlEpg.replace(/&/g,"*");
            
                var url = "http://202.97.183.28:9090/templets/epg/hwplay_profession.jsp?code="+code+"&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=<%=isfourkpian%>&videotype=<%=providerid%>&backurl="+backUrlEpg;
                           Authentication.CTCSetConfig("playUrl",url);
                        window.location.href=url;
            }
    
        //获得地址参数
        function fnGetUrlPara(name) {
            var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"))
            if (result == null || result.length < 1) {
                return ""
            }
            return result[1]
        }

        function keyBack(){
             if(providerid=="zx"){
            
            window.location.href = Authentication.CTCGetConfig("playUrl_zx");
        }else if(providerid=="hw"){
            window.location.href = Authentication.CTCGetConfig("playUrl_hw");
        }
        }
    </script>
</body>
</html>