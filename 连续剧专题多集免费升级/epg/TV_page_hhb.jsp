<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.json.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.besto.util.CommonInterfaceBytuetech" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.besto.util.ReadProperties" %>
<%@ page import="com.besto.util.SecurityTools" %>
<%@ page language="java" import="com.besto.util.CommonInterface" %>
<%@ page language="java" import="org.apache.log4j.Logger" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String urlBack = request.getRequestURI();
String hdpath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getRequestURI();
Logger logger = Logger.getLogger(CommonInterface.class);
String listtype="poster";//common为文字列表  poster为海报列表
int tableSelIndex=0;
int currentMenuListEleIndex12=100;
if(request.getParameter("tableSelIndex")!=null)
{   
	tableSelIndex=Integer.parseInt(request.getParameter("tableSelIndex"));
}
int currentMenuListEleIndex=0;
if(request.getParameter("currentMenuListEleIndex")!=null)
{   
	currentMenuListEleIndex=Integer.parseInt(request.getParameter("currentMenuListEleIndex"));
	

}
if(request.getParameter("currentMenuListEleIndex12")!=null)
{   
	currentMenuListEleIndex12=Integer.parseInt(request.getParameter("currentMenuListEleIndex12"));
	
	
}
%>
<%
	//读取session参数     

	String userip = "";

	String usermac = "";

	String useradsl = "";

	String iaspuserid = "";
	String stbId = "";

	if (session.getAttribute("iaspmac") != null) {

		usermac = session.getAttribute("iaspmac").toString();

	}
	if (session.getAttribute("stbId") != null) {

		stbId = session.getAttribute("stbId").toString();

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


		if("".equals(stbId) && request.getParameter("stbId") != null){

		stbId = request.getParameter("stbId");//盒子信息

		session.setAttribute("stbId",stbId);

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
	
	
	String reloadflag = "0";
    if (request.getParameter("reloadflag") != null) {
    	reloadflag = request.getParameter("reloadflag");
    }

    String isFirst="";
	if (request.getParameter("isFirst") != null) {
    	isFirst = request.getParameter("isFirst");
    }


	String filePath = "";

	String providerid = "";

	if(null !=request.getParameter("providerid")){
		providerid = request.getParameter("providerid");//服务商
	}

	logger.info("////////////////////////////////"+providerid);
  	//providerid="zx"
	//读取配置文件
	filePath = this.getClass().getClassLoader().getResource("interface.properties").toURI().getPath();     //获取接口配置文件路径
	Properties properties = ReadProperties.readProperties(filePath);	          
	//String cmspath = properties.get("cmspath").toString(); 
	//String cmspath = "http://10.10.19.14:9090/cms/";
	String cmspath = "http://218.24.37.2/cms/";
	CommonInterfaceBytuetech ci = new CommonInterfaceBytuetech();
	
/* 	JSONObject resJsoncategory1=ci.getCategoryList(cmspath, category_id_Parent, "1", 100);//获取第一级分类列表
	JSONArray jsonArrayCategory1 = resJsoncategory1.getJSONArray("list");//第一级分类数据 */
	
	String pageid = "1";//请求页数
	if (request.getParameter("pageid") != null) {
		pageid = request.getParameter("pageid");
	}



	String category_name_parent="";
	
	String category_name="";//左侧菜单名
	String category_id="1001003001";//左侧菜单id
	String parent_id = ""; //父分类id  1001007为环球影视
	int contenttype=0;//判断节目是否有下级节点   为1时有下级节点
 	if (request.getParameter("categoryid") != null) { // 获取参数节点
		category_id = request.getParameter("categoryid");
	} 
 	parent_id = category_id.substring(0,category_id.length() - 3);
// 	JSONObject resJsoncategory2=ci.getCategoryList(cmspath, parent_id, "1", 10);//获取第二级分类列表
                SecurityTools st = new SecurityTools();//加密工具
                String key = "besto";//加密KEY
                long time = System.currentTimeMillis();//时间戳
                String riddle = st.encrypt(key + time);
    String intpath = properties.get("vodtypebyidinterface").toString();
    // String intpath = cmspath+"categoryIptv_searchByParent.do";
	//左侧菜单接口链接
	String url1 = intpath + "?vo.parentid=" + parent_id + "&time="
	+ time + "&riddle=" + riddle+"&vo.pageid=1&vo.pagecount=100";

	String res = CommonInterface.getInterface(url1);//调用共通接口方法
	JSONObject resJson = null;
	resJson = new JSONObject(res);
	//左侧菜单json数组
	JSONArray jsonArrayCategory2 = new JSONArray();
	if (resJson.has("list")) {
		String jsonlist = resJson.getString("list");
		jsonArrayCategory2 = new JSONArray(jsonlist);
	}
	if (jsonArrayCategory2 != null) {
		if (request.getParameter("categoryid") == null) { // 获取参数节点
	//获取第一个菜单的名称和id
	category_id = jsonArrayCategory2.getJSONObject(0)
	.getString("primaryid").toString();
	category_name = jsonArrayCategory2.getJSONObject(0)
	.getString("name").toString();
		}
// 		category_name = jsonArrayCategory2.getJSONObject(0)
// 		.getString("name").toString();
		for (int i = 0; i < jsonArrayCategory2.length(); i++) {
	if (StringUtils
	.equals(category_id, jsonArrayCategory2
			.getJSONObject(i).getString("primaryid")
			.toString())) {
		category_name = jsonArrayCategory2.getJSONObject(i)
		.getString("name").toString();
		break;
	}
		}
	}

		String intpath2 = properties.get("tvhhbtypeinterface").toString();
		String url2 = intpath2 + "?vo.category_id=" + category_id + "&time="
		+ time + "&riddle=" + riddle+ "&vo.pageid=" + pageid+"&vo.pagecount=10&vo.providerid="+providerid;
		//url2="http://10.10.19.14/cms/programIptvPro_searchByCategory.do?time=1418439444437&riddle=00eae19783805eb7312b5fe2b989390a&vo.category_id=1001001013&vo.providerid=zx&vo.pageid=1&vo.pagecount=10&resolution=D1";
		String res2 = CommonInterface.getInterface(url2);//调用共通接口方法

		logger.info("TV_page_hhb.jsp hhbtypeinterface "+res2);
		JSONObject	resJson2 = new JSONObject(res2);
 		//String jsonlist = resJson2.getString("count");
 		//logger.info("jsonlist////////////////////////////////////////////"+jsonlist);
 		//如果jsonlist为空 表示节目有下级节点
			if (resJson2 == null || "null".equals(resJson2) || "0".equals(resJson2)) {
				contenttype = 1;
			}
 		
 		//当contenttype==1  直接取节目信息
	if (contenttype == 1) {
		intpath = properties.get("vodprograminterface").toString();
		//url拼接方式 
		String url = intpath + "?vo.category_id=" + category_id + "&time="
		+ time + "&riddle=" + riddle + "&vo.pageid=" + pageid
		+ "&vo.pagecount=10&vo.providerid="+providerid;
		res2 = CommonInterface.getInterface(url);//调用共通接口方法
	}
 		
	resJson2 = new JSONObject(res2);
	JSONArray jsonArrayContent = new JSONArray();
	if (resJson.has("list")) {
		String jsonlist1 = resJson2.getString("list");
		//列表json
		jsonArrayContent = new JSONArray(jsonlist1);
	}
    
	
	
	

	int count = Integer.parseInt(resJson2.getString("count"));
	logger.info("=====================================================count"+count);
	int totolpagecontent = (int) Math
			.ceil(Double.parseDouble(resJson2.getString("count")) / 10);//分类共有页数,默认每页10条
	//获取翻页页码
	HashMap<String, Integer> pagemap = ci.getPreNextPage(pageid,
			totolpagecontent);
	//拼写统计系统参数
	String pageId = "";//
	pageId = request.getRequestURI();
	pageId = pageId.substring(pageId.lastIndexOf("/") + 1);

	String type = request.getParameter("type");
	
	//混排包蒙层，通过userid获取temptoken
	String authRse = "2";//默认通过
	String aaapath = properties.get("AAApath").toString();
	String temptokenurl = aaapath + "authenticationIptv_getTemptokenByUserid.do?userid="+iaspuserid+"&time="+time+"&riddle="+riddle;
	String aaares = CommonInterface.getInterface(temptokenurl);//调用共通接口方法
	
	JSONObject	aaaresJson = new JSONObject(aaares);
	String temptoken = aaaresJson.getString("temptoken");
	//设置时间start
	String beginTime=new String("2018-09-28"); //开始时间
	String endTime=new String("2018-10-09"); //结束时间
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); 
	Date bt=sdf.parse(beginTime); 
	Date et=sdf.parse(endTime); 
	Date dates = new Date();
	String currentTime=sdf.format(dates);//时间
	Date ct=sdf.parse(currentTime);//当前时间
	//设置时间end
	
	//混排包蒙层,鉴权操作 0 请登录1 请订购2 通过
	String authProRes = null;
	if (ct.after(bt)&&ct.before(et)){ //介于开始时间和结束时间之间可以判断是否显示蒙层
		if(temptoken!=null){
			String authurl = aaapath + "authenticationIptv_authorityProduct.do?temptoken="+temptoken+"&productid=240001831,240001884&time="+time+"&riddle="+riddle;
			authProRes = CommonInterface.getInterface(authurl);//调用共通接口方法
			if("1".equals(authProRes)){
				authRse = "1";
			}
		}
	}
	




	//未订购电影混排大包的用户弹出提示订购砸金蛋活动的窗口 By rendongdong 2018/12/25
	String authRse1 = "";

	//设置时间start
	String eggBeginTime=new String("2019-01-29"); //开始时间
	String eggEndTime=new String("2019-02-11"); //结束时间
	Date bt1=sdf.parse(eggBeginTime); 
	Date et1=sdf.parse(eggEndTime); 

	if (ct.after(bt1)&&ct.before(et1)){ //介于开始时间和结束时间之间可以判断是否显示蒙层
		if(temptoken!=null){
			String authurl1 = aaapath + "authenticationIptv_authorityProduct.do?temptoken="+temptoken+"&productid=240001831,240001884&time="+time+"&riddle="+riddle;
			authRse1 = CommonInterface.getInterface(authurl1);//调用共通接口方法
			logger.info("==========================================鉴权接口authurl1"+authurl1);
			logger.info("=====================================================authRse1"+authRse1);
			
			if("1".equals(authRse1)){
				authRse1 = "1";
			}
		}
	}


	logger.info("TV_page_hhb.jsp===============================category_id"+category_id);


	//backurlnosession add by rendd 20190815
	String backurlnosession = "";
	if(null!=request.getParameter("backurlnosession")){
		backurlnosession = request.getParameter("backurlnosession");
		session.setAttribute("tvbackurlnosession",backurlnosession);
	}

	if(backurlnosession==""&&null !=session.getAttribute("tvbackurlnosession")){
		backurlnosession = session.getAttribute("tvbackurlnosession").toString();
		session.setAttribute("tvbackurlnosession",null);
	}

	logger.info("tv_page_hhb.jsp backurlnosession"+backurlnosession);




	//查询混排专题列表
    String hpList =  properties.get("TVhpList").toString();
    //传参混排类型,普通专题0,电影混排1，专题类型电视剧混排2,综艺混排3
    //分类id 1034电视剧混排1035综艺混排
    String special_type = ("1034".equals(parent_id))?"specialType=2":"specialType=3";


	logger.info("列表接口路径==="+hpList+"&"+special_type);
    String hpListRes = CommonInterface.getInterface(hpList+"&"+special_type);
    JSONArray jsonArrayHpList = new JSONArray();
    jsonArrayHpList =  new JSONArray(hpListRes);
     String creatTime = "";

     logger.info("电视剧混排专题数据源======"+jsonArrayHpList);
    if(jsonArrayHpList !=null&&jsonArrayHpList.length()>0){
     creatTime = jsonArrayHpList.getJSONObject(0).getString("createtime").toString();
	}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>列表页</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="Page-View-Size" content="1280*720">
<link rel="stylesheet" href="education/css/list_hhb.css">
<style>
	.menu-list-content-selS { background: #2056ad; }

	/*2019.08.26专题修改*/
	.specialBox { position: absolute; border: 4px solid transparent; box-sizing: border-box;}
	.spFocus {border: 2px solid #9ceeff; padding: 2px; box-shadow: 0px 0px 10px #9ceeff;}
	.sp_1 { left: 256px; top: 113px; }
	.sp_2 { left: 576px; top: 113px; }
	.sp_3 { left: 898px; top: 113px; }

	.sp_4 { left: 256px; top: 368px; }
	.sp_5 { left: 448px; top: 368px; }
	.sp_6 { left: 640px; top: 368px; }
	.sp_7 { left: 830px; top: 368px; }
	.sp_8 { left: 1024px; top: 368px; }

	.sp_9 { left: 256px; top: 770px; }
	.sp_10 { left: 448px; top: 770px; }
	.sp_11 { left: 640px; top: 770px; }
	.sp_12 { left: 830px; top: 770px; }
	.sp_13 { left: 1024px; top: 770px; }

	.sp_14 { left: 256px; top: 1080px; }
	.sp_15 { left: 448px; top: 1080px; }
	.sp_16 { left: 640px; top: 1080px; }
	.sp_17 { left: 830px; top: 1080px; }
	.sp_18 { left: 1024px; top: 1080px; }

</style>
</head>
<body style="background:url(education/img/body.jpg) no-repeat; width:1280px; height:720px; background-color: #000; overflow: hidden;">
	<!-- 2019-04-12 专题栏目搜索 -->
	<div id="specSear" style=" position: absolute; left:1095px; top: 40px;"><img src="education/img/search_c.png"></div>

	<!-- 2018-09-25 加弹出层 -->
	<div id="popBook" style="position: absolute; left: 0; top: 0; display: none;z-index:9999"><img src="education/img/popBook.png"></div>

	<!-- 2019-01-26 加更换弹出层 -->
	<div id="eggBook" style="position: absolute; left: 240px; top: 179px; display: none;z-index:9999"><img src="education/img/pop4.png"></div>
	
	<div style="width:1280px; height:720px; overflow:hidden;"><!-- 页面容器开始 -->
		<input type="hidden" id="time" value="<%=time%>"/>
    	<input type="hidden" id="riddle" value="<%=st.encrypt(key + time)%>"/>
    	<input type="hidden" id="pid" value="1"/>
    	<input type="hidden" id="category_id" value="<%=category_id%>"/>
    	<input type="hidden" id="category_id_for_display" value="<%=category_id%>"/>
    	<input type="hidden" id="parent_id_for_display" value="<%=category_id%>"/>
		<div style="width:1581px;"><!-- 内容容器开始 ，菜单页撑开后的尺寸-->
			<div class="area area-menu" style="margin-left: 0;"><!-- 菜单容器开始 -->
			<div class="menu-arrow-up" id="mau">
				<img id="upimg"  src="education/img/arrow-up.png" alt="">
			</div>
			<div class="menu-arrow-down" id="mad">
				<img id="downimg" src="education/img/arrow-down.png" alt="">
			</div>
 				<div class="menu menu-list-container" style="display:none;">
					<ul class="menu-list menu-list-less dn">
						
					</ul>
				</div>
				<div class="menu menu-gap"></div>
				<div class="menu menu-list-container">
			
					<ul class="menu-list" style="margin-top: 72px; position: relative; z-index: 999;" id="searchID">
						
<!-- 						<li data-url="search.jsp" > -->
<!-- 							<img class="vatb" src="img/ico_search.png" width="32px" height="32px" alt="" style="vertical-align:text-bottom"> -->
<!-- 							<span>搜索</span> -->
<!-- 						</li> -->
                    
						<%
					
						for (int i = 0; i < jsonArrayCategory2.length(); i ++) { 
    						JSONObject jsobjCategory = jsonArrayCategory2.getJSONObject(i);
        					String name = jsobjCategory.getString("name").toString();
        					String primaryid = jsobjCategory.getString("primaryid").toString();
					     	if (name.length() > 5) {	
					     		name = name.toString().substring(0,4) + "...";
					     	}
     	
					     	if (parent_id.equals(primaryid)) {
								category_name_parent=name;
								parent_id=primaryid;
					     	}
						%>

						<%
                   		if(i==1){
                   		%>
                   			<li data-url="TV_page_hhb.jsp?parentid=1034&categoryid=1034002&providerid=<%=providerid%>" data-category_id="1034002" data-parent_id="1034">专题</li>
                   		<%
                   		}
                   		%>

                		<li data-url="TV_page_hhb.jsp?parentid=<%=parent_id %>&categoryid=<%=primaryid%>&providerid=<%=providerid%>" data-category_id="<%=primaryid%>" data-parent_id="<%=parent_id %>"><%=name%></li>                  			
                  
     				<% }%>
		

					</ul>
				</div>
			</div><!-- 菜单容器结束 -->
		
			<div class="area area-main"><!-- 列表容器开始 -->
				<div class="part-info"><!-- 头部信息容器开始 -->
					<div class="part-info-nav">
						<span id="cateNav"><%=category_name_parent %></span>&nbsp;<span id="countID"><%=count %></span>部&nbsp;&gt;<span class="fs18" id="programNav"><%=category_name %></span>
					</div>
					<div class="part-info-mind">
						<img class="vam" id="arrowUp" src="img/arrow-up.png" data-src="img/arrow-up-sel.png" alt="">
						<img class="vam" id="arrowDown" src="img/arrow-down.png" alt="" data-src="img/arrow-down-sel.png">
						<span class="fcfd0" id="currentPage"><%=pageid %></span>/<span id="pageNum"><%=totolpagecontent %></span>页
					</div>
				</div><!-- 头部信息容器结束 -->
				<!-- 通过category_id判断 列表显示的样式  下面为不显示海报的文字列表 -->
				<div id="listmenu">
				<%if(category_id.equals("1026003005")||category_id.equals("1026003006")||category_id.equals("1026003007")||category_id.equals("1026003008")||category_id.equals("1026003009")||(category_id.contains("1026004")&&!category_id.equals("1026004"))||(category_id.contains("1026006")&&!category_id.equals("1026006"))||(category_id.contains("1026007")&&!category_id.equals("1026007"))||(category_id.contains("1026008")&&!category_id.equals("1026008"))){
					listtype="common";
					%>
				<div class="part-list" id="menuList">
					<!-- <span style="display: inline-block; width: 150px; text-align: center; margin-bottom: 15px;"><img src="education/img/titleMoive.png"></span> -->
				<ul class="menu-list">
						
						<%for (int i = 0; i < 10; i ++) { 
					    	if (i < jsonArrayContent.length()) {
					    	    JSONObject jsobjContent = jsonArrayContent.getJSONObject(i);
						        String name = jsobjContent.getString("name").toString();
						        String fileurl = jsobjContent.getString("fileurl").toString();
						        String primaryid = jsobjContent.getString("primaryid").toString();
						        String code = jsobjContent.getString("code").toString();
     					%>
     					<li class="menu-ele" style="text-align: left; height: 55px; line-height:65px;padding-left:20px; " data-url="jq.jsp?code=<%=code %>&pageid=<%=pageid%>&providerid=<%=providerid%>"><%=name%>
     						
     					</li>
     				<% }}%>
					</ul>
					</div>
				<%}else{listtype="poster";%>
				<div class="part-list" id="programList"><!-- 列表展示容器开始 -->
						<div class="program-list"><!-- 列表容器开始 -->
						<% for (int i = 0; i < 10; i ++) { 
					    	if (i < jsonArrayContent.length()) {
					    	    JSONObject jsobjContent = jsonArrayContent.getJSONObject(i);
						        String name = jsobjContent.getString("name").toString();
						        String fileurl = jsobjContent.getString("fileurl").toString();
						        String primaryid = jsobjContent.getString("primaryid").toString();
								String lntvlspid = jsobjContent.getString("cpid").toString();
								String isFree= jsobjContent.getString("isFree").toString();
								if (fileurl == null || "null".equals(fileurl)) {
									fileurl = "img/1.png";
								}
// 						        String code = jsobjContent.getString("code").toString();
						        String seriesflag = "0";
						        String url = "";
						     	if (name.length() > 7) {
						     		name = name.substring(0,6) + "...";
						     	}
                                if (contenttype==0) { // 最终页
                                	String code=jsobjContent.getString("code").toString();
                                	 %>
             				          <div class="program" data-url="tv_zpage_one_hd.jsp?category_id=<%=category_id %>&code=<%=code %>&pageid=<%=pageid%>&providerid=<%=providerid%>&lntvlspid=<%=lntvlspid%>&stbId=<%=stbId%>">
                                    <%
                                } else { // 二级页面
            						 %>
            				     	  <div class="program" data-url="TV_page_hhb.jsp?aa=<%=contenttype%>&categoryid=<%=primaryid%>&providerid=<%=providerid%>" data-category_id="<%=primaryid %>" data-parent_id="<%=parent_id %>">
                                    <%}%>
							<img src="<%=fileurl%>" width="160px" height="240px" alt="">
							<div class="program-mind">
								<%=name%>
							</div>
							<% if("1".equals(isFree)) {%>
							<div class="charge">会员</div>
							<% }%>
							<div class="program-sel dn">
								<img src="<%=fileurl%>" width="176px" height="265px" alt="">
								<div class="program-sel-mind">
									<%=name%>
								</div>
							<% if("1".equals(isFree)) {%>
								<div class="charge-sel">会员</div>
							<% }%>
							</div>
						</div>
			     	<%} else {%>
			     <%} }%>
					</div><!-- 列表容器结束 -->
				</div><!-- 列表展示容器结束 -->
			</div><!-- 列表容器结束 -->
			<%}%>
		</div><!-- 内容容器结束 --></div> 
	</div><!-- 页面容器结束 -->
	<div class="menu-hint" style="display:none;"><!-- <容器开始 -->
<!-- 		<div class="arrow-left"></div> -->
	</div><!-- <容器结束 -->
	</div>



<!-- 2019.08.26专题修改 -->
	<div id="specialOver" style="display: none; position: absolute; top: 0; left: -10px">
		<div class="" id="" style="position: fixed; left: 210px; top: 40px; width: 300px;"><%=jsonArrayHpList.length()%>部 ><span class="fs18">专题</span></div>
							<div class="part-info-mind" style="position: fixed; left: 1097px; top: 10px; width: 300px;">
						<img class="vam" id="arrowUp" src="img/arrow-up.png" data-src="img/arrow-up-sel.png" alt="">
						<img class="vam" id="arrowDown" src="img/arrow-down.png" alt="" data-src="img/arrow-down-sel.png">
						<span class="fcfd0" id="currentPagezt">1</span>/<span id="pageNum">1</span>页
					</div>
					<%
					for (int i = 0; i < jsonArrayHpList.length(); i ++) { 
	                    String Pic =   jsonArrayHpList.getJSONObject(i).getString("poster1url").toString();
	                        String Pic1 =   jsonArrayHpList.getJSONObject(i).getString("poster2url").toString();
						String name =	jsonArrayHpList.getJSONObject(i).getString("name").toString();
	                    String number = jsonArrayHpList.getJSONObject(i).getString("number").toString();
				     	if (name.length() > 5) {	
				     		name = name.toString().substring(0,4) + "...";
				     	}
 	
 					%>
           <%if(i<3){%>
     		<%if("1".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
               
     	         <div data-url = "sp_1/TV_special1.jsp?number=<%=number%>&iaspuserid=<%=iaspuserid%>"
     	          class="specialBox sp_<%=i+1%>"><img src="<%=Pic%>" width="298px" height="196px"></div>
                   
     				<% }%>
            	<%if("2".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
     	         <div data-url = "sp_2/TV_special2.jsp?number=<%=number%>&iaspuserid=<%=iaspuserid%>" class="specialBox sp_<%=i+1%>"><img src="<%=Pic%>" width="298px" height="196px"></div>
                   
     				<% }%>
     				<% }%>
     				<%if(i>=3&&i<8){%>
     				     		<%if("1".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
               
     	         <div data-url = "sp_1/TV_special1.jsp?number=<%=number%>"
     	          class="specialBox sp_<%=i+1%>" data-scroll="down"><img src="<%=Pic1%>" width="168px" height="250px"></div>
                   
     				<% }%>
            	<%if("2".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
     	         <div data-url = "sp_2/TV_special2.jsp?number=<%=number%>" class="specialBox sp_<%=i+1%>" data-scroll="down"><img src="<%=Pic1%>" width="168px" height="250px"></div>
                   
     				<% }%>
     				<%}%>
     				<%if(i>=8&&i<13){%>
	     		<%if("1".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
               
     	         <div data-url = "sp_1/TV_special1.jsp?number=<%=number%>"
     	          class="specialBox sp_<%=i+1%>" data-scroll="up"><img src="<%=Pic1%>" width="168px" height="250px"></div>
                   
     				<% }%>
            	<%if("2".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
     	         <div data-url = "sp_2/TV_special2.jsp?number=<%=number%>" class="specialBox sp_<%=i+1%>" data-scroll="up"><img src="<%=Pic1%>" width="168px" height="250px"></div>
                   
     				<% }%>
     				<% }%>
     				<%if(i>=13&&i<18){%>
     		<%if("1".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
               
     	         <div data-url = "sp_1/TV_special1.jsp?number=<%=number%>"
     	          class="specialBox sp_<%=i+1%>"><img src="<%=Pic1%>" width="168px" height="250px"></div>
                   
     				<% }%>
           <%if("2".equals(jsonArrayHpList.getJSONObject(i).getString("templetFlag").toString())){%>
     	         <div data-url = "sp_2/TV_special2.jsp?number=<%=number%>" class="specialBox sp_<%=i+1%>"><img src="<%=Pic1%>" width="168px" height="250px"></div>
                   
     				<% }%>
     				<% }%>
     				
     				<% }%>
     		


	</div>




	<script type="text/javascript">
	//混排包蒙层判断
	var authRse = '<%=authRse%>';
	var isFirst = '<%=isFirst%>';
	var isPop = false;


	var isPop1 = false;
	if(authRse=="2"){
		isPop = false;
	}else{
		if(isFirst=="t"){
			isPop = true;
		}else{
			isPop = false;
		}
	}
	

	</script>
	<script src="education/js/extend.js"></script>
	<script src="education/js/common.js"></script>
	<script src="education/js/list_hhb_tv.js"></script>
	<script src="education/js/keyPresstv.js"></script>
	<script type="text/javascript">
    var currentMenuListEleIndex12 ='<%=currentMenuListEleIndex12%>';

	var timerMenu = null;
	var pathConstant="<%=cmspath%>";
	var pageid=<%=pageid%>;
	var listtype="<%=listtype%>";
	var providerid="<%=providerid%>";
	var backurl=location.href;
	var tableSelIndex=<%=tableSelIndex%>;//文字列表光标位置
	var currentMenuListEleIndex=<%=currentMenuListEleIndex%>;//左侧菜单光标位置

	setCookie("currentMenuListEleIndex12",currentMenuListEleIndex);

	var syListIndex=<%=currentMenuListEleIndex%>;//首页广告位的位置

	
	//新加的
	// if(currentMenuListEleIndex12!=100){

	// 	var currentMenuListEleIndex11 = menu.menus[1].selIndexInScreen;
	// 			var abc = getCookie("dblastleftindex");
		
			
	// 			var nowLi = document.getElementById('searchID').getElementsByTagName('li')[abc];
	// 			nowLi.style.background = '#2056ad';	
	// }else{
	// 		var currentMenuListEleIndex11 = menu.menus[1].selIndexInScreen;
				
	// 			setCookie("dblastleftindex","0");
	// 			var nowLi = document.getElementById('searchID').getElementsByTagName('li')[0];
	// 			nowLi.style.background = '#2056ad';	
	
	// }
	//海报下一页
	function OnKeyPgDn() {
		
		var category_id = document.getElementById("category_id_for_display").value;
		var parent_id = document.getElementById("parent_id_for_display").value;
		var countID = document.getElementById("countID").innerHTML;
		var pid = document.getElementById("pid").value;
		var pageid = 1;
		var totalPages = 1;
		
		if (countID != 0 && countID != "" && countID != null) {
			if (parseInt(countID) > 10) {
				totalPages = Math.ceil(parseInt(countID)/10);

				if (totalPages > 1) {
					if (parseInt(pid) < totalPages) {
						pageid = parseInt(pid) + 1;
					} else {
						pageid = totalPages;
					}
				}
			} 
		} 
		
		if (parseInt(pid) != totalPages) {
			
			clearTimeout(timerMenu);
			timerMenu=setTimeout(function(){
				clearTimeout(timerMenu);
				//check 为false左侧菜单刷新  为true重新构建页面   用来判断是否显示光标
				var check=true;
				reconstructionList(parent_id,category_id,timerMenu,pageid,check);
				fnAddCurrentStyle();
				return;
			},1000);
		} else {
			
			return false;
		}
	}
	//文字下一页
	function OnKeyPgDnCommon() {
		var category_id = document.getElementById("category_id_for_display").value;
		var parent_id = document.getElementById("parent_id_for_display").value;
		var countID = document.getElementById("countID").innerHTML;
		var pid = document.getElementById("pid").value;
		var pageid = 1;
		var totalPages = 1;
		
		if (countID != 0 && countID != "" && countID != null) {
			if (parseInt(countID) > 10) {
				totalPages = Math.ceil(parseInt(countID)/10);
				if (totalPages > 1) {
					if (parseInt(pid) < totalPages) {
						pageid = parseInt(pid) + 1;
					} else {
						pageid = totalPages;
					}
				}
			} 
		} 
		
		if (parseInt(pid) != totalPages) {
			clearTimeout(timerMenu);
			timerMenu=setTimeout(function(){
				clearTimeout(timerMenu);
				//check 为false左侧菜单刷新  为true重新构建页面   用来判断是否显示光标
				var check=true;
				reconstructionListCommon(parent_id,category_id,timerMenu,pageid,check);
				//fnAddCurrentStyle();
				return;
			},1000);
		} else {
			return false;
		}
	}
	//海报上一页
	function OnKeyPgUp() {
		var category_id = document.getElementById("category_id_for_display").value;
		var parent_id = document.getElementById("parent_id_for_display").value;
		var countID = document.getElementById("countID").innerHTML;
		var pid = document.getElementById("pid").value;
		var pageid = 1;
		
		if (countID != 0 && countID != "" && countID != null) {
			if (parseInt(pid) > 1) {
				pageid = parseInt(pid) - 1;
			}
		}
		
		if (parseInt(pid) != 1) {
			clearTimeout(timerMenu);
			timerMenu=setTimeout(function(){
				clearTimeout(timerMenu);
				//check 为false左侧菜单刷新  为true重新构建页面   用来判断是否显示光标
				var check=true;
				reconstructionList(parent_id,category_id,timerMenu,pageid,check);
				return;
			},1000);
		} else {
			return false;
		}
	}
	//文字上一页
	function OnKeyPgUpCommon() {
		var category_id = document.getElementById("category_id_for_display").value;
		var parent_id = document.getElementById("parent_id_for_display").value;
		var countID = document.getElementById("countID").innerHTML;
		var pid = document.getElementById("pid").value;
		var pageid = 1;
		
		if (countID != 0 && countID != "" && countID != null) {
			if (parseInt(pid) > 1) {
				pageid = parseInt(pid) - 1;
			}
		}
		
		if (parseInt(pid) != 1) {
			clearTimeout(timerMenu);
			timerMenu=setTimeout(function(){
				clearTimeout(timerMenu);
				//check 为false左侧菜单刷新  为true重新构建页面   用来判断是否显示光标
				var check=true;
				reconstructionListCommon(parent_id,category_id,timerMenu,pageid,check);
				return;
			},1000);
		} else {
			return false;
		}
	}
	function keyBack11(){

		//add by rendd 20190815
		var backurlnosession = "<%=backurlnosession%>";
		if(isPop1){
			isPop1 = false
			document.getElementById('eggBook').style.display = 'none'
		}else{

			//add by rendd 20190815
			//判断上级访问页面是否是广播推荐位过来的
			if(backurlnosession!=""){
			 	window.location.href = backurlnosession;
			 	return
			}

			 
			//隐藏砸金蛋活动提示窗
			setCookie("dblastrightindex","");
	        setCookie("dblastdownindex","");
			var epgdomain='';
			if ('CTCSetConfig' in Authentication) {
				epgdomain = Authentication.CTCGetConfig("EPGDomain");
			} else {
				epgdomain = Authentication.CUGetConfig("EPGDomain");
			}
			window.location.href = epgdomain;
			//top.location.href=EPGDomain;
		}	
		
	}

	function keyOk(){
		

		var currentMenuList=menu.menus[1].ele.getElementsByClassName('menu-list')[0];
		var currentMenuListEles=currentMenuList.getElementsByTagName('li');
	
		// var category_id = currentMenuListEles[getCookie("dblastleftindex")].dataset["category_id"];
		var category_id = currentMenuListEles[currentMenuListEleIndex].dataset["category_id"];
		//var category_id = "<%=category_id%>";

		var backurl1 = "TV_page_hhb.jsp?categoryid="+category_id+"&thisdz=1&providerid="+providerid;

		if(isSpecser){
			//setCookie("sosobackurl11",compile(location.href));
			setCookie("sosobackurl11",compile(backurl1));
			var parent_id = "<%=parent_id%>";
			if("1034"==parent_id){
				window.location.href = "http://218.24.37.2/templets/epg/sosohd_zt_serial.jsp?providerid="+providerid+"&category_id=<%=parent_id%>"+"&iaspuserid=<%=iaspuserid%>&sosobackurl="+compile(backurl1);

			}else{
				window.location.href = "http://218.24.37.2/templets/epg/sosohd_zt_variety.jsp?providerid="+providerid+"&iaspuserid=<%=iaspuserid%>"+"&category_id=<%=parent_id%>"+"&sosobackurl="+compile(backurl1);
			}
	
			return 
		}
		if(isSpecial){

			var backurl1 = location.href;
			/*var backurl1 = "../TV_page_hhb.jsp?categoryid="+category_id+"&thisdz=1&providerid="+providerid;*/
			setCookie("dblastrightindex",specialNum);
			setCookie("dblastleftindex",1);

			backurl1 = backurl1.replace(/&/g,"*");
         	url=specialBox[specialNum].dataset['url']+"&providerid="+providerid+"&backurl1="+backurl1+"&tableSelIndex="+tableSelIndex;
         	window.location.href = url;
         	return
		}
      
		if(listtype=="common")
			{
			url=table.eles[tableSelIndex].dataset['url'];
			url=url+"&categoryid="+category_id+"&tableSelIndex="+tableSelIndex;
			}
		else{
		//记住光标位置
		var dbonerightindex = program.current.colIndex;//列
		var dbonedownindex = program.current.listIndex*2+program.current.rowIndex;//行
	
		var menuindex=dbonedownindex*5+dbonerightindex;//下级菜单光标位置
		var url;
		if(menu.state==-1){
 			url=program.current.ele.dataset['url'];
		}else{
		//	url=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0].getElementsByTagName('li')[menu.menus[menu.state].selIndex].dataset['url'];
		}
		//if(location.href.indexOf("thisdz=1")>=0)
		//	{
			//向最终页存储位置
			setCookie("dblastrightindex",dbonerightindex);
			setCookie("dblastdownindex",dbonedownindex);
			var urls="TV_page_hhb.jsp?categoryid="+category_id+"&thisdz=1&providerid="+providerid;
			//var urls = document.getElementById("category_id").value;
			setCookie("dblisturl",compile(urls));//向最终页存储backurl
			setCookie("dbbackurl",compile(urls));
			setCookie("dblastleftindex",menu.menus[1].selIndex);

			setCookie("currentMenuListEleIndex12",currentMenuListEleIndex);


		//	}
		//else{
			//将最终页位置cookie清空
		//	var urls="dy_page_hhb.jsp?categoryid="+category_id+"&providerid="+providerid+"&currentMenuListEleIndex="+currentMenuListEleIndex+"&currentMenuListEleIndex1="+menu.menus[1].selIndexInScreen+"&pageid=1";
		//	setCookie("dblastrightindex","");
		//	setCookie("dblastdownindex","");
		//	setCookie("dblastleftindex","");//最终页上一级的左侧菜单
			//向下级页面存储位置
		//	setCookie("dbonerightindex",dbonerightindex);
		//	setCookie("dbonedownindex",currentMenuListEleIndex);
		//	setCookie("dbbackurl",compile(urls));//向下级页面存储backurl
		//	setCookie("dboneleftindex",menu.menus[1].selIndex);
		//}
		}
		if(url){
			//光标在左侧不跳转链接
			if(menu.state==-1){
		
			window.location=url+"&currentMenuListEleIndex="+currentMenuListEleIndex+"&currentMenuListEleIndex1="+menu.menus[1].selIndexInScreen;               
			}
		}
	}
	
	var XMLHttpRequestObject = false;
	if (window.XMLHttpRequest) {
		XMLHttpRequestObject = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
	}
	//向下移动左侧菜单
	function onKeyMenu(){
		 
 		 if (XMLHttpRequestObject) {
 			var time = document.getElementById("time").value;
 			var riddle = document.getElementById("riddle").value;
 			var list = menu.menus[menu.state].ele.getElementsByTagName('li');
			var parent_id = "";
			for (var i = 0 ; i < list.length ; i ++) {
				if (list[i].className == " menu-list-content-sel") {
					parent_id = list[i].dataset['parent_id'];
					parent_name = list[i].innerHTML;
					if (parent_id != "") {
						break;
					}
				}
			}

			
			// pathConstant = "http://202.97.183.28:9090/cms/";
			// var newurl=pathConstant+"categoryIptv_searchByParent.do?time=" + time +"&riddle=" + riddle + "&vo.parentid="+parent_id+"&vo.pageid=1&vo.pagecount=100&vo.providerid="+providerid;
			var newurl=pathConstant+"categoryIptv_searchByAnyId.do?time=" + time +"&riddle=" + riddle + "&vo.parentid="+parent_id+"&vo.pageid=1&vo.pagecount=100&vo.providerid="+providerid;
			 

 			XMLHttpRequestObject.open("GET", newurl);
 			
 			XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
 			XMLHttpRequestObject.onreadystatechange = function() {
 				if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
 					var dataValue = XMLHttpRequestObject.responseText;
 					var dataObj = "";
 					
 					if(dataValue != null && dataValue != "") {
 						dataObj = JSON.parse(dataValue);


					}else{
						dataValue=XMLHttpRequestObject.responseText;
						if(dataValue!=null&&dataValue!=""){
							dataObj = JSON.parse(dataValue);
						}
					}

					

 					var category_id = "";
 					var category_name = "";
 					var flag = true;
 					var count = 0;
 					if (dataObj != null && dataObj != '' && dataObj != 'null') {
 						
 						var html = '';
 						for (var i = 0 ; i < dataObj["list"].length ; i ++) {
 							        var dataPro= dataObj["list"][i];
 									category_id = dataPro["primaryid"];
 									category_name = dataPro["name"];
 									document.getElementById("category_id").value = category_id;
 									flag = false;
 									if (category_name.length > 4) {
 										category_name = category_name.substring(0,4) + "...";
 							     	}
 								

 								if(i==1){
 									html+=	'<li data-url="" data-category_id="1034002" data-parent_id="1034">专题</li>';
 								}
 								html += "<li data-url='TV_page_hhb.jsp?parentid=" + parent_id + "&categoryid=" + category_id + "&providerid=<%=providerid%>' data-parent_id='" + parent_id + "' data-category_id='" + category_id + "'>" +category_name+ "</li>";
 								
 								


 								count++;
 						}
 						setCookie("inHtml",html)
 						document.getElementById("searchID").innerHTML = "";
 						//拼接左侧菜单并覆盖到searchID下
 						document.getElementById("searchID").innerHTML = html;
				
 						//当前菜单
						var currentMenuList=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
						//当前菜单元素
						var currentMenuListEles=currentMenuList.getElementsByTagName('li');
						//当前选中元素索引
						var currentMenuListEleIndex=menu.menus[menu.state].selIndex;


						//添加新选中元素的选中效果
						fnAddEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');
						
						if (menu.menus[0].ele.getElementsByClassName("menu-list-content-sel").length > 0) {
							document.getElementById("cateNav").innerHTML = menu.menus[0].ele.getElementsByClassName("menu-list-content-sel")[0].innerHTML;
						} else {
							if (document.getElementsByClassName("menu-list-content-sel").length > 1) {
								document.getElementById("cateNav").innerHTML = document.getElementsByClassName("menu-list-content-sel")[1].innerHTML;
							}
						}
						
						if (menu.menus[1].ele.getElementsByClassName("menu-list-content-sel").length ==1) {
							document.getElementById("programNav").innerHTML = menu.menus[1].ele.getElementsByClassName("menu-list-content-sel")[0].innerHTML;
						}else if (document.getElementsByClassName("menu-list-content-sel").length == 1) {
 							document.getElementById("programNav").innerHTML = category_name;
 						} else {
 							document.getElementById("programNav").innerHTML = document.getElementsByClassName("menu-list-content-sel")[1].innerHTML;
 						}
						
 					}
 				}
 			};
 			XMLHttpRequestObject.send(null);
 		} 
 

	}
	//向上移动左侧菜单
	function onKeyMenuUp(){
		//pathConstant = "http://202.97.183.28:9090/cms/";
	  	
		if (XMLHttpRequestObject) {
			var list = menu.menus[menu.state].ele.getElementsByTagName('li');

			var parent_id = "";

			for (var i = 0 ; i < list.length ; i ++) {

				if(list[i].innerHTML =="专题"){
					
					parent_id ="<%=parent_id%>";
				}

				if (list[i].className == " menu-list-content-sel") {
					parent_id = list[i].dataset['parent_id'];
					parent_name = list[i].innerHTML;
					if (parent_id != "") {
						break;
					}
				}
			}

			
			var time = document.getElementById("time").value;
 			var riddle = document.getElementById("riddle").value;
 			// XMLHttpRequestObject.open("GET", pathConstant+"categoryIptv_searchByParent.do?time=" + time +"&riddle=" + riddle + "&vo.parentid="+parent_id+"&vo.pageid=1&vo.pagecount=100&vo.providerid"+providerid);

 			XMLHttpRequestObject.open("GET", pathConstant+"categoryIptv_searchByAnyId.do?time=" + time +"&riddle=" + riddle + "&vo.parentid="+parent_id+"&vo.pageid=1&vo.pagecount=100&vo.providerid="+providerid);
 			

 			XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
 			XMLHttpRequestObject.onreadystatechange = function() {
 				if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
 					var dataValue = XMLHttpRequestObject.responseText;
 					var dataObj = "";
 					
 					if(dataValue != null && dataValue != "") {
 						dataObj = JSON.parse(dataValue);
					}else{
						dataValue=XMLHttpRequestObject.responseText;
						if(dataValue!=null&&dataValue!=""){
							dataObj = JSON.parse(dataValue);
						}
					}
 					var category_id = "";
 					var category_name = "";
 					var flag = true;
 					var count = 0;
 					if (dataObj != null && dataObj != '' && dataObj != 'null') {
 						
 						var html = '';
 						for (var i = 0 ; i < dataObj["list"].length ; i ++) {
 							        var dataPro= dataObj["list"][i];
 									category_id = dataPro["primaryid"];
 									category_name = dataPro["name"];
 									document.getElementById("category_id").value = category_id;
 									flag = false;
 									if (category_name.length > 4) {
 										category_name = category_name.substring(0,4) + "...";
 							     	}
 								
 								if(i==1){
 									html+=	'<li data-url="" data-category_id="1034002" data-parent_id="1034">专题</li>';
 								}
 								html += "<li data-url='TV_page_hhb.jsp?parentid=" + parent_id + "&categoryid=" + category_id + "&providerid=<%=providerid%>' data-parent_id='" + parent_id + "' data-category_id='" + category_id + "'>" +category_name+ "</li>";
 								


 								count++;
 						}
 						document.getElementById("searchID").innerHTML = "";
 						//拼接左侧菜单并覆盖到searchID下
 						document.getElementById("searchID").innerHTML = html;
 						
 						//当前菜单
						var currentMenuList=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
						//当前菜单元素
						var currentMenuListEles=currentMenuList.getElementsByTagName('li');
						//当前选中元素索引
						var currentMenuListEleIndex=menu.menus[menu.state].selIndex;
						//添加新选中元素的选中效果
						fnAddEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');
						
						if (menu.menus[0].ele.getElementsByClassName("menu-list-content-sel").length > 0) {
							document.getElementById("cateNav").innerHTML = menu.menus[0].ele.getElementsByClassName("menu-list-content-sel")[0].innerHTML;
						}else {
							if (document.getElementsByClassName("menu-list-content-sel").length > 1) {
								document.getElementById("cateNav").innerHTML = document.getElementsByClassName("menu-list-content-sel")[1].innerHTML;
							}
						}
						
						if (menu.menus[1].ele.getElementsByClassName("menu-list-content-sel").length ==1) {
							document.getElementById("programNav").innerHTML = menu.menus[1].ele.getElementsByClassName("menu-list-content-sel")[0].innerHTML;
						}else if (document.getElementsByClassName("menu-list-content-sel").length == 1) {
 							document.getElementById("programNav").innerHTML = category_name;
 						} else {
 							document.getElementById("programNav").innerHTML = document.getElementsByClassName("menu-list-content-sel")[1].innerHTML;
 						}
						
 					}
 				}
 			};
 			XMLHttpRequestObject.send(null);
 		}
    
	}
	
	
	
	var pwd = "gdyzs";
	function compile(str) {
	  if(pwd == null || pwd.length <= 0) {
	    
	    return null;
	  }
	  var prand = ""; 
	  for(var i=0; i<pwd.length; i++) {
	    prand += pwd.charCodeAt(i).toString();
	  }
	  var sPos = Math.floor(prand.length / 5);
	  var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
	  var incr = Math.ceil(pwd.length / 2);
	  var modu = Math.pow(2, 31) - 1;
	  if(mult < 2) {
	    
	    return null;
	  }
	  var salt = Math.round(Math.random() * 1000000000) % 100000000;
	  prand += salt;
	  while(prand.length > 10) {
	    prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
	  }
	  prand = (mult * prand + incr) % modu;
	  var enc_chr = "";
	  var enc_str = "";
	  for(var i=0; i<str.length; i++) {
	    enc_chr = parseInt(str.charCodeAt(i) ^ Math.floor((prand / modu) * 255));
	    if(enc_chr < 16) {
	      enc_str += "0" + enc_chr.toString(16);
	    } else enc_str += enc_chr.toString(16);
	    prand = (mult * prand + incr) % modu;
	  }
	  salt = salt.toString(16);
	  while(salt.length < 8)salt = "0" + salt;
	  enc_str += salt;
	  return enc_str;
	}

		function uncompile(str) {
			
		  if(str == null || str.length < 8) {
			
			return;
		  }
		  if(pwd == null || pwd.length <= 0) {
			
			return;
		  }
		  var prand = "";
		  for(var i=0; i<pwd.length; i++) {
			prand += pwd.charCodeAt(i).toString();
		  }
		  var sPos = Math.floor(prand.length / 5);
		  var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
		  var incr = Math.round(pwd.length / 2);
		  var modu = Math.pow(2, 31) - 1;
		  var salt = parseInt(str.substring(str.length - 8, str.length), 16);
		  str = str.substring(0, str.length - 8);
		  prand += salt;
		  while(prand.length > 10) {
			prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
		  }
		  prand = (mult * prand + incr) % modu;
		  var enc_chr = "";
		  var enc_str = "";
		  for(var i=0; i<str.length; i+=2) {
			enc_chr = parseInt(parseInt(str.substring(i, i+2), 16) ^ Math.floor((prand / modu) * 255));
			enc_str += String.fromCharCode(enc_chr);
			prand = (mult * prand + incr) % modu;
		  }
		  return enc_str;
		} 	
	
		
		function setCookie(name,value)
		{
			//document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
			document.cookie = name + "="+ escape (value) + ";expires=";
		}
		function getCookie(name)
		{
			var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
			if(arr=document.cookie.match(reg))
			return unescape(arr[2]);
			else
			return null;
		}
		
	
		

	</script>

	<!-- 680 769 -->

	<!-- 弹出层判断显示与否 -->
	<script type="text/javascript">
		var popBook = document.getElementById('popBook')
		if(isPop){
			popBook.style.display = 'block'
		} else {
			popBook.style.display = 'none'
		}

		if(getCookie("eggActivity")==null){
			//活动标识
			var authRse1 = "<%=authRse1%>";
			if(authRse1=="1"){
				//弹出金蛋活动提示层
				isPop1 = true;
				document.getElementById('eggBook').style.display = 'block'
				setCookie("eggActivity","1");
			}else{
				isPop1 =false;
				document.getElementById('eggBook').style.display = 'none'
			}

		};
	


	</script>

	<script type="text/javascript">
		var sLength = specialBox.length;
		specialPos.splice(sLength, 18 - sLength);
		specialPos[sLength-1].right = '-1';

		for(var i = 0, len = sLength; i < len; i++){
			if(specialPos[i].down >= sLength){
				specialPos[i].down = '-1'
			}
		}

	</script>
</body> 
</html>
