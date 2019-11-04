<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="datajsp/vod_IfilmListData-db.jsp"%>
<%
String iaspuserid = request.getParameter("iaspuserid");
String iaspmac = request.getParameter("iaspmac");
String stbId = request.getParameter("stbId");
String areaId = request.getParameter("areaId");
 session.setAttribute("abc","abc1");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="page-view-size" content="640*530" />
<title>Insert title here</title>
</head>
<style>
	body{
		width:640px;
		height:530px;
	}
	#div1{
		width:640px;
		height:530px;
		float:left;
	}
	.showPicDiv1{
		/* position:absolute;
		right:10px;
		top:10px; */
		float:right;
		margin-right:10px;
		margin-top:-520px;
		width:200px;
		height: 40px;
		line-height: 40px;
		text-align: center;
		font-size: 22px;
		font-family: "微软雅黑";
		background-color: #0F0F0F;
		opacity: 0.6;
		color: #FFFFFF;
	}
	.showPicSpan{
		color: #FF0000;
	}
</style>







<body>
<div id="div1">
<img src="" width="640px" height="530px" />
</div>
<div class="showPicDiv1"></div>
</body>
<script type="text/javascript">
function showPro1(){
		var GOTOType =Authentication.CTCGetConfig("STBType");
			

        window.location.href="firstStartStb3.jsp";
	
}


	function whitePop(){
	 		var XMLHttpRequestObject = false;
				
	if (window.XMLHttpRequest) {
	


		XMLHttpRequestObject = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
	} 
	    var path;
		 path = "http://202.97.183.133:9091/userCitySearch/usercity?time="+time1+"&riddle="+riddle+"&userid=<%=iaspuserid%>";
			 XMLHttpRequestObject.open("GET", path,true);
			XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
 			XMLHttpRequestObject.onreadystatechange = function() {
 				if(XMLHttpRequestObject.readyState==4&&XMLHttpRequestObject.status==200){
            

				var dataValue1 = XMLHttpRequestObject.responseText;
 				var dataObj = "";
                 if(dataValue1 != null && dataValue1 != "") {
					 if(dataValue1!="null"){
						 dataObj = JSON.parse(dataValue1);
					     var dataPro = dataObj["citycode"];
					     if(dataPro=="210100"){
	window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";  
					     }else if(dataPro=="210200"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId1%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }else if(dataPro=="210300"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId2%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="210400"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId3%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="210500"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId4%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="210600"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId5%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="210700"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId6%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="210800"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId7%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="210900"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId8%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="211000"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId9%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="211100"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId10%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="211200"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId11%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="211300"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId12%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="211400"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId13%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }
					     else if(dataPro=="210000"){
window.location.href ="SaveCurrFocus_new.jsp?url=au_PlayFilm_new.jsp?PROGID=<%=vodId%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ONECEPRICE=0.0&TYPE_ID=-1&FATHERSERIESID=-1&FROM=-1";
					     }else if(dataPro=="110000"){
	     	
window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/vediopic_profession.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=hw";				     	
					     }else if(dataPro!="110000"&&Authentication.CTCGetConfig("STBType").indexOf("HG510PG")>=0){
   window.location.href = "category_Index_epg.jsp";
}else{
	window.location.href="category_Index_epghd_new.jsp?area=1";				     	
					     }

						

      




						}
					}
				}else{

					
					window.location.href = "category_Index_epghd_new.jsp?area=1";
				}
	
		

			}
			  XMLHttpRequestObject.send(null);
	}

	        function Z_porde(){
          var myDate = new Date();
           
var StartTime =  myDate.getFullYear()+"-"+myDate.getMonth()+"-"+ myDate.getDate()+"-"+ myDate.getHours()+":"+myDate.getMinutes()+":"+myDate.getSeconds();

         
        var mac ="<%=iaspmac%>";

        
            var boxType = Authentication.CTCGetConfig("STBType");
        var hdType = "2";
        var providerid="hw";
        var areaId = "<%=areaId%>";

 
        var adlog= "http://218.24.37.2/templets/epg/spstatistics_ZR.jsp?stbId="+boxType+"&mac="+mac+"&areaId="+areaId+"&providerid="+providerid+"&hdType="+hdType+"&StartTime="+StartTime;
        
        
        
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
             xmlhttpforadlog.onreadystatechange = handlelogResponse; 
             xmlhttpforadlog.setRequestHeader("If-Modified-Since", "0");
             xmlhttpforadlog.send(null); 
    }
     function handlelogResponse(){

    }

window.onload=function(){



Z_porde();
whitePop();




 
}
</script>
</html>