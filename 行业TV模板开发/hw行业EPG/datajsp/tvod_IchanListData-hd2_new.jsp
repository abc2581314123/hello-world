<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<%-- Author:hujian --%>
<%-- CreateAt:20090207 --%>
<%-- FileName:tvod_GetProInfoData.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="64kb"%>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file="SubStringFunction.jsp"%>

<%!	
	protected final static int CHANNEL_NAME_LENGTH = 260;     	//直播名称长度
	protected final static int PROGRAM_NAME_LENGTH = 200;		//节目单名称长度
	protected final static int DISPLAY_ROWS = 999;   			//每批获取的节目单个数
	protected final static int DISPLAY_ROWS_PAGE = 8; 			//每页显示8行节目单
	protected final static int DISPLAY_DAY_FOCUS = 2; 			//用于标注今天在tvodScope的位置
	

	/*
	* 如果字符串参数为null,返回默认给定的int参数
	*/
	public static int defaultIfNull(String str,int i) 
	{
		if(str == null || str.equalsIgnoreCase("") || str.equalsIgnoreCase("null") 	|| str.equalsIgnoreCase("undefined")) 
		{
			return i;
		} 
		else 
		{
			int temp;
			try
			{
				temp = Integer.parseInt(str.trim());				
			} 
			catch (Exception e)
			{
				temp = i;
			}
			return temp;		 
		}		
	}
	
%>

<script>
	// 当前直播信息
	var chanCurrentInfoObj = {};
	chanCurrentInfoObj.displayDate = [];
	
	// 当前日期节目单信息		
	var progCurrentInfo_JS = [];	
</script>

<%	
	//获取直播订购信息-----------------
    String isOrder = (String)request.getParameter("ISSUB");
	String cindex = (String)request.getParameter("cindex");
    if(null == isOrder)
    {
        isOrder = "0";
    }
	String strDateIndex = (String)request.getParameter("DATEINDEX");
	int tvodDateFocus = Integer.parseInt(request.getParameter("TVODDATEFOCUS"));
    //获取直播Id及名称
    String strChanId = (String)request.getParameter("CHAN_ID");
    int intChanId = Integer.parseInt(strChanId);
	String getDate = (String)request.getParameter("GETDATE");
	
	
	MetaData metaData = new MetaData(request);
	ServiceHelp serviceHelp = new ServiceHelp(request);
	HashMap chanInfoMap = metaData.getChannelInfo(strChanId);

	HashMap chanInfoMapHwtct = metaData.getChannelInfoHWCTC(strChanId);

	//获取直播的预览标识
	String chanPreview = (String)chanInfoMapHwtct.get("PreviewEnable");
	int previewEnable = 0;
	if(chanPreview != null)
	{
		previewEnable = Integer.parseInt(chanPreview);
	}
	//获得直播名称
	String strChanName = "";
	if(chanInfoMap == null)
	{
		strChanName = "直播";
	}
	else
	{
		strChanName = (String)chanInfoMap.get("CHANNELNAME");
		strChanName = subStringFunction(strChanName,1,CHANNEL_NAME_LENGTH);
	}
	
	//直播状态
	int liveStatus = 0;
	liveStatus = ((Integer)chanInfoMap.get("LIVESTATUS")).intValue();
	//直播序号
	int intChanIndex = 0;
	intChanIndex = ((Integer)chanInfoMap.get("CHANNELINDEX")).intValue();	
	
	//获取直播录播时长，单位：秒
	int recordLength = ((Integer)chanInfoMap.get("RECORDLENGTH")).intValue();
	
	
	//获取录播节目单需要显示的天数
	int recDays = serviceHelp.getRecdayFromSec(recordLength);

	//获取录播节目一周的时间信息。格式为：yy-mm-dd 周x
	String[] tmpDateList = serviceHelp.getRecDateFormatList(recDays);
	String[] dateList = new String[recDays];
	int countTotalDate = recDays;

	int intDateIndex = 0;
	intDateIndex = defaultIfNull(strDateIndex,0);

	//去掉"-"的日期数组
	for(int i = 0; i <recDays; i++)
	{
		String tempDate = tmpDateList[i].substring(0,4) + tmpDateList[i].substring(5,7) + tmpDateList[i].substring(8,10);
		dateList[recDays-i-1] = tempDate;
	}
%>

<script>
	chanCurrentInfoObj.isOrder = "<%=isOrder%>";
	chanCurrentInfoObj.strChanId = "<%=strChanId%>";
	chanCurrentInfoObj.chanName = "<%=strChanName%>";
	chanCurrentInfoObj.liveStatus = "<%=liveStatus%>";
	chanCurrentInfoObj.chanIndex = "<%=intChanIndex%>";
	chanCurrentInfoObj.chanPreview = "<%=previewEnable%>";
	
</script>


	
<%
	String[] tempRecBill = null;
	String[] tempRecInfo = null;
	String[] tempProgBill = null ;
	String[] tempProgInfo = null;
	String todayString = "" ;		
	//用来存放当天节目单
	ArrayList progInfoEachDayList = new ArrayList();
	
	/* 根据前台页面传入的日期和频道得到节目单 */	
	if(null != getDate)
	{
		todayString = getDate ;
		tempRecBill = (String[])metaData.getRecBill(intChanId,getDate);
		if (tvodDateFocus>=DISPLAY_DAY_FOCUS)/**/
		{
			tempProgBill = (String[])metaData.getProgBill(intChanId,getDate);
		}
	}
	else
	{
		return ;
	}
	//获取当前日期还已经录播的节目,放到集合当天的节目集合中
	if (null != tempRecBill)
	{
		for(int j = 0; j < tempRecBill.length; j++)
		{
			tempRecInfo = tempRecBill[j].split("\u007f");
			//录制失败的不展示
			if ("2".equals(tempRecInfo[8]))continue ;
			progInfoEachDayList.add(tempRecInfo);
		}
	}
	if (null != tempProgBill)
	{
		for(int i = 0; i < tempProgBill.length; i++)
		{
			tempProgInfo = tempProgBill[i].split("\u007f");
			//录制失败的不展示
			if ("2".equals(tempProgInfo[8]))continue ;
			progInfoEachDayList.add(tempProgInfo);
		}	
	}
	//当天节目单的总个数
	int numSize = progInfoEachDayList.size();
	//所有节目的开始日期(yyyymmddhhmmss)集合数组
	String startTimeStr = "";
	//所有节目的结束日期(yyyymmddhhmmss)集合数组
	String endTimeStr = "";
	//所有节目的开始日期(yyyy-mm-dd)集合数组
	String progStartDate = "";
	//所有节目的开始时间(hh:mm:ss)集合数组
	String progStartTime = "";
	//所有节目的结束时间(hh:mm:ss)集合数组
	String progEndTime = "";
	//所有节目的节目名称集合数组
	String progName = "";
	//所有截取长度节目的节目名称集合数组
	String progNameSplit = "";
	//所有节目的节目ID集合数组
	String progID = "";	
	//判断节目单名是否滚动
	String scrollFlag = "1";
	//节目单状态 0 未录制 1 录制成功 2 录制失败 3 正在录制
	String progStatus = "";
	
	Map progInfo = new HashMap();
	String[] tempProgInfoTemp = new String[8];
	//取出每天所有的节目
	for(int i = 0 ;i < progInfoEachDayList.size();i++)
	{
		tempProgInfoTemp = (String[])progInfoEachDayList.get(i);
		progStartDate = tempProgInfoTemp[0];
		progStartTime = tempProgInfoTemp[1];

		progName = tempProgInfoTemp[2];
		progNameSplit = subStringFunction(progName,1,PROGRAM_NAME_LENGTH);	
		scrollFlag = "1";
		if(progName.equals(progNameSplit))
		{
			scrollFlag = "-1";
		}
		
		progEndTime = tempProgInfoTemp[3];
		progID = tempProgInfoTemp[4];
		progStatus = tempProgInfoTemp[8];//临时修改
		//录制失败的不展示
		// if("2".equals(progStatus)) continue;
		
		//获取节目的开始时间和结束时间		
		progInfo = metaData.getProgDetailInfo(Integer.parseInt(progID));
		
		startTimeStr = (String)progInfo.get("STARTTIME");
		//节目单开始时间不是当前日期的，则不显示 或者 录制失败的影片不展示
		if (startTimeStr.indexOf(todayString) != -1) 
		{
			endTimeStr = (String)progInfo.get("ENDTIME");
			String tempStartTime = "";
			String tempEndTime = "";
	
			//节目单是今天的。则进行这个判断，此判断是完成今天的节目单是否存在正在播放和还没播放的节目单
			if(intDateIndex == 0)
			{
				String todayTime = StringDateUtil.getTodaytimeString("yyyyMMddHHmmss");
				if((startTimeStr.compareTo(todayTime) < 0) && (endTimeStr.compareTo(todayTime) > 0))
				{				
					progStatus = "3";
				}
			}
%>	
<script>	
			tempObj = {};
			tempObj.progId = "<%=progID%>";
			tempObj.progName = "<%=progName%>";
			tempObj.progNameSplit = "<%=progNameSplit%>";		
			tempObj.startTimeStr = "<%=startTimeStr%>";
			tempObj.endTimeStr = "<%=endTimeStr%>";	
			tempObj.progStartTime = "<%=progStartTime.substring(0,5)%>";
			tempObj.progEndTime = "<%=progEndTime.substring(0,5)%>";			
			tempObj.progStatus = <%=progStatus%>;		
			tempObj.scrollFlag = "<%=scrollFlag%>";
			tempObj.numSize = <%=numSize%>;	
			progCurrentInfo_JS.push (tempObj) ;
</script>
<%	
		}
	}
%>
<script>
	var cindex = '<%=cindex%>'
	if (typeof(iPanel) != 'undefined')
  {
	iPanel.focusWidth = "4";
	iPanel.defaultFocusColor = "#FCFF05";
  }
  //  document.getElementById("testdata").innerHTML = cindex+"==show";
  var aa= '<%=numSize%>';
	parent.progCurrentInfo_JS = progCurrentInfo_JS;
	parent.results="1";
	//parent.getElementById


</script>





