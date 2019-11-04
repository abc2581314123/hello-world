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


    logger.info("special1.jsp path  ========="+ztList.concat(number+"&providerid="+providerid));
        String ztListRes = CommonInterface.getInterface(ztList.concat(number+"&providerid="+providerid));
   // String ztListRes = CommonInterface.getInterface(ztList.concat(number));

    JSONObject ztListResult = new JSONObject(ztListRes);

    logger.info("special1.jsp ztListResult========="+ztListResult);
     String poster3url = ztListResult.getString("poster3url").toString(); //获取背景图
    String ztListArray = ztListResult.getString("programlist").toString();
    String type = ztListResult.getString("type").toString();
    JSONArray ztListArray_pro = new JSONArray(ztListArray);


%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="Page-View-Size" content="1280*720">
	<title></title>
	<link rel="stylesheet" type="text/css" href="css/htmleaf-demo.css">
	<style type="text/css">
		* {margin: 0; padding: 0; list-style-type: none;}
		img { display: inline-block; vertical-align: bottom; border: none; }
		#carousel {
	        /*width:960px;*/
	        /* border:1px solid #222; */
	        height:600px;
	        position:relative;
	        clear:both;
	        overflow:hidden;
	      }
	      #filmDat {
	      	position: absolute;
	      	top: 550px;
	      	left: 350px;
	      }
	      #filmDat ul li h3 { width: 100%; text-align: center; }
	      #filmDat ul li { color: #fff; width: 600px;}
	</style>
</head>
<body  style="width: 1280px; height: 720px; background: url('<%=poster3url%>') no-repeat; border: 1px solid #fff;">
	<div id = "ceshi" style="position: absolute;top: 0px;left: 0px"></div>
	<div style="position: absolute; font-weight: bold; font-size: 22px; top: 30px; left: 30px; color: #ffcc00"></div>
	<div class="htmleaf-container">
		<div class="container">
			    <div id="carousel">
			    			<%
						for (int i = 0; i < ztListArray_pro.length(); i ++) { 
                    
					        String name = ztListArray_pro.getJSONObject(i).getString("name").toString();
							String code = ztListArray_pro.getJSONObject(i).getString("code").toString();
							String category_id = ztListArray_pro.getJSONObject(i).getString("category_id").toString(); 
		 					String picture_url =	ztListArray_pro.getJSONObject(i).getString("picture_url").toString();
   							String cpid =  ztListArray_pro.getJSONObject(i).getString("cpid").toString();
   							String freeflag = ztListArray_pro.getJSONObject(i).getString("freeflag").toString();
					     	if (name.length() > 5) {	
					     		name = name.toString().substring(0,4) + "...";
					     	}
     	
     					%>
                 		<%if("1".equals(freeflag)){%>
			     		 <div><img width="320" height="450" src="<%=picture_url%>" id="item-<%=i+1%>" data-name="<%=name%>" data-url = "<%=Epgpath%>/templets/epg/tv_zpage_one_hd.jsp?category_id=<%=category_id %>&code=<%=code%>&pageid=1&providerid=<%=providerid%>&lntvlspid=<%=cpid%>&stbId=<%=stbId%>&number=<%=number%>&tempFlag=1" data-role="影片主演" data-style="影片类型" data-intro="影片简介" /></div>

     					<%}%>
     					<%if("0".equals(freeflag)){%>
      					<div><img width="320" height="450" src="<%=picture_url%>" id="item-<%=i+1%>" data-name="<%=name%>" data-url = "<%=Epgpath%>/templets/epg/TV_zpage_one_free.jsp?category_id=<%=category_id%>&code=<%=code%>&pageid=1&providerid=<%=providerid%>&lntvlspid=<%=cpid%>&number=<%=number%>&tempFlag=2" data-role="影片主演" data-style="影片类型" data-intro="影片简介" /></div>
     						<%}%>
     						<%}%>
			    </div>
			    <br>
			<a href="#" id="prev" class="btn btn-primary" style="display: none;">前一幅</a>　<a href="#" id="next" class="btn btn-primary" style="display: none;">下一幅</a>
		</div>

		<!-- 影片介绍 -->
		<div id="filmDat">
			<ul>
				<li><h3 id="filmName">《狄仁杰四大天王》</h3></li>
				<li id="filmNRole">主演：赵又廷 / 冯绍峰</li>
				<li id="filmStyle">类型 搞笑 / 动作</li>
				<li id="filmIntro">剧情：大家好我是剧情介绍大家好我是剧情介绍大家好我是剧情介绍大家好我是剧情介绍大家好我是剧情介绍</li>
			</ul>
		</div>

	</div>
	<script src="js/keyPress.js"></script>
	<script>window.jQuery || document.write('<script src="js/jquery-1.11.0.min.js"><\/script>')</script>
	<script type="text/javascript" src="js/jquery.waterwheelCarousel.js"></script>
	<script type="text/javascript">
		


var providerid = '<%=providerid%>';
var ztListResult = '<%=ztListResult%>';
var ztListArray = '<%=ztListArray%>';
var ztListRes = '<%=ztListRes%>';
var ztListArray_pro ='<%=ztListArray_pro%>';
		document.getElementById("filmName").innerHTML ='<%=ztListArray_pro.getJSONObject(0).getString("name").toString()%>';
			document.getElementById("filmNRole").innerHTML ='<%=ztListArray_pro.getJSONObject(0).getString("actordisplay").toString()%>';
				document.getElementById("filmIntro").innerHTML ='<%=ztListArray_pro.getJSONObject(0).getString("description").toString()%>';
	document.getElementById("filmStyle").innerHTML ='<%=ztListArray_pro.getJSONObject(0).getString("director").toString()%>';
	      $(document).ready(function () {
	        var carousel = $("#carousel").waterwheelCarousel({
	          flankingItems: 3,
	          movingToCenter: function ($item) {
	            $('#callback-output').prepend('movingToCenter: ' + $item.attr('id') + '<br/>');
	          },
	          movedToCenter: function ($item) {
	            $('#callback-output').prepend('movedToCenter: ' + $item.attr('id') + '<br/>');
	          },
	          movingFromCenter: function ($item) {
	            $('#callback-output').prepend('movingFromCenter: ' + $item.attr('id') + '<br/>');
	          },
	          movedFromCenter: function ($item) {
	            $('#callback-output').prepend('movedFromCenter: ' + $item.attr('id') + '<br/>');
	          },
	          clickedCenter: function ($item) {
	            $('#callback-output').prepend('clickedCenter: ' + $item.attr('id') + '<br/>');
	          }
	        });

	        $('#prev').bind('click', function () {
	          carousel.prev();
	          return false
	        });

	        $('#next').bind('click', function () {
	          carousel.next();
	          return false;
	        });

	        $('#reload').bind('click', function () {
	          newOptions = eval("(" + $('#newoptions').val() + ")");
	          carousel.reload(newOptions);
	          return false;
	        });

	        

	      });

	//记录当前电影索引 
	var filmNum = 0;
	var films = document.getElementById('carousel').getElementsByTagName('img');  
	var canbeClick = true;
	var timer = null;
	function keyRight() {
		if(canbeClick){
			canbeClick = false;
			$("#next").trigger("click");	
			filmNum++;
			if(filmNum == films.length){
				filmNum = 0
			}

var jsonObj =  JSON.parse(ztListArray_pro);//转换为json对象

document.getElementById("filmName").innerHTML =jsonObj[filmNum].name;
	document.getElementById("filmNRole").innerHTML =jsonObj[filmNum].actordisplay;
	document.getElementById("filmIntro").innerHTML =jsonObj[filmNum].description;
		document.getElementById("filmStyle").innerHTML = jsonObj[filmNum].director;
			timer = setTimeout(function(){
				canbeClick = true;
			},500)
		}
	}
	function keyBack(){


   // location.href = "<%=Epgpath%>/templets/epg/dy_page_hhb.jsp?categoryid=1031001&thisdz=1&providerid=<%=providerid%>&currentMenuListEleIndex12=1&ztFlag=ztFlag&ztPosition=ztPosition";

   var backurl1= "<%=backurl1%>";
   backurl1 = backurl1.replace(/\*/g,"&");

   
   location.href  = backurl1+"&currentMenuListEleIndex12=1&currentMenuListEleIndex=1&ztFlag=ztFlag&ztPosition=ztPosition";

}




	function keyLeft() {
		if(canbeClick){
			canbeClick = false;
			$("#prev").trigger("click");
			filmNum--;
			if(filmNum == -1){
				filmNum = films.length - 1
			}

var jsonObj =  JSON.parse(ztListArray_pro);//转换为json对象

document.getElementById("filmName").innerHTML =jsonObj[filmNum].name;
	document.getElementById("filmNRole").innerHTML =jsonObj[filmNum].actordisplay;
	document.getElementById("filmIntro").innerHTML =jsonObj[filmNum].description;
	document.getElementById("filmStyle").innerHTML = jsonObj[filmNum].director;
			timer = setTimeout(function(){
				canbeClick = true;
			},500)
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


		var showImgs = document.getElementById('carousel').getElementsByTagName('img');
		function keyOk(){
			location.href =showImgs[filmNum].dataset['url']+"&iaspuserid=<%=iaspuserid%>&specialBack="+compile(location.href);		
			//setCookie("dblisturl",compile(location.href));

		}


		

	    </script>

</body>
</html>