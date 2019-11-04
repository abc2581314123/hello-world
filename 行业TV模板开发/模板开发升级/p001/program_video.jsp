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

    //获取节目code
    String intpath = properties.get("hhbtypeinterface").toString();
    String url = intpath + "?vo.category_id=" + categoryid + "&time="+ time + "&riddle=" + riddle+ "&vo.pageid=1&vo.pagecount=10&vo.providerid="+providerid;
    logger.info("program_video.jsp 获取节目列表的路径======="+url);


    String res = CommonInterface.getInterface(url);//调用共通接口方法

    if(null == res){
        logger.info("获取节目列表信息失败，节目不存在======");
    }else{
        JSONObject  resJson = new JSONObject(res);
        String jsonlist ="";
        JSONArray jsonArrayCategory = null;
        if (resJson.has("list")) {
            jsonlist = resJson.getString("list");
            jsonArrayCategory = new JSONArray(jsonlist);
        }
        logger.info("program_video.jsp jsonlist////////////////////////////////////////////"+jsonlist);
        
        String code = jsonArrayCategory.getJSONObject(0).getString("code");
        logger.info("获取列表第一条数据的code========"+code);

        //调用详情页列表接口获取节目播放需要的参数

        String  finalpath = properties.get("finalinterface").toString();

        finalpath = finalpath + "?time=" + time + "&riddle=" + st.encrypt(key + time)+"&vo.code="+code+"&vo.providerid="+providerid;

        logger.info("program_video.jsp 获取节目详情页信息的路径======="+finalpath);
        
        String finalres = "";
       
            
            finalres = CommonInterface.getInterface(finalpath);//调用共通接口方

            logger.info("program_video.jsp 获取节目详情页数据源======="+finalres);
        
            JSONArray jsonArrayCategory1 = null;  
          
            jsonArrayCategory1 = new JSONArray(finalres);

            finala.put("code",jsonArrayCategory1.getJSONObject(0).getString("code"));
            finala.put("name",jsonArrayCategory1.getJSONObject(0).getString("name"));

            logger.info("=================code "+jsonArrayCategory1.getJSONObject(0).getString("code")+" name "+jsonArrayCategory1.getJSONObject(0).getString("name"));
            
       
    }

    logger.info("导航列表页返回路径  backUrlEpg============="+backUrlEpg);
%>

<script type="text/javascript">
  
    //直接播放
    play();
    function play() {         
        var backUrlEpg = "<%=backUrlEpg%>";
        backUrlEpg = backUrlEpg.replace(/&/g,"*");
        var url = '../hwplay.jsp?code=<%=finala.get("code")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=&videotype=<%=providerid%>&backurl='+backUrlEpg;
        window.location.href=url;           
    }

</script>

</html>