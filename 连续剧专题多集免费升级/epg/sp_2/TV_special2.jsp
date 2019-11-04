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
Logger logger = Logger.getLogger(CommonInterface.class);

%>
<%
	//读取session参数     

	String userip = "";

	String usermac = "";

	String useradsl = "";

	String iaspuserid = "";
	String stbId = "";
	String backurl1 = "";
	String Epgpath = "http://218.24.37.2";
   

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
		if("".equals(backurl1) && request.getParameter("backurl1") != null){

		backurl1 = request.getParameter("backurl1");

		session.setAttribute("backurl1",backurl1);

	}
	
	String reloadflag = "0";
    if (request.getParameter("reloadflag") != null) {
    	reloadflag = request.getParameter("reloadflag");
    }

    String isFirst="";
	if (request.getParameter("isFirst") != null) {
    	isFirst = request.getParameter("isFirst");
    }

    String number ="";
    if (request.getParameter("number") != null) {
    	number = request.getParameter("number");
    }
	String filePath = "";
	String providerid = request.getParameter("providerid");//服务商
      
  	//providerid="zx"
	//读取配置文件
	filePath = this.getClass().getClassLoader().getResource("interface.properties").toURI().getPath();     //获取接口配置文件路径
	Properties properties = ReadProperties.readProperties(filePath);
	//专题详情页的数据铺展	          
        String ztList =  properties.get("zxList").toString();
      
    logger.info("special2.jsp path  ========="+ztList.concat(number+"&providerid="+providerid));
        String ztListRes = CommonInterface.getInterface(ztList.concat(number+"&providerid="+providerid));

    JSONObject ztListResult = new JSONObject(ztListRes);

     String poster3url = ztListResult.getString("poster3url").toString();
     String type = ztListResult.getString("type").toString();
    String ztListArray = ztListResult.getString("programlist").toString();
    JSONArray ztListArray_pro = new JSONArray(ztListArray);


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Page-View-Size" content="1280*720">
<title>专题</title>
<style>
	* { padding: 0; margin: 0; list-style-type: none;}
	.dom.focus { border: 2px solid #9ceeff; padding: 2px; box-shadow: 0px 0px 10px #9ceeff;}
	img { display: inline-block; vertical-align: bottom; }
    #ulB {overflow: hidden; position: relative; width: 1230px; margin: 0 auto; height: 100%;}
	ul { overflow: hidden; position: absolute; top: 400px; width: 9999px;}
	ul li { display: inline-block; float: left; margin: 0 8px; padding: 2px; border: 2px solid transparent; box-sizing: border-box; position: relative;}
	ul li p { position: absolute; bottom: 0; width: 180px; height: 40px; line-height: 40px; text-align: center; color: #fff; background: rgba(32,86,173, 0.9);}
	ul li img { width: 180px; height: 267px; }
</style>
</head>

<body  style="width: 1280px; height: 720px; background: url('<%=poster3url%>') no-repeat; border: 1px solid #fff;">
<div id="ulB">
		<ul data-area="1">
			    			<%
						for (int i = 0; i < ztListArray_pro.length(); i ++) { 

                    
					        String name = ztListArray_pro.getJSONObject(i).getString("name").toString();
					   	    String code = ztListArray_pro.getJSONObject(i).getString("code").toString();String category_id = ztListArray_pro.getJSONObject(i).getString("category_id").toString(); 
					      String picture_url =	ztListArray_pro.getJSONObject(i).getString("picture_url").toString();
					     
					         String freeflag =  ztListArray_pro.getJSONObject(i).getString("freeflag").toString();
					         String cpid =  ztListArray_pro.getJSONObject(i).getString("cpid").toString();
					     	if (name.length() > 5) {	
					     		name = name.toString().substring(0,4) + "...";
					     	}
     	
     					%>
            <%if("1".equals(freeflag)){%>
	               <li class="dom"data-url = "<%=Epgpath%>/templets/epg/tv_zpage_one_hd.jsp?category_id=<%=category_id%>&code=<%=code%>&pageid=1&providerid=<%=providerid%>&lntvlspid=<%=cpid%>&number=<%=number%>&tempFlag=1&iaspuserid=<%=iaspuserid%>"><img src="<%=picture_url%>" ><p><%=name%></p></li>

     					<%}%>


     		<%if("0".equals(freeflag)){%>
	               <li class="dom"data-url = "<%=Epgpath%>/templets/epg/TV_zpage_one_free.jsp?category_id=<%=category_id%>&code=<%=code%>&pageid=1&providerid=<%=providerid%>&lntvlspid=<%=cpid%>&number=<%=number%>&tempFlag=2&iaspuserid=<%=iaspuserid%>" ><img src="<%=picture_url%>" ><p><%=name%></p></li>

     					<%}%>
 					<%}%>


		</ul>
	</div>

    <script src="js/keyPress.js"></script>
    <script src="js/common.js"></script>
    <script src="js/master.js"></script>
    <script src="js/bytueToolsSerial.js"></script>
    
    <script>

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
    	function keyOk(){
			var area = pageControls.ele.parentNode.dataset['area'];
			if(pageControls.okHandler && pageControls.okHandler[area]){
				pageControls.okHandler[area]();
				return;
			}
			var goUrl = pageControls.ele.dataset['url'];
			window.location.href = goUrl+"&specialBack="+compile(location.href);	
		}

    	function keyBack(){
 // location.href = "<%=Epgpath%>/templets/epg/dy_page_hhb.jsp?categoryid=1031001&thisdz=1&providerid=<%=providerid%>&currentMenuListEleIndex12=1&ztFlag=ztFlag&ztPosition=ztPosition";

  var backurl1= "<%=backurl1%>";
   backurl1 = backurl1.replace(/\*/g,"&");

   
   location.href  = backurl1+"&currentMenuListEleIndex12=1&currentMenuListEleIndex=1&ztFlag=ztFlag&ztPosition=ztPosition";
    	}
        var domC = document.querySelectorAll('.dom');
        pageControls = {
        	self: this,
            ele: domC[0],
            index: 0,
            hooks: {
            	leaved: function(dir){
            		lMarquee();	
            	},
            	entered: function(dir){
            		eMarquee();
                    eScroll(dir);
            	}
            }
        }
        bytueTools.fnAddEleClass(pageControls.ele, 'focus');
    </script>
    <script src="js/newDirControl.js"></script>
    <script src="js/s2.js"></script>
</body>
	
</html>