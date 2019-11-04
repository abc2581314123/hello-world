<%@ page contentType="text/html; charset=GBK" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zte.iptv.epg.content.FirstPageInfoList" %>
<%@ page import="com.zte.iptv.newepg.datasource.EpgFirstPageDatasource" %>
<%@ page import="com.zte.iptv.epg.web.FirstPageInfoQueryValueIn" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.epg.web.Result" %>
<%@ page import="com.zte.iptv.epg.content.ChannelInfo" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="com.zte.iptv.epg.content.VoDQuery" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.zte.iptv.epg.content.*" %>
<%!

    public String getPath(String uri) {
        String path = "";
        int begin = 0;
        int end = uri.lastIndexOf('/');
        if (end > 0) {
            path = uri.substring(begin, end + 1) + path;
        }
        return path;
    }
%>
<%!
String replace(HttpServletRequest req, String expression)
{
	String ret = expression;
	if(ret == null) return "";
		UserInfo userInfo = (UserInfo)req.getSession().getAttribute(EpgConstants.USERINFO);
		String pathTemp = PortalUtils.getPath(req.getRequestURI(), req.getContextPath());
		HashMap paramTemp = PortalUtils.getParams(pathTemp, "GBK");
		String backepgurl = req.getRequestURL().toString();
		ret = ret.replaceAll("\\{framedir\\}", userInfo.getUserModel());
		ret=ret.replaceAll("\\{frameid\\}",userInfo.getUserModel().substring(5,userInfo.getUserModel().length()));
		ret = ret.replaceAll("\\{epgIp\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{epgip\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{stbId\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{stbid\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{userId\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userid\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userToken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{usertoken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{userTokenExpiretime\\}", userInfo.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{usertokenexpiretime\\}", userInfo.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{areaCode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{areacode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{returnUrl\\}", backepgurl);
		ret = ret.replaceAll("\\{returnurl\\}", backepgurl);
		return ret;
}
String getinfo(HttpServletRequest req)
{
	  //update by qiaolinqiang 20160125
	  UserInfo iaspuserInfo = (UserInfo)req.getSession().getAttribute(EpgConstants.USERINFO);
	  String iaspadsl = "";
	  iaspadsl = iaspuserInfo.getAccountNo();//Â¿Ã­Â´Ã¸Ã•Ã‹ÂºÃ…
	  String iaspmac = ""; 
	  iaspmac = iaspuserInfo.getStbMac();//MACÃÃ…ÃÂ¢
	  String iaspip = ""; 
	  iaspip = iaspuserInfo.getUserIP();//IPÃÃ…ÃÂ¢
	  String  iaspuserid = "";
	  iaspuserid = iaspuserInfo.getUserId();//Ã“ÃƒÂ»Â§ÃÃ…ÃÂ¢
	  //update by qiaolinqiang 20160125
	   String returnstr="&iaspmac="+iaspmac+"&iaspip="+iaspip+"&iaspuserid="+iaspuserid;
		return returnstr;
}
            /**
         *ÃÂ¨Â¹Ã½httpÂ¾Ã¸Â¶Ã”Ã‚Â·Â¾Â¶Â»Ã±ÃˆÂ¡frameÂºÃ…
         * @param reqURI  Ã‡Ã«Ã‡Ã³Â¾Ã¸Â¶Ã”Ã‚Â·Â¾Â¶ http://
         * @return framexxxx
         */
    String getHTTPFrameCode(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);
        return reqURI.substring(start, end);
    }
%>
<%
    String path = getPath(request.getRequestURI());
    String isFromTvod = String.valueOf(request.getParameter("programid"));
	String mixno = String.valueOf(request.getParameter("mixno"));
	String chennelName = request.getParameter("channelname");
	String temstr = getinfo(request);
          UserInfo iaspuserInfo1 = (UserInfo)request.getSession().getAttribute(EpgConstants.USERINFO);

      String  iaspuserid1 = "";
      iaspuserid1 = iaspuserInfo1.getUserId();
    String areaId = iaspuserInfo1.getAreaNo();
    String stbId = iaspuserInfo1.getStbId();
    String iaspmac1 = ""; 
    iaspmac1 = iaspuserInfo1.getStbMac();//MACÃÃ…ÃÂ¢
    String iaspip1 = ""; 
    iaspip1 = iaspuserInfo1.getUserIP();//IPÃÃ…ÃÂ¢
	String showid=request.getParameter("channelid");

%>
<%
    String pushtype = String.valueOf(session.getAttribute("pushportal"));
    if ("null".equals(pushtype) || "1".equals(pushtype)) { //Â½Â«pushportalÃ‰Ã¨Ã–ÃƒÃŽÂª0Â£Â¬Ã’Ã”ÂºÃ³Â²Â¥Â·Ã…Ã†ÂµÂµÃ€Â¾ÃÂ²Â»Ã‘Â¹portal.jsp
        session.setAttribute("pushportal", "0");
%>





<%} else { %>
<epg:PageController/>
<%}%>




<html>
<head>
	<meta name="page-view-size" content="640*530" />
    <title>control_transit_play.jsp</title>
<script language="javascript" type="text/javascript">
		//Ã…ÃÂ¶ÃÃ†ÂµÂµÃ€ÃŠÃ‡Â·Ã±ÃÃ¨Ã’ÂªÃ”Ã¶Ã–Âµ
	
	function panduanCanplay(channelnum){



	    var isfourk = "";
		var fourkbox = "B860AV1.1,IP903H_05U1,E900,HG680-JLK9H-42,EC6108V9U_pub_sdllt,HG680-L";
		 if ('CTCSetConfig' in Authentication) {
        		isfourk = Authentication.CTCGetConfig("STBType");
        }else{
            	isfourk = Authentication.CUGetConfig("STBType");
        }
		if(channelnum==951){
			return false;
		}else if(channelnum==888||channelnum==889){	
			if(fourkbox.indexOf(isfourk)>-1){
				 return true;
			}else{
			return false;
			}
           
		}else{
			   return true;
		}




	}



	</script>
</head>
<body>
<!-- 首次进入提醒 -->

<div id="firstvod" style="background: url('./playimages/last_quit.png'); width: 365px; height: 220px; position: absolute;margin: auto; top: 0; left: 0; bottom: 0; right: 0; color: #fff; font-size: 36px; text-align: center; line-height: 220px;">按OK键可查看节目单</div> 
<script language="javascript" type="text/javascript">
	var channum = '<%=mixno%>';

	var canplay = panduanCanplay(channum);	
    var channelName1 = '<%=chennelName%>';
		
		
    var isFromTvod = "<%=isFromTvod%>";
    top.jsClearVideoKeyFunction();
    var functionKeyUrl = "<%=path%>portal_key.jsp?Action=";
    function channelPlayStop() {



        var zbBackUrl = getCookie("zbBackUrl");



        if( undefined != zbBackUrl && null !=zbBackUrl && ""!=zbBackUrl && "null"!=zbBackUrl){
            setCookie('zbBackUrl',"");


            clearTimeout(timerLoadData);
            top.doStop();
            top.setBwAlpha(0);
            top.mainWin.document.location = zbBackUrl;

        }
    }






    function donothing() {
        alert("11111111111");
        return false;
    }
    if (iSTB && isFromTvod != "null") {
        //ÃŠÃŠÃ…Ã¤ÃÂªÃÂ¨Ã‰ÃÃÃ‚Â¼Ã¼Â²Ã™Ã—Ã·  Â²Â»ÃÂ¸Â´Â«Â¼Ã¼Ã–ÂµÂµÂ½Ã¤Â¯Ã€Ã€Ã†Ã·
        top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.onKeyUp%>);
        top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.onKeyDown%>);
    }



    top.jsSetVideoKeyFunction("top.extrWin.channelPlayStop", <%=STBKeysNew.remoteStop%>);
    top.jsSetVideoKeyFunction("top.extrWin.channelPlayStop", <%=STBKeysNew.remoteBack%>);
	top.jsSetVideoKeyFunction("top.extrWin.channelPlayStop2Back1", <%=STBKeysNew.remoteBack%>);
	top.jsSetVideoKeyFunction("top.extrWin.channelPlayStop", 24);
    top.jsSetVideoKeyFunction("top.extrWin.FastForword", <%=STBKeysNew.remoteFastForword%>);
    top.jsSetVideoKeyFunction("top.extrWin.FastForword", <%=STBKeysNew.onKeyRight%>);
    top.jsSetVideoKeyFunction("top.extrWin.FastRewind", <%=STBKeysNew.remoteFastRewind%>);
    top.jsSetVideoKeyFunction("top.extrWin.FastRewind", <%=STBKeysNew.onKeyLeft%>);



 
   function channelPlayStop2Back1(){
       // å…šå»ºç›´æ’­è¿”å›ž

            //ÃÃ‚ÃŒÃ­Â¼Ã“Â»Ã˜Â¿Â´ÃŒÃ¸Ã—ÂªÂ·ÂµÂ»Ã˜ 03-04 rendd
        var zbBackUrl = getCookie("zbBackUrl");


       // if( undefined != back_detail_url || null !=back_detail_url || ""!=back_detail_url||"null"!=back_detail_url){
        if( undefined != zbBackUrl && null !=zbBackUrl && ""!=zbBackUrl && "null"!=zbBackUrl){  
            setCookie('zbBackUrl',"");  
            clearTimeout(timerLoadData);
            top.doStop();
            top.setBwAlpha(0);
            top.mainWin.document.location = zbBackUrl;

        }

}

    
   


       
    function FastForword() {





        alert("================Â£Â¨top.currStateÂ£Â©" + top.currState)
        if (top.currState == 1 || top.currState == 7 || top.currState == 8 || top.currState == 10 || top.currState == 3) {
            top.mainWin.document.location = "<%=path%>speedOSD.jsp?fast=FF";
            top.showOSD(2, 0, 0);
            top.setBwAlpha(0);
        } else if (top.currState == 2 || top.currState == 4) {


            var currCh = parseInt(top.channelInfo.currentChannel);
            if (top.channelInfoArr[currCh] == undefined || top.channelInfoArr[currCh] == null) {
                return false;
            }
            if (top.isSupportTSTV() == 0) {
                return false;
            }
            if (top.channelInfoArr[currCh].timeShift == 1) {

                top.getTSTVTime();
                var TSTVCurrentTimeM = parseInt(top.TSTVCurrentTime.getTime() / 1000);
                var TSTVEndTime = parseInt(top.TSTVEndTime.getTime() / 1000);
                alert("(TSTVCurrentTimeM)" + TSTVCurrentTimeM + "(TSTVEndTimeM)" + TSTVEndTime)
                if (TSTVCurrentTimeM < TSTVEndTime) {
//                doFastRewind(speed);
//                showLiveSpeedOSD("RR");
                    alert("ffffffffffffffffffffffffffffffffffffffffffff")
                    top.mainWin.document.location = "<%=path%>liveSpeedOSD.jsp?fast=FF";
                    top.showOSD(2, 0, 0);
                    top.setBwAlpha(0);
                }
            }
        }
    }



    function FastRewind() {




        alert("================Â£Â¨top.currStateÂ£Â©" + top.currState)
        if (top.currState == 1 || top.currState == 7 || top.currState == 8 || top.currState == 10 || top.currState == 3) {
            top.mainWin.document.location = "<%=path%>speedOSD.jsp?fast=RR";
            top.showOSD(2, 0, 0);
            top.setBwAlpha(0);
        } else if (top.currState == 2 || top.currState == 4) {

            var currCh = parseInt(top.channelInfo.currentChannel);
            if (top.channelInfoArr[currCh] == undefined || top.channelInfoArr[currCh] == null) {
                return false;
            }
            if (top.isSupportTSTV() == 0) {
                return false;
            }
            if (top.channelInfoArr[currCh].timeShift == 1) {
                top.speed = -2;
                if (window.navigator.appName.indexOf("ztebw") >= 0) {
                    top.speed = -top.speed;
                }
                top.getTSTVTime();
                var TSTVCurrentTimeM = parseInt(top.TSTVCurrentTime.getTime() / 1000);
                var TSTVBeginTimeM = parseInt(top.TSTVBeginTime.getTime() / 1000);
                if (TSTVCurrentTimeM > TSTVBeginTimeM) {
//                doFastRewind(speed);
//                showLiveSpeedOSD("RR");
                    alert("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr")
                    top.mainWin.document.location = "<%=path%>liveSpeedOSD.jsp?fast=RR";
                    top.showOSD(2, 0, 0);
                    top.setBwAlpha(0);
                }
            }


//    alert("----------------=================================-------------"+top.getStbPlaySpeed());
//    alert("----------------=================================-------------"+top.vodspeedarr.length);
//    top.showSpeedOSD("FF");
        <%--top.mainWin.document.location = "<%=path%>liveSpeedOSD.jsp?fast=RR";--%>
        <%--top.showOSD(2, 0, 0);--%>
        <%--top.setBwAlpha(0);--%>
        }
    }


    function doF1() {
        doFunctionKeyToStopVideo();
        functionKeyUrl = functionKeyUrl + "1";
        top.mainWin.document.location = functionKeyUrl;
        return false;
    }

    function doF2() {
        doFunctionKeyToStopVideo();
        functionKeyUrl = functionKeyUrl + "2";
        top.mainWin.document.location = functionKeyUrl;
        return false;
    }

    function doF3() {
        doFunctionKeyToStopVideo();
        functionKeyUrl = functionKeyUrl + "3";
        top.mainWin.document.location = functionKeyUrl;
        return false;
    }

    function doF4() {
        doFunctionKeyToStopVideo();
        functionKeyUrl = 'mySpace.jsp?mflag=myspace&leefocus=leftllinker11';
        top.mainWin.document.location = functionKeyUrl;
        return false;
    }

    function doFunctionKeyToStopVideo() {
        top.jsHideOSD();
        top.doStop();
        top.setBwAlpha(0);
        // top.switchToStopUrl();
    }


	 function keyOk() {

		
	    top.mainWin.document.location = "<%=path%>player.jsp?ChannelId="+channum+"&showid=<%=showid%>";
              top.showOSD(2, 0, 0);

		
	 }



       function H5_spstatistics(channelNum){
        var adlog ="";
var GOTOType1 =Authentication.CTCGetConfig("STBType");
        if(GOTOType1.indexOf("B860AV1.1")>=0 ||GOTOType1.indexOf("HG680-RLK9H-12")>=0||GOTOType1.indexOf("EC6108V9")>=0||GOTOType1.indexOf("E900")>=0||GOTOType1.indexOf("EC6109U")>=0){        
    
         adlog ='http://202.97.183.77:91/loginterface/irts?platform=zx&version=1.5&userId=<%=iaspuserid1%>&rtsType=2&contentId='+channelNum;
        
        }else{
         adlog ='http://202.97.183.77:91/loginterface/irts?platform=zx&version=1.0&userId=<%=iaspuserid1%>&rtsType=2&contentId='+channelNum;
        }
        
        var xmlhttpforadlog; 
             if (window.XMLHttpRequest) 
             { 
                  xmlhttpforadlog   =   new   XMLHttpRequest(); 
             } 
             else if (window.ActiveXObject) 
             { 
                  xmlhttpforadlog   =   new   ActiveXObject("Microsoft.XMLHTTP"); 
             } 
             
             xmlhttpforadlog.open("GET",adlog, true); 
             xmlhttpforadlog.onreadystatechange = handlelogResponse1; 
             xmlhttpforadlog.setRequestHeader("If-Modified-Since", "0");
             xmlhttpforadlog.send(null); 
  
   }
               function spstatistics(){
            var boxType = Authentication.CTCGetConfig("STBType");

        var hdType = "1";

        var boxCity = "<%=areaId%>";

        var stbId = "<%=stbId%>";
        var pageID="control_transit_vodplay.jsp";
        
        
        
        var adlog= 'http://218.24.37.2/templets/epg/spstatistics_HD.jsp?deviceToken=<%=iaspuserid1%>&iaspip=<%=iaspip1%>&iaspmac=<%=iaspmac1%>&boxType='+boxType+'&hdType='+hdType+'&boxCity='+boxCity+'&stbId='+stbId+'&pageID='+pageID+'&orignal=5&categoryType=1';
        
        
        
        var xmlhttpforadlog; 
             if (window.XMLHttpRequest) 
             { 
                  xmlhttpforadlog   =   new   XMLHttpRequest(); 
             } 
             else if (window.ActiveXObject) 
             { 
                  xmlhttpforadlog   =   new   ActiveXObject("Microsoft.XMLHTTP"); 
             } 
             
             xmlhttpforadlog.open("GET",adlog, true); 
             xmlhttpforadlog.onreadystatechange = handlelogResponse1; 
             xmlhttpforadlog.setRequestHeader("If-Modified-Since", "0");
             xmlhttpforadlog.send(null); 
  
   }
              function handlelogResponse1() 
             { 
                 if(xmlhttpforadlog.readyState == 4 && xmlhttpforadlog.status==200) 
                 { 
                 } 
             }
	var  Clearh5Time = "";
    function H5_onload(channelNum1){
            if(Clearh5Time!= "")

        {

            clearTimeout(Clearh5Time);

        }
 Clearh5Time =  setTimeout("H5_spstatistics("+channelNum1+")",300000);
    } 



	function setCookie(name,value)
	{
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
 
	top.jsSetVideoKeyFunction("top.extrWin.keyOk", <%=STBKeysNew.onKeyOK%>);
	
</script>
<script type="text/javascript">


window.onload = function(){

  if(Authentication.CTCGetConfig("ZbType")=="true"){
    Authentication.CTCSetConfig("ZbType","false");
              top.setBwAlpha(0);    
              top.mainWin.document.location = "<%=path%>zb_init.jsp";
              top.showOSD(2, 3, 0);

              

}

}



</script>
</body>
</html>
