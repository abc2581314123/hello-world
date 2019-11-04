<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<%-- CreateAt:2009-02-06 --%>
<%-- FileName:ChanDirectAction.jsp --%>
<%-- 
	页面功能: 判断输入的屏道是否为标清。屏道是否存在。
--%>



<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%
  String chanNum = request.getParameter("chanNum");
  String backUrl = request.getParameter("backUrl");
%>
<html>
<head>
	<meta name="page-view-size" content="640*530" />
    <title>频道详细页面</title>
</head>
<body></body>
<script type="text/javascript">
	var backUrl = "<%=backUrl%>";
function playchannel(){
  setCookie("zbFlag","false");
setCookie("zbBackurl",backUrl);
	window.location.href = "ChanDirectAction.jsp?chanNum=<%=chanNum%>";
}
window.onload = function(){
  setCookie("zbFlag","false");
setCookie("zbBackurl",backUrl);
	playchannel();

}
    function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*30);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}


</script>
</html>