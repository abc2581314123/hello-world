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
    String key = "besto";
    String riddle = st.encrypt(key + time);

    String providerid="";
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


    String categoryid = "";
    if(request.getParameter("categoryid")!=null){
        categoryid = request.getParameter("categoryid");
        session.setAttribute("categoryid",categoryid);
    }
    if ("".equals(categoryid)) {
        categoryid = (String)session.getAttribute("categoryid");
    }
    

    String backUrlEpg = "";
    if(request.getParameter("backUrlEpg")!=null){
        backUrlEpg = request.getParameter("backUrlEpg");
        session.setAttribute("backUrlEpg",backUrlEpg);
    }
    if ("".equals(backUrlEpg)) {
        backUrlEpg = (String)session.getAttribute("backUrlEpg");
    }




    logger.info("program_video.jsp========"+"providerid:"+providerid+"iaspuserid:"+iaspuserid+" categoryid:"+categoryid);


    Map<String,String> finala = new HashMap<String,String>();


    String filePath = this.getClass().getClassLoader().getResource("interface.properties").toURI().getPath();     //获取接口配置文件路径
    Properties properties = ReadProperties.readProperties(filePath);    
    String pageid = "1";//请求页数
    if (request.getParameter("pageid") != null) {
      pageid = request.getParameter("pageid");
    }
    //获取节目code
    String intpath = properties.get("hhbtypeinterface").toString();
    String url = intpath + "?vo.category_id=" + categoryid + "&time="+ time + "&riddle=" + riddle+ "&vo.pageid="+pageid+"&vo.pagecount=10&vo.providerid="+providerid;
    logger.info("科室详情页list.jsp 获取节目列表的路径======="+url);


    String res = CommonInterface.getInterface(url);//调用共通接口方法
    JSONObject  resJson =null;
    JSONArray jsonArrayCategory = null;
    double count =0;
    if(null == res){
        logger.info("获取节目列表信息失败======");
    }else{
        resJson = new JSONObject(res);
        String jsonlist ="";
        count = Integer.parseInt(resJson.getString("count"));
        if (resJson.has("list")) {
            jsonlist = resJson.getString("list");
            jsonArrayCategory = new JSONArray(jsonlist);
        }
        logger.info("list.jsp jsonArrayCategory////////////////////////////////////////////"+jsonArrayCategory);

        logger.info("list.jsp count////////////////////////////////////////////"+count);
       
        String code = jsonArrayCategory.getJSONObject(0).getString("code");
        logger.info("获取列表第一条数据的code========"+code);


        String  finalpath = properties.get("finalinterface").toString();

        finalpath = finalpath + "?time=" + time + "&riddle=" + st.encrypt(key + time)+"&vo.code="+code+"&vo.providerid="+providerid;

        logger.info("list.jsp 获取节目详情页信息的路径======="+finalpath);
        
        String finalres = "";
       
            
            finalres = CommonInterface.getInterface(finalpath);//调用共通接口方

            logger.info("list.jsp 获取节目详情页数据源======="+finalres);
        
            JSONArray jsonArrayCategory1 = null;  
          
            jsonArrayCategory1 = new JSONArray(finalres);

            finala.put("code",jsonArrayCategory1.getJSONObject(0).getString("code"));
            finala.put("name",jsonArrayCategory1.getJSONObject(0).getString("name"));

            logger.info("=================code "+jsonArrayCategory1.getJSONObject(0).getString("code")+" name "+jsonArrayCategory1.getJSONObject(0).getString("name"));

    }

    //科室标识0内科1外科
    String index = "";
    if(request.getParameter("index")!=null){
        index = request.getParameter("index");
        session.setAttribute("index",index);
    }
    if ("".equals(index)) {
        index = (String)session.getAttribute("index");
    }


    backUrlEpg = backUrlEpg.replace("*","&");
    logger.info("科室页面返回路径 backUrlEpg============="+backUrlEpg);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>科系</title>
	<meta name="Page-View-Size" content="1280*720">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/list.css">
<script type="text/javascript">



  var categoryid = "<%=categoryid%>";
  var providerid = "<%=providerid%>";
  var iaspuserid = "<%=iaspuserid%>";
  //当前页面返回上级页面路径
  var backUrlEpg = "<%=backUrlEpg%>";



  //播放页返回当前页面路径
  var backUrl = location.href;
  backUrl = backUrl.replace(/&/g,"*");

  var pageid = "<%=pageid%>";
  var count="<%=count%>";
  var pageCount = Math.ceil("<%=count/10%>");
  var index = "<%=index%>";

  //下一页
  function nextpage(){

    
    sessionStorage.setItem("item",0);
    document.getElementById("item0").focus();
    if(pageid == pageCount){
      return
    }
    ++pageid;  
    window.location.href ="list.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&pageid="+pageid+"&backUrlEpg="+backUrlEpg;
  }

  //上一页
  function prePage(){
    sessionStorage.setItem("item",0);
    document.getElementById("item0").focus();
    if(pageid == 1){
      return
    }
    --pageid;  
    window.location.href ="list.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&pageid="+pageid+"&backUrlEpg="+backUrlEpg;
  }

  //播放
  function play(e) {

      console.log(e.getAttribute("item"));
      sessionStorage.setItem("item", e.getAttribute("item"));

      var url = '../hwplay.jsp?code=<%=finala.get("code")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=&videotype=<%=providerid%>&backurl='+backUrl;
      window.location.href=url;           
  }

  function init(){
  
      document.getElementById("item"+sessionStorage.getItem("item")).focus();
    
    
  }
</script>

</head>
<body style="width:1280px; height:720px; background: url('img/bg2.jpg') no-repeat" onload="init();">
      <div id= "title" class="title">外科系</div>  
      <div id="list">
          <!-- <a href="javascript:void(0)" onclick="play()">adsfasdfasdf</a> -->
          <ul>

          <%
            if(null !=jsonArrayCategory&&jsonArrayCategory.length()>0){

            %>

              <%
              for(int i =0;i<jsonArrayCategory.length();i++){
                JSONObject jsobjContent = jsonArrayCategory.getJSONObject(i);
                String name = jsobjContent.getString("name").toString();
                String fileurl = jsobjContent.getString("fileurl").toString();
                if (fileurl == null || "null".equals(fileurl)) {
                  fileurl = "../img/1.png";
                }
                String primaryid = jsobjContent.getString("primaryid").toString();
                String code = jsobjContent.getString("code").toString();
                %>

                <li><a id = "item<%=i%>" item ="<%=i%>" href="javascript:void(0)" onclick="play(this)"><img src="<%=fileurl%>" width="180" height="220"></a><p><%=name%></p></li>
                <%
              }%>        

            <%
          }else{
          %>
              <li><a href="#"><img src="./img/tv.jpg" width="180" height="220"></a><p>精神病科</p></li>
              <li><a href="#"><img src="./img/tv.jpg" width="180" height="220"></a><p>精神病科</p></li>
              <li><a href="#"><img src="./img/tv.jpg" width="180" height="220"></a><p>精神病科</p></li>
              <li><a href="#"><img src="./img/tv.jpg" width="180" height="220"></a><p>精神病科</p></li>
              <li><a href="#"><img src="./img/tv.jpg" width="180" height="220"></a><p>精神病科</p></li>
              <li><a href="#"><img src="./img/tv.jpg" width="180" height="220"></a><p>精神病科</p></li>
              <li><a href="#"><img src="./img/tv.jpg" width="180" height="220"></a><p>精神病科</p></li>

            <%
          }
            %>
              
          </ul>
      </div>

      <!-- 上下页 -->
      <a href="javascript:prePage()" style="position: absolute; top: 35px; left: 1050px;"><img src="./img/upPage.png"></a>
      <a href="javascript:nextpage()" style="position: absolute; top: 35px; left: 1100px;"><img src="./img/downPage.png"></a>

      <!-- 页数 -->
      <div id = "page" style="position: absolute; left: 1140px; top: 40px; height: 30px; line-height: 30px; background: #e1e1e1; padding: 2px 15px; font-size: 22px; border-radius: 16px; -webkit-border-radius: 16px; color: #666;">1/3</div>
      <script type="text/javascript">
          document.getElementById("page").innerHTML = "<%=pageid%>/"+pageCount;
          document.getElementById("title").innerHTML=(index=="0"?"内科系":"外科系");
      </script>
      <script src="js/list.js"></script>
 
</body>
</html>