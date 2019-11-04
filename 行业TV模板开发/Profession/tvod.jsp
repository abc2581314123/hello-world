<!DOCTYPE html>
<%@ include file="datajsp/tvod_progBillByRepertoireData-hd.jsp"%>
<%@ include file = "hk-channellist-control.jsp"%>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>首页</title>
	<meta name="Page-View-Size" content="1280*720">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href="css/common.css">
    <style type="text/css">
        img { display: inline-block; vertical-align: top; }
        * {
            color: #c2c2c0;
            margin: 0;
            padding: 0;
        }
        .channel { 
            width: 980px;
            margin: auto;
            overflow: hidden;
            position: relative;
            height: 100px;
         }
        .channel ul {
            overflow: hidden;
            width: 10000px;
            position: absolute;
        }
        .channel li {
            float: left;
            height: 95px;
            line-height: 95px;
            margin: 0 15px;
        }
        .channel li.sel {
            color: #ffae00
        }
        .date {
            position: absolute;
            left: 150px;
        }
        .date .sel {
            color: #ffae00;
        }
        .date ul li {
            line-height: 55px;
            font-size: 22px;
        }
        .tvodlist {
            position: absolute;
            left: 280px;
            width: 860px;
        }
        .tvodlist ul li {
            float: left;
            margin: 10px;
        }
        .tvodlist ul li.sel span{
            color: #ffae00;
        }
        .tvodlist ul li span {
            display: inline-block;
            font-size: 20px;
            vertical-align: middle;
        }
        .tvodlist .s1 {
            width: 60px;
            height: 50px;
             line-height: 50px;
            background: #026086;
            text-align: center;
        }
        .tvodlist .s2 {
            width: 90px;
            height: 50px;
            line-height: 50px;
            background: #1c7ebd;
            text-align: center;
        }
        .video {
            position: absolute;
            left: 150px;
            top: 535px;
        }
        .page {
            position: absolute;
            width: 50px;
            background: #1c7ebd;
            text-align: center;
            padding: 10px 0;
        }
        .uppage {
            left: 1200px;
            top: 110px;
        }
        .downpage {
            left: 1200px;
            top: 410px;
        }
        .page.sel {
            background: #ffae00;
            color: #026086;
        }
    </style>
</head>
<body style="width:1280px; height:720px; background: url('img/body.jpg') no-repeat">
    
    <!-- 频道 -->
    <div class="channel">
        <ul>
            <li>CCTV1</li>
            <li>CCTV2</li>
            <li>CCTV3</li>
            <li>CCTV4</li>
            <li>CCTV5</li>
            <li>CCTV6</li>
            <li>CCTV7</li>
            <li>CCTV8</li>
            <li>CCTV9</li>
            <li>CCTV10</li>
            <li>CCTV11</li>
            <li>CCTV12</li>
            <li>CCTV13</li>
            <li>CCTV14</li>
            <li>CCTV15</li>
            <li>CCTV16</li>
        </ul>
    </div>

    <!-- 回看日期 -->
    <div class="date">
        <ul>
            <li>07月07日</li>
            <li>07月06日</li>
            <li>07月05日</li>
            <li>07月04日</li>
            <li>07月03日</li>
            <li>07月02日</li>
            <li>07月01日</li>
        </ul>
    </div>

    <!-- 回看节目单 -->
    <div class="tvodlist">
        <ul>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>

            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>

            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
            <li><span class="s1">00:00</span><span class="s2">当前节目</span></li>
        </ul>
    </div>

    <!-- 翻页 -->
    <div class="page uppage">上一页1</div>
    <div class="page downpage">下一页</div>

    <div class="video"><img src="img/seat.png" width="300" height="160"></div>

	<script src="EPGjs/keyPress.js"></script>
	<script src="EPGjs/master.js"></script>
	<script src="EPGjs/tvod.js"></script>
	<script src="EPGjs/common.js"></script>
</body>
</html>