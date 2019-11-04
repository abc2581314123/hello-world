<%@ page contentType="text/html; charset =UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="ShowException.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<%@ include file = "SubStringFunction.jsp"%>
<html>
<script type="text/javascript">
    iPanel.focusWidth = "4";
    iPanel.defaultFocusColor = "#FCFF05";
</script>
<%
    TurnPage turnPage = new TurnPage(request);
    //PLAY_FATHERID
    String strTypeId = request.getParameter("TYPE_ID"); //当前播放完毕vodid
    String strFilmId = request.getParameter("FILM_ID"); //当前播放完毕vodid
    String isSitcom = request.getParameter("isSitcom"); //是否连续剧
    String nextEpisId = request.getParameter("nextEpisId"); //下一集id -1 时没有连续剧
    String nextSitnum = request.getParameter("nextSitnum"); //下一集集号
    String superVodID = request.getParameter("superVodID");
	
	String comeFrom = request.getParameter("FROM")== null ? "-1":request.getParameter("FROM"); //tongNian:金色童年栏目,xinWen:新闻频道栏目
	String nextFinishId = request.getParameter("nextFinishId")== null ? "-1":request.getParameter("nextFinishId");
	String nextFinishFatherId = request.getParameter("nextFinishFatherId")== null ? "-1":request.getParameter("nextFinishFatherId");
		
    String strFatherId = "";
    String vodName = "";
    int flag = 0;
    int fatherId = -1;
    String desc = "谢谢观赏！";
    if("1".equals(isSitcom) && !"-1".equals(nextEpisId)) //判断是否最后一集
    {
        flag = 1;
    }
	
    String nextSitcomUrl = "";
    String nextSitcomId = nextEpisId;
    if(flag == 1)
    {
        nextSitcomUrl = "au_PlayFilm.jsp?TYPE_ID=" + strTypeId + "&PROGID=" + nextSitcomId
                 + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_VOD + "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_VOD_VIDEO
                 + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD
                 +"&FATHERSERIESID="+superVodID+"&FROM="+comeFrom;
    }
	else if((comeFrom.equals("tongNian") || comeFrom.equals("xinWen")||comeFrom.equals("liaoNing"))&& !nextFinishId.equals("-1")) //tongNian:金色童年栏目,xinWen:新闻频道栏目,liaoNing:辽宁
	{
		 flag = 2;
		 nextSitcomUrl = "au_PlayFilm.jsp?TYPE_ID=" + strTypeId + "&PROGID=" + nextFinishId
                 + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_VOD + "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_VOD_VIDEO
                 + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD
                 +"&FATHERSERIESID="+nextFinishFatherId+"&FROM="+comeFrom;
	}

     //Modified by Caiyuhong 2008-06-24------------------------------------------------------------
    String backurl   = "";
	  String returnUrl = "";
    if (session.getAttribute("vas_back_url") != null && !"".equals(session.getAttribute("vas_back_url"))) {
        backurl = "backToVis.jsp";
        if (session.getAttribute("omitThanksPage") != null &&
                ((Integer) session.getAttribute("omitThanksPage")).intValue() == 1) {
%>
<script type="text/javascript">
    window.location.href = '<%=backurl%>';
</script>
<%
        }
    }
    if (!"".equals(backurl)) returnUrl = backurl;
    else returnUrl = turnPage.go(0);
	
    //将返回页替换
    if(returnUrl.indexOf("programDetail_xj.jsp")>=0)
    {
    	returnUrl=returnUrl.replace("programDetail_xj.jsp", "programDetail.jsp");
    }
    if(returnUrl.indexOf("newfilmDetail_pro")>=0)
    {
    	returnUrl=returnUrl.replace("newfilmDetail_pro.jsp", "newfilmDetail.jsp");
    }
    
	String spbackurl = request.getParameter("backurl");
	if(spbackurl != null && !"".equals(spbackurl)){
		returnUrl = spbackurl;
		backurl = spbackurl;
	}
%>

<style type="text/css">
<!--
.STYLE1 {
	font-size: 24px;
	color: #FFFFFF;
}
.STYLE2 {
	font-size: 24px;
	color: #C29D07;
}
.STYLE3 {
	font-size: 24px;
	color: #3399FF;
}
-->
</style>
<head>
<title>InfoDisplay</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
	var flag = <%=flag%>;
	var second = 8;
	var intervalId = 0;
    document.onirkeypress = keyevent ;
    document.onkeypress = keyevent;

    function keyevent()
    {
        var val = (event.keyCode == undefined) ? event.which:event.keyCode;
        return keypress(val);
    }

    function keypress(keyval)
    {
    	 // clearAll();
        switch(keyval)
        {
            case <%=KEY_BACKSPACE%>://回退键和返回键同样处理
            case <%=KEY_RETURN%>:
                goBack();
                return 0;
           default:
				return videoControl(keyval);
        }
        return 1;

    }

    function goBack()
    {
		clearInterval(intervalId);
    	window.location.href = "<%=returnUrl%>";
    }


    //下一集
    function playNextSitcom()
    {
      if(3 == flag)
      {
      
        document.getElementById("nextDiv").style.display = "none";
        document.getElementById("nextVipPop").style.display = "block";  

        document.getElementById("backq").focus(); 
        return;    
      }

		    clearInterval(intervalId);
        window.location.href = "<%=nextSitcomUrl%>";
    }  
	
  //初始化
    function init()
    {

      getAuthenticationData();
     

	  if(1 == flag) 
	  {
		  second = 8;
		  document.getElementById("nextDiv").style.display = "block";
		 intervalId =  setInterval((function()
					   {
						   	second--;
					    	document.getElementById("second").innerHTML = second;
							if(second == 0)
							{
								playNextSitcom();  //8秒后播放下一集
							}
					   }),1000);
	  }
	  else if(2 == flag)
	  {
		   second = 3;
		  document.getElementById("nextFilm").style.display = "block";
		 intervalId =  setInterval((function()
					   {
						   	second--;
					    	document.getElementById("second2").innerHTML = second;
							if(second == 0)
							{
								playNextSitcom();  //3秒后播放下一条影片
							}
					   }),1000);
	  }	 



    //新添加0903连续剧结束判断 rendd
    else if(3 == flag)
    {
      document.getElementById("nextDiv").style.display = "block";
      //包含订购隐藏倒计时下一集回详情页
      document.getElementById("zdNext").innerHTML = '';
      document.getElementById("second").innerHTML = '';
       
      //如果是电视剧综艺混排、环球、世嘉TV电视剧点击的播放进入多集判断逻辑
       
    }
	  else
	  {

      
		  document.getElementById("finished").style.display = "block";
	  }
       
    }




  //判断下一集是否是免费剧集

  // add by rendd 20190902

  var freecount = 0;
  var orderUrl = "";
  var programnum = 0;

  //判断是否是需要订购的节目，节目付费鉴权标识0鉴权通过不走免费剧集判断逻辑按原播放逻辑走
 
//点击连续剧多集选择，存放页面标识，只有电视剧综艺混排和环球世嘉TV增加多集免费功能，控制播放
  var currentPage = ('CTCSetConfig' in Authentication)?Authentication.CTCGetConfig("currentPage"):Authentication.CUGetConfig("currentPage");
  currentPage = currentPage==null?"":currentPage;


  
  //获取缓存的多集信息
  function getAuthenticationData(){




  //如果是电视剧综艺混排、环球、世嘉TV电视剧点击的播放进入多集判断逻辑
  if(currentPage.indexOf("TV_zpage_one_dj")>-1||currentPage.indexOf("db_zpage_one_dj")>-1){



     var isPay = ('CTCSetConfig' in Authentication)?Authentication.CTCGetConfig("isPay"):Authentication.CUGetConfig("isPay");
      isPay = isPay==null?0:isPay;
    //订购节目
      if(isPay==1){
        try{
          if('CTCSetConfig' in Authentication) {
              freecount= Number(Authentication.CTCGetConfig("freecount"));
              orderUrl= Authentication.CTCGetConfig("backurl_video");
              programnum= Number(Authentication.CTCGetConfig("programnum"));
             }else{
              freecount =Number(Authentication.CUGetConfig("freecount"));
              orderUrl =Authentication.CUGetConfig("backurl_video");
              programnum = Number(Authentication.CUGetConfig("programnum"));
             }

         

             if(programnum+1>freecount-1){

                flag = 3;
             }
          }catch(e){

        } 
      }
      
    }
  }







  function goRedirectBack(){
      window.location.href = orderUrl.replace(/\*/g,"&");
   }

</script>


<body leftmargin="0" topmargin="0" class="unnamed1" onLoad="init()"  bgcolor="transparent">



<div id="nextDiv" style="background:url(images/playcontrol/playTvod/quit.jpg); width:380px;height:262px; left:130px; top:100px; position:absolute; font-size:22px; color:#FFFFFF; display:none;">



	<div style="position:absolute;left:74px;top:40px;width:230px;height:40px;">您是否继续收看下一集?</div>
	<div style="position:absolute;left:80px;top:110px;width:80px;height:40px"><a href="javascript:playNextSitcom()"><img src="images/link-dot.gif" width="80" height="40"></a></div>
   <div style="position:absolute;left:210px;top:110px;width:80px;height:40px"><a href="javascript:goBack()"><img src="images/link-dot.gif" width="80" height="40"></a></div>
   <div style="position:absolute;left:86px;top:121px;width:80px;height:40px">下一集</div>
 	 <div style="position:absolute;left:227px;top:120px;width:81px;height:40px">退出</div>
  <div id="second" style="position:absolute; left:178px; top:120px; width:30px; height:40px">8</div>
   <div id = "zdNext" style="position:absolute; left:91px; top:182px; width:208px; height:29px; font-size:20px;">8秒后自动进入下一集</div>
</div>

<div id="finished" style="background:url(images/playcontrol/playVod/playFinished.jpg); width:380px; height:214px; left:130px; top:100px; position:absolute; font-size:40px; color:#FFFFFF; display:none;">
   <div style="position:absolute; left:75px; top:44px; width:210px; height:60px"><a href="javascript:goBack()"><img src="images/link-dot.gif" width="210" height="60"></a></div>
  <div style="position:absolute;left:100px;top:52px;width:194px;height:47px">播放结束</div>
	<div style="position:absolute; left:15px; top:120px;"> <img src="images/playcontrol/playTvod/poster.gif" height="84px" width="348px" /> </div>
</div>
  <!--------------------------------------------------------------> 
  <!--新闻频道,金色童年栏目下的影片结束层-->
  <div id="nextFilm" style="background:url(images/playcontrol/playTvod/quit.jpg); width:380px;height:262px; left:130px; top:100px; position:absolute; font-size:22px; color:#FFFFFF; display:none;">
	<div style="position:absolute;left:74px;top:40px;width:230px;height:40px;">您是否继续收看下一条?</div>
	<div style="position:absolute;left:80px;top:110px;width:80px;height:40px"><a href="javascript:playNextSitcom()"><img src="images/link-dot.gif" width="80" height="40"></a></div>
   <div style="position:absolute;left:210px;top:110px;width:80px;height:40px"><a href="javascript:goBack()"><img src="images/link-dot.gif" width="80" height="40"></a></div>
   <div style="position:absolute;left:86px;top:121px;width:80px;height:40px">下一条</div>
 	 <div style="position:absolute;left:227px;top:120px;width:81px;height:40px">退出</div>
  <div id="second2" style="position:absolute; left:178px; top:120px; width:30px; height:40px">3</div>
   <div style="position:absolute; left:91px; top:182px; width:208px; height:29px; font-size:20px;">3秒后自动进入下一条</div>
</div>





<!-- 2019-09-02vip弹出 -->
<div id="nextVipPop">
  <p>免费剧集观看结束,继续观看请返回后"订购"</p>
  <a style=" margin: auto; display:block;" id = "backq" href="javascript:goRedirectBack()"><img src="images/backend.jpg"></a>
</div>




<style>
  #nextVipPop {
    height: 360px;
    position: absolute;
    
    margin:auto;
    top: 150px;
    width: 640px;
    text-align: center;
    background:#999;
    display:none;
  }
  #nextVipPop p {
    color: #fff;
    width: 100%;
    text-align: center;
    margin-top: 80px;
    font-size: 28px;
    margin-bottom: 40px;
  }

</style>
</body>
</html>
