<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="java.text.SimpleDateFormat" %>
	<%@ page import="java.text.DateFormat" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file="SubStringFunction.jsp"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.HashMap" %>
<script>
	//定义一个用于接收数据的变量
	var chanList = [];
	
	
	var chanList1 = [];
	var chanList2 = [];
	var chanList3 = [];
	var chanList4 = [];
	var chanList5 = [];
	var chanList6 = [];
	var chanList7 = [];
	var chanList8 = [];//加入4k频道号 890
	var channelCount1 = 0;
	var channelCount2 = 0;
	var channelCount3 = 0;
	var channelCount4 = 0;
	var channelCount5 = 0;
	var channelCount6 = 0;
	var channelCount7 = 0;
	var channelCount8 = 0;
	
	
    function contains(arr, obj) {
  var i = arr.length;
  while (i--) {
    if (arr[i] === obj) {
      return true;
    }
  }
  return false;
}
	
	
	
	
	//索引
	var j = 0;
	//当前数据块
	var blockNum = 0;
	
	//记忆返回焦点位置
	var preFocus = [];

<%

	JSONArray jsArr = new JSONArray();

			
	TurnPage turnPage = new TurnPage(request);
	String isfirst = request.getParameter("ISFIRST");

	if("1".equals(isfirst))
	{
		turnPage.addUrl();    	
	}
	
	String tmpFocus = (String)request.getParameter("PREFOUCS");
	if(tmpFocus == "" || tmpFocus == null)
	{
	  tmpFocus = "0,0,0,0";
	}
	String[] tempFocus = new String[4];
	tempFocus =tmpFocus.split(",");
	for(int i=0;i<tempFocus.length;i++)
	{
%>
		preFocus.push(<%=tempFocus[i]%>);
<%
	}	
	//获取到记忆焦点
	int columnIndex = Integer.parseInt(tempFocus[0]);
	//获取记忆页码
	int columnPageIndex = Integer.parseInt(tempFocus[1]);
	
	String currTime = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
	
	boolean isNumOne = true;
	
	//new一个类的实例
    MetaData metadata_ = new MetaData(request);
	
	//当前数据块
	int blockNum = 0;
	
	//每个数据块展示的节目数
	int BLOCK_SIZE = 999;
	
	//高清支持,从session中取得
	int supportHD = 0 ;
	try
	{
		String strSupportHD = (String)session.getAttribute("SupportHD");
		supportHD = Integer.parseInt(strSupportHD.trim());
	}
	catch(Exception ee)
	{
		supportHD = 0;
	}
	
	//调用getChannelListInfo()方法
    ArrayList channelData = metadata_.getChannelListInfo();
    String channelstr = ",312,705,706,707,840,841,842,843,844,845,846,847,848,850,951,283,284,285,286,287,288,289,290,"; 
	//如果取出的数据为空，跳到InfoDisplay.jsp
    if(channelData == null || channelData.size()== 0)
    {
        turnPage.removeLast();
%>
        window.location.href = "InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2";
<%	
    }
	else
	{
		ArrayList realChanList = new ArrayList();
		ArrayList newChanList = new ArrayList();
		HashMap filmMap = new HashMap();
		//过滤掉高清频道，重新计算总记录数
		if(supportHD == 0)
		{
			for(int i = 0 ; i < channelData.size() ; i++)
			{
				filmMap = (HashMap)channelData.get(i);
				if(!channelstr.contains(","+filmMap.get("UserChannelID").toString()+",") && Integer.parseInt(filmMap.get("UserChannelID").toString())<1000){
					int definitionFlag = 0 ;
					if(null == filmMap.get("DEFINITION"))
					{
						definitionFlag = 2 ;
					}
					else
					{
						definitionFlag = ((Integer)filmMap.get("DEFINITION")).intValue();			
					}
					if(definitionFlag == 2)
					{
						realChanList.add(filmMap);
						newChanList.add(filmMap);
					}
			    }
			}
		}
		else
		{
			ArrayList sdChanList = new ArrayList();
		    ArrayList hdChanList = new ArrayList();
			for(int i = 0 ; i < channelData.size() ; i++)
			{
				filmMap = (HashMap)channelData.get(i);
				if(!channelstr.contains(","+filmMap.get("UserChannelID").toString()+",") && Integer.parseInt(filmMap.get("UserChannelID").toString())<1000){
					int newchan = Integer.parseInt(filmMap.get("UserChannelID").toString());
					if(newchan>799 && newchan<900){
						hdChanList.add(filmMap);
					}else{
						sdChanList.add(filmMap);
					}
				   realChanList.add(filmMap);
				   
			    }
				
			}
			for(int i = 0 ; i < hdChanList.size() ; i++){
				filmMap = (HashMap)hdChanList.get(i);
				newChanList.add(filmMap);
			}
			for(int i = 0 ; i < sdChanList.size() ; i++){
				filmMap = (HashMap)sdChanList.get(i);
				newChanList.add(filmMap);
			}
			//realChanList = channelData ;
		}
		
		//过滤高清频道后总数还是为0，跳InfoDisplay
        if(newChanList.size() == 0)
        {   
			turnPage.removeLast();	         
%>	
			<jsp:forward page="InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2" />		
<%
	    }


		//遍历realChanList
		for(int i = blockNum * BLOCK_SIZE,j=0; i < blockNum * BLOCK_SIZE + BLOCK_SIZE && i < newChanList.size();i++)
		{
			HashMap chanData = (HashMap)newChanList.get(i);
		
			String chanUrl = (String)chanData.get("ChannelURL"); 
			String chanSDP = (String)chanData.get("ChannelSDP");			
		
			//取出频道编号
			int channelIndex = ((Integer)chanData.get("UserChannelID")).intValue();
			//取出频道编号
			int channelID = ((Integer)chanData.get("ChannelID")).intValue();
			//取出频道名称
			String channelName = (String)chanData.get("ChannelName");
			String shortName = "";
			if(!channelstr.contains(","+channelIndex+",") && (Integer)chanData.get("UserChannelID")<1000){
				if (stringLength(channelName) > 75)
				{
					//截取频道名称长度
					shortName = subStringFunction(channelName,1,75);
				}
				else 
				{
					shortName = channelName;
				}
				String scrollFlag = "1";
				//判断频道名称是否需要滚动显示(用三个点判断频道是否滚动有缺陷，因为名称中可能本身含有三个点)
				if(channelName.equals(shortName))
				{
					scrollFlag = "-1";
				}
				//是否已订购 1订购 0未订购
				int chanIsSubscribed = ((Integer)chanData.get("isSubscribe")).intValue();
				//标志频道是否是回看频道???
				int isTvod =((Integer)chanData.get("IsTvod")).intValue();
				int isNvod =((Integer)chanData.get("IsNvod")).intValue();
				//频道类型
				int channelType = ((Integer)chanData.get("ChannelType")).intValue();
				//频道的可预览标识
				String previewAble = (String)chanData.get("PreviewEnableHWCTC");
				//判断是否为高清
				Integer chanDefinition = (Integer)chanData.get("DEFINITION");
				int isHighDefinition = 2;
				if(chanDefinition != null)
				{
					isHighDefinition = chanDefinition.intValue();
				}
				
				
					HashMap progInfo = metadata_.getChannelProgInfo(channelID,currTime);

					String progName = "";
					
					String picTure = "";

						if(progInfo != null)
					{
						HashMap progMap = (HashMap)progInfo.get("CURRPROG");
						if(progMap != null)
						{
							progName = (String)progMap.get("progName");
							progName = subStringFunction(progName,1,240);
                            picTure = (String)progMap.get("PICTURE");
						}

					}
				
				
				
				
				JSONObject jsObj = new JSONObject();
				jsObj.put("channelIndex",channelIndex);
				jsObj.put("channelId",channelID);
				jsObj.put("channelName",channelName);
				jsObj.put("channelName_cut",shortName);
				
				jsObj.put("subscribe",chanIsSubscribed);
				jsObj.put("channelType",channelType);
				jsObj.put("preview",previewAble);
				jsObj.put("isTvod",isTvod);
				jsObj.put("isNvod",isNvod);
				//jsObj.put("isHighDefinition",isHighDefinition);
				jsObj.put("progName",progName);
                jsObj.put("logourl",picTure);

			
				jsArr.add(jsObj);
			}
		}
%>	
	
	

	
	
	
	
		chanList = <%=jsArr%>;
		var blockNum = <%=blockNum%>;
		var supportHD_js = <%=supportHD%>;
		var size = <%=newChanList.size()%>;
	
	
	for(var i = 1;i<size;i++){	

	var chan = chanList[i];
   
	  if(Number(chan["channelIndex"])>0 && Number(chan["channelIndex"])<17){
		chanList1.push(chan);
	}  
		
		//把央视的cctv的高清频道放到央视下
		//update by mawei
		if(Number(chan["channelIndex"])==801||Number(chan["channelIndex"])==802||Number(chan["channelIndex"])==804||Number(chan["channelIndex"])==807||Number(chan["channelIndex"])==809||Number(chan["channelIndex"])==810||Number(chan["channelIndex"])==812||Number(chan["channelIndex"])==814||Number(chan["channelIndex"])==817){
			
			chanList1.push(chan);
			
		}
		
	
	if(Number(chan["channelIndex"])==20|| Number(chan["channelIndex"])==84|| Number(chan["channelIndex"])==90){
		chanList2.push(chan);//辽宁卫视
	}
	if(Number(chan["channelIndex"])>=45 && Number(chan["channelIndex"])<=76){
		chanList2.push(chan);
	}
	
	if(Number(chan["channelIndex"])>=821 && Number(chan["channelIndex"])<=852){
		chanList2.push(chan);
	}

	
	
	
	
	
	if(Number(chan["channelIndex"])>=20 && Number(chan["channelIndex"])<44){
		chanList3.push(chan);
	}
	
	
		if(Number(chan["channelIndex"])>=77 && Number(chan["channelIndex"])<86){
		chanList3.push(chan);
	}
	
	
		if(Number(chan["channelIndex"])==116 || Number(chan["channelIndex"])==117){
		chanList3.push(chan);
	}
	
	
	if(Number(chan["channelIndex"])==306 || Number(chan["channelIndex"])==307|| Number(chan["channelIndex"])==308|| Number(chan["channelIndex"])==305|| Number(chan["channelIndex"])==304|| Number(chan["channelIndex"])==401|| Number(chan["channelIndex"])==839|| Number(chan["channelIndex"])==14){
		chanList4.push(chan);
	}
	
			if(Number(chan["channelIndex"])==310 || Number(chan["channelIndex"])==839|| Number(chan["channelIndex"])==302|| Number(chan["channelIndex"])==303){
		chanList4.push(chan);
	}
     
     
			if(Number(chan["channelIndex"])==111 || Number(chan["channelIndex"])==106|| Number(chan["channelIndex"])==105|| Number(chan["channelIndex"])==107|| Number(chan["channelIndex"])==109|| Number(chan["channelIndex"])==836|| Number(chan["channelIndex"])==838|| Number(chan["channelIndex"])==3|| Number(chan["channelIndex"])==6|| Number(chan["channelIndex"])==8){
		chanList5.push(chan);
	}
     
			if(Number(chan["channelIndex"])==103 || Number(chan["channelIndex"])==102|| Number(chan["channelIndex"])==112|| Number(chan["channelIndex"])==113|| Number(chan["channelIndex"])==108|| Number(chan["channelIndex"])==101|| Number(chan["channelIndex"])==110|| Number(chan["channelIndex"])==837|| Number(chan["channelIndex"])==836|| Number(chan["channelIndex"])==101|| Number(chan["channelIndex"])==104|| Number(chan["channelIndex"])==108){
		chanList6.push(chan);
	}
     
    
    
    			if(Number(chan["channelIndex"])==114 || Number(chan["channelIndex"])==201|| Number(chan["channelIndex"])==202|| Number(chan["channelIndex"])==203|| Number(chan["channelIndex"])==205|| Number(chan["channelIndex"])==301|| Number(chan["channelIndex"])==19|| Number(chan["channelIndex"])==402|| Number(chan["channelIndex"])==403|| Number(chan["channelIndex"])==408|| Number(chan["channelIndex"])==410|| Number(chan["channelIndex"])==501|| Number(chan["channelIndex"])==502|| Number(chan["channelIndex"])==506|| Number(chan["channelIndex"])==507|| Number(chan["channelIndex"])==601|| Number(chan["channelIndex"])==602|| Number(chan["channelIndex"])==603|| Number(chan["channelIndex"])==605|| Number(chan["channelIndex"])==606|| Number(chan["channelIndex"])==701|| Number(chan["channelIndex"])==115|| Number(chan["channelIndex"])==126|| Number(chan["channelIndex"])==127|| Number(chan["channelIndex"])==128|| Number(chan["channelIndex"])==206|| Number(chan["channelIndex"])==702|| Number(chan["channelIndex"])==820|| Number(chan["channelIndex"])==703|| Number(chan["channelIndex"])==604|| Number(chan["channelIndex"])==503|| Number(chan["channelIndex"])==504|| Number(chan["channelIndex"])==505|| Number(chan["channelIndex"])==406|| Number(chan["channelIndex"])==407|| Number(chan["channelIndex"])==409|| Number(chan["channelIndex"])==204|| Number(chan["channelIndex"])==704|| Number(chan["channelIndex"])==705|| Number(chan["channelIndex"])==125|| Number(chan["channelIndex"])==807|| Number(chan["channelIndex"])==0){
		chanList7.push(chan);
	} 
    			//新增4k频道
     			if(Number(chan["channelIndex"])==890){
     				chanList8.push(chan);
    } 
	

			
			
	}

	var channelCount = chanList.length;
	channelCount1 = chanList1.length;
    channelCount2 = chanList2.length;
    channelCount3 = chanList3.length;
    channelCount4 = chanList4.length;
    channelCount5 = chanList5.length;
    channelCount6 = chanList6.length;
    channelCount7 = chanList7.length;
    channelCount8 = chanList8.length;
		
		
		
		
		
		
<%		
	}//end of else	
	if (!isNumOne)
	{
%>
		parent.data[blockNum] = <%=jsArr%>;
		parent.freeFocus();
		parent.clearTypeData();
		parent.initTypeData();
		parent.columnIndex = 0;		
		parent.inFlag = 0;
		parent.setFocus();
		parent.isDataReady = 1;
<%
	}
%>
	if (typeof(parent.iPanel) != 'undefined')
{
	parent.iPanel.firstLinkFocus = 5;
	parent.iPanel.focusWidth = "4";
	parent.iPanel.defaultFocusColor = "#FCFF05";
	parent.iPanel.defaultalinkBgColor = "#FCFF05";
}
</script>

