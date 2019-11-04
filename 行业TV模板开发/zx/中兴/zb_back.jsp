<%@page contentType="text/html; charset =UTF-8" language="java" pageEncoding="UTF-8" %>
<%
  String hdpath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getRequestURI();
%>

<head>
	<meta charset="UTF-8">  
	<title>播放页</title>
	<meta name="Page-View-Size" content="1280*720">
	<link rel="stylesheet" href="css/play/reset.css">
	<link rel="stylesheet" href="css/play/common.css">
	<link rel="stylesheet" href="css/play/menu.css">
	<link rel="stylesheet" href="css/play/vol.css">
	<link rel="stylesheet" href="css/play/playbar.css">
	<link rel="stylesheet" href="css/play/channel.css">
	
</head>
<body>


	<div id="apDiv14" style="display:block; left: 450px; top: 250px;">

  <table width="365" height="220" border="0" cellspacing="0" cellpadding="0" background="playimages/last_quit.png">

    <tr>

      <td height="220"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">

        <tr>

          <td id="apDiv141" height="45" colspan="4" align="center" class="allbb st" style="padding: 20px 0; color: #fff; font-size: 26px;">快捷入口</td>

        </tr>

        <tr>

          <td width="" height="70" rowspan="2" align="center">
          </td>

           <td align="center"><a href="javascript:jixu()" id="myplay" style="color: #fff;  background: #f8c64f; padding: 10px 33px;  font-size: 26px; display: inline-block;">辽视</a></td>

          <td align="center"><a href="javascript:tuichu()" style="color: #fff; background: #ff784e; padding: 10px 15px; font-size: 26px;  display: inline-block;">热门影视</a></td>

          <td width="" rowspan="2" align="center">          

          </td>


        </tr></table></td>

    </tr>

  </table>

<style>
  #apDiv14 {
  position:absolute;
  left:137px;
  top:150px;
  width:365px;
  height:220px;
  z-index:-1;
}
</style>
<script type="text/javascript">
  document.getElementById('myplay').onfocus();
  function tuichu(){
  	            top.doStop();
            top.setBwAlpha(0);
    top.mainWin.document.location = "http://218.24.37.2/templets/epg/Profession/list_vod.jsp?category_id=1037&providerid=zx&hdpath=<%=hdpath%>";
  }
  function jixu() {
  	            top.doStop();
            top.setBwAlpha(0);
    top.mainWin.document.location = "http://218.24.37.2/templets/epg/Profession/list_ln_vod.jsp?category_id=1002&providerid=zx&hdpath=<%=hdpath%>";
  }
</script>
<script src="js/play/extend.js"></script>
  <script src="js/play/common.js"></script>
  <script src="js/play/master-bf.js"></script>
  <script src="js/play/log.js"></script>
  <script src="js/play/vol.js"></script>
  <script src="js/play/loading.js"></script>
  <script src="js/play/playbar.js"></script>
  <script src="js/play/channel.js"></script>
  <script src="js/play/playMenu2.js"></script>
  <script src="js/play/keyPress2.js"></script>
</body>
</html>
