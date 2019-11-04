<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="com.besto.util.AESUtil"%>
<%@ page language="java" import="com.besto.util.CommonInterface"%>
<%@ page language="java" import="com.besto.util.SecurityTools"%>
<%@ page language="java" import="org.apache.log4j.Logger"%>
<%@ page language="java" import="com.besto.util.ReadProperties"%>
<%


	Logger logger = Logger.getLogger(CommonInterface.class);
	String path = request.getContextPath();

	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String providerid = request.getParameter("providerid");//服务商
	if(request.getParameter("providerid") != null){
				providerid = request.getParameter("providerid");//providerid
				session.setAttribute("providerid",providerid);
	}
	
	if ("".equals(providerid) || providerid == null) {
		providerid = session.getAttribute("providerid").toString();
	}
    if (session.getAttribute("providerid") != null) {

	   providerid = session.getAttribute("providerid").toString();

    }
	String tmpInputText = "";//检索条件

	if(request.getParameter("tmpInputText")!=null&&!"".equals(request.getParameter("tmpInputText"))){ //请求页数

			tmpInputText = request.getParameter("tmpInputText");

	}

	String searchtype = "namek"; //namek为按照影片名搜索，name为按照人名搜索

	if(request.getParameter("searchtype")!=null&&!"".equals(request.getParameter("searchtype"))){ //请求页数

			searchtype = request.getParameter("searchtype");

	}

	String nowpage = ""; //namek为按照影片名搜索，name为按照人名搜索

	if(request.getParameter("nowpage")!=null&&!"".equals(request.getParameter("nowpage"))){ //请求页数

			nowpage = request.getParameter("nowpage");

	}

	String backflag = "0";//返回标志位

	if (request.getParameter("backflag") != null) {

		backflag = request.getParameter("backflag");

	}
	String sosobackurl = "";

		if (request.getParameter("sosobackurl") != null) {

		sosobackurl = request.getParameter("sosobackurl");

	}

	String backUrl = "";
	
	String iaspadsl = "";
			if(request.getParameter("iaspadsl") != null){
				iaspadsl = request.getParameter("iaspadsl");//宽带账号
				session.setAttribute("iaspadsl",iaspadsl);
			}

			String iaspmac = "";
			if(request.getParameter("iaspmac") != null){
				iaspmac = request.getParameter("iaspmac");//MAC信息
				session.setAttribute("iaspmac",iaspmac);
			}
            if (session.getAttribute("iaspmac") != null) {

	           iaspmac = session.getAttribute("iaspmac").toString();

            }
			String iaspip = "";
			if(request.getParameter("iaspip") != null){
				iaspip = request.getParameter("iaspip");//IP信息
				session.setAttribute("iaspip",iaspip);
			}
            
			if (session.getAttribute("iaspip") != null) {

	        iaspip = session.getAttribute("iaspip").toString();

            }
			String iaspuserid = "";
			if(request.getParameter("iaspuserid") != null){
				iaspuserid = request.getParameter("iaspuserid");//用户信息
				session.setAttribute("iaspuserid",iaspuserid);
			}
			if (session.getAttribute("iaspuserid") != null) {

	            iaspuserid = session.getAttribute("iaspuserid").toString();

            }
	
	
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

    Date date = new Date();

    timestemp=sim.format(date);

  	ip=request.getLocalAddr();

    if (session.getAttribute("UserID") != null && !"".equals(session.getAttribute("UserID").toString())) {

  		deviceToken=session.getAttribute("UserID").toString(); 

  	} else {

  		deviceToken="2108" + timestemp;

  	} 

    pageID="iptv_sosohd.jsp"; 

    if ("zx".equals(providerid)) {

    	orignal = "6";

    } else {

    	orignal = "5";

    }

  	if (session.getAttribute("MAC") != null && !"".equals(session.getAttribute("MAC").toString())) {

  		mac = session.getAttribute("MAC").toString();

  	} else {

  		mac="2108mac";

  	} 

  	String param=ip+"|"+tempToken+"|"+deviceToken+"|"+nickName+"|"+pageID+"|"+categoryType+"|"+categoryID+

  		 "|"+contentID+"|"+contentName+"|"+adType+"|"+plateID+"|"+positionID+"|"+operationType+"|"+keyword+"|"+orignal+"|"+

  	 	  mac+"|"+protal+"|"+timestemp;

  	param = AESUtil.encrypt(param);



  	String category_id  = "";

  	if(null !=request.getParameter("category_id")){
  		category_id = request.getParameter("category_id");
  	}
  	logger.info("sosohd_zt_serial.jsp category_id======="+category_id);

%>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<title>js动画</title>
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
	<meta name="Page-View-Size" content="1280*720">
	<link href="ln-css-hd/index.css" rel="stylesheet">
    <link href="ln-css-hd/search.css" rel="stylesheet">
	<link rel="stylesheet" href="ln-css-hd/reset.css">
	<link rel="stylesheet" href="ln-css-hd/common.css">
	<link rel="stylesheet" href="ln-css-hd/list.css">
	<script>
		var sosobackurl = "<%=sosobackurl%>";
		var providerid = '<%=providerid%>';
		var tempstr =  '&providerid=<%=providerid%>&iaspuserid=<%=iaspuserid%>&iaspadsl=<%=iaspadsl%>&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>';
		var iaspuserid = '<%=iaspuserid%>';
		var searchType="name";
		function loadtotal(){
			if (window.XMLHttpRequest) {
				//isIE   =   false; 
				xmlhttp3 = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				//isIE   =   true; 
				xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
			}
				var d = new Date();
			var testtime = d.getTime();
			var riddle = hex_md5('besto' + testtime);
			var inputdata = document.getElementById("inputType").innerText;
			var URL = "http://127.0.0.1:9090/cms/programIptv_searchByNamePoint.do?userid=guanglianhd01&time="+testtime+"&riddle="+riddle+"&vo.pageid="+1+"&vo.pagecount="+7+"&vo.name="+inputdata+"&vo.providerid=hw&resolution=";
			
			//alert(URL);
			xmlhttp3.open("GET", URL, true);
			xmlhttp3.onreadystatechange = handleResponse3;
			xmlhttp3.setRequestHeader("If-Modified-Since", "0");
			xmlhttp3.send(null);
	
}
		function loaddata(pagenum){
			httpflag = 1;
			if(Number(pagenum)==1){
				fnIniCurrent(0,current.colIndex,current.rowIndex);
			}
			if (window.XMLHttpRequest) {
				//isIE   =   false; +++
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				//isIE   =   true; 
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var d = new Date();
			var testtime = d.getTime();
			var riddle = hex_md5('besto' + testtime);
			var inputdata = document.getElementById("inputType").innerText;
			// var URL = "http://218.24.37.2/cms/special_searchProgram.do?time="+testtime+"&riddle="+riddle+"&resolution=&searchType="+searchType+"&searchValue="+inputdata+"&providerid="+providerid+"&pid="+pagenum+"&pagecount=7";
			var URL = "http://218.24.37.2/cms/special_searchProgramSerial.do?time="+testtime+"&riddle="+riddle+"&resolution=&searchType="+searchType+"&searchValue="+inputdata+"&providerid="+providerid+"&pid="+pagenum+"&pagecount=7"+"&categoryId=<%=category_id%>";
			// var URL = "http://169.254.228.79:8080/cms/es/esearchTrade_searchProgram.do?time="+testtime+"&riddle="+riddle+"&resolution=&searchType="+searchType+"&searchValue="+inputdata+"&providerid="+providerid+"&pid="+pagenum+"&pagecount=7";
            // document.getElementById('ceshi').innerHTML = URL;
			// alert(URL);
            xmlhttp.open("GET", URL, true);
			xmlhttp.onreadystatechange = handleResponse;
			xmlhttp.setRequestHeader("If-Modified-Since", "0");
			xmlhttp.send(null);
	
        }
		
	 function Encrypt(word){  
         var key = CryptoJS.enc.Utf8.parse("rockrollformusic");   
  
         var srcs = CryptoJS.enc.Utf8.parse(word);  
         var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});  
         return encrypted.toString();  
    }  
    function Decrypt(word){  
         var key = CryptoJS.enc.Utf8.parse("rockrollformusic");   
  
         var decrypt = CryptoJS.AES.decrypt(word, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});  
         return CryptoJS.enc.Utf8.stringify(decrypt).toString();  
    }  
	</script>
</head>
<body style="background:url(ln-images-hd/search_Bg.jpg) no-repeat; width:1280px; height:720px;">
	<!--输入框-->
    <div id="inputType"></div>
    <!--T9键盘弹出效果层-->
    <div id="T9Prop" class="T9Prop">
    	<div class="leftFloat"><p></p><p class="showB">J</p></div>
      	<div class="leftFloat"><p class="showB">5</p><p class="showB">K</p><p class="showB" style="opacity:0">K</p></div>
        <div class="leftFloat"><p></p><p class="showB">L</p><p></p></div>
    </div>
    <!--T9弹出背景-->
    <div id="T9Bg"><img src="ln-images-hd/vague.jpg"></div>
    <!--T9键盘搜索-->
    <div id="T9leftSearch" class="overflowK T9leftSearch" style="display:none;">
    	<ul class="keyColT9">
        	<li class="keyRowT9" attr="Num_1" style="line-height:60px;">1</li>
        	<li class="keyRowT9" attr="Num_4"><p>4</p><span>GHI</span></li>
        	<li class="keyRowT9" attr="Num_7"><p>7</p><span>PQRS</span></li>
        	<li class="keyRowT9" attr="del"><p><img src="ln-images-hd/del.png"></p><span>退格</span></li>
        </ul>
        
        <ul class="keyColT9">
        	<li class="keyRowT9" attr="Num_2"><p>2</p><span>ABC</span></li>
        	<li class="keyRowT9" attr="Num_5"><p>5</p><span>JKL</span></li>
        	<li class="keyRowT9" attr="Num_8"><p>8</p><span>TUV</span></li>
        	<li class="keyRowT9" attr="Num_0"   style="line-height:60px;">0</li>
        </ul>
        
        <ul class="keyColT9">
        	<li class="keyRowT9" attr="Num_3"><p>3</p><span>DEF</span></li>
        	<li class="keyRowT9" attr="Num_6"><p>6</p><span>MNO</span></li>
        	<li class="keyRowT9" attr="Num_9"><p>9</p><span>WXYZ</span></li>
        	<li class="keyRowT9" attr="delAll"><p><img src="ln-images-hd/delAll.png"></p><span>清空</span></li>
        </ul>
    </div>
	<!--数字键盘搜索-->
     <div id="NumleftSearch" class="overflowK NumleftSearch" style="display:none;">
     	<ul class="keyColNum">
        	<li class="keyRowNum">1</li>
            <li class="keyRowNum">6</li>
            <li class="keyRowNum" attr="abc"><img src="ln-images-hd/abc.png"></li>
        </ul>
        
        <ul class="keyColNum">
        	<li class="keyRowNum">2</li>
            <li class="keyRowNum">7</li>
            <li class="keyRowNum" attr="del"><img src="ln-images-hd/del.png"></li>
        </ul>
        
        <ul class="keyColNum">
        	<li class="keyRowNum">3</li>
            <li class="keyRowNum">8</li>
            <li class="keyRowNum" attr="delAll"><img src="ln-images-hd/delAll.png"></li>
        </ul>
        
        <ul class="keyColNum">
        	<li class="keyRowNum">4</li>
            <li class="keyRowNum">9</li>
        </ul>
        
        <ul class="keyColNum">
        	<li class="keyRowNum">5</li>
            <li class="keyRowNum">0</li>
        </ul>
     </div>
	<!--全键盘搜索-->
    <div id="leftSearch" class="overflowK leftSearch" style="display:block;">
    	<ul class="keyCol">
        	<li class="keyRow">A</li>
        	<li class="keyRow">F</li>
        	<li class="keyRow">K</li>
        	<li class="keyRow">P</li>
        	<li class="keyRow">U</li>
        	<li class="keyRow">Z</li>
        </ul>
        
        <ul class="keyCol">
        	<li class="keyRow">B</li>
        	<li class="keyRow">G</li>
        	<li class="keyRow">L</li>
        	<li class="keyRow">Q</li>
        	<li class="keyRow">V</li>
        	<li class="keyRow" attr="123"><img src="ln-images-hd/123.png"></li>
        </ul>
        
        <ul class="keyCol">
        	<li class="keyRow">C</li>
        	<li class="keyRow">H</li>
        	<li class="keyRow">M</li>
        	<li class="keyRow">R</li>
        	<li class="keyRow">W</li>
        	<li class="keyRow" attr="del"><img src="ln-images-hd/del.png"></li>
        </ul>
        
        <ul class="keyCol">
        	<li class="keyRow">D</li>
        	<li class="keyRow">I</li>
        	<li class="keyRow">N</li>
        	<li class="keyRow">S</li>
        	<li class="keyRow">X</li>
        	<li class="keyRow" attr="delAll"><img src="ln-images-hd/delAll.png"></li>
        </ul>
        
        <ul class="keyCol">
        	<li class="keyRow">E</li>
        	<li class="keyRow">J</li>
        	<li class="keyRow">O</li>
        	<li class="keyRow">T</li>
        	<li class="keyRow">Y</li>
        	
        </ul>
    </div>
    
    <!--切换输入法-->
    <div class="switch">
		 <ul class="switchCol">
        	<li class="switchRow" attr="t9KeyPro" id="t9KeyB">按节目搜索28</li>
        	<li class="switchRow" attr="allKey">全键盘</li>
        	
        </ul>
		<ul class="switchCol">
        	<li class="switchRow" attr="t9KeyPer" id="t9KeyB">按人名搜索</li>
        	<li class="switchRow" attr="t9Key">九宫格</li>
        </ul>
        <!-- <ul class="switchCol">
        	<li class="switchRow" attr="allKey">全键盘</li>
        </ul>
        <ul class="switchCol">
        	<li class="switchRow" attr="t9Key">九宫格</li>
        </ul> -->
    </div>
    
    <!--输入法选中状态-->
    
    
    <!--右侧默认热门搜索结果-->
    <div class="defaultResult" id="defaultResult" style="width:800px;text-align:center">
	<h3>大家都在搜</h3>
    		<div class="part-list"><!-- 列表展示容器开始 -->
				<div class="program-list"><!-- 列表容器开始 -->
					<div style="float: left;width: 800px;">
						<div class="program" id="turl1">
							<img src="images/p1.jpg" width="140px" height="200px" alt="" id="spic-1">
							<div class="program-sel dn">
								<img src="images/p1.jpg" width="156px" height="225px" alt="" id="bpic-1">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word1">羞羞的铁拳的羞羞</p>
							    </div>
							</div>
						</div>
						<div class="program" id="turl2">
							<img src="images/p2.jpg" width="140px" height="200px" alt="" id="spic-2">			
							<div class="program-sel dn">
								<img src="images/p2.jpg" width="156px" height="225px" alt="" id="bpic-2">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word2">和平饭店和平</p>
							    </div>
							</div>
						</div>
						<div class="program" id="turl3">
							<img src="images/p1.jpg" width="140px" height="200px" alt="" id="spic-3">
							<div class="program-sel dn">
								<img src="images/p1.jpg" width="156px" height="225px" alt="" id="bpic-3">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word3">头号玩家，头号玩家</p>
							   </div>								
							</div>
						</div>
						<div class="program" id="turl4">
							<img src="images/p2.jpg" width="140px" height="200px" alt="" id="spic-4">
							<div class="program-sel dn">
								<img src="images/p2.jpg" width="156px" height="225px" alt="" id="bpic-4">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word4">羞羞的铁拳</p>
							    </div>
							</div>
						</div>
					</div>
					<div style="float: left;width: 800px;margin-top: 20px;">
						<div class="program" id="turl5">
							<img src="images/p1.jpg" width="140px" height="200px" alt="" id="spic-5">
							<div class="program-sel dn">
								<img src="images/p1.jpg" width="156px" height="225px" alt="" id="bpic-5">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word5">12345677</p>
							    </div>
							</div>
						</div>
						<div class="program" id="turl6">
							<img src="images/p2.jpg" width="140px" height="200px" alt="" id="spic-6">			
							<div class="program-sel dn">
								<img src="images/p2.jpg" width="156px" height="225px" alt="" id="bpic-6">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word6">12345677</p>
							    </div>
							</div>
						</div>
						<div class="program" id="turl7">
							<img src="images/p1.jpg" width="140px" height="200px" alt="" id="spic-7">
							<div class="program-sel dn">
								<img src="images/p1.jpg" width="156px" height="225px" alt="" id="bpic-7">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word7">12345677</p>
							    </div>
							</div>
						</div>
						<div class="program" id="turl8">
							<img src="images/p2.jpg" width="140px" height="200px" alt="" id="spic-8">
							<div class="program-sel dn">
								<img src="images/p2.jpg" width="156px" height="225px" alt="" id="bpic-8">
							</div>
							<div class="word">
								<div class="inner">
							      	<p id="word8">1234567778899994564!!!</p>
							    </div>
							</div>
						</div>
					</div>
				</div><!-- 列表容器结束 -->
			</div><!-- 列表展示容器结束 -->
			
			</div>
    </div>
    
    <!--搜索结果-->
    <div class="Result" style="display:none" id="Result">
    	<h3><p>全部</p><i>搜索结果<span id="tolnum">186</span></i></h3>
        <div style="height:625px; overflow:hidden; position:relative; top:45px;">
    	<div class="ResultCol" id="ResultCol">
        	<!--<div class="ResultRow" Sname="布鲁克林" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的..."></div>
        	<div class="ResultRow" Sname="爱情公寓3" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">爱情公寓3</div>
        	<div class="ResultRow" Sname="美人鱼" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">美人鱼</div>
        	<div class="ResultRow" Sname="我去上学啦第2季" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">我去上学啦第2季</div>
        	<div class="ResultRow" Sname="奔跑吧兄弟 第四季" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">奔跑吧兄弟 第四季</div>
        	<div class="ResultRow" Sname="大王叫我来巡山" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">大王叫我来巡山</div>
        	<div class="ResultRow" Sname="社会摇" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">社会摇</div>
        	<div class="ResultRow" Sname="忍者神龟：变种时代" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">忍者神龟：变种时代</div>
            <div class="ResultRow" Sname="爱情公寓3" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">爱情公寓3</div>
        	<div class="ResultRow" Sname="美人鱼" Sedit="约翰·克劳利" Srole="西尔莎·罗南 / 多姆纳尔·格里森 / 艾莫里· ..." Sabout="艾莉丝（西尔莎·罗南 Saoirse Ronan 饰）离开了故乡，离开了母亲和姐姐，前往美国寻找更多的...">美人鱼</div>-->
        </div>
        </div>
    </div>
    
    <!--搜索结果分类-->
    <div id="resultClass" class="resultClass">
    	<ul class="resultClassCol">
        	<li class="resultClassRow"><p class="p">全部(<span id="tolnum1"></span>)</p></li>
        	<!--<li class="resultClassRow"><p>电影<span>(28)</span></p></li>-->
        	<!--<li class="resultClassRow"><p>电视剧<span>(3)</span></p></li>-->
        	<!--<li class="resultClassRow"><p>综艺<span>(0)</span></p></li>-->
        	<!--<li class="resultClassRow"><p>动漫<span>(0)</span></p></li>-->
        </ul>
    </div>
    
    <!--没有搜索结果-->
    <div id="NoResult" style="display:none">
    	<h3>搜索结果0个</h3>
    	<p>对不起没有找到与<span id="sosoword">xxxxxx</span>匹配的相关内容</p>
    </div>
    <script type="text/javascript" src="js/md5.js"></script>
	<script src="ln-js-hd/keyPress.js" charset="utf-8"></script>
	<script src="ln-js-hd/util.js" charset="utf-8"></script>
    <script src="ln-js-hd/serach_zt_serial.js" charset="utf-8"></script>
	<script src="http://218.24.37.2:81/templets/epg/js/data/ad/iptv_zyhpzq.js" charset="GB2312"></script>
</body>
</html>