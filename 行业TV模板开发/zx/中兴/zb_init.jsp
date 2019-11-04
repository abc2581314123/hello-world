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

	
</head>
<body>

<div id="firstvod" style="background: url('./playimages/last_quit.png'); width: 365px; height: 220px; position: absolute;margin: auto; top: 0; left: 0; bottom: 0; right: 0; color: #fff; font-size: 36px; text-align: center; line-height: 220px;">按OK键可查看节目单</div> 

</body>
</html>
