<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="com.zte.iptv.epg.utils.Utils" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.epg.content.*" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@ page import="com.zte.iptv.newepg.datasource.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zte.iptv.newepg.decorator.ChannelDecorator" %>
<%@ page import="com.zte.iptv.epg.web.*" %>
<%@page contentType="text/html; charset=GBK" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%



  String  mixno = request.getParameter("mixno");
  String zbBackUrl = request.getParameter("backUrl");
%>
<html>
<head>
	<meta name="page-view-size" content="640*530" />
    <title>11</title>
</head>
<body>

</body>
<script type="text/javascript">
  var zbBackUrl = "<%=zbBackUrl%>";


  
function playchannel(){
	setCookie("zbBackUrl",zbBackUrl);
    setCookie("zbFlag","ture");
	window.location.href = "channel_detail.jsp?mixno=<%=mixno%>";
}
window.onload = function(){
  setCookie("zbBackUrl",zbBackUrl);
  setCookie("zbFlag","ture");
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
