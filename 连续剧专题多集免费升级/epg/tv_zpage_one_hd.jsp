 
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



	String backurlnosession = "";//无session的时候返回地址

    String backurlnosession1 = "";
	String lntvlspid=request.getParameter("lntvlspid");

	



	String currentMenuListEleIndex1 = "";
	if(request.getParameter("currentMenuListEleIndex1")!=null){
      	currentMenuListEleIndex1 = request.getParameter("currentMenuListEleIndex1");  
	}
String currentMenuListEleIndex = "";
	if(request.getParameter("currentMenuListEleIndex")!=null){
      	currentMenuListEleIndex = request.getParameter("currentMenuListEleIndex");  
	}
	String providerid="zx";//供应商类型



	String jumpflag = "";

	
	String glAdId = request.getParameter("glAdId");
	String glAdName = request.getParameter("glAdName");
	
	if(request.getParameter("jumpflag")!=null){

		jumpflag = request.getParameter("jumpflag");

	}

	

	String twovodname = "";

	

	if(request.getParameter("twovodname")!=null){

		twovodname = request.getParameter("twovodname");

		logger.info("详情页request的twovodname====================="+twovodname);

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

	

	String hwplayurl="";



	if(request.getParameter("hwplayurl")!=null){



		hwplayurl = request.getParameter("hwplayurl");

		hwplayurl = hwplayurl.replace("*","&");



	}





	String zxplayurl="";



	if(request.getParameter("zxplayurl")!=null){



		zxplayurl = request.getParameter("zxplayurl");

		zxplayurl = zxplayurl.replace("$","&");



	}



	String backflag = "1";//返回标志位



	if (request.getParameter("backflag") != null) {



		backflag = request.getParameter("backflag");



	}



    String sosoflag = "";//搜索标志位



	if (request.getParameter("sosoflag") != null) {



		sosoflag = request.getParameter("sosoflag");



	}



	String foucsid = "";//返回焦点id



	if (request.getParameter("foucsid") != null) {



		foucsid = request.getParameter("foucsid");



	}



	session = request.getSession(); 



	//TurnPage.removeUrl(session, "db_zpage_one.jsp");



	String curfoucsid = "";







	if(request.getParameter("backurlnosession")!= null&&!"".equals(request.getParameter("backurlnosession"))&&request.getParameter("backurlnosession")!="null"){
        
		backurlnosession = request.getParameter("backurlnosession");
        backurlnosession1 = request.getParameter("backurlnosession");
		session.setAttribute("backurlnosession",backurlnosession);

	}

   
   
   	if (session.getAttribute("backurlnosession") != null) {

		backurlnosession = session.getAttribute("backurlnosession").toString();

	}

	String stbId ="";
	    				if(request.getParameter("stbId") != null){
				stbId = request.getParameter("stbId");
				session.setAttribute("stbId",stbId);
			}	
			
		
			
	String boxCity ="";
				if(request.getParameter("boxCity") != null){
				boxCity = request.getParameter("boxCity");
				session.setAttribute("boxCity",boxCity);
			}	


	logger.info("dbzpageone中的backurlnosession====="+backurlnosession);

	String backUrl = "";

	if(!"one".equals(jumpflag)){

		//backUrl = TurnPage.getLast(session);

	}

	String backUrlEpg = "";

	

	backUrlEpg = basePath + "tv_zpage_one_hd.jsp?code=" + primaryid_get+"*lntvlspid="+lntvlspid+"*jumpflag="+jumpflag + "*category_id=" + category_id_get + "*providerid=" + providerid + "*jumpflag=" + jumpflag+"*sosoflag=" + sosoflag+"*backurlnosession=" + backurlnosession.replace("&","$");



	//TurnPage.addUrl(session, "db_zpage_one.jsp?code=" + primaryid_get + "&category_id=" + category_id_get + "&providerid=" + providerid);



	String filepath = ""; // 文件路径



	String intpath = ""; // 读取配置文件中的接口地址



	String url = ""; // 连接配置文件中的接口地址+参数



	String finalurl = "";//当前页面视频信息



	String jqpath = "";//配置文件中鉴权接口地址



	String jqurl ="";//鉴权请求接口参数



	String bytecode="";



	String finalpath="";//本页视频信息



	String resolution="1080i";

    String productid = "";//产品ID
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



	finalpath = properties.get("finalinterface").toString();



	jqpath = properties.get("jqinterface").toString();



	//以下是本页信息接口开始



	logger.debug("本页信息接口开始");



	finalurl = finalpath + "?time=" + time + "&riddle=" + st.encrypt(key + time)+"&vo.code="+primaryid_get+"&vo.providerid="+providerid;



	logger.info("finalapath"+finalurl);



	String finalres = "";
	try {
		
	   finalres = CommonInterface.getInterface(finalurl);//调用共通接口方

	} catch (Exception e) {

		logger.error("db_zpage_one.jsp页面：异常返回信息=||"+e.getMessage()+"||");



		//e.printStackTrace();



		response.getWriter().write("<script>location.href='erro.jsp?providerid="+request.getParameter("providerid")+"';</script>");
	}

	HashMap<String,String> finala = new HashMap<String,String>();

	List<HashMap<String,String>> finallist = new ArrayList<HashMap<String,String>>();

    if(finalres !=null && !"".equals(finalres)&&!"null".equals(finalres)){

			try {

	

			JSONArray jsonArrayfinal = new JSONArray(finalres);

			for(int i = 0; i < jsonArrayfinal.length(); i++){

	

				JSONObject jsonObject2final = jsonArrayfinal.getJSONObject(i);

				if(jsonObject2final.getString("name")!= null && !"".equals(jsonObject2final.getString("name"))){

					finala.put("name",jsonObject2final.getString("name"));//节目名

				}else{

					finala.put("name","暂无节目名");

				}

				finala.put("category_id",jsonObject2final.getString("category_id"));//分类ID

	

				finala.put("primaryid",jsonObject2final.getString("primaryid"));//

				if(jsonObject2final.getString("fileurl")!=null && (jsonObject2final.getString("fileurl").toString()).contains("http")){

					finala.put("fileurl",jsonObject2final.getString("fileurl"));//节目缩略图地址

				}else{

					finala.put("fileurl","");

				}

				finala.put("originalname",jsonObject2final.getString("originalname"));//原名

	

				finala.put("director",jsonObject2final.getString("director"));//导演

	

				finala.put("kpeople",jsonObject2final.getString("kpeople"));//主要任务

	

				finala.put("description",jsonObject2final.getString("description"));//节目描述	

	

				finala.put("duration",jsonObject2final.getString("duration"));	//时长

	

				finala.put("releaseyear",jsonObject2final.getString("releaseyear"));//上映年份	

	

				finala.put("orgairdate",jsonObject2final.getString("orgairdate"));	//首播时间

	

				finala.put("category_name",jsonObject2final.getString("category_name"));//分类名称

	

				finala.put("seriesflag",jsonObject2final.getString("seriesflag"));//剧集标识0单集1多集

				
                 
				//session 中存入剧集标识

				session.setAttribute("tuisong_seriesflag",jsonObject2final.getString("seriesflag"));

	

				finala.put("volumncount",jsonObject2final.getString("volumncount"));//总集数

	

				finala.put("code",jsonObject2final.getString("code"));

	

				finala.put("originalcountry",jsonObject2final.getString("originalcountry"));	

	

				//category_id_get = jsonObject2final.getString("category_id");

	

				//取4k标识

				//isfourkpian = jsonObject2final.getString("guest");	
	 /*if("1".equals(finala.get("seriesflag"))){
	 	logger.info("currentMenuListEleIndex1: "+currentMenuListEleIndex1+"currentMenuListEleIndex13: "+currentMenuListEleIndex);

	 	session.setAttribute("currentMenuListEleIndex12",currentMenuListEleIndex1);
	 	session.setAttribute("currentMenuListEleIndex13",currentMenuListEleIndex);
	 	
        pageContext.forward("TV_zpage_one_dj.jsp");
        return;*/


		

    
	//		session.setAttribute("db_zpage_two_code",jsonObject2final.getString("code"));

	//		String namelist = jsonObject2final.getString("serieslist");//获取剧集JSON

	//		JSONArray namejson = new JSONArray(namelist);

	//		for(int s = 0; s<namejson.length();s++){

	//				JSONObject jsonObject2 = namejson.getJSONObject(s);		

	//				HashMap<String,String> namemap = new HashMap<String,String>();

	//				namemap.put("sequence",jsonObject2.getString("sequence"));

	//				namemap.put("code",jsonObject2.getString("code"));

	//				finallist.add(namemap);

			//}
				
	// }
				
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



	



	//以下是推荐位置视频信息



	logger.info("推荐位置接口开始"+primaryid_get+"参数"+category_id_get);



	url = intpath + "?time=" + time + "&riddle=" + st.encrypt(key + time)+"&vo.code="+primaryid_get+"&vo.category_id="+category_id_get+"&vo.providerid="+providerid+"&vo.temp_field1=8";



	logger.info("url:"+url); 



    //url = "http://61.161.172.26/cms/categoryInterface_searchRoot.do?time=1418439444437&riddle=00eae19783805eb7312b5fe2b989390a";



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



			//e.printStackTrace();



			//response.getWriter().write("<script>location.href='erro.jsp?providerid="+request.getParameter("providerid")+"';</script>");



		}



	}






    if (session.getAttribute("backurlnosessionforone") != null) {

       
	   backurlnosession = session.getAttribute("backurlnosessionforone").toString().replace("$","&");

	}
	
	
	logger.info("sessionzhongqubackurlnosession"+backurlnosession);



	

	

	Calendar calendar = Calendar.getInstance();

    Date date = calendar.getTime();

	String payflag = "on";

	payflag = properties.get("payflag").toString();

	

	String jqresult ="2";//默认通过

	
    String volumncount="0";
	

	



	//读取session参数     

	String userip = "";

	String usermac = "";

	String useradsl = "";

	String iaspuserid = "";

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

	logger.info("dbzpageone中的"+"iaspuserid="+iaspuserid+"usermac="+usermac+"userip="+userip+"useradsl="+useradsl);

	//获取temptoken

	String temptoken = "";

	//if(session.getAttribute("buytemptoken") != null){

	//	temptoken = session.getAttribute("buytemptoken").toString();

	//	logger.info("dbzpageone中的temptoken==========="+temptoken);

	//}

	//cookie获取temptoken

	//if("".equals(temptoken)){

	//	Cookie[] cookies = request.getCookies();

		//cookies不为空，则清除

	//	if(cookies!=null)

	//	{

	//	 for(Cookie cookieTemp : cookies){

	//	   String cookieIdentity = cookieTemp.getName();

	//	   if(cookieIdentity.equals("buytemptoken"))

	//	   {

	//		  temptoken = cookieTemp.getValue();

	//	   }

	//	 }

	//	}

	//}

	//请求认证接口获取temptoken

	String riddle = st.encrypt(key + time);

	if("".equals(temptoken)){

		String tokenpath = properties.get("gettemptokenbyuserid").toString();

		String gettoken = tokenpath+"?userid="+iaspuserid+"&time="+time+"&riddle="+riddle;

		String tores = CommonInterface.getInterface(gettoken);

		logger.info("获取的temptoken=========="+iaspuserid+"================="+tores);

		JSONObject toJson = null;

		if(tores != null && !"".equals(tores)){

			toJson = new JSONObject(tores);

		}

		if(toJson != null){

			temptoken = toJson.getString("temptoken");

		}

		if(temptoken != null && !"".equals(temptoken)){

			session.setAttribute("buytemptoken",temptoken);

			Cookie cookie = new Cookie("buytemptoken",temptoken);

			cookie.setMaxAge(600);

			logger.info("测试session中的temptoken======================================"+session.getAttribute("buytemptoken"));

		}

	}
	
	
	String tishimessage = "";
	//郭东阳--增加--开始
	String cppath = "";//获取产品列表地址
	String cpurl = "";//查询产品列表地址
	cppath = properties.get("cpinterface").toString();
	String params = AESUtil.encrypt("categoryid=" + category_id_get
			+ "&programid=" + finala.get("primaryid") + "&pid=1"
			+ "&pagecount=999");//透传参数
	cpurl = cppath
			+ "?time="
			+ time
			+ "&riddle="
			+ st.encrypt(key + time)
			+ "&temptoken=&fromproject=iptv&toproject=oss&interfacename=product_searchProdsByCidAndPidForMuti.do&params="
			+ params;
			logger.info("获取产品列表开始参数" + "categoryid=" + category_id_get
			+ "&programid=" + finala.get("primaryid") + "&pid=1"
			+ "&pagecount=999");
	logger.info("获取产品列表开始参数" + params);
	logger.info("获取产品列表开始" + cpurl);
	String jqres2= CommonInterface.getInterface(cpurl);//调用共通接口方
	logger.info("1------------00:"+jqres2);
	logger.info("1------------01"+CommonInterface.getInterface(cpurl));
	JSONObject resJson2 = null;
	if (!"".equals(jqres2)) {
		logger.info("获取产品列表成功，解析返回值");
		logger.info("jqres2:"+jqres2);
		try {
			resJson2 = new JSONObject(jqres2);
		} catch (JSONException e) {
			logger.error("db_zpage_one.jsp页面：异常返回信息=||"+ e.getMessage() + "||");
			e.printStackTrace();
		}
	} else {
		logger.info("获取产品列表失败");
		
	}
	if(resJson2.getJSONArray("list").length()>0){

		  
			JSONObject jsonObject2final = resJson2.getJSONArray("list").getJSONObject(0);
		 
			        productid = jsonObject2final.getString("id");

	if(temptoken != null && !"".equals(temptoken)&& !"null".equals(temptoken)){
	
	
			
	 
	
	//播放鉴权接口

	jqurl=jqpath+"?time=" + time + "&riddle=" + st.encrypt(key + time)+"&programid="+finala.get("primaryid")+"&categoryid="+category_id_get+"&providerid="+providerid+"&resolution="+resolution+"&temptoken="+temptoken;



	logger.info("播放鉴权开始");



	String jqres = CommonInterface.getInterface(jqurl);//调用共通接口方





	HashMap<String,String> jq = new HashMap<String,String>();



	if("2".equals(jqres)){



		logger.info("播放鉴权成功，解析返回值========="+jqres);



		jqresult="2";



	}else{



		logger.info("播放鉴权失败================================"+jqres);



		jqresult="1";



		//response.getWriter().write("<script>location.href='erro.jsp?providerid="+request.getParameter("providerid")+"';</script>");



	}

	

	

		//宽带 TV 状态
	String portalidnum = "";
	
	
	String rzlastres = "";



   logger.info("payflagpayflag================================"+payflag);


   logger.info("jqresjqresjqres================================"+jqres);
	

	if("on".equals(payflag) && !"2".equals(jqres)){

	

		if(!"".equals(userip) && !"".equals(iaspuserid)){

			//调用支付锁接口---start

			String gmpath="";

			String skey = "besto";

			

			gmpath = properties.get("cpinterface").toString();

			logger.info("userip==================================================="+userip);

			String plparam =AESUtil.encrypt("user_id="+Base64.encodeStr(iaspuserid)+"&time="+time+"&riddle="+st.encrypt(skey + time));

			String plpath = gmpath+"?time=" + time + "&riddle=" + st.encrypt(skey + time)+"&temptoken="+temptoken+"&fromproject=iptv&toproject=ums&interfacename=user_searchlockorder.do&params="+plparam;

			String plres = CommonInterface.getInterface(plpath);//调用共通接口方法

			JSONObject plJson = null;

			String plstatus = "";
			
		

			if(plres != null){

				plJson = new JSONObject(plres);

				plstatus = plJson.getString("user_paylockstatus");

				if(useradsl == null || "".equals(useradsl)||"undefined".equals(useradsl)){

					useradsl = plJson.getString("user_portalid");

				}

				if(!useradsl.contains("@tv")){

					useradsl = plJson.getString("user_portalid");

				}
				
				
				if(plJson.getString("user_portalidnum") != null && !"".equals(plJson.getString("user_portalidnum"))){
                
                portalidnum = plJson.getString("user_portalidnum");
                }

			}

			//调用支付锁接口---end

			

			//session内的信息

			logger.info("usermac==="+usermac+"          userip======"+userip+"                  useradsl======="+useradsl+"               iaspuserid========="+iaspuserid);

			//订购前调用iasp认证接口---start

			String iasppl = "1";

			if("0".equals(plstatus)||"6".equals(plstatus)||"7".equals(plstatus)||"8".equals(plstatus)||"9".equals(plstatus)){

					iasppl = "0";

				}

			String paylock = "0";

			if("2".equals(plstatus)){

				paylock = "1";

			}

			

			

			

			

			if(session.getAttribute("rzlastres") != null){

				rzlastres = session.getAttribute("rzlastres").toString();

			}

			//cookie 判断 认证结果

			Cookie[] cookies = request.getCookies();

			 //cookies不为空，则清除

			if(cookies!=null && rzlastres != null && !"".equals(rzlastres))

			{

			  for(Cookie cookieTemp : cookies){

				 String cookieIdentity = cookieTemp.getName();

				 if(cookieIdentity.equals("rzlastres"))

				 {

					 rzlastres = cookieTemp.getValue();

				  }

			   }

			}

			 if("0".equals(iasppl)){

				if(rzlastres == null || "".equals(rzlastres)){

					SimpleDateFormat matteriasp=new SimpleDateFormat("yyyyMMddhhmmss.SSS");

				    String TimeStamp  = matteriasp.format(date).toString();

					String aaapath ="";

					String standBy1="";

				    String standBy2="";

				    String standBy3="";

				    String standBy4="";

				    String standBy5="";

				    String transparent = "";

					gmpath = properties.get("cpinterface").toString();

					String rzoriginal ="2" + "$" +"01"+ "$" +TimeStamp+ "$" +"088000000001"+ "$"+ userip +"$"+ usermac +"$"+ useradsl+ "$" + iaspuserid + "$" + iasppl +"$" +standBy1+ "$" +standBy2+ "$" +standBy3+ "$" +standBy4+ "$" +standBy5;

					MD5 md5 = new MD5();

					String secret = "kzrDfRQbKFkCRzAJiwhfJMKY";

					String Mode="1";//接口方式

					String rzhash = md5.getMD5ofStr(Base64.encodeStr(rzoriginal + "$" + secret));

					byte[] rzbEncrypt = Encryptor.desEncrypt((rzoriginal + "$" + rzhash + "$" + transparent).getBytes(), secret);

					String rzpart2 = Base64.encodeBytes(rzbEncrypt);

					String rzvalue = URLEncoder.encode("088000000001"+ "$" + "01" + "$" + "2" + "$" + rzpart2, "UTF-8");

					String rzparam = AESUtil.encrypt("SPRequest="+rzvalue);

					String rzaaapath = gmpath+"?time=" + time + "&riddle=" + st.encrypt(skey + time)+"&temptoken="+temptoken+"&fromproject=iptv&toproject=iasp&interfacename=&params="+rzparam;

					String rzres = CommonInterface.getInterface(rzaaapath);//调用共通接口方法

					logger.info("认证接传参========================"+rzoriginal+"!!!!!!!temptoken="+temptoken);

					logger.info("认证接口返回值========================"+rzres);

					if(rzres != null){

						String tospString = "";

						try{

							JSONObject jsonObject = new JSONObject(rzres);

							tospString = jsonObject.getString("ToSP");

							//解第二层json

								JSONObject jsonObject21 = new JSONObject(tospString);

								rzlastres = jsonObject21.getString("Result");

								Cookie cookie = new Cookie("rzlastres",rzlastres);

								cookie.setMaxAge(600);

								session.setAttribute("rzlastres",rzlastres);

						} catch (Exception e) {	

							e.printStackTrace();

						}

					}

					logger.info("认证结果========================"+rzres+"============================"+rzlastres);

			    }

			}

			logger.info("认证结果最终========================"+rzlastres+"============================"+rzlastres);

			//订购前调用iasp认证接口---end

		

			

			System.out.println("PPPPPPPPPPPPPP"+finala.get("primaryid"));

		

			//播放鉴权结束

			

			

			//判断支付订购按钮

			if("0".equals(plstatus)||"6".equals(plstatus)||"7".equals(plstatus)||"8".equals(plstatus)||"9".equals(plstatus)){

				if("0".equals(rzlastres)){

					jqresult="1";

				}else{

					//jqresult="3";IASP 认证失败修改成到支付页可以第三方支付
					jqresult="1";

				}

			}else if("2".equals(plstatus)){

				//jqresult="3";黑名单修改成到支付页可以第三方支付

				jqresult="1";

			}else if("1".equals(plstatus)){

				jqresult="2";

			}else{

				jqresult="3";

			}

		}else{

			jqresult="3";

		}

		

	}

	//session.setAttribute("payplstatus",plstatus);


	session.setAttribute("payrzlastres",rzlastres);

	

	if(!"on".equals(payflag)){

		jqresult="2";

	}

	

	if("暂无节目".equals(finala.get("name").toString())){

		jqresult="6";

	}

	//查看是否为4k

	String isfourk = "";

	String fourkflag = "0";

    if(session.getAttribute("isfourk") != null){

    isfourk = session.getAttribute("isfourk").toString(); 
	}

	if(request.getParameter("isfourk")!=null){

		isfourk = request.getParameter("isfourk");
		session.setAttribute("isfourk",isfourk);

	}

    

	String fourkstring = "";

	fourkstring = properties.get("4kboxflag").toString();

	String[] fourkstype = fourkstring.split(",");

	for(int i=0;i < fourkstype.length;i++){

		if(isfourk != null && !"".equals(isfourk)){

 		 if(isfourk.equals(fourkstype[i])){

				fourkflag = "1";

			}

		}

	}

	

	if("4k".equals(isfourkpian)){

		isfourkpian = "4KOTT";

		if("1".equals(fourkflag)){

			

			}else{

				jqresult="4";

			}

		

	}
	
	
	
	
	
	
	
	
	
	 //4k 节目判断是否可以订购
    
    if(category_id_get.contains("1001007007")||category_id_get.contains("1024001")||category_id_get.contains("1001022001")||category_id_get.contains("1001024002")){
    //if(category_id_get.contains("1001007007")){
	
    
    //是4K 节点下的节目
    
    if("1".equals(fourkflag)){
    //是4k 机顶盒

        if(!"".equals(userip) && !"".equals(iaspuserid)&& "".equals(portalidnum)){

			//调用支付锁接口---start
			String gmpath="";

			String skey = "besto";

			gmpath = properties.get("cpinterface").toString();

			logger.info("userip==================================================="+userip);

			String plparam =AESUtil.encrypt("user_id="+Base64.encodeStr(iaspuserid)+"&time="+time+"&riddle="+st.encrypt(skey + time));

			String plpath = gmpath+"?time=" + time + "&riddle=" + st.encrypt(skey + time)+"&temptoken="+temptoken+"&fromproject=iptv&toproject=ums&interfacename=user_searchlockorder.do&params="+plparam;

			String plres = CommonInterface.getInterface(plpath);//调用共通接口方法

			JSONObject plJson = null;

			String plstatus = "";
			
		

			if(plres != null){

				plJson = new JSONObject(plres);

				
				if(plJson.getString("user_portalidnum") != null && !"".equals(plJson.getString("user_portalidnum"))){
                
                portalidnum = plJson.getString("user_portalidnum");
                }

			}

			//调用支付锁接口---end

		}


	logger.info("portalidnumportalidnum====================="+portalidnum);




    
    if(!"1".equals(portalidnum)&&!"".equals(portalidnum)&&!"null".equals(portalidnum)){
    
    //宽带状态不正常是4k机顶盒提示
    jqresult = "7";
    }
    }else{
    //不是4k机顶盒提示
    jqresult = "7";
    
    }

    }
    
	


    if("1".equals(fourkflag)){
    
    
    if(!"1".equals(portalidnum)&&!"".equals(portalidnum)&&!"null".equals(portalidnum)){

	if ("2".equals(portalidnum)) {
	
		tishimessage = "联通电视速率不达标，请拨打10010报障。";
		
	}else {
	
		tishimessage = "您使用的宽带速率不能流畅播放4K超清节目，请到联通营业厅办理50M及以上宽带或智慧沃家业务，详询10010。";

	}
	
	}

	}else{
        tishimessage = "您使用的机顶盒不支持播放4K超清节目,请询问10010了解购买或更换4K机顶盒办法。";

	}
	
	
}else{
	logger.info("portalidnumportalidnum1111111====================="+category_id_get);
	
	
	}
	
//郭东阳--补充end--括号	
	}else{
		jqresult ="2";
	    String portalidnum = "";
	    logger.info("portalidnumportalidnum11111111111111111====================="+category_id_get);
		if(!"".equals(userip) && !"".equals(iaspuserid)){

			//调用支付锁接口---start

			String gmpath="";

			String skey = "besto";

			

			gmpath = properties.get("cpinterface").toString();

			logger.info("userip==================================================="+userip);

			String plparam =AESUtil.encrypt("user_id="+Base64.encodeStr(iaspuserid)+"&time="+time+"&riddle="+st.encrypt(skey + time));

			String plpath = gmpath+"?time=" + time + "&riddle=" + st.encrypt(skey + time)+"&temptoken="+temptoken+"&fromproject=iptv&toproject=ums&interfacename=user_searchlockorder.do&params="+plparam;

			String plres = CommonInterface.getInterface(plpath);//调用共通接口方法

			JSONObject plJson = null;

			String plstatus = "";
			
		

			if(plres != null){

				plJson = new JSONObject(plres);

				plstatus = plJson.getString("user_paylockstatus");

				if(useradsl == null || "".equals(useradsl)||"undefined".equals(useradsl)){

					useradsl = plJson.getString("user_portalid");

				}

				if(!useradsl.contains("@tv")){

					useradsl = plJson.getString("user_portalid");

				}
				
				
				if(plJson.getString("user_portalidnum") != null && !"".equals(plJson.getString("user_portalidnum"))){
                
                portalidnum = plJson.getString("user_portalidnum");
                }

			}
		}
		//查看是否为4k

		String isfourk = "";

		String fourkflag = "0";

	    if(session.getAttribute("isfourk") != null){

	    isfourk = session.getAttribute("isfourk").toString(); 
		}

		if(request.getParameter("isfourk")!=null){

			isfourk = request.getParameter("isfourk");
			session.setAttribute("isfourk",isfourk);

		}

	    

		String fourkstring = "";

		fourkstring = properties.get("4kboxflag").toString();

		String[] fourkstype = fourkstring.split(",");

		for(int i=0;i < fourkstype.length;i++){

			if(isfourk != null && !"".equals(isfourk)){

	 		 if(isfourk.equals(fourkstype[i])){

					fourkflag = "1";

				}

			}

		}

		

		if("4k".equals(isfourkpian)){

			isfourkpian = "4KOTT";

			if("1".equals(fourkflag)){

				

				}else{

					jqresult="4";

				}

			

		}
		
		 //4k 节目判断是否可以订购
	    
	    if(category_id_get.contains("1001007007")||category_id_get.contains("1024001")||category_id_get.contains("1001022001")||category_id_get.contains("1001024002")){
	    //if(category_id_get.contains("1001007007")){
		
	    logger.info("portalidnumportalidnum1111====================="+category_id_get);
	    //是4K 节点下的节目
	    
	    if("1".equals(fourkflag)){
	    //是4k 机顶盒

	        if(!"".equals(userip) && !"".equals(iaspuserid)&& "".equals(portalidnum)){

				//调用支付锁接口---start
				String gmpath="";

				String skey = "besto";

				gmpath = properties.get("cpinterface").toString();

				logger.info("userip==================================================="+userip);

				String plparam =AESUtil.encrypt("user_id="+Base64.encodeStr(iaspuserid)+"&time="+time+"&riddle="+st.encrypt(skey + time));

				String plpath = gmpath+"?time=" + time + "&riddle=" + st.encrypt(skey + time)+"&temptoken="+temptoken+"&fromproject=iptv&toproject=ums&interfacename=user_searchlockorder.do&params="+plparam;

				String plres = CommonInterface.getInterface(plpath);//调用共通接口方法

				JSONObject plJson = null;

				String plstatus = "";
				
			

				if(plres != null){

					plJson = new JSONObject(plres);

					
					if(plJson.getString("user_portalidnum") != null && !"".equals(plJson.getString("user_portalidnum"))){
	                
	                portalidnum = plJson.getString("user_portalidnum");
	                }

				}

				//调用支付锁接口---end

			}


		logger.info("portalidnumportalidnum====================="+portalidnum);




	    
	    if(!"1".equals(portalidnum)&&!"".equals(portalidnum)&&!"null".equals(portalidnum)){
	    
	    //宽带状态不正常是4k机顶盒提示
	    jqresult = "7";
	    }
	    }else{
	    //不是4k机顶盒提示
	    jqresult = "7";
	    
	    }
	    if("1".equals(fourkflag)){
	        
	        
	        if(!"1".equals(portalidnum)&&!"".equals(portalidnum)&&!"null".equals(portalidnum)){

	    	if ("2".equals(portalidnum)) {
	    	
	    		tishimessage = "联通电视速率不达标，请拨打10010报障。";
	    		
	    	}else {
	    	
	    		tishimessage = "您使用的宽带速率不能流畅播放4K超清节目，请到联通营业厅办理50M及以上宽带或智慧沃家业务，详询10010。";

	    	}
	    	
	    	}

	    	}else{
	            tishimessage = "您使用的机顶盒不支持播放4K超清节目,请询问10010了解购买或更换4K机顶盒办法。";

	    	}
	 }
		
	}
	
	

	//测试数据问题先写死产品id
	//productid = "240001831";
String mode = ""; // 0：单次:1：包月
		String isgoon = ""; // 0：自动续订 1：非自动续订
	
		String productname = "";//产品名称
		String description = "";//产品描述
		String price = "";//产品价格
		String tariffid = "";//资费id
		String orderNumber = "";//订单号
		String spcode = "wxcyhy37";
		String standby1 = "";
		String standby2 = "";
		String standby3 = "";
		String standby4 = "";
		String standby5 = "";
		String hash = "";
		String secret = "kzrDfRQbKFkCRzAJiwhfJMKY";
		String transparentString = "";
		mode = "1";
		isgoon = "0";
		
		productname = "极限超清29元包月";
		description = "尽情观看极限超清的极致体验";
		price = "29.00";
		orderNumber = "wxcyhy37mon" + time + iaspuserid.substring(iaspuserid.length() - 3, iaspuserid.length());
		standby1 = "wxcyhy37mon";
		backUrl=backUrlEpg;
		
		String original = mode + "$" + isgoon + "$" + productid + "$" + productname + "$" + description + "$" + price + "$" + tariffid + "$" + orderNumber + "$" + temptoken + "$" + providerid + "$" + spcode + "$" + backUrl + "$$" + usermac + "$" + userip + "$" + iaspuserid + "$$$$$";
		MD5 md5 = new MD5();
		hash = md5.getMD5ofStr(Base64.encodeStr(original + "$" + secret));
 		byte[] bEncrypt = Encryptor.desEncrypt((original + "$" + hash + "$" + "").getBytes("UTF-8"), secret);
		String part2 = Base64.encodeBytes(bEncrypt);
	    String	SPRequest = URLEncoder.encode("wxcyhy37" + "$" + "" + "$" + "0" + "$" + part2, "UTF-8");


		
	
/*----------------------sp增值业务end---------------------*/

	
	
	
	
	
	
	

session.setAttribute("SPRequest",SPRequest);

	//拼写log值



    String timestemp="";//时间戳   



 	String ip="";//ip地址



 	String tempToken="";//用户的临时标识      



 	String deviceToken="";//用户标识  	



    String nickName = "";//昵称             



    String pageID="";//页面标识         



    String categoryType="";//访问类型         



    String categoryID="";//访问类型栏目唯一ID 



    String contentID="";//内容唯一ID 



    String contentName="";//节目名称    



    String adType="";  //ad类型                           



    String plateID="";//板块标识   



    String positionID="";//广告位置标识   



    String operationType="";//操作类型 



    String keyword="";//关键词



    String orignal="";//日志来源 



 	String mac ="";	//msc地址



	String protal="";//网络接入类型



	SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");



    timestemp=sim.format(date);



  	ip=request.getLocalAddr();



  	session = request.getSession();



  	if (session.getAttribute("UserID") != null && !"".equals(session.getAttribute("UserID").toString())) {



  		deviceToken=session.getAttribute("UserID").toString(); 



  	} else {



  		deviceToken="2108" + timestemp;



  	}



    pageID="iptv_dy_zpage_one_hhb.jsp";     



	if (request.getParameter("positionID") != null) {



		positionID = request.getParameter("positionID");



	}

	operationType = glAdId;
	plateID = glAdName;
	
    if ("zx".equals(providerid)) {



    	orignal = "6";



    } else {



    	orignal = "5";



    }



    if (session.getAttribute("iaspmac") != null && !"".equals(session.getAttribute("iaspmac").toString())) {



  		mac = session.getAttribute("iaspmac").toString();



  	} else {



  		mac="2108mac";



  	} 


	
    if (session.getAttribute("stbId") != null && !"".equals(session.getAttribute("stbId").toString())) {



  		stbId = session.getAttribute("stbId").toString();



  	}



  	String param=ip+"|"+tempToken+"|"+deviceToken+"|"+nickName+"|"+pageID+"|"+categoryType+"|"+categoryID+



  		 "|"+contentID+"|"+contentName+"|"+adType+"|"+plateID+"|"+positionID+"|"+operationType+"|"+keyword+"|"+orignal+"|"+



  	 	  mac+"|"+protal+"|"+timestemp;


	logger.info("dy_params====================="+param);
	
  	param = AESUtil.encrypt(param);

  	//暂用



   	String returnurl_1 = basePath + "finalpage.jsp?iptvwarchloginsert_returnurl=";

   	

   	

   			//为推送信息制作返回地址

	String backurlfortuisong ="dy_page.jsp?categoryid="+category_id_get+"$providerid="+providerid

	+"$backflag=0$foucsid=requests0$positionID=request0";

   	

   	

/*   				//为推送信息制作返回地址

	String backurlfortuisong ="dy_page.jsp?code="+primaryid_get+"$category_id="+category_id_get+"$providerid="+providerid

	+"$backflag=0$foucsid=dy_page_right0"+"$backurlnosession="+backurlnosession.replace("&","$");

   	

   	session.setAttribute("backurlfortuisong_db_zpage",backurlfortuisong);*/

   	logger.info("详情页最后的providerid====================="+providerid);



	logger.info("zxplayurl====================="+zxplayurl);





	logger.info("sosoflag:"+sosoflag); 




    logger.info("categoryIDcategoryIDcategoryIDcategoryIDcategoryIDcategoryID====================="+category_id_get);
    


    session.setAttribute("backUrlEpg",backUrlEpg);

     session.setAttribute("providerid",providerid);
	
//jqresult = "1";
     
   logger.info("最终播放结果判断==="+jqresult);


   String specialBack = "";
   if(null!=request.getParameter("specialBack")){
   specialBack = request.getParameter("specialBack");
}

String tempFlag = "";
if(null !=request.getParameter("tempFlag")){
	tempFlag = request.getParameter("tempFlag");
}
   //封装多集页参数
   String djUrl = "TV_zpage_one_dj.jsp?category_id="+category_id_get+"&code="+primaryid_get+"&providerid="+providerid+"&lntvlspid="+lntvlspid+"&stbId="+stbId+"&tempFlag="+tempFlag+"&specialBack="+specialBack;
   
   logger.info("TV_zpage_one_dj.jsp djUrl=================="+djUrl);
   
   


%>
<script language="javascript">
		var boxType = Authentication.CTCGetConfig("STBType");

        var hdType = "1";
        var xmlhttpforadlog; 
       var pageID ='<%=pageID%>';
	   var orignal = '<%=orignal%>';
       var stbId ='<%=stbId%>';
	   var boxCity='<%=boxCity%>';
	   var lntvlspid = '<%=lntvlspid%>';
	   var djUrl = "<%=djUrl%>";

	   var seriesflag = "<%=finala.get("seriesflag")%>";

	   if(seriesflag =="1"){
	   		window.location.href = djUrl;
	   }


			 if (window.XMLHttpRequest) 
			 { 
				  xmlhttpforadlog   =   new   XMLHttpRequest(); 
			 } 
			 else if (window.ActiveXObject) 
			 { 
				  xmlhttpforadlog   =   new   ActiveXObject("Microsoft.XMLHTTP"); 
			 }






			 var adlog='http://202.97.183.77:88/templets/epg/spstatistics_HD_hhb.jsp?deviceToken=<%=iaspuserid%>&iaspip=<%=ip%>&iaspmac=<%=mac%>&boxType='+boxType+'&hdType='+hdType+'&boxCity='+boxCity+'&stbId='+stbId+'&pageID='+pageID+'&orignal='+orignal+'&lntvlspid='+lntvlspid;
			 xmlhttpforadlog.open("GET",adlog, true); 
			 xmlhttpforadlog.onreadystatechange = handlelogResponse; 
			 xmlhttpforadlog.setRequestHeader("If-Modified-Since", "0");
			 xmlhttpforadlog.send(null);
			
			 function handlelogResponse() 
			 { 
				 if(xmlhttpforlog.readyState == 4 && xmlhttpforlog.status==200) 
				 { 
					 xmlhttpforlog = null; 
				 } 
			 }
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
<meta name="Page-View-Size" content="1280*720">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>最终页</title>

<link rel="stylesheet" href="education/css/reset.css">
<link rel="stylesheet" href="education/css/common.css">
<link rel="stylesheet" href="education/css/terminal.css">
</head>
<body onload=''>
	<div class="shade shade-up dn"></div>
	<div class="shade shade-down"></div>

	
	<div class="main">
		<div class="container">
			<div class="title">
  <%if(lntvlspid.equals("hhb_ykwh")){%>
				<span class="fcfd0">影片信息：</span> <span><%=finala.get("name")%> 上海语康</span>
				<%}else if(lntvlspid.equals("hhb_hqhy")){%>
				<span class="fcfd0">影片信息：</span> <span><%=finala.get("name")%> 环球影视</span>
				<%}else if(lntvlspid.equals("hhb_yppl")){%>
				<span class="fcfd0">影片信息：</span> <span><%=finala.get("name")%> 优朋</span>
				<%}else if(lntvlspid.equals("hhb_bestv")){%>
				<span class="fcfd0">影片信息：</span> <span><%=finala.get("name")%> 百视通</span>
				<%}else if(lntvlspid.equals("hhb_mgtv")){%>
				<span class="fcfd0">影片信息：</span> <span><%=finala.get("name")%> 芒果</span>
				<%}else if("".equals(lntvlspid)){%>
				<span class="fcfd0">影片信息：</span> <span><%=finala.get("name")%> </span>
				<%}else{%>
				<span class="fcfd0">影片信息：</span> <span><%=finala.get("name")%></span>
				<%}%>



			</div>
			<div class="program-container">
				<div class="program-pic">
					<img src="<%=finala.get("fileurl")%>" width="175" height="260" />
				</div>
				<div class="program-content">
					<div class="program-info">
						<p>
							<span class="fcfd0">主演:</span> <span
								class="program-actor program-staff"><%=finala.get("kpeople")%></span>
						</p>
						<p>
							<span class="fcfd0">导演：</span> <span
								class="program-director program-staff"><%=finala.get("director")%></span>
						</p>
						<p>
							<span class="fcfd0">简介：</span>

							<%
								String description1="";
								if(finala.get("description") !=null){
									description1= finala.get("description");
									if(finala.get("description").length()>100){
										description1= finala.get("description").substring(0,100)+"...";
								}
								
							}
							%>

							<%=description1%>

						</p>
						<div class="program-funcs">
						
                       <%if("2".equals(jqresult)){%>
	                    <div
								class="program-func program-func-play program-func-sel program-func-play-sel">

								<div id="playbutton" class="ico-play"></div>
								&nbsp;&nbsp;&nbsp;&nbsp;播放

							</div>
						
                  
                       <%}if ("1".equals(jqresult)){%>
                           <div
								class="program-func program-func-play program-func-sel program-func-play-sel">

								<div id="playbutton1" class="ico-play"></div>
								&nbsp;&nbsp;&nbsp;&nbsp;试看

							</div>
                       		<div
								class="program-func program-func-play  program-func-play-sel">

								<div id="playbutton2" class="ico-play"></div>
								&nbsp;&nbsp;&nbsp;&nbsp;订购
                         
							</div>
 					   
                         
 						<%}if("7".equals(jqresult)){%>
 					
 						 <div  style="width:108px; height:35px;color: white;position:absolute; left:280px; top:250px"><div style="width:750px;"><%=tishimessage%></div></div>
 						<%} if("4".equals(jqresult)){ %>
 						<div  style="width:108px; height:35px;color: white;position:absolute; left:280px; top:250px"><div style="width:400px;">您未办理4k业务，无法观看此视频，请联系营业厅办理4k业务！</div></div>
 						<%} if("6".equals(jqresult)){%>
 						                      		 <div  style="width:108px; height:35px;color: white;position:absolute; left:280px; top:250px"><div style="width:400px;">暂无节目！</div></div>
 					<%} %>
						<!--
                            <div class="program-func program-func-list  ">
							<div id="playbutton4" class="ico-list"></div>
								&nbsp;&nbsp;&nbsp;&nbsp;<span id="collection">
								
								</span>
							</div>-->
						
						</div>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div class="title prefer-title">猜你喜欢</div>
			<div class="prefer-content">
				<!-- 列表容器开始 -->

				<%
					for(int i = 0;i<list.size();i++){
				                    	Map m1 = (Map)list.get(i);
				%>

				<%
					if(i==list.size()-1){
				%>
				<div class="program program-last">
					<img src="<%=m1.get("fileurl")%>" id="pic<%=i%>" width="120px"
						height="180px" alt="">
					<div class="program-mind" id="describe<%=i%>">
						<%=m1.get("name")%>
					</div>
					<div class="program-sel dn" id="pro<%=i%>">
						<img id="picimg<%=i%>" src="<%=m1.get("fileurl")%>" width="132px"
							height="198px" alt="">
						<div class="program-sel-mind" id="bdescribe<%=i%>">
							<%=m1.get("name")%>
						</div>
					</div>
				</div>

				<%
					}
				%>
				<%
					if(i!=list.size()-1){
				%>
				<div class="program">
					<img src="<%=m1.get("fileurl")%>" id="pic<%=i%>" width="120px"
						height="180px" alt="">
					<div class="program-mind" id="describe<%=i%>">
						<%=m1.get("name")%>
					</div>
					<div class="program-sel dn" id="pro<%=i%>">
						<img id="picimg<%=i%>" src="<%=m1.get("fileurl")%>" width="132px"
							height="198px" alt="">
						<div class="program-sel-mind" id="bdescribe<%=i%>">
							<%=m1.get("name")%>
						</div>
					</div>
				</div>

				<%
					}
				%>
				<%
					}
				%>





			</div>
			<!-- 列表容器结束 -->
		</div>
	</div>
	<div class="layer dn" id="layer">
		<div class="selector-nav-container">
			<div class="selector-nav-title">请选择：</div>
			<div class="selector-nav">
				<div class="selector-nav-nav" id="selectorNav"></div>
			</div>
		</div>
		<div class="selector-single-container">
			<div class="selector-single-title" id="singleTitle"></div>
			<div class="selector-single" id="selectorSingle"></div>

		</div>
		
	</div>
	
	<script src="education/js/extend.js"></script>
	<script src="education/js/common.js"></script>
	<script src="education/js/terminal_hhb_tv.js"></script>
	<script src="education/js/keyPress_tv.js"></script>
	<script type="text/javascript" src="js/aes.js"></script> 
	<script type="text/javascript">
	
	var codeList='<%=codeList%>';
	var category_id_get='<%=category_id_get%>';
	var code=codeList.split("@@"); 
    var jqresult ='<%=jqresult%>';
	var payflag ='<%=payflag%>';
   var volumncountList = '<%=finala.get("volumncount")%>';
   var providerid1 = '<%=providerid%>';
	var seriesflag ='<%=finala.get("seriesflag")%>';
 var currentMenuListEleIndex12 ='<%=currentMenuListEleIndex1%>';
	var currentMenuListEleIndex13 =	'<%=currentMenuListEleIndex%>';

	
	var lntvlspid='<%=lntvlspid%>';


		function getGys()
		{
		if(lntvlspid=='hhb_hqhy')
		{
		document.getElementById("gys").innerHTML="(环球影视)";
		}
		else if(lntvlspid=='hhb_ypplhhb_ykwh'||lntvlspid=='hhb_yppl')
		{
		document.getElementById("gys").innerHTML="(优朋)";
		}
		else if(lntvlspid=='hhb_bst')
		{
		document.getElementById("gys").innerHTML="(百视通)";
		}
		}
//返回方法
		var backurlnosession1 ='<%=backurlnosession1%>';
		function onkeyback() {

			 var backurl = getCookie("dblisturl");

 			
    			//var currentMenuListEleIndex12 = getCookie("currentMenuListEleIndex12");
    	     location.href = uncompile(backurl)+"&currentMenuListEleIndex12="+currentMenuListEleIndex12+"&currentMenuListEleIndex="+currentMenuListEleIndex12;
			// if(backurlnosession1!= null&&backurlnosession1!=""){
			// location.href = backurlnosession1;
			// }else{
			// var ref="";
			//  if (document.referrer.length > 0) {  
			//   ref = document.referrer;  
			//  }  
			//  try {  
 		// 	  if (ref.length == 0 && opener.location.href.length > 0) {  
			//    ref = opener.location.href;  
			//   }  
 		// 	 } catch (e) {
			 
			//  } 
			//  if(ref.indexOf("thisdz=1")>=0){
			//  			var dblisturl = getCookie("dblisturl");

			// if (dblisturl == "null" || dblisturl == ""
			// 		|| dblisturl == "undefined" || dblisturl == null
			// 		|| typeof (dblisturl) == "undefined"
			// 		|| typeof (dblisturl) == "null") {

			// 	var EPGDomain = '';
			// 	if ('CTCSetConfig' in Authentication) {
			// 		EPGDomain = Authentication.CTCGetConfig("EPGDomain");
			// 	} else {
			// 		EPGDomain = Authentication.CUGetConfig("EPGDomain");
			// 	}
			// 	window.location = EPGDomain;

			// } else {
			// 	if (dblisturl.indexOf("?") > -1) {
			// 		window.location = uncompile(dblisturl)+"&currentMenuListEleIndex12="+currentMenuListEleIndex12;
			// 	} else {
			// 		window.location = uncompile(dblisturl)+"&currentMenuListEleIndex12="+currentMenuListEleIndex12;
			// 	}

			// }
			 
			//  }else{
			// var dbbackurl = getCookie("dbbackurl");

			// if (dbbackurl == "null" || dbbackurl == ""
			// 		|| dbbackurl == "undefined" || dbbackurl == null
			// 		|| typeof (dbbackurl) == "undefined"
			// 		|| typeof (dbbackurl) == "null") {

			// 	var EPGDomain = '';
			// 	if ('CTCSetConfig' in Authentication) {
			// 		EPGDomain = Authentication.CTCGetConfig("EPGDomain");
			// 	} else {
			// 		EPGDomain = Authentication.CUGetConfig("EPGDomain");
			// 	}
			// 	window.location = EPGDomain;

			// } else {
			// 	if (dbbackurl.indexOf("?") > -1) {
			// 		if(currentMenuListEleIndex13>7){
			// 			if(currentMenuListEleIndex12==""||currentMenuListEleIndex12==null){
		 //        	var EPGDomain = '';
			// 	if ('CTCSetConfig' in Authentication) {
			// 		EPGDomain = Authentication.CTCGetConfig("EPGDomain");
			// 	} else {
			// 		EPGDomain = Authentication.CUGetConfig("EPGDomain");
			// 	}
			// 	window.location = EPGDomain;
			// 		}else{
			// 		window.location =uncompile(dbbackurl)+"&currentMenuListEleIndex12=7"
			// 		}	
			// 		}else{
			// 		if(currentMenuListEleIndex12==""||currentMenuListEleIndex12==null){
			//     	var EPGDomain = '';
			// 	if ('CTCSetConfig' in Authentication) {
			// 		EPGDomain = Authentication.CTCGetConfig("EPGDomain");
			// 	} else {
			// 		EPGDomain = Authentication.CUGetConfig("EPGDomain");
			// 	}
			// 	window.location = EPGDomain;
			// 		}else{
			// 		window.location =uncompile(dbbackurl)+"&currentMenuListEleIndex12="+currentMenuListEleIndex12;
			// 		}	
					
			// 		}
			// 	} else {
			// 		if(currentMenuListEleIndex13>7){
			// 		if(currentMenuListEleIndex12==""||currentMenuListEleIndex12==null){
			// 	var EPGDomain = '';
			// 	if ('CTCSetConfig' in Authentication) {
			// 		EPGDomain = Authentication.CTCGetConfig("EPGDomain");
			// 	} else {
			// 		EPGDomain = Authentication.CUGetConfig("EPGDomain");
			// 	}
			// 	window.location = EPGDomain;
			// 		}else{
			// 		window.location =uncompile(dbbackurl)+"&currentMenuListEleIndex12=7"
			// 		}
			// 		}else{
	  //              if(currentMenuListEleIndex12==""||currentMenuListEleIndex12==null){
			// 	var EPGDomain = '';
			// 	if ('CTCSetConfig' in Authentication) {
			// 		EPGDomain = Authentication.CTCGetConfig("EPGDomain");
			// 	} else {
			// 		EPGDomain = Authentication.CUGetConfig("EPGDomain");
			// 	}
			// 	window.location = EPGDomain;
			// 		}else{
			// 		window.location = uncompile(dbbackurl)+"&currentMenuListEleIndex12="+currentMenuListEleIndex12;
			// 		}
			// 		}
			// 	}

			// }
			 
			//  }

			// }
			
		}
		var pwd = "gdyzs";
		function uncompile(str) {

			if (str == null || str.length < 8) {

				return;
			}
			if (pwd == null || pwd.length <= 0) {

				return;
			}
			var prand = "";
			for (var i = 0; i < pwd.length; i++) {
				prand += pwd.charCodeAt(i).toString();
			}
			var sPos = Math.floor(prand.length / 5);
			var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos * 2)
					+ prand.charAt(sPos * 3) + prand.charAt(sPos * 4)
					+ prand.charAt(sPos * 5));
			var incr = Math.round(pwd.length / 2);
			var modu = Math.pow(2, 31) - 1;
			var salt = parseInt(str.substring(str.length - 8, str.length), 16);
			str = str.substring(0, str.length - 8);
			prand += salt;
			while (prand.length > 10) {
				prand = (parseInt(prand.substring(0, 10)) + parseInt(prand
						.substring(10, prand.length))).toString();
			}
			prand = (mult * prand + incr) % modu;
			var enc_chr = "";
			var enc_str = "";
			for (var i = 0; i < str.length; i += 2) {
				enc_chr = parseInt(parseInt(str.substring(i, i + 2), 16)
						^ Math.floor((prand / modu) * 255));
				enc_str += String.fromCharCode(enc_chr);
				prand = (mult * prand + incr) % modu;
			}
			return enc_str;
		}

		function play() {
            if('<%=providerid%>'=='zx')
			{
			//中兴点击播放时就加入历史记录
			setHistory();
			setTimeout("zxPlay()", 100);
			}
			else{
			var backUrlEpg = location.href;
            backUrlEpg = backUrlEpg.replace(/&/g,"*");
			var url = "hwplay.jsp?code=<%=finala.get("code")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=<%=isfourkpian%>&videotype=<%=providerid%>&backurl="+backUrlEpg;
            //var url = "hwplay.jsp?code=<%=finala.get("code")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=<%=isfourkpian%>&videotype=<%=providerid%>&vod_poster_url=<%=finala.get("fileurl")%>&backurl="+backUrlEpg;
	        window.location.href=url; 
			}
		} 
		function zxPlay(){
		var backUrlEpg = location.href;
            backUrlEpg = backUrlEpg.replace(/&/g,"*");
			var url = "http://218.24.37.2/templets/epg/hwplay.jsp?code=<%=finala.get("code")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=<%=isfourkpian%>&videotype=<%=providerid%>    &backurl="+backUrlEpg;
            //var url = "hwplay.jsp?code=<%=finala.get("code")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&isfourkpian=<%=isfourkpian%>&videotype=<%=providerid%>&vod_poster_url=<%=finala.get("fileurl")%>&backurl="+backUrlEpg;
	        window.location.href=url; 
		}
		
		
	 function Tryplay() {
		  var meta = document.getElementsByTagName('meta')[0];
        meta.setAttribute('content','640*530');
        	var epgdomain;

			if (typeof(Authentication) == "object"){	

				if("CTCSetConfig" in Authentication) {

					epgdomain = Authentication.CTCGetConfig("EPGDomain");

					

				} else {

					epgdomain = Authentication.CUGetConfig("EPGDomain");

				}

			}

			var last = epgdomain.lastIndexOf("/"); 

			var host = epgdomain.substr( 0, last );

			var returnurl_1 = "<%=basePath%>myplay.jsp?code=<%=finala.get("code")%>";

			var requrl = "";

			if ('<%=providerid%>' == 'zx') {

		
			   	requrl = "geturlzx.jsp?code=<%=finala.get("code")%>&ReturnURL="+returnurl_1+"&ifameFlag=1";
			} else {

				requrl = host + "/geturlhw.jsp?code=<%=finala.get("code")%>&ReturnURL="+returnurl_1;

			

			}
			setCookie("myplayurl",location.href);
			window.location = requrl;

        }
	 //订购方法
	 function order(){
		 var backUrlEpg=location.href;
	     backUrlEpg = backUrlEpg.replace(/&/g,"*");


	if(lntvlspid=="hhb_ykwh"){
		var url_sp = 'spbuyInfo_new.jsp?SPRequest=<%=SPRequest%>&code=<%=finala.get("code")%>&spflag=<%=lntvlspid%>';
		    window.location.href=url_sp; 
	}
	else if(lntvlspid=="hhb_yppl"){
		var url_sp = 'spbuyInfo_new.jsp?SPRequest=<%=SPRequest%>&code=<%=finala.get("code")%>&spflag=<%=lntvlspid%>';
		    window.location.href=url_sp; 
	}
	else  if(lntvlspid=="hhb_mgtv"){
	var url = 'cpbuyInfo_new.jsp?primaryid=<%=finala.get("primaryid")%>&category_id=<%=finala.get("category_id")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&providerid=<%=providerid%>&backurl='+backUrlEpg+'&orderspid=<%=lntvlspid%>';
		window.location.href=url;
	}else{
		var url = 'cpbuyInfo_new.jsp?primaryid=<%=finala.get("primaryid")%>&category_id=<%=finala.get("category_id")%>&name=<%=AESUtil.encrypt(finala.get("name").toString())%>&providerid=<%=providerid%>&backurl='+backUrlEpg+'&orderspid=<%=lntvlspid%>';
		window.location.href=url;
	}

	 }
	 //收藏
	 var xmlhttp;
	 function favorited()
	 {
	 var url="?vo.userid=<%=iaspuserid%>&vo.collect_type=1&vo.vod_program_code=<%=finala.get("code")%>&vo.vod_name=<%=URLEncoder.encode(finala.get("name").toString())%>&vo.vod_synopsis="+Encrypt('<%=finala.get("description").toString()%>')+"&vo.vod_poster_url=<%=finala.get("fileurl")%>"
	 
	 if (window.XMLHttpRequest) {
				//isIE   =   false; 
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				//isIE   =   true; 
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//http://218.24.37.24:9090
			var URL = "http://218.24.37.24:9090/ugms/userCollectProgram_save.do"+url;
			xmlhttp.open("GET", URL, true);
			xmlhttp.onreadystatechange = handleResponse;
			xmlhttp.setRequestHeader("If-Modified-Since", "0");
			xmlhttp.send(null);
	}
	function setHistory()
	 {
	 var url="?vo.userid=<%=iaspuserid%>&vo.collect_type=2&vo.vod_program_code=<%=finala.get("code")%>&vo.vod_name=<%=URLEncoder.encode(finala.get("name").toString())%>&vo.vod_synopsis="+Encrypt('<%=finala.get("description").toString()%>')+"&vo.vod_poster_url=<%=finala.get("fileurl")%>"
	 
	 if (window.XMLHttpRequest) {
				//isIE   =   false; 
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				//isIE   =   true; 
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//http://218.24.37.24:9090
			var URL = "http://218.24.37.24:9090/ugms/userCollectProgram_save.do"+url;
			xmlhttp.open("GET", URL, true);
			xmlhttp.onreadystatechange = handleResponse3;
			xmlhttp.setRequestHeader("If-Modified-Since", "0");
			xmlhttp.send(null);
	}
	//加密
	function Encrypt(word){  
         var key = CryptoJS.enc.Utf8.parse("rockrollformusic");   
  
         var srcs = CryptoJS.enc.Utf8.parse(word);  
         var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});  
         return encrypted.toString();  
    } 
	function handleResponse(){
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
				var result=xmlhttp.responseText;
				
				//xmlhttp = null;
				//var obj=eval('('+result+')');
				//var list=obj[0].list;
				//adstrategyid=list[0].adstrategyid;
				isFavorited=1;
				document.getElementById("collection").innerHTML="取消收藏";
				
						}
	}
	var isFavorited=0;
	//判断是否收藏
	function getCollectProgram()
	 {
	 var url="?vo.userid=<%=iaspuserid%>&vo.collect_type=1&vo.vod_program_code=<%=finala.get("code")%>"
	 
	 if (window.XMLHttpRequest) {
				//isIE   =   false; 
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				//isIE   =   true; 
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//http://218.24.37.24:9090
			var URL = "http://218.24.37.24:9090/ugms/userCollectProgram_getCollectProgram.do"+url;
			xmlhttp.open("GET", URL, true);
			xmlhttp.onreadystatechange = handleResponse1;
			xmlhttp.setRequestHeader("If-Modified-Since", "0");
			xmlhttp.send(null);
	}
	function handleResponse1(){
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
				var result=xmlhttp.responseText;
				
				xmlhttp = null;
				var obj=eval('('+result+')');
				
				if(obj.collect_type==1){
				isFavorited=1;
				document.getElementById("collection").innerHTML="取消收藏";
				}else{
				document.getElementById("collection").innerHTML="加入收藏";
				}
				
						}
	}
	//取消收藏
	function delFavorited()
	 {
	 var url="?vo.userid=<%=iaspuserid%>&vo.collect_type=1&vo.vod_program_code=<%=finala.get("code")%>"
	 
	 if (window.XMLHttpRequest) {
				//isIE   =   false; 
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				//isIE   =   true; 
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//http://218.24.37.24:9090
			var URL = "http://218.24.37.24:9090/ugms/userCollectProgram_delete.do"+url;
			xmlhttp.open("GET", URL, true);
			xmlhttp.onreadystatechange = handleResponse2;
			xmlhttp.setRequestHeader("If-Modified-Since", "0");
			xmlhttp.send(null);
	}
	function handleResponse2(){
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
				var result=xmlhttp.responseText;
				
				xmlhttp = null;
				//var obj=eval('('+result+')');
				isFavorited=0;
				document.getElementById("collection").innerHTML="加入收藏";
				}
	}
        function setCookie(name,value)
       {
       	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
       } 
        function getCookie(name)
       {
       		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
       		if(arr=document.cookie.match(reg))
       		return unescape(arr[2]);
       		else
       		return null;
       
       }
        function equals(str1,str2){
        	if(str1==str2){
        		return true;
        	}else{
        		return false;
        	}
        }
	</script>
</body>
</html>
