<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp"%>
<%@ include file="SubStringFunction.jsp"%>
<%@ include file="OneKeySwitch_zb.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ include file="MemToVas.jsp" %>
<%@ include file="config/config_CategoryHD.jsp" %>
<%@ include file="util/util_GetCategoryRecAllHD.jsp"%>
<%	
	UserProfile userProfile = new UserProfile(request);
	String pageId = "";//
		String iaspuserid = userProfile.getUserId();//用户名
		String iaspadsl = "";//userProfile.toString();//宽带账号
		String iaspip = userProfile.getStbIp();//机顶盒IP
		String iaspmac = userProfile.getSTBMAC()+"&hdpath=hdpathflag";//机顶盒mac地址
		String stbId = userProfile.getStbId();//机顶盒ID
		int areaId = userProfile.getAreaId();//区域ID
		String tjparamsInfo = getEpgInfo(request);
	pageId=request.getRequestURI();   
	pageId=pageId.substring(pageId.lastIndexOf("/")+1);   
%>











<html>
<head>
<meta   name="page-view-size" content="1280*720" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script src="js/PlayRecord.js"></script>
<title>PlayControleChannel.jsp</title>
<style type="text/css">
.icon{
	position:absolute ;
	width:20px;
	height:80px;
	background:url(images/playcontrol/playChannel/Volume_0.gif);
}
</style>
</head>

<script type="text/javascript">
var picIndexLeftTop = 0;
var picIndexLeftBot = 0;
var picIndexRight = 0;
    var isFromVas = false;
	var stbType = iPanel.ioctlRead("STBType");
	var JbFlag = "close";
	var zbldFlag = "close";
	
	/** add 上海二期开发直播信息统计  by 郭东阳  begin **/
	//提交频道控制信息
	var pr2 = null;

    //直播业务
    var live_type = "live";
    
    //直播回看业务
    var back_type = "back";

    //当前的业务类型

    var business_type = live_type;
/** add  上海二期,直播信息统计  by 郭东阳  end  **/
</script>
<%
    TurnPage turnPage = new TurnPage(request);
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);


	//解锁验证页面使用 begin

	  String locktimeStamp = "";
    locktimeStamp = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
	  String _userid = (String)session.getAttribute("USERID");
    if (_userid == null)
    {
        _userid = "-1";
    }

	//解锁验证页面使用 end
	String strProgId = request.getParameter("PROGID");
	String strPlayType = request.getParameter("PLAYTYPE");
	String strChannelNum = request.getParameter("CHANNELNUM");
	int chanSize = 0;

    int channelId = -1;

    int chanNum = -1; //频道号

    int playType = -1;

	boolean currControled = false;

	String currChanName = "";

	int currOrdered = 0;
	
	String currChannelUrl = "";

    if(null != strProgId && strProgId.trim().length() > 0)

    {

        channelId = Integer.parseInt(strProgId);

    }

    else

    {

%>

<script>

        window.location.href = "InfoDisplay.jsp?ERROR_ID=77&ERROR_TYPE=2";

</script>

<%

    }

    if(null != strPlayType && strPlayType.trim().length() > 0)

    {

        playType = Integer.parseInt(strPlayType);

    }
	//isLock[2] = 1;
	int isFromChanNum = 0;   //从频道号传递进来

    if(null != strChannelNum && strChannelNum.trim().length() > 0 && !"null".equals(strChannelNum))

    {

        isFromChanNum = 1;

		chanNum = Integer.parseInt(strChannelNum);

    }

    //ArrayList recChanList  = metaData.getChanListByTypeId("-1",1000,0);

    ArrayList recChanList  = metaData.getChannelListInfo();
	//if(null == recChanList || 2 != recChanList.size() || 0 == ((ArrayList)recChanList.get(1)).size())

    if(null == recChanList || recChanList.size() < 1)

    {

%>

<script>

        window.location.href = "InfoDisplay.jsp?ERROR_ID=77&ERROR_TYPE=2";

</script>

<%

    }

    else

    {

        //ArrayList realChanList = (ArrayList)recChanList.get(1);

        ArrayList realChanList = recChanList;
		//频道个数

		chanSize = realChanList.size();
		//用以存储频道号以及对应的频道信息的有序map

	    TreeMap chanNumMap = new TreeMap();

	    HashMap chanInfo = new HashMap();

	    HashMap chanInfoForLogo = new HashMap();  //频道台标
		/* 获得台标信息处理 begin */
		String[] logoUrl = new String[chanSize];

    	int[] logoWidth = new int[chanSize];

    	int[] logoHeight = new int[chanSize];

    	int[] logoLocationX = new int[chanSize];

    	int[] logoLocationY = new int[chanSize];
		int[] logoShowTime = new int[chanSize];

    	int[] logoHideTime = new int[chanSize];
		/* 获得台标信息处理 end */
		for (int i = 0; i < chanSize; i++)

		{

			chanInfo = (HashMap)realChanList.get(i);

			//Integer chanIndex = (Integer)chanInfo.get("CHANNELINDEX");

			Integer chanIndex = (Integer)chanInfo.get("UserChannelID");

			chanNumMap.put(chanIndex, chanInfo);

		}



        int maxChanNum = ((Integer)chanNumMap.lastKey()).intValue(); //最大频道号

        int minChanNum = ((Integer)chanNumMap.firstKey()).intValue(); //最小频道号
		//频道ID数组

		int[] chanIds = new int[chanSize];

		String[] chanCode = new String[chanSize];



		//频道名称数组

		String[] chanNames = new String[chanSize];



        //频道号数组
		int[] chanNums = new int[chanSize];
		//频道类型数组

		int[] chanIsNvod = new int[chanSize];



		//频道授权数组

		int[] isSub = new int[chanSize];



		//频道是否支持时移数组 (是否支持时移：1：支持 0：不支持)

		int[] isPltv = new int[chanSize];



		//频道激活时移状态数组(时移状态：1：激活 0：去激活)

		int[] pltvStatus = new int[chanSize];
		//授权授权通过后的URL链接

		String[] chanUrls = new String[chanSize];



		//当前频道索引 初始值为 -1

		int currChanIndex = -1;

		int currPltvStatus = 0;



        //是否收藏

		boolean[] isFavorite = new boolean[chanSize];



        //是否受控级别 true 受控  false 不受控

		boolean[] isControlled = new boolean[chanSize];



		//播放类型

		int[] playTypes =  new int[chanSize];



		int[] pauseLength = new int[chanSize];



		String[] ChannelSDP  =  new String[chanSize];

		String[] TimeShiftURL  =  new String[chanSize];

		//台标显示开始时间,是与频道开始播放的相对时间

		String[] BeginTime  =  new String[chanSize];

		//台标两次显示之间的间隔时间（单位为秒，-1 为台标一直显示，此时忽略lasting；0 代表显示一次）

		int[] Interval = new int[chanSize];

		//每次出现台标后的显示时间，Lasting 的值一定要小于Interval

		String[] Lasting  =  new String[chanSize];
		int c = 0;

		Iterator iter = chanNumMap.keySet().iterator();
		while(iter.hasNext())

    	{

			Integer key = (Integer)iter.next();

			chanInfo = (HashMap)chanNumMap.get(key);
			//System.out.println(chanInfo);
			//得到频道名称数组

			//chanNames[c] = subStringFunction((String)chanInfo.get("CHANNELNAME"),1,90);

			chanNames[c] = subStringFunction((String)chanInfo.get("ChannelName"),1,90);

			//得到频道ID数组

			//chanIds[c] = ((Integer)chanInfo.get("CHANNELID")).intValue();

			chanIds[c] = ((Integer)chanInfo.get("ChannelID")).intValue();
			chanInfoForLogo = metaData.getChannelInfo(chanIds[c] + "");  //获取台标信息
			//得到频道顺序号

			//chanNums[c] = ((Integer)chanInfo.get("CHANNELINDEX")).intValue();

			chanNums[c] = ((Integer)chanInfo.get("UserChannelID")).intValue();

			//得到频道类型，是NVOD，还是直播 NVOD = 1 轮播

			//chanIsNvod[c]=((Integer)chanInfo.get("ISNVOD")).intValue();

			chanIsNvod[c] = 0;



			//频道是否时移

			//isPltv[c] = ((Integer)chanInfo.get("ISPLTV")).intValue();

			isPltv[c] = ((Integer)chanInfo.get("TimeShift")).intValue();

			//频道时移状态
			//pltvStatus[c] = ((Integer)chanInfo.get("PLTVSTATUS")).intValue();

			pltvStatus[c] = ((Integer)chanInfo.get("TimeShift")).intValue();
			//System.out.println("shiyi status :::::::pltvStatus[c]:::::"+pltvStatus[c]);
			playTypes[c] = ((Integer)chanInfo.get("ChannelType")).intValue();
			//add new by duanxiaohui 频道SDP信息 begin

			ChannelSDP[c] = (String)chanInfo.get("ChannelSDP");

			TimeShiftURL[c] = (String)chanInfo.get("TimeShiftURL");
			//频道的授权状态 = 1授权通过

			//isSub[c] = ((Integer)chanInfo.get("ISSUBSCRIBED")).intValue();

			isSub[c] = ((Integer)chanInfo.get("ChannelPurchased")).intValue();
			//是否受控

			isControlled[c] = serviceHelp.isControlledOrLocked(true,false,EPGConstants.CONTENTTYPE_CHANNEL_VIDEO,chanIds[c]);

			if(channelId == chanIds[c] || chanNum == chanNums[c])

			{

			    currChanIndex = c;

				channelId = chanIds[c];

				chanNum = chanNums[c];

				currControled = isControlled[c];

				currOrdered = isSub[c];

				currChanName = (String)chanInfo.get("ChannelName");

				currPltvStatus = pltvStatus[c];
				currChannelUrl = (String)chanInfo.get("ChannelUrl");

			}
			/*

			if(chanIsNvod[c] == 1)

			{

			    playTypes[c] = EPGConstants.PLAYTYPE_NVOD;

				chanUrls[c] = "PlayFilm.jsp?PROGID=" + chanIds[c] + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_NVOD + "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_CHANNEL_VIDEO + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_NVOD;

			}

			else

			{

			    playTypes[c] = EPGConstants.PLAYTYPE_LIVE;

			    chanUrls[c] = "PlayFilm.jsp?PROGID=" + chanIds[c] + "&PLAYTYPE=" + EPGConstants.PLAYTYPE_LIVE + "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_CHANNEL_VIDEO + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_LIVETV;

			}

			*/



			//playTypes[c] = ((Integer)chanInfo.get("ChannelType")).intValue();

			isFavorite[c] = serviceHelp.isFavorited(chanIds[c],EPGConstants.CONTENTTYPE_CHANNEL);









            /* 获得台标信息处理 begin */



            if(null == chanInfoForLogo)

            {

	            logoUrl[c] = "";

	            logoWidth[c] = 0;

	            logoHeight[c] = 0;

	            logoLocationX[c] = 0;

	            logoLocationY[c] = 0;

	            logoShowTime[c] = 0;

	            logoHideTime[c] = 0;

            }

            else

            {

	            String tmpLogoUrl = (String)chanInfoForLogo.get("LOGOURL");

	            if(null == tmpLogoUrl || tmpLogoUrl.trim().length() < 1)

	            {

	                tmpLogoUrl = "";

	            }
				logoUrl[c] = tmpLogoUrl;
				if(null == (Integer)chanInfoForLogo.get("LOGOWIDTH"))

				{

					logoWidth[c] = 0;

				}

				else

				{

					logoWidth[c] = ((Integer)chanInfoForLogo.get("LOGOWIDTH")).intValue();

				}

	

				if(null == chanInfoForLogo.get("LOGOHEIGHT"))

				{

					logoHeight[c] = 0;

				}

				else

				{

					logoHeight[c] = ((Integer)chanInfoForLogo.get("LOGOHEIGHT")).intValue();

				}

	

				if(null == chanInfoForLogo.get("LOGOLOCATIONX"))

				{

					logoLocationX[c] = 0;

				}

				else

				{

					logoLocationX[c] = ((Integer)chanInfoForLogo.get("LOGOLOCATIONX")).intValue();

				}

	

				if(null == chanInfoForLogo.get("LOGOLOCATIONY"))

				{

					logoLocationY[c] = 0;

				}

				else

				{

					logoLocationY[c] = ((Integer)chanInfoForLogo.get("LOGOLOCATIONY")).intValue();

				}

	

				if(null == chanInfoForLogo.get("LOGOSHOWTIME"))

				{

					logoShowTime[c] = 0;

				}

				else

				{

					logoShowTime[c] = ((Integer)chanInfoForLogo.get("LOGOHIDETIME")).intValue();

				}

	

				if(null == chanInfoForLogo.get("LOGOSHOWTIME"))

				{

					logoHideTime[c] = 0;

				}

				else

				{

					logoHideTime[c] = ((Integer)chanInfoForLogo.get("LOGOHIDETIME")).intValue();

				}



            }

   	    	chanCode[c] = (String)chanInfo.get("CODE");

            

            //logoWidth[c] = ((Integer)chanInfoForLogo.get("LOGOWIDTH")).intValue();

            //logoHeight[c] = ((Integer)chanInfoForLogo.get("LOGOHEIGHT")).intValue();

            //logoLocationX[c] = ((Integer)chanInfoForLogo.get("LOGOLOCATIONX")).intValue();

            //logoLocationY[c] = ((Integer)chanInfoForLogo.get("LOGOLOCATIONY")).intValue();

            //logoShowTime[c] = ((Integer)chanInfoForLogo.get("LOGOSHOWTIME")).intValue();

            //logoHideTime[c] = ((Integer)chanInfoForLogo.get("LOGOHIDETIME")).intValue();

            /* 获得台标信息处理 end*/

			

			c++;

		}

		





		// 判断该频道是否加锁





		int[] isLock  =  new int[chanSize];



		ArrayList lockInfo = serviceHelp.getLockList();

		if(lockInfo!= null && lockInfo.size()>1)

		{

			lockInfo = (ArrayList)lockInfo.get(1);

			for(int i =0 ; i<lockInfo.size() ;i++)

			{

				HashMap tmpMap = (HashMap)lockInfo.get(i);

				//String lockId = (String)tmpMap.get("PROG_ID");

				int lockId = Integer.parseInt((String)tmpMap.get("PROG_ID"));

				int lockType = ((Integer)tmpMap.get("PROG_TYPE")).intValue();

				if(lockType == EPGConstants.CONTENTTYPE_CHANNEL)

				{

					if(lockId == channelId)

					{

						currControled = true;

					}

				 }

			 }

		}





    String playUrl = "";

    String beginTime = "0";

    playUrl = serviceHelp.getTriggerPlayUrl(playType,channelId,beginTime);

    if(playUrl != null && playUrl.length() > 0)

    {

        int tmpPosition = playUrl.indexOf("rtsp");

        if(-1 != tmpPosition)

		{

			playUrl = playUrl.substring(tmpPosition,playUrl.length());

		}

    }

    







    String returnUrl = "";
    returnUrl = turnPage.go(0);
	
	  String backurl = "";
	  if (session.getAttribute("vas_back_url") != null && !"".equals(session.getAttribute("vas_back_url"))) {
        backurl = (String) session.getAttribute("vas_back_url");
%>
<script type="text/javascript">
        isFromVas = true;
</script>
<%
    } else {
        session.removeAttribute("vas_back_url");
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
	  //---------------------------------------------------------------------------------------------
    session.removeAttribute("MEDIAPLAY");
	  session.removeAttribute("PLAYTYPE");
	  session.removeAttribute("PROGID");
	  session.removeAttribute("PRODUCTID");
	  session.removeAttribute("SERVICEID");
	  session.removeAttribute("PRICE");
	  //-------------------获取当前时间

    // 获取当前本地时间
    Date nowDate = new Date();
    GregorianCalendar gca = new GregorianCalendar();
    gca.setTime(nowDate);
    // 分别将年、月、日、时、分、秒取出
    int currYear = gca.get(GregorianCalendar.YEAR);
    int currMonth = gca.get(GregorianCalendar.MONTH);
    int currDay = gca.get(GregorianCalendar.DAY_OF_MONTH);
    int currHour = gca.get(GregorianCalendar.HOUR_OF_DAY);
    int currMinute = gca.get(GregorianCalendar.MINUTE);
    int currSecond = gca.get(GregorianCalendar.SECOND);
	//System.out.println(System.currentTimeMillis());
%>

<script>

    var isFromChanNum = "<%=isFromChanNum%>";  //是否存频道号过来
	var playType=0;   //0不可以快进  1 可以快进


    var chanIds = new Array();

	var playtypes = new Array();

    var chanNames = new Array();

    var chanNums = new Array();

    var chanIsNvod = new Array();

    var isSub = new Array();

    var isPltv = new Array();

    var pltvStatus = new Array();

    var chanUrls = new Array();

    var isFavorite = new Array();

    var isLock = new Array();

    var isControlled = new Array();

    var chanSize = <%=chanSize%>; //总的频道数



    var logoUrl = new Array();

    var logoWidth = new Array();

    var logoHeight = new Array();

    var logoLocationX = new Array();

    var logoLocationY = new Array();

    var logoShowTime = new Array();

    var logoHideTime = new Array();

	var onWebChannel = 0; //0表示普通频道，1表示webchannel

	var chanCode = new Array();



	//解锁页面使用  begin

	var locktimeStamp = <%=locktimeStamp %>;

    var encrptedPassword = "";

	var pwd = "";

	

	var currControled = "<%=currControled%>";

	var currOrdered = <%=currOrdered%>;

	var currChanName = "<%=currChanName%>";
	
	var currChannelUrl = "<%=currChannelUrl%>";
	
	var logo;

	var filmInfoDiv;// = document.getElementById("filmInfo1");

	var filmInfoDiv2;

	var  nochannel;

	//解锁页面使用  end





	//设置单个播放的媒体属性



	var json = '[{mediaUrl:"<%=playUrl%>",';

	json += 'mediaCode: "jsoncode1",';

	json += 'mediaType:1,';

	json += 'audioType:1,';

	json += 'videoType:1,';

	json += 'streamType:1,';

	json += 'drmType:1,';

	json += 'fingerPrint:0,';

	json += 'copyProtection:1,';

	json += 'allowTrickmode:1,';

	json += 'startTime:0,';

	json += 'endTime:10000.3,';

	json += 'entryID:"jsonentry1"}]';



	//创建MediaPlayer对象

	var mp = new MediaPlayer(1);



	var hideTimer = "";   // 提示信息隐藏定时器



	var showTimer = "";   // 提示信息显示定时器



	var	hideNumTimer = ""; // 隐藏频道号定时器



	var showState = 0;    // 提示信息的显示状态 信息条 showState = 1 显示





	var returnUrl = "<%=returnUrl%>";	// 返回页面地址

	var maxChanNum = <%=maxChanNum%>;

	var minChanNum = <%=minChanNum%>;



	// 总的频道数

	var totalNum = <%=chanNumMap.size()%>;

	// 初始化本地频道信息

	var chanNumList = new Array();



    //保留参数 begin

    var seekTimeString = "|__:__:__";

    var timeIndex = 0;

    var hour = 0;

    var min = 0;

    var sec = 0;

    //保留参数 end





    var state = "";   // 定位状态标志 时移定位  state == seek || state == ""

    var speed = 1;

    var playStat = "play";   //表示播放状态,如果该频道支持时移 还有三种状态 fastrewind fastforward pause

    var preChannel = -1;  //上一次播放的频道号 -1 表示第一次播放

    var preChannelIndex = -1;  //上一次播放的频道索引

    var preChannelId = -1;  //上一次播放的频道索引



    var currChannel = <%=chanNum%>;   //当前频道号

    var currChannelId = <%=channelId%>;   //当前频道id

    var currChanIndex = <%=currChanIndex%>;  //当前频道索引

    var nowChanIndex = <%=currChanIndex%>; //保存正在播放的频道索引 切换频道时 如果频道更新成功需要 更新该值

	var dataLoaded = 0;



    var pltvStatusFlag = <%=currPltvStatus%>;   //不支持时移或状态为去激活 1 支持时移

    var shiftFlag = 0; //时移标志位

	//探针


    //var isSeeking = 0;  //进度跳显示标志  1 显示进度条

    var isJumpTime = 1; //跳转输入框显示标志 1 显示



    //var volume = 20;

    var volume = mp.getVolume();



    //未授权，有锁，父母级别受控 信息是否显示标志 disLockFlag = 1显示

    //此时如果频道支持时移的话,禁止快进快退

    var disLockFlag = 0;



    document.onirkeypress = keyEvent ;

    document.onkeypress = keyEvent;


    var ttt = false
    function keyEvent()

    {
        var val = event.which ? event.which : event.keyCode;
		if(dataLoaded == 0)

		{

			return false;

		} 

        return keypress(val);

    }



    function keypress(keyval)

    {   
    	
        switch(keyval)

        {
			case <%=KEY_TVOD%>:
					pr2.servletSubmit("1","removeOnPlayUser",currChannel);
					setTimeout("greengo()",500);
					break;
			case <%=KEY_PORTAL%>:	
			        pr2.servletSubmit("1","removeOnPlayUser",currChannel);
					setTimeout("portalgo()",500);
					break;
            case <%=KEY_0%>:

				inputNum(0);

				break;

            case <%=KEY_1%>:

				inputNum(1);

				break;

            case <%=KEY_2%>:

				inputNum(2);

				break;

            case <%=KEY_3%>:

				inputNum(3);

				break;

            case <%=KEY_4%>:

				inputNum(4);

				break;

            case <%=KEY_5%>:

				inputNum(5);

				break;

            case <%=KEY_6%>:

				inputNum(6);

				break;

            case <%=KEY_7%>:

				inputNum(7);

				break;

            case <%=KEY_8%>:

				inputNum(8);

				break;

            case <%=KEY_9%>:

				inputNum(9);

				break;

			case <%=KEY_CHANNEL_UP%>:  //加频道

				addchannel();

				break;

			case <%=KEY_CHANNEL_DOWN%>:  //减频道

				decchannel();

				break;

        	case <%=KEY_PAUSE_PLAY%>:

				pauseOrPlay();

				break;

		    case <%=KEY_RIGHT%>:
		    	if(ttt) {
		    		return
		    	}
		        arrowRight();

				//return false;

				break;

    	    case <%=KEY_LEFT%>:
    	    	if(ttt) {
		    		return
		    	}

    	        arrowLeft();

				//return false;

				break;

		    case <%=KEY_DOWN%>:   //一键追时移
		    	if(ttt) {
		    		return
		    	}
		        arrowDown();

    			break;

		    case <%=KEY_UP%>:   //一键追直播
		    	if(ttt) {
		    		return
		    	}
				arrowUp();

				//return false;

				break;


    		case <%=KEY_PAGEDOWN%>:   

			    goEnd();

    			break;

			case <%=KEY_FAST_FORWARD%>: 
				if(ttt) {
		    		return
		    	}
				fastForward();

				break;

			case <%=KEY_FAST_REWIND%>: 
				if(ttt) {
		    		return
		    	}
				fastRewind();

				break;

    		case <%=KEY_MUTE%>:   //静音

    			setMuteFlag();

    			break;
			case 1060:
            case <%=KEY_TRACK%>:  //切换声道

    			switchTrack();

    			break;

            case <%=KEY_VOL_UP%>:

                //volumeUp();

    			incVolume();

    			//mediaError();

    			break;

            case <%=KEY_VOL_DOWN%>:

    			//volumeDown();

    			decVolume();

				break;

            case <%=KEY_BACKSPACE%>:
            if(zbldFlag=="open") {
            	var GOTOType =Authentication.CTCGetConfig("STBType");
				if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0){
		   			filmZbldInfo.window.fnOperateMenuLayer('back');
			    }
				zbldFlag="close";
				return;  
            }
            if(!ttt && zbldFlag=="close") {
        		document.getElementById('apDiv14').style.display = 'block'
        		document.getElementById('myplay').onfocus()
        		ttt = true
        	} else {
        		document.getElementById('apDiv14').style.display = 'none'
        		 ttt = false
        	}
        	break;

            case <%=KEY_RETURN%>:

            case <%=KEY_STOP%>:

                goBack();

            break;

            case <%=KEY_PAGEUP%>:

                         goBeginning();
                         break;
				return false;

            case <%=KEY_GO_BEGINNING%>:

            	goBeginning();

            	break;

            case <%=KEY_OK%>:
            	if(ttt) {
		    		return
		    	}
			    show();
            	break ;

	   		case <%=KEY_IPTV_EVENT%>:

                goUtility();

            	break;
            default:

                 return videoControl(keyval);

        }

        return true;



    }


    function yellowgo(){
		var favoUrl = main_path+"vod_Category.jsp?MainPage=1&INDEXPAGE=0"+"&ISFIRST=1&subjectType=10|0|4|9999";
					window.location.href=favoUrl;
					return 0;
	}
	function bluego(){
		var favoUrl = main_path+"query_Favorite.jsp?ISFIRST=1";
					window.location.href=favoUrl;
					return 0;
	}
	function greengo(){
		var favoUrl = main_path+"tvod_progBillByRepertoire.jsp?ISFIRST=1";//?
					window.location.href=favoUrl;
					return 0;
	}
	function redgo(){
		 var favoUrl = "chan_RecordList.jsp?ISFIRST=1";//? vod
		 window.location.href=favoUrl;
		 return 0;
	}
	function portalgo(){
			var EPGDomain = '';
			if ('CTCSetConfig' in Authentication) {
		        EPGDomain = Authentication.CTCGetConfig("EPGDomain");
			} else {
				EPGDomain = Authentication.CUGetConfig("EPGDomain");
			}
			window.location.href=EPGDomain;
		 return 0;
	}
	
    function goUtility()

    {

        if(disLockFlag == 1)

         {

             return;

         }

    	eval("eventJson = " + Utility.getEvent());

    	var typeStr = eventJson.type;

    	switch(typeStr)

        {

          case "EVENT_MEDIA_ERROR":

              //mediaError();

              break;

          case "EVENT_MEDIA_END": //结束 开始播放频道

		      processEventEnd();

              return false;
			  break;
          case "EVENT_MEDIA_BEGINING":// 从时移位置开始播放

              shiftFlag = 0;

              processEventBegin();

              break;

          case "EVENT_PLAYMODE_CHANGE":  //恢复流以后会触发该事件 从暂停到正常播放

              playModeChange(eventJson);

              return false;

              break;
		 case "EVENT_PLTVMODE_CHANGE":  //机顶盒进入时移或退出时移

              pltvModeChange(eventJson);

              return false;

              break;
            default :

              break;

        }

        return true;

    }
	function pltvModeChange(eventJson)
	{
		// service_types表示当前播放是否为时移 0: 返回直播   1: 进入时移
		var pltvMode = eventJson.service_type;
		if(pltvMode == 1)
		{
			shiftFlag = 1;
		}
		else if(pltvMode == 0)
		{
			shiftFlag = 0;
		}
	}


    function playModeChange(eventJson)

    {  
		
    	var mode = eventJson.new_play_mode;
		
    	if (mode == 3)

    	{

    		var playRate = eventJson.new_play_rate;

    		// 此条件是规避快速到尾时，状态不对的问题

    		if (playRate < 0)

    		{

    			shiftFlag = 1;
				playType=1;

    		}

    	}





    	var pausePic = '<img src="images/playcontrol/playChannel/pause_top.gif">';

    	var playPic = '<img src="images/playcontrol/playChannel/play.gif">';

    	var fastPic = '<img src="images/playcontrol/playChannel/fast.gif">';

    	var rewindPic = '<img src="images/playcontrol/playChannel/rewind.gif">';



    	count = parseInt(count) + 1;

    	if (true)

    	{

    		clearTimeout(topTimer);

	    	// 处理状态切换时的图片

	    	if(mode == 1) // 暂停状态

	    	{

	    		shiftFlag = 1;

				if (mp.getNativeUIFlag() == 0)

				{

	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + pausePic + '</td></tr></table>';
					playStat = "pause";// add by chenzhqiang at 21030821 for 直播按暂停键无效 
					playType=1;
				}

	    	}



	    	if(mode == 2) // 正常状态

	    	{
				//document.getElementById("testDiv0").innerText = "CHECK--cJ=" + channelJoined +"--playType="+playType+"--sF="+shiftFlag;
	    		if(shiftFlag == 1)

				{

					showClock();
					playType=1;
					//document.getElementById("testDiv1").innerText = "SHOWCLOCK--cJ=" + channelJoined +"--playType="+playType+"--sF="+shiftFlag;
				}

				else

				{

					showLive();
					playType=0;
					shiftFlag=0;
					if (stbType.indexOf("EC2108V3H") != -1 || stbType.indexOf("EC1308V2H") != -1)
					{
						resumestat();
						fullSeekStatus();
					}
					//document.getElementById("testDiv1").innerText = "LIVE--cJ=" + channelJoined +"--playType="+playType+"--sF="+shiftFlag;
				}
				EventBeginForSeekHide();
				playStat = "play";// add by chenzhqiang at 21030821 for 直播按暂停键无效 
				//document.getElementById("testDiv2").innerText = "CHECKEND--cJ=" + channelJoined +"--playType="+playType+"--sF="+shiftFlag;
	    	}

	    	if(mode == 3) // 快速状态

	    	{
				
	    		var playRate = eventJson.new_play_rate;


	    		if (playRate > 0)

	    		{

					if (mp.getNativeUIFlag() == 0)

					{

	    				fastPic = '<img src="images/playcontrol/_' + playRate + '.gif">';

	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100 height=40>' + fastPic + '</td></tr></table>';
						playStat = "fastforward";// add by chenzhqiang at 21030821 for 直播按暂停键无效
						playType=1; 
					}

	    		}

	    		else

	    		{

	    			shiftFlag = 1;

					if (mp.getNativeUIFlag() == 0)

					{

	    				var tmpplayRate = -playRate;

	    				rewindPic = '<img src="images/playcontrol/_x' + tmpplayRate + '.gif">';

	    				document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100  height=40>' + rewindPic + '</td></tr></table>';
						playStat = "fastrewind";// add by chenzhqiang at 21030821 for 直播按暂停键无效
						playType=1; 
					}

	    		}

	    	}

    	}

    }





	/**

	 * 由于mp.getNativeUIFlag() 现在有机顶盒控制展示

	 * @mode 播放模式

	 */

	function playModeChangeForNew(mode)

    {

		if(mode == 1)

		{

			shiftFlag = 1;

		}

		else if(mode == 2)

		{

		}

		else if(mode == 3)

		{

		}

	}



	

	/**

	 * 触发开始事件

	 */

	function processEventBegin()

	{

		//if((shiftFlag == 0 && pltvStatusFlag == 1) || pltvStatusFlag == 0) return false;  //触发开始事件要进行判断



		//如果快退到头以后 需要手动将进度条刷完 并将进度条显示隐藏

		resumestat();

		shiftFlag = 1;

		EventBeginForSeek();

		

		//setTimeout("EventBeginForSeekHide();",200)

		

		

		//EventBeginForSeekHide();

		showClock();

		//resumestat();

		shiftFlag = 1;

		EventBeginForSeekHide();

	}



	

	/**

	 * 快退到进度条后 将进度条刷完

	 */

	function EventBeginForSeek()

	{

        if(isSeeking == 0)   //进度条无显示

        {

            return 0;

        }

		isSeeking  = 0;

		

		document.getElementById("progressBar").style.width = "0px";

		

		/*

        var seekTableDef = "";

        seekTableDef = '<table width="500" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';

        seekTableDef +='<td width="500" height="25" bgColor = "#000080" style="border-style:none;"></td>';

        seekTableDef += '</tr></table>';

        document.getElementById("seekTable").innerHTML = seekTableDef;   //进度条显示满

		*/

        document.getElementById("seekPercent").innerHTML = '<span style="color:#FFFFFF;">' + 0 + "%</span>";  //显示百分比

	}







	/**

	 * 快退到进度条后 隐藏进度条

	 */

	function EventBeginForSeekHide()

	{

		document.getElementById("seekDiv").style.display = "none";

		document.getElementById("jumpTimeDiv").style.display = "block";

		document.getElementById("jumpTimeImg").style.display = "block";

		isSeeking = 0;

		clearTimeout(timeID_jumpTime);

		clearTimeout(timeID_check);

	}



	function processEventEnd()

	{

		showLive();

		resumestat();

		fullSeekStatus();

		EventBeginForSeekHide();
		


	}



    /* 快进到直播后进度条后 画满进度条 */

    function fullSeekStatus()

    {

        if(isSeeking == 0)   //进度条无显示

        {

            return 0;

        }

		

		

		

		document.getElementById("progressBar").style.width = "1100px";

		

		/*

        var seekTableDef = "";

        seekTableDef = '<table width="500" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';

        seekTableDef +='<td width="500" height="25" bgColor = "#DAA520" style="border-style:none;"></td>';

        seekTableDef += '</tr></table>';

        document.getElementById("seekTable").innerHTML = seekTableDef;   //进度条显示满

		*/

        document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + 100 + "%</span>";  //显示百分比

    }





	/**

	 * 显示时移图标

	 */

	function showClock() 

	{

		var clockPic = '<img src="images/playcontrol/playChannel/colock.gif">';

		if (mp.getNativeUIFlag() == 0)

    	{

	    	document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + clockPic + '</td></tr></table>';

    	}

		//topTimer = setTimeout("hideTopFrm();", 5000);

	}

    function showLive()

    {

    	shiftFlag = 0;

		var livePic = '<img src="images/playcontrol/playChannel/live.gif">';

     	if (mp.getNativeUIFlag() == 0)

    	{

	    	document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + livePic + '</td></tr></table>';

	    	topTimer = setTimeout("hideTopFrm();", 5000);

    	}

		resumestat();



    }

	function showVolumeBar(Num)
	{
		for (var i = 1 ; i <= 20 ; i ++)
		{
			if (i <= Num)document.getElementById("icon_"+i).style.background = "url(images/playcontrol/playChannel/Volume_1.gif)";
			else document.getElementById("icon_"+i).style.background = "url(images/playcontrol/playChannel/Volume_0.gif)" ;
		}
	} 

    function hideTopFrm()

    {

    	document.getElementById("topframe").innerHTML = "";

    }





    function hideMediaError()

    {

        iPanel.overlayFrame.location = "";

    }





	/*

	 *弹出错误信息页面

	 */

	function mediaError()

	{

	    

//	    document.getElementById("order").style.display = "none";

	     

		iPanel.overlayFrame.location ="MediaError.jsp?PARAM=" + iRet; //断流

		overlayframe();

	}



	/*

	 *设置错误信息页面

	 */

	function overlayframe()

	{

		iPanel.overlayFrame.resizeTo(500,250);

		iPanel.overlayFrame.focus();

	}





    var timerTrack = "";

    function switchTrack()  //声道切换

    {



		disVolume_sd();



        var currAudio = Authentication.CTCGetConfig('AudioChannel');

		if(currAudio == 2)

		{

		    mp.switchAudioChannel();

			//mp.switchAudioTrack();

		}

		else

		{

			mp.switchAudioChannel();

		}

		



		//mp.switchAudioChannel();

		var leftPic = '<img src="images/voice/leftvoice.png" />';
		var rightPic = '<img src="images/voice/rightvoice.png" />';
		var litisheng = '<img src="images/voice/centervoice.png" />';

        if (mp.getAudioTrackUIFlag() == 0)

        {

			var disPic = "";

			
 var audio= Authentication.CTCGetConfig('AudioChannel');

			if(audio=="0" || audio=="Left" || audio ==0)
			{//(0);
				audio=0;
			}
			else if(audio=="1" || audio=="3" ||  audio=="Right" || audio ==1)
			{//(1);
				audio=1;	
			}
			else if(audio=="2" || audio=="JointStereo" || audio ==2)
			{//(2);
				audio=2;	
			}
			clearTimeout(voiceflag);
			switch(audio)
			{
				case 0:
				disPic = leftPic;
				break;
				case 1:
				disPic = rightPic;
				break;
				case 2:
				disPic = litisheng;
				break;
				default:
				break;
			}
	        var tabdef = "<table width=120 height=30><tr><td>";

	        tabdef += disPic;

	        tabdef += "</td></tr></table>";

	        document.getElementById("TrackImg").innerHTML = disPic ;

	        clearTimeout(timerTrack);

            timerTrack = setTimeout("hideTrackImg();",5000)

        }

    }



    function hideTrack()

    {

        document.getElementById("bottomframe1").innerHTML = "";

    }





    function switchSubTitle()  //获取当前选择的字幕类型

    {



        var tabdef = "<table width=120 height=30><tr><td><font color=white size=20>";

        tabdef += mp.getSubtitle();

        tabdef += "</font></td></tr></table>";

        document.getElementById("bottomframe1").innerHTML = tabdef;

    }

	function hideTrackImg()
    {
        document.getElementById("TrackImg").innerHTML = "";
    }



    var timeID_volume = "";

	/*

	 * 隐藏音量显示

	 */

	function unVolume()

	{

		document.getElementById("bottomframe").style.display = "none";

	}



	/*

	 * 显示音量显示

	 */

	function disVolume()

	{

		document.getElementById("bottomframe").style.display = "block";

	}



	/*

	 * 声道显示

	 */

	function unVolume_sd()

	{

		document.getElementById("bottomframe1").style.display = "none";

	}	



	/*

	 * 声道显示

	 */

	function disVolume_sd()

	{

		document.getElementById("bottomframe1").style.display = "block";

	}	





    function incVolume()

    {
		volume = mp.getVolume();
		disVolume();
		var muteFlag = mp.getMuteFlag();
    	if(muteFlag == 1)
    	{
            mp.setMuteFlag(0);
			document.getElementById("bottomframeMute").innerHTML = "";
    	}
		if (volume == 100) 

        {

            document.getElementById("volumeValue").innerText = 20;	
			showVolumeBar(20); 
            clearTimeout(timeID_volume);
		    timeID_volume = setTimeout("unVolume()",5000);
		    return;

        }

        volume = volume + 5;

		if(volume >= 100) volume = 100;

        if(mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)

        {

			var width = 500 * volume / 100;
			var showVolume = volume / 5;
			// document.getElementById("volumeBar").style.width = width + "px";
			document.getElementById("volumeValue").innerText = showVolume;
			showVolumeBar(showVolume);
        }

        mp.setVolume(volume);

        clearTimeout(timeID_volume);

		timeID_volume = setTimeout("unVolume()",5000);

		//disVolume();

    }

	/*
	 *减小音量
	 */

	function decVolume()

	{
		volume = mp.getVolume();
		disVolume();
		var muteFlag = mp.getMuteFlag();
    	if(muteFlag == 1)
    	{
            mp.setMuteFlag(0);
			document.getElementById("bottomframeMute").innerHTML = "";
    	}
		if (volume == 0) 

		{

            document.getElementById("volumeValue").innerText = 0;	
			showVolumeBar(0); 
            clearTimeout(timeID_volume);
		    timeID_volume = setTimeout("unVolume()",5000);	
			return;

		}

	    volume = volume - 5;

        if(volume <= 0) volume = 0;      

        if(mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)

        {
			var width = 500 * volume / 100;
			var showVolume = volume / 5;
			// document.getElementById("volumeBar").style.width = width + "px";
			document.getElementById("volumeValue").innerText = showVolume;			
			showVolumeBar(showVolume); 
        }

		//设置音量大小

		mp.setVolume(volume);

		clearTimeout(timeID_volume);

		timeID_volume = setTimeout("unVolume()",5000);

		//disVolume();

	}



    /* 保留该方法 end*/

    function volumeUp()  //+音量

    {

        volume = mp.getVolume();

        if(volume >= 100)

        {

            volume = 100;

        }

        else

        {

        	volume = volume + 1;

        }

        if(mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)

        {

            var tabdef = "<table width=120 height=30><tr><td><font color=green size=20>";

            tabdef += volume;

            tabdef += "</font></td></tr></table>";

            document.getElementById("bottomframe").innerHTML = tabdef;

        }

        mp.setVolume(volume);

    }



    function volumeDown()  //-音量

    {

        volume = mp.getVolume();

        if(volume <= 0)

        {

            volume = 0;



        }

        else

        {

       		 volume = volume - 5;

        }



        mp.setVolume(volume);

        if(mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)

        {

            var tabdef = "<table width=120 height=30><tr><td><font color=green size=20>";

            tabdef += volume;

            tabdef += "</font></td></tr></table>";

            document.getElementById("bottomframe").innerHTML = tabdef;

        }



    }



    /* 保留该方法 end*/



    function goEnd()  //跳转到媒体末端播放 时移

    {

		if(isSeeking == 1) return;
		shiftFlag = 0;
    	mp.gotoEnd();

    }





    function switChannel()

    {

    	 localPlay(preChannel);

    }



    function goBeginning() //跳转到媒体开始播放 时移

    {

		if(isSeeking == 1 || pltvStatusFlag == 0) return;

		shiftFlag = 1;

    	mp.gotoStart();

    }

	

	function arrowUp()

	{
		
	 	 if(zbldFlag=="open")
		    {
	 		var GOTOType =Authentication.CTCGetConfig("STBType");
		    if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0){
	 		filmZbldInfo.window.fnOperateMenuLayer('up');
		    }
		    return;
	    }
		var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101 || rc_model == 106)

		{

			addchannel();

		}

		else

		{

        	goEnd();

		}	

	}

	

	function arrowDown()

	{   
		
		if(zbldFlag=="open")
	    {
			var GOTOType =Authentication.CTCGetConfig("STBType");
			if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0){
			filmZbldInfo.window.fnOperateMenuLayer('down');
			}  
	    	   return;   
	    
		}
		var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101 || rc_model == 106)

		{

			decchannel();

		}

		else

		{

        	goBeginning();

		}		

	}



    /* 只有在 该频道支持时移的时候 该方法才能生效 */

    function pauseOrPlay()

    {

        if (pltvStatusFlag == 0) return;

        if(disLockFlag == 1) return;



        // 防止提示框显示

    	clearTimeout(showTimer);

		

        if(showState == 1)

        {

        	hideInfo();          

        } 

    	speed = 1;

		/*

    	if(playStat == "play")

    	{



    		pause();

    	}

    	else

    	{

    		resume();

    	}

		*/

		

		document.getElementById("cancelJumpId").blur();

		document.getElementById("jumpTimeHour").focus();



        if(playStat == "play")

        {    
			//document.getElementById("testDiv0").innerText = "iJT=" + isJumpTime +"---iS="+isSeeking+"--sF="+shiftFlag+"--sS="+showState;
            displaySeekTable();  

			pause();
			//document.getElementById("testDiv3").innerText = "pOP--iJT=" + isJumpTime +"---iS="+isSeeking+"--sF="+shiftFlag+"--sS="+showState;
			isJumpTime = 1;

        }       

        else

        {   displaySeekTable();      	

         	resume();

                    

        }		

    }



    function goBack()
    {
    	
    	if(zbldFlag=="open")
	    {
    		
    	var GOTOType =Authentication.CTCGetConfig("STBType");
		if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0){
   		filmZbldInfo.window.fnOperateMenuLayer('back');
	    }
		zbldFlag="close";
		return;   
		}
		zbldFlag="close";
    	pr2.servletSubmit("1","removeOnPlayUser",currChannel);
		setTimeout("gogo()",500);
    }
	function gogo(){
	


        var  returnURL = "http://202.97.183.28:9090/templets/epg/Profession/professionEPG.jsp";

            if(""!=getCookie("zbBackurl")&&null!=getCookie("zbBackurl")&&"null"!=getCookie("zbBackurl")&&"undefined"!=getCookie("zbBackurl")){
                     returnURL = getCookie("zbBackurl");
                setCookie("zbBackurl","");
            document.location.href = returnURL;
            }else{
	     document.location.href = returnUrl;

     } 



	}
       function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*30);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
          function getCookie(name){
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
        else
        return null;
    }

    function play()
    {
    	mp.setVideoDisplayArea(0,0,0,0);
	    mp.setVideoDisplayMode(1);
	    mp.refreshVideoDisplay();
		var turnURL = "InfoDisplay.jsp?ERROR_ID=131&ERROR_TYPE=2";
		if(channelstr.indexOf(","+currChannel+",") > -1 || Number(currChannel)>999){
			window.location.href = turnURL;
			return false;
		}else{
				/*******add by 郭东阳 start****/
		   if(null != pr2)
		   {
				//将上次播放记录上报，传的是上次的节目号，在第一次播放的时候不走该步
				//var temp = new PlayRecordStat(1);
				//先提交pr2.progId结束播放，再提交chanIndex开始播放
				//pr2.servletSubmit2("1","changeChannel",pr2.progId,_chanNum);
				//pr2.servletSubmit("1","removeOnPlayUser",pr2.progId);
		   }
		   else
		   {
			   pr2 = new PlayRecordStat(1);
			   pr2.beginTime = new Date();
			   pr2.progId = currChannel;
			   pr2.servletSubmit("1","addOnPlayUser",currChannel);
		   }
			
			/********add by 郭东阳 end****/
			 checkGoChannel(currChannel);
		}
	    
    }
       
 
	function statistics(){
    //探针
  	}

	function checkGoChannel(channelNumber)

	{
        if(currChannelUrl.indexOf("http") == 0)
    	{
			onWebChannel = 1;

			this.webchannel.location.href = currChannelUrl;

			this.webchanneldiv.style.display = "block";

        }
		//else if(isFromChanNum == 1 && (currOrdered == 3 || currControlled) ) 
		else if(false)
		{
			if(currOrdered == 3)  //授权

			{
				nochannel.style.display = "block";

				disLockFlag = 1;

				document.getElementById("displayErrorInfo").innerHTML = '您尚未订购频道&lt;' + currChanName + '&gt;，如需订购请到营业厅办理!';

				document.getElementById("cancleCurr").focus();

				number = 0;

				return 0;

			}

			//频道有父母级别控制

			else if(currControlled) //父母级别控制

			{
				isControlChanIndex = _chanIndex;

				parentOrLockFlag = 1;

				disLockFlag = 1; //显示信息 设置标志

				order.style.display ="block";

				document.getElementById("img_1").focus(); // 弹出需要验证密码对话框后获得焦点后

				//document.getElementById("lock").style.background = "images/playcontrol/bg_unlock.jpg";

				//setFocus();

				//document.getElementById("channame").innerHTML = "&nbsp;"+chanNames[_chanIndex];

				document.getElementById("displayLockInfo").innerHTML = '该频道&lt;' + currChanName + '&gt;需要验证密码，请选择操作：';

				number = 0;

				return 0;

			}

		}

		else

		{

			var temp = mp.joinChannel(channelNumber);

			showChannelNum(channelNumber);

		}

	}





    function playByTime(beginTime)

    {

        var type = 2;

        var speed = 1;

        mp.playByTime(type,beginTime,speed);  //跳转后直接播放

		// add by dxh

		pause();

    }



    function pause()   // 暂停

    {

        mp.pause();

        speed = 1;  // add by duanxiaohui

        playStat = "pause";
		playType=1;
		

    }







    /**

     * 判断是否支持时移 并且 时移状态 为激活时，支持快进快退

     */

    function isSupportPltvStatus()

    {

		if(dataLoaded == 0)

		{

			return 0;

		}

        if(pltvStatus[currChanIndex] == 1)

        {

            pltvStatusFlag = 1;

        }

		else

		{

			pltvStatusFlag = 0;

		}

    }















    //一键切换功能 使用切换键

    function oneKeySwitch()

    {

        if(preChannel == -1)

        {

            return;

        }



		//currChanIndex = preChannelIndex;   //当前索引就是上一次播放频道的索引

		currChanIndex = getChanIndexByNum(preChannel);



        //currChannelId = preChannelId;  暂时保留

        joinChannel(preChannel);

    }



    /**

     * 焦点移动 和快退

     */

    function arrowLeft()

    {   
    	
    	if(zbldFlag=="open")
        {
    		var GOTOType =Authentication.CTCGetConfig("STBType");
    		if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0){
    		filmZbldInfo.window.fnOperateMenuLayer('left');
            }
    		return;
		}
        var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101 || rc_model == 106)

		{

			if(disLockFlag == 1 || isSeeking == 1 || showState )

			{

				return 0;

			}

			else

			{

				decVolume();

			}

		}

		else

		{

        	
			
			if (pltvStatusFlag == 0 || disLockFlag == 1 || (isJumpTime == 1 && isSeeking == 1) || showState)

			{

				return 0;

			}

			else

			{

				fastRewind();

			}

		}

    }



    /**

     * 焦点移动 和快进

     */

    function arrowRight()

    {   
    	
        if(zbldFlag=="open")
        {
        	var GOTOType =Authentication.CTCGetConfig("STBType");
    		if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0){
        	filmZbldInfo.window.fnOperateMenuLayer('right');
        }
    		 return;   
		}	
        var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101 || rc_model == 106)

		{

			if(disLockFlag == 1 || isSeeking == 1 || showState )

			{

				return 0;

			}

			else

			{

				incVolume();

			}

		}

		else

		{
			
        	if (pltvStatusFlag == 0 || disLockFlag == 1 || (isJumpTime == 1 && isSeeking == 1) || shiftFlag == 0 || showState)

			{

				return 0;

			}

			else

			{

				fastForward();

			}

		}

    }

	

	

    function fastForward()

    { 

  		//document.getElementById("testDiv3").innerText = "fastForward--cJ=" + channelJoined +"--playType="+playType+"--sF="+shiftFlag;
    	if (shiftFlag == 0 || channelJoined == 0 || playType == 0) return;    	  	

    		

    	clearTimeout(showTimer);

    		

   		if (showState == 1)

   		{ 

   			hideInfo();

   		}	

    		

        if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0))

        {            

            if(speed >= 32 && playStat == "fastforward")

            {                

                displaySeekTable();

                resume();

                return 0;

            }

            else

            {

            	if(playStat == "fastrewind") speed = 1;

            	            	

                speed = speed * 2;

                playStat = "fastforward";

                //iPanel.debug.debug("fastForward();speed="+speed);

                mp.fastForward(speed);

                

               if(isSeeking == 0 || playStat == "pause")

	            {

	                displaySeekTable();

	                clearTimeout(timeID_jumpTime);

	                isJumpTime = 0;

	                document.getElementById("jumpTimeDiv").style.display = "none";

	                document.getElementById("jumpTimeImg").style.display = "none";

	            }

	            

                document.getElementById("statusImg").innerHTML = speed + 'X&nbsp;<img src="images/playcontrol/playChannel/fastForward.gif" width="20" height="20"/>';

            }

        }

    }

    

		

    function fastRewind()

    {    
		playType=1;
    	isSupportPltvStatus(); 

   if(pltvStatusFlag == 0 || channelJoined == 0)

         return ;

		

		

    	clearTimeout(showTimer);

    		

   		if (showState == 1)

   		{ 

   	        hideInfo();

   		}	

    			  	

        if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0))

        {

            if(speed >= 32 && playStat == "fastrewind")

            {                

                displaySeekTable();

                resume();

                return 0;

            }

            else

            {

            	if (playStat == "fastforward") speed = 1;

                speed = speed * 2;

                playStat = "fastrewind";

                mp.fastRewind(-speed);

                

                if(isSeeking == 0 || playStat == "pause")

	            {

	                displaySeekTable();

	                clearTimeout(timeID_jumpTime);

	                isJumpTime = 0;

	                document.getElementById("jumpTimeDiv").style.display = "none";

	                document.getElementById("jumpTimeImg").style.display = "none";

	            }

                document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/fastRewind.gif" width="20" height="20"/>&nbsp;X' + speed;

            }          

          

        }

    }

    	



    function resume()   //从当前媒体的快进,快退,暂停的位置开始播放

    {

        speed = 1;

        playStat = "play";

        mp.resume();

        //mp.resume();



        if(mp.getNativeUIFlag() == 0) //不让 player 使用本地UI显示功能 = 1 可以

        {

            document.getElementById("topframe").innerHTML = "";

        }

    }



    function resumestat()   //重新设置播放状态

    {

        speed = 1;

        playStat = "play";

		isJumpTime = 1;

		shiftFlag = 0;

		isSeeking = 0;

    }





	/**

	 * 对显示的台标进行预处理

	 */

	function disLogo()

	{



	    var _tab = "";

	    _tab += '<img src="' + logoUrl[currChanIndex] + '" width="' + logoWidth[currChanIndex] + '" height="' + logoHeight[currChanIndex] + '" />';

	    document.getElementById("logo").innerHTML = _tab;



        logo.style.left = logoLocationX[currChanIndex];

        logo.style.top = logoLocationY[currChanIndex];

        logo.style.width = logoWidth[currChanIndex];

        logo.style.height = logoHeight[currChanIndex];

	}

	/*

	 *显示频道台标处理

	 */



	var logoShowTimeTemp = "";

	var logoHideTimeTemp = "";



	function showChannelLogo()

	{

		if(logoShowTime[currChanIndex] > 0)

		{

		    disLogo();

			if(logo.style.display=="none")

			{

				logo.style.display="block";

			}

			logoShowTimeTemp = logoShowTime[currChanIndex] * 1000;

			setTimeout("hideChannelLogo();",logoShowTimeTemp);

		}

	}



	/*

	 *隐藏频道台标处理

	 */

	function hideChannelLogo()

	{

		if(logoHideTime[currChanIndex] > 0)

		{

			if(logo.style.display=="block")

			{

				logo.style.display="none";

			}

			logoHideTimeTemp = logoHideTime[[currChanIndex]] * 1000;

			setTimeout("showChannelLogo();",logoHideTimeTemp);

		}

	}

	/*

	 * 切换频道时，清除当前频道显示的台标和定时器

	 */

	function clearCurrChanLogoInfo()

	{

	    if("" != logoShowTimeTemp)

	    {

	        clearTimeout(logoShowTimeTemp);

	    }

	    if("" != logoHideTimeTemp)

	    {

	        clearTimeout(logoHideTimeTemp);

	    }

	    logo.style.display="none";

	}





    //显示时移图标

    function displtvFlag()

    {

    }



    //开始播放频道后 清除当前频道的时移、快进 图标 显示频道台标

    function clearCurrChanAllInfo()

    {

        clearCurrChanLogoInfo();

    }







    /* 保留该方法 begin*/

    function setSpeed(s_speed)  //设置快进快退速度

    {

        speed = s_speed;

        if(speed > 0)

        {

            mp.fastForward(speed);

            playStat = "fastforward";

        }

        else if(speed < 0)

        {

            mp.fastRewind(speed);

            playStat = "fastrewind";

        }

        if(speed == 0)

        {

            mp.pause();

            playStat = "pause";

        }

    }





    function switchAudioChannel()  //声道切换

    {

        mp.switchAudioChannel();

    }



    function switchAudioTrack()  //切换音轨

    {

        mp.switchAudioTrack();

    }



    function switchSubtitle()  //切换字幕

    {

        mp.switchSubtitle();

    }



    function stop()

    {

    	mp.leaveChannel();

        mp.stop();

    }

    /* 保留该方法 end*/


		//预约--变量
		var xmlhttp;
        var img;
		var desc;
		var starttime;
		var endtime;
		var twotime = new Array();
		var timearr = new Array();
	var channelstr = ",283,284,285,286,287,288,289,290,"; 
    function init()

    {

		
	    initMediaPlay();
		//delet mp.setSingleMedia by chenzhiqiang at 2013.07.09
        //mp.setSingleMedia(json);

        //mp.setAllowTrickmodeFlag(1);

        mp.setNativeUIFlag(1);

        mp.setAllowTrickmodeFlag(0);  //不允许媒体快进，快退，暂停 duanxiaohui

        //mp.setNativeUIFlag(0);        ////不允许媒体的本地UI显示功能,此功能将有EPG自己实现

        mp.setChannelNoUIFlag(0);

        //mp.setAudioVolumeUIFlag(1);

        mp.setAudioVolumeUIFlag(0);  //本地音量

        //mp.setAudioTrackUIFlag(1);

        mp.setAudioTrackUIFlag(0);  // duanxiaohui

        var app = navigator.appName;

        if(app == "Microsoft Internet Explorer")

        {

            mp.setNativeUIFlag(0);

        }

        //mp.setMuteUIFlag(1);

        mp.setMuteUIFlag(0);  //duanxiaohui

		

        //genSeekTable();  //delete by duanxiaohui	

		

       	filmInfoDiv2 = document.getElementById("filmInfo22");

		filmInfoDiv = document.getElementById("filmInfo1");

		logo = document.getElementById("logo");

		nochannel = document.getElementById("nochannel");

		var turnURL = "InfoDisplay.jsp?ERROR_ID=131&ERROR_TYPE=2";
		//屏蔽判断
		if(channelstr.indexOf(","+currChannel+",") > -1 || Number(currChannel)>999){
			window.location.href = turnURL;
			return false;
		}else{
			 play();
		}

    }

	function handleResponse() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
					var result=xmlhttp.responseText;
					
					xmlhttp = null;
					
					 var obj=eval('('+result+')');
					 var adstr = obj.datas;
					 var roomsarr = eval(adstr);
					  for(var j=0;j<roomsarr.length;j++){  
						 var adrooms = roomsarr[j].adRooms;
						 var adarr = eval(adrooms);
						 for(var i=0;i<adarr.length;i++){  
							if(adarr[i].imgurl!=""){
								img = adarr[i].imgurl;
							}
							if(adarr[i].desc!=""){
								desc = adarr[i].desc;
								timearr = desc.split("_");
								starttime = timearr[0];
								endtime = timearr[1];
							}
						}  
					}
					  setTimeout(initdata(),1000);
	
				}
			}
		  function initdata(){
			  var curlong = new Date().getTime();
			  var startlong = new Date(starttime).getTime();
			  var endlong = new Date(endtime).getTime();
			  if(curlong>=startlong && curlong<=endlong){
				  document.getElementById("adimg").src = img;
				  document.getElementById("adimg").style.display = "block";
			  }else{
				  document.getElementById("adimg").style.display = "none";
			  }
		  }

    function initMediaPlay()

    {



        var instanceId = mp.getNativePlayerInstanceID();

        var playListFlag = 0;

        var videoDisplayMode = 1;

        var height = 0;

        var width = 0;

        var left = 0;

        var top = 0;

        var muteFlag = 0;

        var subtitleFlag = 0;

        var videoAlpha = 0;



        var cycleFlag = 0;

        var randomFlag = 0;

        var autoDelFlag = 0;

        var useNativeUIFlag = 1;

        mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);

    }




    //显示直播联动
    function showInfo1()

    {
		
        zbldFlag = "open";
		filmZbldInfo.location.href = "player.jsp?ChannelId=" + chanIds[currChanIndex] + "&pltvStatusFlag=" + pltvStatusFlag;
    }

	function divBlock()

	{

		filmInfoDiv.style.display="block";
		filmInfoDiv2.style.display="block";

	}



    function hideInfo()

    {
         JbFlag = "close";
    	if (hideTimer != "")

    	{

    		clearTimeout(hideTimer);

    	}

        if (showTimer != "")

        {

            clearTimeout(showTimer);

        }



        showState = 0;

		filmInfo.location.href = "NoInfoChannel.jsp";

		 filmInfoDiv2.style.display="none"; 

        filmInfoDiv.style.display="none"; //隐藏



    }





	function hideLockInfo()

	{

		document.getElementById("golock1").style.display="none";

	}



	function showLockInfo()

	{

		document.getElementById("order").style.display="none";      //确认输入密码页面

        document.getElementById("golock1").style.display="block";   //密码输入页面

	}



    /**

     * 确认输入密码

     */

    function ensureCheckPass()

    {

        showLockInfo();

    }



    function pressOK()  //

    {
    	
    	if(zbldFlag=="open")
        {
    	var GOTOType =Authentication.CTCGetConfig("STBType");
		if(GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("HG510PG")>=0){
    		filmZbldInfo.window.fnOperateMenuLayer('ok');
        }
		 return;   
		}
		if(inputNumFlag == 1)

		{

			if (showTimer != "")

			{

				clearTimeout(showTimer);

			}

	

			// 防止隐藏频道号

			if (hideNumTimer != "")

			{

				clearTimeout(hideNumTimer);

			}

	

			if (showState == 1)

			{
                
				hideInfo();

			}

			playByChannelNum(number);

			showChannelNum(number);

		}

    	resetTimer();

        if(isSeeking == 1 || isJumpTime == 0)

		{

			return false;

		}



        if(disLockFlag == 1)

        {

            return true;

        }

        else

        {

        	if (state == "seek")

        	{

        		state = "";

        	}



        	if (showState == 1)

        	{

        		hideInfo();

        		hideChannelNum();
        	}

        	else

        	{

   
        		showInfo1();
				

        		//showChannelNum(currChannel);

        	}

        }

    }



	/** 

	 * 按下频道加键进行预处理，防止快速按键导致的按键累积

	 */

    var timeID_keyChannel = "";

	var timeoutFlag = 0;

    function keyAdd()
 
	{

	    currChanIndex++;

		

		if(currChanIndex >= chanSize)

        {

            currChanIndex = 0;

        }

		

		var num1 = chanNums[currChanIndex];

	    showChannelNum(num1);

		clearTimeout(timeID_keyChannel);

		timeID_keyChannel = setTimeout("addchannel();",500);

		/*

		if(timeoutFlag != 0)

		{

		    

			timeoutFlag = 2; 

			clearTimeout(timeID_keyChannel);

		    timeID_keyChannel = setTimeout("checkTimeoutFlag();",2000);		

		}

		else

		{

		    timeoutFlag = 1;

		    addchannel();

			setTimeout("checkTimeoutFlag();", 2000);

		}

		*/

		

	    

	}

	

	

	function checkTimeoutFlag()

	{

	    if(timeoutFlag == 2)

		{

		    addchannel();

		}

		

		timeoutFlag = 0;

	}

	



	/** 

	 * 按下频道减键进行预处理，防止快速按键导致的按键累积

	 */

	function keyDec()

	{

	    currChanIndex--;

		if(currChanIndex < 0)

		{

		    currChanIndex = chanSize - 1;

		}

	    var num1 = chanNums[currChanIndex];

	    showChannelNum(num1);

	    clearTimeout(timeID_keyChannel);

		timeID_keyChannel = setTimeout("decchannel();",500);

	}



    //判断是否进行了 + - 频道的操作 ,根据该标志,当出现未授权,或者有锁的提示信息页面的

    //时,用户选择相反的操作,恢复未操作前当前频道的索引

    var addOrDecChanKey = 0;

    function addchannel()

    {
	    //isControlChanIndex = -1;	

        if(2 == addOrDecChanKey)

        {

            resetCurrChanIndex();

        }

        addOrDecChanKey = 1;  //进行了+频道操作

        

		


		if(Number(currChannel)==206){
			currChanIndex = currChanIndex + 9;
		}else{
			currChanIndex = currChanIndex + 1;
		}
        if(currChanIndex >= chanSize)

        {

            currChanIndex = 0;

        }
        if(Number(currChannel)==999){
			currChanIndex = 0;
		}


        //跳转前对频道进行判断

    	if(disLockFlag == 1)

    	{

    	    clealOrder();

    	}

        updateChannel(currChanIndex);

    }



    function decchannel()

    {

	    //isControlChanIndex = -1;

        //在进行 - 频道操作之前 判断是否是因为 为授权或者有锁 出现的提示页面
        if(1 == addOrDecChanKey)

        {

            resetCurrChanIndex();

        }



        addOrDecChanKey = 2;//进行了 - 频道操作

		if(Number(currChannel)==301){
			currChanIndex =  currChanIndex - 9;
		}else{
			currChanIndex = currChanIndex - 1;
		}

        if(currChanIndex < 0)

        {

            currChanIndex = chanSize - 1;

        }

		
		if(Number(currChannel)==0){
			currChanIndex =  chanSize - 4;
		}
        //跳转前对频道进行判断

    	if(disLockFlag == 1)

    	{

    	    clealOrder();

    	}

        updateChannel(currChanIndex);

    }



    /**

     * 取消当前操作 无频道 未订购 出现解锁提示信息

     */

    function cancleCurrAction()

    {

		hideErrorInfo();

        nochannel.style.display = "none";

        order.style.display = "none";

        golock1.style.display = "none";  //密码输入DIV



        resetCurrChanIndex();

        disLockFlag = 0;

        number = 0;

		//当用户输入的频道号不存在时,点提示信息大取消按钮,清除右上角显示的频道号

		//hideNumTimer = setTimeout("hideChannelNum()",5000);

		hideChannelNum();

		hideInfo();

		showWebChannel();

		

		//isControlChanIndex = -1;

    }



    /**

     * 恢复到当前频道索引索引

     */

    function resetCurrChanIndex()

    {

        addOrDecChanKey = 0;  //取消当前加解锁标志

        currChanIndex = preChannelIndex;

    }



	/**

	 * 判断是否 订购，授权，父母级别控制

	 * @_chanIndex 需要处理的频道索引

	 */

	 

	var parentOrLockFlag = 0; // parentOrLockFlag = 1 父母级别控制 2 锁控制

	var isControlChanIndex = -1;   //当输入的频道号是受限制的频道号 记录当前索引
	var channelJoined = 1;
	function updateChannel(_chanIndex)

	{

		//判断顺序 授权,父母级别控制,有无所状态

		isControlChanIndex = -1;





		if(isSeeking == 1)

		{

			clearTimeout(timeID_check);//清空定时器

			

			document.getElementById("seekDiv").style.display = "none";

			resetPara_seek();//复位各参数

			isSeeking = 0;

			mp.resume();

		}



		//if(isSub[_chanIndex] == 0)  //授权

		if(isSub[_chanIndex] == 3)  //授权

		{

			hideWebChannel();

            nochannel.style.display = "block";

            disLockFlag = 1;

            document.getElementById("displayErrorInfo").innerHTML = '您尚未订购频道&lt;' + chanNames[_chanIndex] + '&gt;，如需订购请到营业厅办理!';

            document.getElementById("cancleCurr").focus();

			number = 0;

			return 0;

		}

		//频道有父母级别控制

		else if(isControlled[_chanIndex] == "true") //父母级别控制

		{

			hideWebChannel();

		    isControlChanIndex = _chanIndex;

		    parentOrLockFlag = 1;

		    disLockFlag = 1; //显示信息 设置标志

			order.style.display ="block";

			document.getElementById("img_1").focus(); // 弹出需要验证密码对话框后获得焦点后

			//document.getElementById("lock").style.background = "images/playcontrol/bg_unlock.jpg";

			//setFocus();

			//document.getElementById("channame").innerHTML = "&nbsp;"+chanNames[_chanIndex];

			document.getElementById("displayLockInfo").innerHTML = '该频道&lt;' + chanNames[_chanIndex] + '&gt;需要验证密码，请选择操作：';

			number = 0;

			return 0;

		}

		else if(isLock[_chanIndex] == 1)  //有锁

		{

		    isControlChanIndex = _chanIndex;

		    parentOrLockFlag = 2;

		    disLockFlag = 1; //显示信息 设置标志

			order.style.display ="block";

			document.getElementById("img_1").focus();  // 弹出需要验证密码对话框后获得焦点后

			//setFocus();

			hideWebChannel();

			document.getElementById("displayLockInfo").innerHTML = '该频道&lt;' + chanNames[_chanIndex] + '&gt;需要验证密码，请选择操作：';

			number = 0;

			return 0;

		}

		else

		{
			
			channelJoined = 0;
			//用户决定跳转频道的时候，关闭任何提示信息

			clealOrder();

			addOrDecChanKey = 0;

			hideWebChannel();

			locationChannel(_chanIndex);

			return 0;

		}

	}



    /**

     * @param _realChannelIndex 实际跳转频道在现在频道列表中的索引

     */

	function locationChannel(_realChannelIndex)

	{

	    currChanIndex = _realChannelIndex;  //解决输入频道号后，再次按频道加减键的问题

	    clearCurrChanAllInfo(); //清除当前频道信息

	    joinChannel(chanNums[_realChannelIndex]);

	    //currChannelId = chanIds[_realChannelIndex];



    }



	/*

	 *清除频道未订购，未解锁提示

	 */

	function clealOrder()

	{

		if(order.style.display == "block")

		{

			order.style.display = "none";

		}

		if(nochannel.style.display == "block")

		{

			nochannel.style.display = "none";

		}

		//还要处理密码输入页面的显示情况

		if(golock1.style.display == "block")

		{

			golock1.style.display = "none";

		}

		disLockFlag = 0;

	}



    var infoIndex = 1;   //提示信息图片索引

	/*

	 *设置焦点

	 */

	function setFocus()

    {

        document.getElementById("img_" + infoIndex).focus();

    }





    var number = 0;

    var timeID = "";

	var inputNumFlag = 0;

    function inputNum(i)

    {

		inputNumFlag = 1;

		// 防止显示提示信息

	    if (showTimer != "")

        {

        	clearTimeout(showTimer);

        }



        // 防止隐藏频道号



        if (hideNumTimer != "")

        {

        	clearTimeout(hideNumTimer);

        }



    	if (showState == 1)

    	{

    		hideInfo();

		}

		if(number * 10 >= 1000)

		{

			return 0;

			//number = number * 10 + i;

		}



		if (timeID != "")

		{

			 clearTimeout(timeID);

		}



		number = number * 10 + i;



		showChannelNum(number);



		// 一秒钟之后切换频道

		//timeID = setTimeout("localPlay("+ number +")", 1000);

		timeID = setTimeout("playByChannelNum("+ number +")", 2000);

        //}

    }







    //用户输入的频道号时的处理



    function playByChannelNum(chanNum)

    {
		number = 0;

		timeID = "";

		inputNumFlag = 0;

		

    	if(disLockFlag == 1)

    	{

    	    clealOrder();

    	}	



		//判断当前输入的频道号是否是正在播放的频道

		if(chanNum == currChannel)

		{

            if(errorFlag == -1 && isControlChanIndex == -1)

            {

                return;

            }

		}

		

	

        var returnIndex = getChanIndexByNum(chanNum);



		if(isSeeking == 1)

		{

			clearTimeout(timeID_check);//清空定时器

			document.getElementById("seekDiv").style.display = "none";

			resetPara_seek();//复位各参数

			//isSeeking = 0;

			mp.resume();

		}

        if(-1 == returnIndex)

        {

            number = 0;

            //弹出提示信息

            nochannel.style.display = "block";

            disLockFlag = 1;

            document.getElementById("displayErrorInfo").innerHTML = '您输入的频道&lt;' + chanNum + '&gt;不存在，请重新选择!';

			setTimeout("cancleCurrAction();",1000);

        }

        else

        {

		    //isControlChanIndex = -1;

			if(channelstr.indexOf(","+chanNum+",") > -1 || Number(chanNum)>999){
				nochannel.style.display = "block";

				disLockFlag = 1;

				document.getElementById("displayErrorInfo").innerHTML = '您输入的频道&lt;' + chanNum + '&gt;不存在，请重新选择!';

				setTimeout("cancleCurrAction();",1000);
				return false;
		   }
            updateChannel(returnIndex);

        }

    }





    // 出现断流后该标志为0

    var errorFlag = -1;



    /** 播放频道的函数

     * @_chanNum 频道号

     */

    function joinChannel(_chanNum)

    {
	
    	number = 0;

         // 将一些状态位复位

    	speed = 1;

        playStat = "play";

        //解决焦点不输入框上的时候，输入数字频道进行跳转

        //，按暂停键后出现暂停图标但是画面没有暂停

        

        isSeeking = 0;

        isJumpTime = 1;

        

        state = "";

        errorFlag = -1;



         // 隐藏提示信息

       	hideInfo();



        // 显示频道号



        preChannel = currChannel;   //重点频道号 preChannel 上一次正常播放的频道号

        preChannelIndex = currChanIndex; //preChannelIndex 上一次正常播放频道的索引

        //preChannelId = currChannelId;

        //nowChanIndex = currChanIndex;



        currChannel = _chanNum;

        addOrDecChanKey = 0;

        disLockFlag = 0;

        pltvStatusFlag = 0;  //时移频道初始化

		isControlChanIndex = -1;

		shiftFlag = 0;



        isSupportPltvStatus();  //判断是否支持时移



       //clearCurrChanAllInfo();  //清除当前频道的信息



        // 切换频道

        mp.leaveChannel();

        if(chanUrls[currChanIndex].indexOf("http") == 0)

		{

			onWebChannel = 1;

			this.webchannel.location.href = chanUrls[currChanIndex] ;

			this.webchanneldiv.style.display = "block";

		}

		else

		{

		    onWebChannel = 0;
			
			//在线人数统计
			 currChannel = _chanNum;
		

        	var temp = mp.joinChannel(_chanNum);
			
			
			/*******add by 郭东阳 start****/
		   if(null != pr2)
		   {
				//将上次播放记录上报，传的是上次的节目号，在第一次播放的时候不走该步






				//var temp = new PlayRecordStat(1);
				//先提交pr2.progId结束播放，再提交chanIndex开始播放






				pr2.servletSubmit2("1","changeChannel",pr2.progId,_chanNum);

				//pr2.servletSubmit("1","removeOnPlayUser",pr2.progId);
		   }
		   else
		   {
			   pr2 = new PlayRecordStat(1);
			   pr2.beginTime = new Date();
			   pr2.progId = _chanNum;
			   pr2.servletSubmit("1","addOnPlayUser",_chanNum);
		   }
			
			/********add by 郭东阳 end****/
		
		
			channelJoined = 1;

			this.webchanneldiv.style.display = "none";

			showChannelNum(_chanNum);

			//显示台标

			showChannelLogo();

			// 五秒后展示提示信息

			//showTimer = setTimeout("showInfo()", 5000);



		}

		//tvms支持,向机顶盒写入mediacode

		

    }



    function showChannelNum(num)

    {

        // 如果机顶盒来控制,则不展示

    	if (mp.getNativeUIFlag() == 1 && mp.getChannelNoUIFlag() == 1)

    	{

    		return;

    	}

        if (hideNumTimer != "")

        {

        	clearTimeout(hideNumTimer);

        }



        var tabdef = '<table width=200 height=30><tr align="right"><td><font color=green size=20>';

        tabdef += num;

        tabdef += '</font></td></tr></table>';

        document.getElementById("topframe").innerHTML=tabdef;



        // 五秒钟后隐藏频道号

        hideNumTimer = setTimeout("hideChannelNum()",5000);

    }



    function hideChannelNum()

    {

		number = 0;

        document.getElementById("topframe").innerHTML="";

    }



    function setMuteFlag()   //静音

    {

    	var muteFlag = mp.getMuteFlag();
    	if(muteFlag == 1)
    	{
            mp.setMuteFlag(0);
			var tabdef = '<table width=120 height=30><tr><td><img src="images/playcontrol/playChannel/muteoff.png">';
            tabdef += '</img></td></tr></table>';
            document.getElementById("bottomframeMute").innerHTML = tabdef;
			clearTimeout(muteTimer);
			muteTimer = setTimeout(function(){document.getElementById("bottomframeMute").innerHTML = "";}
			,3000);
    	}
    	else
    	{
			 var tabdef = '<table width=120 height=30><tr><td><img src="images/playcontrol/playChannel/muteon.png">';
            tabdef += '</img></td></tr></table>';
			document.getElementById("bottomframeMute").innerHTML = tabdef;
            mp.setMuteFlag(1);
        }

    }



    function setAllowTrickmodeFlag()

    {

    	var allowTrickMode = mp.getAllowTrickmodeFlag();

    	if(allowTrickMode == 1)

    	{

            mp.setAllowTrickmodeFlag(0);

    	}

    	if(allowTrickMode == 0)

    	{

            mp.setAllowTrickmodeFlag(1);

        }

    }



    function setVideoAlpha(alpha)

    {

    	mp.setVideoAlpha(alpha);

    }



    function setSingleMode()

    {

    	mp.setSingleOrPlaylistMode(0);

    }



    function setPlaylistMode()

    {

    	mp.setSingleOrPlaylistMode(1);

    }



    function pigPlay(left, top, width, height)

    {

    	mp.setVideoDisplayArea(left,top,width,height);

		mp.setVideoDisplayMode(0);

		mp.refreshVideoDisplay();

    }



    function fullscreenPlay()

    {

    	//mp.setVideoDisplayArea(left,top,width,height);

		mp.setVideoDisplayMode(1);

		mp.refreshVideoDisplay();

    }



    function destoryMP()

    {

        mp.leaveChannel();

        mp.stop();

    }





    function seekPlay(timePos)

    {

         mp.playByTime(1,timePos,1);

         document.getElementById("topframe").innerHTML = "";

    }



     function seekInput(i)

    {

        // 最大时间23:59:59

        if (timeIndex == 0 && i > 2)

        {

        	return;

        }



        if (timeIndex == 1 && hour == 2 && i > 3)

        {

        	return;

        }

    	if ((timeIndex == 2 || timeIndex == 4) && i > 5)

    	{

    		return;

    	}



        if(timeIndex%2 == 0)

        {

            if(i > 5)

            {

                return 0;

            }

        }

        timeIndex++;

        switch (timeIndex)

        {

            case 1:

                hour = i;

                seekTimeString = hour + "|_:__:__";

                break;

            case 2:

                hour =  hour * 10 + i;

                seekTimeString = hour + ":|__:__";

                break;

            case 3:

                min = i;

                seekTimeString = hour + ":" + min + "|_:__";

                break;

            case 4:

                min = min * 10 + i;

                seekTimeString = hour + ":" + min + ":|__";

                break;

            case 5:

                sec = i;

                seekTimeString = hour + ":" + min + ":" + sec + "|_";

                break;

            case 6:

                sec = sec * 10 + i;

                seekTimeString =  hour + ":" + min + ":" + sec;

                break;

        }

        var tabdef = "<table width=120 height=30><tr><td><font color=blue size=20>";

        tabdef += seekTimeString;

        tabdef += "</font></td></tr></table>";

        document.getElementById("topframe").innerHTML = tabdef;

        if(timeIndex == 6)

        {

            state = "";



            var timeStamp = (hour * 60 * 60 + min * 60 + sec);



            // 频道需要重新设置时间格式



            timeStamp = "";

            var dateobj = new Date();

            var year = dateobj.getYear();

			var month = dateobj.getMonth() + 1;

			var day = dateobj.getDate();



			if (month < 10)

			{

				month = "0" + month;

			}

			if (day < 10)

			{

				day = "0" + day;

			}

            if (hour < 10)

            {

            	hour = "0" + hour;

            }

            if (min < 10)

            {

            	min = "0" + min;

            }

            if (sec < 10)

            {

            	sec = "0" + sec;

            }



            timeStamp += year + month + day + "T" + hour + min + sec + "Z";



            hour = 0;

            min = 0;

            sec = 0;

            timeIndex = 0;

            seekTimeString = "|__:__:__";



            // 一秒钟这后切换频道

            setTimeout("seekPlay('" + timeStamp + "')", 1000);

        }

    }



    function seek()

    {

   		resetTimer();



    	if (showState == 1)

    	{

    		hideInfo();

    	}



        if(state == "seek")

        {

            state = "";

            seekTimeString = "|__:__:__";

            hour = 0;

            min = 0;

            sec = 0;

            timeIndex = 0;

            document.getElementById("topframe").innerHTML = "";

        }

        else

        {

            state = "seek";

            var tabdef = "<table width=60 height=30><tr><td><font color=white size=20>";

            tabdef += seekTimeString;

            tabdef += "</font></td></tr></table>";

            document.getElementById("topframe").innerHTML = tabdef;

        }

    }



   function showFavourite()

   {

        var nextUrl = "FavoAction.jsp?ACTION=show&enterFlag=check";

        pr.submit(nextUrl);

   }





    // 在本页面进行频道切换时需要调用此函数 保留该函数

    function localPlay(chanNum)

    {

    	var nextUrl = "chanInfoHint.jsp?ChanNum=" + chanNum;



    	var chanIndex = getChanIndexByNum(chanNum);



    	// 如果频道不存在,则跳到提示页面



    	if (chanIndex == -1)

    	{

    		pr.submit(nextUrl);

    	}



    	chanNum = chanNumList[chanIndex][0];



    	 // 如果已经定购,则直接播放



    	if (chanNumList[chanIndex][1] == 1)

    	{

    		joinChannel(chanNum);

    	}

    	// 跳转到提示页面



    	else

    	{

    		// 如果是在当前页面进行频道切换,则需要上报播放信息



    		if (null != pr)

    		{

        		pr.submit(nextUrl);

        	}

        	// 否则直接跳转

        	else

        	{

        		location.href = nextUrl;

        	}

    	}

    }



    // 根据频道号获取频道在本地数组的索引  重要函数

    //可以在该函数进行判断是否订购、加解锁

    /*

    function getChanIndexByNum(chanNum)

    {

    	var chanIndex = -1;



    	for (i = 0; i < totalNum; i++)

    	{

    		if (chanNum == chanNumList[i][0])

    		{

    			chanIndex = i;

    			break;

    		}

    	}



    	return chanIndex;

    }

    */



    function getChanIndexByNum(chanNum)

    {

    	var chanIndex = -1;



    	for (i = 0; i < chanSize; i++)

    	{

    		if (chanNum == chanNums[i])

    		{

    			chanIndex = i;

    			break;

    		}

    	}

    	return chanIndex;

    }



    // 向上找一个可播放的频道



    function getUpNum(chanNum)

    {

    	var currIndex = getChanIndexByNum(chanNum);



    	if (currIndex == totalNum - 1)

    	{

    		currIndex = 0;

    	}

    	else

    	{

    		currIndex += 1;

    	}



    	for (i = currIndex; i < currIndex + totalNum; i++)

    	{

    		var index = i % totalNum;

    		if (chanNumList[index][1] == 1)

    		{

    			currIndex = index;

    			break;

    		}

    	}



    	return chanNumList[currIndex][0];

    }



    // 向下找一个可以播放的频道

    function getDownNum(chanNum)

    {

    	var currIndex = getChanIndexByNum(chanNum);



    	if (currIndex == 0)

    	{

    		currIndex = totalNum - 1;

    	}

    	else

    	{

    		currIndex -= 1;

    	}



    	for (i = currIndex; i > currIndex - totalNum; i--)

    	{

    		var index = (i + totalNum) % totalNum;

    		if (chanNumList[index][1] == 1)

    		{

    			currIndex = index;

    			break;

    		}

    	}



    	return chanNumList[currIndex][0];

    }



    // 将所有定时器复位

    function resetTimer()

    {

    	if(hideTimer != "")

        {

            clearTimeout(hideTimer);

        }



        if (showTimer != "")

        {

        	clearTimeout(showTimer);

        }



        if (hideNumTimer != "")

        {

        	clearTimeout(hideNumTimer);

        }



        if (timeID != "")

        {

       	     clearTimeout(timeID);

        }

    }



    function showBookmark()

    {

        var nextUrl = "BookMark.jsp";

        pr.submit(nextUrl);

    }





    function noChannelSure()

    {

        nochannel.style.display = "none";

        disLockFlag = 0;

    }











	/*解码页面使用 */

	function clickAction(value)

    {

        if (value)

        {

            /* C03B110版本开发 mod by f60019624 for AB4D04518 2007-7-2 begin */

            if(isValidString(document.getElementById("pwd").value))

            {

                if (isValidTimeStamp(timeStamp))

                {

                    //var pwd = document.getElementById("pwd").value;



                    var user = "<%=_userid%>";

                    var mwdb = iPanel.ioctlRead("encyptedcontent:original="+pwd);

                    encrptedPassword = iPanel.ioctlRead("encyptedcontent:original="+mwdb+user+locktimeStamp);

                    /* mod by z00104564 for AB4D05639 2008-01-11 begin */

                    if(encrptedPassword != "")

                    {

                         pwd  = mwdb;

                    }

                    /* mod by z00104564 for AB4D05639 2008-01-11 end */

                }

				

				var tmpChanIndex = -1;

				if(isControlChanIndex != -1)

				{

				    tmpChanIndex = isControlChanIndex;

				}

				else

			    {

				    tmpChanIndex = currChanIndex;

				}

				

				var strUrl = "PassCheckInfo_lock.jsp?&pwd=" + pwd + "&encrptedPassword=" + encrptedPassword + "&timeStamp=" + locktimeStamp;

				//strUrl += "&currChanNum=" + chanNums[currChanIndex] + "&currChannelId=" + chanIds[currChanIndex] + "&currChanIndex=" + currChanIndex;

				strUrl += "&currChanNum=" + chanNums[tmpChanIndex] + "&currChannelId=" + chanIds[tmpChanIndex] + "&currChanIndex=" + tmpChanIndex;

				document.getElementById("golock").location.href = strUrl;

                /* C03B110版本开发 mod by f60019624 for AB4D04518 2007-7-2 end */

            }

        }

        else

        {

            //hideLockInfo();

			

            cancleCurrAction();

			showWebChannel();

			//用户取消验证时恢复当前正在播放频道的索引

			//currChanIndex = getChanIndexByNum(currChannel);

        }

    }



    //判断输入字符是否还有非法字符（"'#\空格）



    function isValidString(s)

    {

    	var tmpString = s;

    	var flag = 0;

    	var character = "";

    	var validString = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.@";

    	if(tmpString.length == 0)

    	{

    	    document.getElementById("errorinfo").innerHTML = "密码不能为空，请重新输入";

			document.getElementById("pwd").focus();

    	    return false;

    	}

    	else

    	{

    	    for (var i = 0; i < tmpString.length; i++)

    	    {

    		    character=tmpString.substring(i,i+1);

    		    if(validString.indexOf(character) == -1)

    		        flag++;

    	    }

    	    if (flag!=0)

    	    {

    		    document.getElementById("errorinfo").innerHTML = "密码只能由数字，大小写字母，.，@组成，请重新输入";

				document.getElementById("pwd").focus();

				return false;

    	    }

    	    else

    		    return true;

        }

    }

    /*解码页面使用 */

    function isValidTimeStamp(s)

    {

    	var tmpString = s;

    	var flag = 0;

    	var character = "";

    	var validString = "0123456789";

    	if(tmpString.length == 0 || tmpString.length < 14)

    	{

    	    return false;

    	}

    	else

    	{

    	    for (var i = 0; i < tmpString.length; i++)

    	    {

    		    character=tmpString.substring(i,i+1);

    		    if(validString.indexOf(character) == -1)

    		        flag++;

    	    }

    	    if (flag!=0)

    	    {

    	        return false;

    	    }

    	    else

    		    return true;

        }

    }



	function showErrorInfo()

	{

		document.getElementById("errorinfo").innerHTML = "密码输入错误，请重新输入";

		document.getElementById("pwd").focus();

	}

	function hideErrorInfo()

	{

		document.getElementById("errorinfo").innerHTML = "";

	}

	

	function hideWebChannel()

	{

		if(onWebChannel == 1)

		{

			this.webchanneldiv.style.display = "none";

		}	

	}

	

	function showWebChannel()

	{

		if(onWebChannel == 1)

		{

			this.webchanneldiv.style.display = "block";

		}	

	}

	

	function setpwd(spwd)

	{

		pwd = spwd.value;

	}



	function getpwd(spwd)

	{

		 spwd.value = "" ;

	}



	function goCheck(spwd)

	{

		 pwd =  spwd.value;

		 clickAction(true);

	}







    /**

     *seek相关的参数及方法begin

     */



    /***********************************************************/



    //Utility.setBrowserWindowAlpha(0);



    //var currTime = mp.getCurrentPlayTime();

    //var mediaTime = mp.getMediaDuration();节目总时长

    //var timePerCell = mediaTime / 100;



	var currTime = 0;

    var mediaTime = 0;

    var timePerCell = 0;

    var currCellCount = 0;

	var isSeeking = 0;

    //var tempCurrTime = 0;





    /**

     *显示/隐藏进度条

     *控制进度条是否显示的标示位及pause/resume播放状态的切换

     */

    var timeID_jumpTime = "";



    function displaySeekTable()

    {

        mediaTime = mp.getMediaDuration(); //秒



        // 如果读到时间为零则取1小时

        //if (mediaTime <= 0 || mediaTime > 3600) mediaTime = 3600;

		if (mediaTime <= 0)  mediaTime = 3600;

		



        timePerCell = mediaTime / 100;



        //isSeeking等于0时展示进度条及跳转框

        if(isSeeking == 0)

        {

            isSeeking = 1;

            currTime = mp.getCurrentPlayTime();// 时间格式 YYYYMMDDThhmmssZ



            processSeek(currTime);



            document.getElementById("fullTime").innerHTML = getCurrTime();

            document.getElementById("beginTime").innerHTML = getShiftBeginTime();



            document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/pause.gif" width="20" height="22"/>';

            document.getElementById("seekDiv").style.display = "block";


			//document.getElementById("testDiv1").innerText = "pOP--iJT=" + isJumpTime +"---iS="+isSeeking+"--sF="+shiftFlag+"--sS="+showState;
            //6秒后隐藏跳转输入框所在的div

            clearTimeout(timeID_jumpTime);

            timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
			//document.getElementById("testDiv2").innerText = "pOP2--iJT=" + isJumpTime +"---iS="+isSeeking+"--sF="+shiftFlag+"--sS="+showState;
            checkSeeking();//调用方法检测进度条及跳转框的状态

        }

        //isSeeking等于1时

        else

        {

        		clearTimeout(timeID_check);//清空定时器

	            resetPara_seek();//复位各参数

	            document.getElementById("seekDiv").style.display = "none";

        }

    }



    /**

     *生成进度条，此方法只是生成背景，具体进度在processSeek方法中生成

     *整个进度条长度为500像素，每个td即片长的1%是5像素

     */

    function genSeekTable()

    {

        var seekTableDef = "";

        seekTableDef = '<table width="1100px" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';

        for(var i = 0; i < 100; i++)

        {

            /*

            if(i < currCellCount)

            {

                seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" bgcolor="yellow"></td>';

            }

            else

            {

                seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" bgcolor="transparent"></td>';

            }

            */



            //seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" style="border-style:none;background-image:url(images/playcontrol/seeking.gif);filter:AlphaImageLoader(src=\'images/playcontrol/seeking.gif\');"></td>';

            //seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" bgcolor="#DAA520" style="border-style:none;filter:Alpha(opacity=50);"></td>';

            seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="25" style="border-style:none;"></td>';

            //filter:Alpha(opacity=100);

            //seekTableDef +='<td id="td_' + String(i+1) + '" width="5" height="30" style="border-style:none;"><img src="images/playcontrol/seeking.gif" width="6" height="30" /></td>';



        }

        seekTableDef += '</tr></table>';



        document.getElementById("seekTable").innerHTML = seekTableDef;

    }



    /**

     *根据时间来显示进度

     *@_currTime 当前播放的时间长度  

     */

    function processSeek(_currTime)

    {

        //如果入参时间非法，则重取一下当前时间

        if(null == _currTime || _currTime.length != 16 || _currTime == undefined)

        {

            _currTime = mp.getCurrentPlayTime();

        }

        if(_currTime < 0)

        {

            _currTime = 0;

        }



       // 有时候时间会读不准，所以每次都读    注视掉不咬每次都读，影响性能

       //mediaTime = mp.getMediaDuration();

       var currPlayTime = _currTime;



       // 如果读到时间为零则取1小时  

       //if (mediaTime <= 0 || mediaTime > 3600) mediaTime = 3600;

	   //if (mediaTime <= 0) mediaTime = 3600;

       //timePerCell =  mediaTime / 100;





        // 得到到前播放相对时间，单位秒

        _currTime = getRelativeTime(_currTime);
		
		
		//document.getElementById("testDiv").innerText = "***relativeTime=====" + _currTime;



        currCellCount = Math.floor(_currTime / timePerCell);

        //document.getElementById("testDiv").innerText += "***timePerCell=====" + timePerCell + "***currCellCount=====" + currCellCount;

        if(currCellCount > 100)

        {

            currCellCount = 100;

        }



        if(currCellCount < 0)

        {

            currCellCount = 0;

        }



        if(currCellCount < 49)

        {

            document.getElementById("seekPercent").innerHTML = currCellCount + "%";

        }

        else if(currCellCount >= 49 && currCellCount <= 50)

        {

            document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + (String(currCellCount)).substring(0,1) + '</span><span style="color:white;">' + (String(currCellCount)).substring(1,2) + "%</span>";

        }

        else if(currCellCount >= 51 && currCellCount <= 53)

        {

            document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + currCellCount + '</span><span style="color:white;">%</span>';

        }

        else if(currCellCount >= 54)

        {

            document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + currCellCount + "%</span>";

        }



		var tmp1 = getCurrPlayTime(currPlayTime);
		
		//document.getElementById("testDiv").innerText += "***currPlayTime=====" + tmp1;

		var tmp2 = getShiftBeginTime();



		// 规避当前时间显示小于时移开始时间的问题

		if (tmp1 < tmp2) tmp1 = tmp2;

        document.getElementById("currTimeShow").innerHTML = tmp1;

        document.getElementById("fullTime").innerHTML = getCurrTime();

        document.getElementById("beginTime").innerHTML = tmp2;

		document.getElementById("progressBar").style.width = currCellCount / 100 * 1100 + "px";

    }



/**

     *检测进度条及跳转框的状态



     */

    var timeID_check = 0;

    var preInputValueHour = "";//上一次检测时，文本框中的值

    var preInputValueMin = ""



    function checkSeeking()

    {

        if(isSeeking == 0)

        {

            //如果没有显示进度条及跳转框，重置定时器

            clearTimeout(timeID_check);

        }

        else

        {

            //下面一行代码的作用：获取不到文本框中的值，动态刷新文本框所在div可以解决

            if(playStat != "fastrewind" && playStat != "fastforward")

            {

                document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/pause.gif" width="20" height="22"/>';

            }
            var inputValueHour = document.getElementById("jumpTimeHour").value;

            var inputValueMin = document.getElementById("jumpTimeMin").value;

            //每隔1秒检测一次进度条的显示情况

            clearTimeout(timeID_check);

            timeID_check = setTimeout("checkSeeking();",1000);



            //当播放状态是快进或快退时，刷新进度条



            if(playStat == "fastrewind" || playStat == "fastforward")

            {

            	currTime = mp.getCurrentPlayTime();

                processSeek(currTime);

            }

            //如果上次检测时文本框中的内容和当前文本框中的内容不相符时，重置定时器


            if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)

            {


                var tempTimeID = timeID_jumpTime;

                //6秒后隐藏跳转输入框所在的div

                clearTimeout(tempTimeID);

                timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);

                preInputValueHour = inputValueHour;

                preInputValueMin = inputValueMin;

            }

        }



    }



    /***********************************************************/

    /**

     *seek相关的参数及方法end

     */





    function convertTime(_time)

    {

        if(null == _time || _time.length == 0)

        {

            _time = mp.getMediaDuration();

        }



        var returnTime = "";



        var time_min = "";

        var time_hour = "";



        /*

        time_min = Math.floor(_time / 60);

        time_hour = String(Math.floor(time_min / 60));

        time_min = String(time_min % 60);

        */



        var tempIndex = -1;

        tempIndex = (String(_time / 60)).indexOf(".");

        if(tempIndex != -1)

        {

            time_min = (String(_time / 60)).substring(0,tempIndex);

            tempIndex = -1;

        }

        else

        {

            time_min = String(_time / 60);

        }



        tempIndex = (String(time_min / 60)).indexOf(".");

        if(tempIndex != -1)

        {

            time_hour = (String(time_min / 60)).substring(0,tempIndex);

            tempIndex = -1;

        }

        else

        {

            time_hour = String(time_min / 60);

        }



        time_min = String(time_min % 60);









        if("" == time_hour || 0 == time_hour)

        {

            time_hour = "00";

        }



        if("" == time_min || 0 == time_min)

        {

            time_min = "00";

        }



        if(time_hour.length == 1)

        {

            time_hour = "0" + time_hour;

        }



        if(time_min.length == 1)

        {

            time_min = "0" + time_min;

        }



        returnTime = time_hour + ":" + time_min;



        return returnTime;

    }

	

    function checkJumpTime(pHour, pMin)

    {

        if(isEmpty(pHour))

        {

            return false;

        }

        else if(!isNum(pHour))

        {

            return false;

        }



        if(isEmpty(pMin))

        {

            return false;

        }

        else if(!isNum(pMin))

        {

            return false;

        }



        else if(!isInMediaTime(pHour, pMin))

        {

            return false;

        }

        else

        {

            return true;

        }



    }



    function isEmpty(s)

    {

        return ((s == undefined) || (s == "") || (s == null) || (s.length == 0));

    }





    function isNum(s)

    {

        var nr1=s;

        var flg=0;

        var cmp="0123456789"

        var tst ="";



        for (var i=0;i<nr1.length;i++)

        {

            tst=nr1.substring(i,i+1)

            if (cmp.indexOf(tst)<0)

            {

                flg++;

            }

        }



        if (flg == 0)

        {

            return true;

        }

        else

        {

            return false;

        }

    }



    //判断是否在播放时长内

    function isInMediaTime(pHour, pMin)

    {

        var currTime = new Date();

        var inputTime = new Date();

        var shiftLength = mp.getMediaDuration();

        var beginTime = new Date(currTime.getTime() - shiftLength * 1000);

        

         

        inputTime.setHours(parseInt(pHour,10));

        inputTime.setMinutes(parseInt(pMin,10));

        inputTime.setSeconds(0);



        return  (((beginTime.getTime() - inputTime.getTime()) <= 0) && ((currTime.getTime() - inputTime.getTime()) > 0));

    }





	var timeForShow = 0;

	/**

	 * _time YYYYMMDDhhmmss

	 */



    function jumpToTime(_time)

    {

    	timeForShow = 0;

        playByTime(_time);

        processSeek(_time);

        //displaySeekTable();

		jumpToTimeReset();

    }

	

	/**

	 * 输入跳转时间以后，并验证成功跳转后的恢复参数

	 */

	function jumpToTimeReset()

	{

		//输入参数清空

		document.getElementById("jumpTimeHour").value = "";

        document.getElementById("jumpTimeMin").value = "";

		//失去焦点

		document.getElementById("ensureJump").blur();

		document.getElementById("jumpTimeHour").focus();

		//跳转输入框隐藏

		document.getElementById("jumpTimeDiv").style.display = "none";

		// 跳转标志设置为0

		isJumpTime = 0;

	}







    //跳转提示信息隐藏后，重置相关参数

    function resetPara_seek()

    {

        clearTimeout(timeID_jumpTime);

        isSeeking = 0;

        isJumpTime = 1;

        preInputValueHour = "";

        preInputValueMin = "";

        document.getElementById("jumpTimeDiv").style.display = "block";

        document.getElementById("jumpTimeImg").style.display = "block";

        document.getElementById("jumpTimeHour").value = "";

        document.getElementById("jumpTimeMin").value = "";

        document.getElementById("timeError").innerHTML = "";

        document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/playChannel/pause.gif" width="20" height="22"/>';

    }







    /**

     *隐藏跳转框所在的div

     */

    function hideJumpTimeDiv()

    {

        clearTimeout(timeID_jumpTime);



		isJumpTime = 0;

		preInputValueHour = "";

		preInputValueMin = "";

		document.getElementById("jumpTimeHour").value  = "";

		document.getElementById("jumpTimeMin").value  = "";

		document.getElementById("jumpTimeDiv").style.display = "none";

		document.getElementById("jumpTimeImg").style.display = "none";

       //document.getElementById("testDiv4").innerText = "hideJumpTime--iJT=" + isJumpTime +"---iS="+isSeeking+"--sF="+shiftFlag+"--sS="+showState;

    }





    /**

     *点击跳转按钮，对数据进行校验及跳转



     */

    function clickJumpBtn()

    {


        var inputValueHour = document.getElementById("jumpTimeHour").value;

        var inputValueMin = document.getElementById("jumpTimeMin").value;





        //校验通过，跳转到相应时间，并隐藏跳转框所在div

		if(checkJumpTime(inputValueHour,inputValueMin))

        {

        	var hour = parseInt(inputValueHour,10);

			var min = parseInt(inputValueMin,10);

			

        	var dateobj = new Date();
			//modify by chenzhiqiang at 2013.07.09 for 输入的时间是本地时间不是utc时间，改为UTC时间(setHours -8 再 getHours )
        	//if(stbType != 'EC2108V3H' && stbType != 'EC1308V2H')stbType="EC2108V3H_pub"
			if (stbType.indexOf("EC2108V3H") != -1 || stbType.indexOf("EC1308V2H") != -1)
			{
				dateobj.setHours(hour - 8);
			 
			    hour = dateobj.getHours();
			}

     		var year =  dateobj.getYear();     

			var month = dateobj.getMonth() + 1;

			var day = dateobj.getDate();
			//modify end
			

			if (month < 10) month = "0" + month;

			if (day < 10) day = "0" + day;

			if (hour < 10) hour = "0" + hour;

			if (min < 10) min = "0" + min;

		

			var timeStamp = "" +  year + month + day + "T" + hour + min + "00" + "Z";

	

            clearTimeout(timeID_jumpTime);

            isJumpTime = 0;

            document.getElementById("jumpTimeDiv").style.display = "none";

            document.getElementById("jumpTimeImg").style.display = "none";

            document.getElementById("jumpTimeHour").value = "";

            document.getElementById("jumpTimeMin").value = "";



            jumpToTime(timeStamp);
			pauseOrPlay();

        }

        //校验不通过，提示用户时间输入不合理

        else

        {        	

            document.getElementById("jumpTimeHour").value = "";

            document.getElementById("jumpTimeMin").value = "";

            document.getElementById("timeError").innerHTML = "时间输入不合理，请重新输入！";

            processSeek();

            preInputValueHour = "";

            preInputValueMin = "";

            

            document.getElementById("jumpTimeHour").focus();

            

            //6秒后隐藏跳转输入框所在的div"

            clearTimeout(timeID_jumpTime);

            timeID_jumpTime = setTimeout("hideJumpTimeDiv();",10000);

        }

    }
// 更改处 跳转链接
     function show(){
	if(JbFlag=='open')
		{
	 window.location.href = recommendList_all[33][picIndexLeftBot].vasUrl+"&providerid=hw&iaspuserid=<%=iaspuserid%>&iaspadsl="+NetUserID+"&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&right=0&down=1";
		}
	else{
		pressOK();
	}
	 }

    // 得到当前时间

    function getCurrTime()

    {

    	var currTime = new Date();    	

    	var min = currTime.getMinutes();

    	var sec = currTime.getSeconds();

    	if (sec >= 30) currTime.setMinutes(min + 1);

    	

    	var hour = currTime.getHours();

    	min = currTime.getMinutes();

    	

    	if (hour < 10) hour = "0" + hour;

    	if (min < 10) min = "0" + min;    	

    	return hour + ":" + min;

    }



    // 得到时移的开始时间

    function getShiftBeginTime()

    {

    	var currTime = new Date();  

    	      

    	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);

    	var min = beginTime.getMinutes();

    	

    	var sec = beginTime.getSeconds();

    	if (sec >= 30) beginTime.setMinutes(min + 1);   	

    	var hour = beginTime.getHours();

    	min = beginTime.getMinutes();

    	

    	if (hour < 10) hour = "0" + hour;

    	if (min < 10) min = "0" + min;   

    	 	

    	return hour + ":" + min;  

    }



    

	/**

	 * 得到当前播放的时间

	 * @ currPlayTime 格林尼治时间 格式YYYYMMDDThhmmssZ

	 */

    function getCurrPlayTime(currPlayTime)

    {

    	//转化UTC时间

    	currPlayTime = parseUtcTime(currPlayTime);
   	    
		currPlayTime = String(currPlayTime);
		
		//document.getElementById("testDiv").innerText += "currPlayTime.tosubStr====" + currPlayTime;
        /*
    	var sec = currPlayTime.getSeconds();

    	if (sec >= 30) currPlayTime.setMinutes(min + 1);   

    	

    	var hour = currPlayTime.getHours();

    	var min = currPlayTime.getMinutes();

    	

    	if (hour < 10) hour = "0" + hour;

    	if (min < 10) min = "0" + min;

		*/

		

		var hour = currPlayTime.substr(16,2);

		var min = currPlayTime.substr(19,2);

    	return hour + ":" + min;  

    }



    // 得到当前播放的相对时间，单位秒 

	//@ currPlayTime 格林尼治时间 格式YYYYMMDDThhmmssZ

    function getRelativeTime(currPlayTime)

    {

    	currPlayTime = parseUtcTime(currPlayTime);

    	var currTime = new Date(); 

    	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);

    	var relativeTime = (currPlayTime.getTime() - beginTime.getTime())/1000;

    	return relativeTime;

    }



    // 解析UTC时间为一日期对象

    function parseUtcTime(utcTime)

    {

    	var year = parseInt(utcTime.substr(0, 4));

    	var month = parseInt(utcTime.substr(4, 2));

    	var day = parseInt(utcTime.substr(6, 2));

    	var hour = parseInt(utcTime.substr(9, 2));

    	var min = parseInt(utcTime.substr(11, 2));

    	var sec = parseInt(utcTime.substr(13, 2));

    	// 处理parseInt("0X")等于零的问题

    	if (month == 0) month = parseInt(utcTime.substr(5,1));

    	if (day == 0) day = parseInt(utcTime.substr(7,1));

    	if (hour == 0) hour = parseInt(utcTime.substr(10,1));

    	if (min == 0) min = parseInt(utcTime.substr(12,1));

    	if (sec == 0) sec = parseInt(utcTime.substr(14,1));

		var d =  new Date(year, month -1, day, hour , min, sec);
		//add xie LiMin 20130710
		//if(stbType == 'EC2108V3H' || stbType == 'EC1308V2H')
		if (stbType.indexOf("EC2108V3H") != -1 || stbType.indexOf("EC1308V2H") != -1)
		{
			d =  new Date(year, month - 1, day, hour + 8 , min, sec);
		}
   	 	return d;

    }

	

	function loadChannelData()

	{

		loadDataIframe.location.href = "GetChannelData.jsp?<%=request.getQueryString()%>";

	}

	

	setTimeout("loadChannelData();",500);

</script>



<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent" onLoad="init()" onUnload="destoryMP();">



	<div id="apDiv14" style="display:none; left: 450px; top: 250px;">

  <table width="365" height="220" border="0" cellspacing="0" cellpadding="0" background="playimages/last_quit.png">

    <tr>

      <td height="220"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">

        <tr>

          <td id="apDiv141" height="45" colspan="4" align="center" class="allbb" style="color: #fff; font-size: 30px; padding-bottom: 20px; padding-top: 20px;">快捷入口</td>

        </tr>

        <tr style="margin-top: 30px;">

          <td width="" height="70" rowspan="2" align="center">

          </td>

           <td align="center"><a href="javascript:tuichu()" id="myplay" style="color: #fff;  background: #f8c64f; padding: 10px 40px;  font-size: 26px;">辽视</a></td>

          <td align="center"><a href="javascript:jixu()" style="color: #fff; background: #ff784e; padding: 10px 15px; font-size: 26px;">热门辽视</a></td>

          <td width="" rowspan="2" align="center">          

          </td>


        </tr></table></td>

    </tr>

  </table>
</div>



<div id="testDiv0" style="position:absolute ; top:30px; left:32px; font-size:24px; color:#FF9900; width:540px;z-index:5;"></div>
<div id="testDiv1" style="position:absolute ; top:70px; left:32px; font-size:24px; color:#FF9900; width:540px; z-index:5;"></div>
<div id="testDiv2" style="position:absolute ; top:110px; left:32px; font-size:24px; color:#FF9900; width:540px;z-index:5;"></div>
<div id="testDiv3" style="position:absolute ; top:150px; left:32px; font-size:24px; color:#FF9900; width:540px;z-index:5;"></div>
<div id="testDiv4" style="position:absolute ; top:150px; left:32px; font-size:24px; color:#FF9900; width:540px;z-index:5;"></div>


<style>
  #apDiv14 {
  position:absolute;
  width:365px;
  height:220px;
  z-index:1;
}
</style>


<div id="topframe" style="position:absolute;left:1000px; top:8px; width:200px; height:30px; z-index:1">

</div>
<!-- div id="bottomframe" style="position:absolute;left:65px; top:400px; width:600px; height:150px; z-index:1;display:none">

    <table width="570"  border ="0" bgcolor="transparent">

	   <tr>

         <td width="20" height="20">&nbsp;</td>

	     <td bgcolor="#000080" width="500">

		   <table width="0" height="20" border="0" cellspacing="0" cellpadding="0">

             <tr>

		       <td id="volumeBar" bgcolor="#DAA520"></td>

             </tr>

           </table>

         </td>

	    <td width="50" style="color:#00ff00; font-size:20px" id="volumeValue">&nbsp;</td>

      </tr>

	</table>

</div -->
<!--音量修改-->
<div id="bottomframe" style="position:absolute;left:280px; top:550px; width:1200px; height:100px; z-index:1;display:none;">
    <div id="volume_bar">
		<div id="volume_num"></div>
		<div id="press" style="background:#330099 ;">
			<div id="icon_1" class="icon" style="left:0px;top:30px;"></div>
			<div id="icon_2" class="icon" style="left:40px;top:30px;"></div>
			<div id="icon_3" class="icon" style="left:80px;top:30px;"></div>
			<div id="icon_4" class="icon" style="left:120px;top:30px;"></div>
			<div id="icon_5" class="icon" style="left:160px;top:30px;"></div>
			<div id="icon_6" class="icon" style="left:200px;top:30px;"></div>
			<div id="icon_7" class="icon" style="left:240px;top:30px;"></div>
			<div id="icon_8" class="icon" style="left:280px;top:30px;"></div>
			<div id="icon_9" class="icon" style="left:320px;top:30px;"></div>
			<div id="icon_10" class="icon" style="left:360px;top:30px;"></div>
			<div id="icon_11" class="icon" style="left:400px;top:30px;"></div>
			<div id="icon_12" class="icon" style="left:440px;top:30px;"></div>
			<div id="icon_13" class="icon" style="left:480px;top:30px;"></div>
			<div id="icon_14" class="icon" style="left:520px;top:30px;"></div>
			<div id="icon_15" class="icon" style="left:560px;top:30px;"></div>
			<div id="icon_16" class="icon" style="left:600px;top:30px;"></div>
			<div id="icon_17" class="icon" style="left:640px;top:30px;"></div>
			<div id="icon_18" class="icon" style="left:680px;top:30px;"></div>
			<div id="icon_19" class="icon" style="left:720px;top:30px;"></div>
			<div id="icon_20" class="icon" style="left:760px;top:30px;"></div>
		</div>
		<div id="volumeValue" style="position:absolute;left:850px;top:45;width:40px;color:#FFFFFF;font-size:36px;"></div>
		<div id="volumeValue1" style="position:absolute;left:900px;top:45;width:40px;color:#FFFFFF;font-size:36px;width:100px;height:131px">
		<img src="img/nav0.jpg" width="100px" height="131px"/>
		</div>
	</div>
</div>

<div id="bottomframe1" style="position:absolute;left:1px; top:380px; width:600px; height:150px; z-index:1">

</div>

<!-- 左下显示静音信息需要特殊处理-->

<div id="bottomframeMute" style="position:absolute;left:15px; top:380px; width:600px; height:150px; z-index:1">

</div>
<div id="TrackImg" style="position:absolute; top:320px; left:30px;">
</div>
<!-- 直播节目信息条-->
<div id="filmInfo22" style="position:absolute;width:160px; height:100px;left:1100px;top:500px; z-index:3;">
</div>
<div id="filmInfo1" style="position:absolute;left:20px; top:500px; width:1240px; height:150px; z-index:1;">


   <iframe name="filmInfo" id="filmInfo" src="" scroll="no" height="150px" width="1240px" bgcolor="transparent" allowtransparency="true" frameborder="0" style="border:0px;">

  </iframe>

</div>  
<div id="filmZbldInfo1" style="position:absolute; width:1280px; height:720px; z-index:1;">

   <iframe name="filmZbldInfo" id="filmZbldInfo" src="" scroll="no" height="720px" width="1280px" bgcolor="transparent" allowtransparency="true" frameborder="0" style="border:0px;">

  </iframe>

</div>

<div id="loadDataDiv" style="position:absolute;left:0px; top:0px; width:0px; height:0px; z-index:1;">

   <iframe name="loadDataIframe" id="loadDataIframe" src="" scroll="no" height="0px" width="0px" bgcolor="transparent" allowtransparency="true" frameborder="0" style="border:0px;">

  </iframe>

</div>

<div id="webchanneldiv" style="position:absolute;left:0px; top:0px; width:635px; height:534px; z-index:-1;">

   <iframe name="webchannel" id="webchannel" src="" scroll="no" height="534px" width="635px" bgcolor="transparent" allowtransparency="true" frameborder="0" style="border:0px;">

  </iframe>

</div>





<!--未解锁提示-->

<div id="order" style="left:0px; top:226px; width:635px; height:110px; position:absolute;display:none; alpha:85%; z-index:1;">

  <table id="lock" width="635" height="110" background="images/playcontrol/bg-seek.gif" cellpadding="0" cellspacing="0">

    <tr>

      <td id = "displayLockInfo" colspan="5" align="center"  style="color:#FFFFFF; font-size:20px"></td>

    </tr>

     <tr>

      <td colspan="5" height="2"></td>

    </tr>

    <tr>

      <td height="39" width="165"></td>

      <td width="122" align="right"><a id="img_1" href="javascript:ensureCheckPass();"><img src="images/playcontrol/playChannel/nextView_yes.gif" width="102" height="39"/></a></td>

      <td width="96">&nbsp;</td>

      <td width="141" align="left"><a id="img_2" href="javascript:cancleCurrAction();"><img src="images/playcontrol/playChannel/cancelJump.gif" width="102" height="39"/></a></td>

      <td width="120"></td>

    </tr>

     <tr>

      <td colspan="5" height="14"></td>

    </tr>

  </table>

</div>

<!-- 密码输入页面-->

<div id="golock1" style="position:absolute;left:0px; top:226px; width:635px; height:110px;display:none; z-index:2;">

	<table background="images/playcontrol/bg-seek.gif" width="635" border="0" align="left"  cellpadding="0" cellspacing="0">

		<tr>

			<td valign="top" align="center">

				<table width="623" border="0">

					 <tr>

						<td>

							<table width="615">

							  <tr>

								<td>&nbsp;</td>

								<td>&nbsp;</td>

								<td>&nbsp;</td>

								<td>&nbsp;</td>

							  </tr>

							  <tr>

								<td width="30" height="48" align="left"></td>

								<td width="78" height="48" align="center" style="color:#FFFFFF; font-size:20px">密码：</td>

								<td width="172" align="center">

									<input height="27px" maxlength="12" type="password" onBlur="javascript:setpwd(this)" onFocus="javascript:getpwd(this)" onClick="javascript:goCheck(this)"  id="pwd" name="pwd" style="width:145px;"/>

								</td>

								<td width="156" height="48" align="center">

									<a href="javascript:clickAction(true)" id="apply">

										<img src="images/playcontrol/playChannel/nextView_yes.gif" width="102" height="39" border="0"/>

									</a>

								</td>

								<td width="155" align="left">

									<a href="javascript:clickAction(false)" id="cancel">

										<img src="images/playcontrol/playChannel/cancelJump.gif" width="102" height="39" border="0"/>

									</a>

								</td>

							  </tr>

						  </table>

						</td>

					</tr>

					<tr>

						<td width="627" height="20" id="" >

							<table>

								<tr>

									<td width="60">&nbsp;</td>

									<td height="20" id="errorinfo" align="center" style="color:DAA520;"></td>

								</tr>

							</table>

						</td>

					</tr>

				</table>

			</td>

		</tr>

	</table>

</div>

<div id="hiddenframe" style="position:absolute;left:0px; top:370px; width:640px; height:164px;display:none;">

   <iframe name="golock" id="golock" src="" scroll="no" height="164px" width="640px" bgcolor="transparent" allowtransparency="true" frameborder="0" style="border:0px;">

  </iframe>

</div>

<div id="nochannel" style="position:absolute; left:0px; top:226px; width:635px; height:110px; display:none; alpha:85%;">

<table id="chanError" width="635" height="110" background="images/playcontrol/bg-seek.gif" cellpadding="0" cellspacing="0">

   	<tr>

      <td id="displayErrorInfo" colspan="3" align="center" height="60" style="color:#FFFFFF; font-size:20px"></td>

    </tr>

    <tr>

      <td colspan="3" align="center" height="14"></td>

    </tr>

</table>

</div>

<!--台标显示 -->

<div id="logo" style="position:absolute; display:none;alpha:85%;">

</div>

<!--显示进度和跳转-->

<div  id="seekDiv" style="position:absolute;width:1280px;height:200px;left:0px;top:500px; z-index:1;display:none;">

    <!-- 进度条中显示的百分比 -->

    <div id="seekPercent" style="position:absolute;color:#FFFFFF;width:45;height:30;top:24%;left:622;z-index:3; font-size:22px;"></div>

    <!-- 进度条所在div -->

    <div style="position:absolute;width:1280;height:80;left:0;top:0;z-index:-2;">

    <img class="alpha" id="" width="1280" height="80" src="images/playcontrol/bg-seek.gif">

    </div>

    <div id="" style="position:absolute;width:1280;height:80;left:0;top:0;z-index:2;color:white;">

        <table width="1280" height="80" border="0" cellpadding="0" cellspacing="0">

            <tr height="40">

                <td></td>

                <td height="40">

                    <table width="1100" border="0" cellpadding="0" cellspacing="0">

                        <tr>

                            <!-- 当前时间 -->

                            <td id="currTimeShow" width="580" valign="middle" align="right" style="font-size:22px; color:#FFF;"></td>

                            <!-- 当前播放状态 -->

                            <td id="statusImg" height="40" align="right" style="font-size:22px;color:#FFF;"></td>

                            <td width="5"></td>

                        </tr>

                    </table>

                </td>

                <td></td>

            </tr>

            <tr>

                <td width="80" height="40" valign="middle" align="center" id="beginTime" style="font-size:22px;color:#FFF;">00:00</td>

                <td width="1100" valign="top">

                    <!--table width="" height="" border="0" cellpadding="0" cellspacing="0">

                        <tr>

                            <td id="seekTable" width="" height="30">

                            </td>

                        </tr>

                    </table-->

                   <table width="" height="" border="0" cellpadding="0" cellspacing="0">

                        <tr>

                            <td width="1100" height="30" bgcolor="#000080">

							    <table height="30" width="0" border="0" cellspacing="0" cellpadding="0">

  <tr>

    <td id="progressBar" bgcolor="#DAA520"></td>

  </tr>

</table>



                            </td>

                        </tr>

                  </table>

                </td>

                <td width="70" valign="middle" align="center" id="fullTime" style="font-size:22px; color:#FFF;"></td>

            </tr>

        </table>

    </div>

    <!-- 跳转框所在div -->

    <div id="jumpTimeImg" style="position:absolute;width:1280;height:76;left:0;top:82;z-index:-9;">

    <img class="alpha"  id="" width="1280" height="76" src="images/playcontrol/playChannel/bg-seek.gif">

    </div>

    <div id="jumpTimeDiv" style="position:absolute;width:1280;height:76;left:0;top:82;z-index:9;color:white;">

	<form  name="passForm" action="javascript:clickJumpBtn()">

        <table width="1280" height="76" border="0" cellpadding="0" cellspacing="0" style="font-size:22px;">

            <tr><td height="10" colspan="6"></td></tr>

            <tr height="36">

                <td width="200"></td>

                <td width="180" height="36" valign="middle" align="center" style="font-size:30px; color:#fff;">跳转到</td>



                <td width="40" valign="middle" align="center">

                    <input id="jumpTimeHour" type="text" maxlength="3" style="width:80px; height:28px; line-height:28px; display:inline-block;  font-size:22px"/> 

                </td>

                <td width="30" valign="middle" align="center" style="font-size:30px; color:#fff;">时</td>

                <td width="40" valign="middle" align="center">

                    <input id="jumpTimeMin" type="text" maxlength="3" style="width:80px; height:28px;  font-size:22px"/> 

                </td>

                <td width="30" valign="middle" align="center" style="font-size:30px; color:#fff;">分</td>

                <td width="140" valign="middle" align="center" height="36">

                    <a id="ensureJump" href="javascript:clickJumpBtn();"><img src="images/playcontrol/playChannel/ensureJump.gif" width="73" height="28"/></a>
				</td>
                <td width="140" valign="middle" align="left" height="36">

                    <a id="cancelJumpId"href="javascript:pauseOrPlay();"><img src="images/playcontrol/playChannel/cancelJump.gif" width="73" height="28"/></a>

                </td>               

            </tr>

            <tr>

                <!-- 跳转框下的提示信息 -->

                <td id="timeError" width="1280" height="30" valign="middle" align="center" colspan="6" style="color:DAA520;  font-size:22px;"></td>

            </tr>

        </table>

	  </form>

    </div>

</div>
<div style="visibility:hidden">
<img src="images/playcontrol/playChannel/Volume_1.gif" />
<img src="images/playcontrol/playChannel/Volume_0.gif" />
</div>

<div id="playRecordDiv" style="position:absolute;left:0px; top:0px; width:0px; height:0px;">
  <iframe name="prFrame" id="prFrame" scroll="no" height="0" width="0"  bgcolor="transparent" allowtransparency="true">
    </iframe>
</div> 

<div id="onPlayRecordDiv" style="position:absolute;left:0px; top:0px; width:0px; height:0px;">
  <iframe name="onPrFrame" id="onPrFrame" scroll="no" height="0" width="0"  bgcolor="transparent" allowtransparency="true">
    </iframe>
</div> 
<div id="onPlayRecordDiv2" style="position:absolute;left:0px; top:0px; width:0px; height:0px;">
  <iframe name="onPrFrame2" id="onPrFrame2" scroll="no" height="0" width="0"  bgcolor="transparent" allowtransparency="true">
    </iframe>
</div> 
<!------加图片-------->
<div style="display:none;position:absolute;top:340px;left:510px;"><img id="adimg" src="#" width="136" height="136"></div>


<!-- 首次进入提醒 -->
<div id="firstvod" style="display: none; background: url('./playimages/last_quit.png'); width: 365px; height: 220px; position: absolute;margin: auto; top: 0; left: 0; bottom: 0; right: 0; color: #fff; font-size: 36px; text-align: center; line-height: 220px;">按OK键可查看节目单</div>	

</body>

<%

}

%>
<script>
var STBType =Authentication.CTCGetConfig("STBType");
 	//document.getElementById('datea').innerHTML = STBType;
		if(STBType == "E8200"){
		document.getElementById('jumpTimeHour').style.fontSize = 18+'px';
		}
</script>

<script type="text/javascript">
function tuichu(){
	window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/list_ln_vod.jsp?category_id=1001007&providerid=hw&iaspuserid=<%=iaspuserid%>";
}
function jixu(){
	window.location.href = "http://202.97.183.28:9090/templets/epg/Profession/list_vod.jsp?category_id=1031&providerid=hw&iaspuserid=<%=iaspuserid%>";
}

</script>



<script type="text/javascript">
	// if(sessionStorage.getItem("firstvod") == null) {
	// 	sessionStorage.setItem("firstvod", '111')
	// 	document.getElementById('firstvod').style.display = 'block';
	// 	setTimeout(function() {
	// 		document.getElementById('firstvod').style.display = 'none';
	// 	}, 3000)
	// }

	//写cookies 

function setCookie(name,value) 
{ 
    var Days = 30; 
    var exp = new Date(); 
    exp.setTime(exp.getTime() + Days*24*60*60*1000); 
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
} 

//读取cookies 
function getCookie(name) 
{ 
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
    	return unescape(arr[2]); 
    else 
        return null; 
} 
if(getCookie('firstvod') == null) {
	setCookie('firstvod', 111)
	document.getElementById('firstvod').style.display = 'block';
	setTimeout(function() {
		document.getElementById('firstvod').style.display = 'none';
	}, 3000)
}
</script>




</html>

