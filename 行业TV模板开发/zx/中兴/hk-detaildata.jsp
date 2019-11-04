<%@ page import="com.zte.iptv.epg.web.ChannelForeshowQueryValueIn" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.newepg.datasource.ChannelOneForeshowDataSource" %>
<%@ page import="com.zte.iptv.newepg.decorator.ChannelOneForeshowDecorator" %>
<%@ page import="com.zte.iptv.newepg.datasource.EpgResult" %>
<%@ page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
	
<script type="text/javascript">
var chanProgListObject = {};
var chanList = [];
var chanList1 = [];
var chanList2 = [];
var chanList3 = [];
var chanList4 = [];
var channelCount1 = 0;
var channelCount2 = 0;
var channelCount3 = 0;
var channelCount4 = 0;
var tpageCount = 0; // 频道总页数
var pageSize = 9; // 每页数量
var tIndex = 1;   //频道当前页码
var vIndex = 1; //  节目当前页码
var progCurrentInfo_JS = [];
</script>	
	
<%!
	public Map getOneChannelTVOD(String date,String startTime,String endTime,String columnid,String channelid,UserInfo userInfo){
		Map rmap = new HashMap();
		try{
            System.out.println("SSSstartTime="+startTime);
            System.out.println("SSSSSendTime="+endTime);
			ChannelOneForeshowDataSource cds = new ChannelOneForeshowDataSource();
			ChannelForeshowQueryValueIn valueIn = (ChannelForeshowQueryValueIn)cds.getValueIn();
			valueIn.setDate(date);
			valueIn.setColumnId(columnid);
			valueIn.setChannelId(channelid);
            valueIn.setStartTime(startTime);
            valueIn.setEndTime(endTime);
			valueIn.setUserInfo(userInfo);
			EpgResult result = cds.getData();
			ChannelOneForeshowDecorator oneDs = new ChannelOneForeshowDecorator();
			EpgResult trueResult = oneDs.decorate(result);
			Map dataOut = (Map) trueResult.getDataOut().get(EpgResult.DATA);
			Vector vstarttime = new Vector();
			Vector vendtime = new Vector();
			Vector vprogramname = new Vector();
			Vector vcontentid = new Vector();
			Vector vplayable = new Vector();
			Vector vstartdate = new Vector();
			Vector venddate = new Vector();
            Vector vrecordsystem = new Vector();
			vstarttime = (Vector)dataOut.get("StartTimeF");
			vplayable = (Vector)dataOut.get("IsPlayable");
			vendtime = (Vector)dataOut.get("EndTimeF");
			vprogramname = (Vector)dataOut.get("Programname");
			vcontentid = (Vector)dataOut.get("ContentId");
			vstartdate = (Vector)dataOut.get("StartTime");
			venddate = (Vector)dataOut.get("EndTime");
            vrecordsystem = (Vector)dataOut.get("Recordsystem");

             rmap.put("recordsystem",vrecordsystem);
			rmap.put("start",vstarttime);
			rmap.put("end",vendtime);
			rmap.put("name",vprogramname);
			rmap.put("contentid",vcontentid);
			rmap.put("playable",vplayable);
			rmap.put("startdate",vstartdate);
			rmap.put("enddate",venddate);

		}catch(Exception ex){
		}
		
		return rmap;
	}

	public String formatname(String name,int num){
		String rname = "";
		if(name.length()>num){
			rname = name.substring(0,num);
		}else{
			rname = name;
		}
		return rname;
	}

%>
    <%@ include file="getFitString.jsp" %>
		<script type="text/JavaScript">

		var tvodpros = [] ;
		
		</script>
<%
	Date now = new Date();
	SimpleDateFormat curday1 = new SimpleDateFormat("yyyy.MM.dd");
	String nowdate = curday1.format(now);

	SimpleDateFormat curday2 = new SimpleDateFormat("HH:mm");
	String nowhour = curday2.format(now);

	String destpage = request.getParameter("destpage");
	if(null == destpage || destpage.equals("")){
		destpage = "1";
	}
	String columnid = "01";
	String num = request.getParameter("num");
	String date = nowdate;
	
	
	if(request.getParameter("date")!=null){

		date = request.getParameter("date");

	}
	String initsel = "6";
		if(request.getParameter("initsel")!=null){

		initsel = request.getParameter("initsel");

	}
	
		String channelid = "";
		if(request.getParameter("channelid")!=null){

		channelid = request.getParameter("channelid");

	}
	
	
			String showid = "";
		if(request.getParameter("showid")!=null){

		showid = request.getParameter("showid");

	}
	
	
			String showname = "";
		if(request.getParameter("showname")!=null){

		showname = request.getParameter("showname");

	}
	
	
				String showpic = "";
		if(request.getParameter("showpic")!=null){

		showpic = request.getParameter("showpic");

	}
	
	
					String backurl = "";
		if(request.getParameter("backurl")!=null){

		backurl = request.getParameter("backurl");

	}
	
	
    
	System.out.println("nowdate="+nowdate+"date="+date);
	String isfirstcome = request.getParameter("isfirstcome");
	isfirstcome = (isfirstcome== null || isfirstcome.equals(""))?"0":isfirstcome;
	//为true，是回看，为false是预告
	int istvod = 0;
	istvod=date.compareTo(nowdate);

	Map mmap = new HashMap();
	UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	if(startTime == null || startTime.equals("")){
         startTime = "00:01";
	}
	if(endTime == null || endTime.equals("")){
         endTime = "23:59";
	}

	mmap = getOneChannelTVOD(date,startTime,endTime,columnid,channelid,userInfo);
	Vector mname = (Vector)mmap.get("name");
	Vector vstart = (Vector)mmap.get("start");
	Vector vend = (Vector)mmap.get("end");
	Vector vcontentid = (Vector)mmap.get("contentid");
	Vector vplayable = (Vector)mmap.get("playable");
		Vector isVrecordsystem=(Vector)mmap.get("recordsystem");
	int totalcount = mname.size();
	int pagenum = 0;
	if(totalcount%8==0){
		pagenum = totalcount/8;
	}else{
		pagenum = totalcount/8+1;
	}
	int numm = 0;
    System.out.println("+++++++++++++mname.size()="+mname.size());
	if(mname.size()>0){
	    String name = "";
        String start = "";
        String end = "";
        String contentid = "";
        boolean palyable = false;
        String isrecordsystem="";
        String tvod = "0";

	    if(isfirstcome.equals("1") && nowdate.equals(date)){
	         int breakint =0;
             for(int i=0; i<mname.size(); i++){
                  start = (String)vstart.get(i);
				  end = (String)vend.get(i);
//                  System.out.println("nowhour="+nowhour+"start"+start+"end"+end+"===="+nowhour.compareTo(end));
                  if(nowhour.compareTo(end)<=0){
                      //breakint=i-1;
                      breakint=i;
                      if(breakint<0){
                          breakint =0;
                      }
                      break;
                  }
             }
             destpage = String.valueOf((breakint+1-1)/8+1);
//             System.out.println("+++breakint="+breakint+"destpage="+destpage);
	    }
		for(int k=0;k<mname.size();k++){
				numm++;
				name = (String)mname.get(k);
				start = (String)vstart.get(k);
				end = (String)vend.get(k);
				contentid = (String)vcontentid.get(k);
				palyable = (Boolean)vplayable.get(k);
				isrecordsystem=String.valueOf(isVrecordsystem.get(k));
				tvod = "0";
				if(istvod!=0){
					tvod = "0";
				}else{
					if(end.compareTo(nowhour)>0 && start.compareTo(nowhour)<0){
						tvod = "1";
					}else{
						tvod = "0";
					}
				}
				
				
					
		%>
		<script>
			tempObj = {};
			tempObj.tvod = "<%=tvod%>";
			tempObj.progName = "<%=name%>";
			tempObj.progNameSplit = "<%=name%>";		
			tempObj.startTimeStr = "<%=start%>";
			tempObj.endTimeStr = "<%=end%>";
			tempObj.progStartTime = "<%=start.substring(0,5)%>";
			tempObj.progEndTime = "<%=end.substring(0,5)%>";			
			tempObj.palyable = "<%=palyable%>";		
			tempObj.contentid = "<%=contentid%>";
			tempObj.recordsystem = "<%=isrecordsystem%>";


			progCurrentInfo_JS.push (tempObj) ;
		

		
		</script>
	<%
				
				
				


	}
	
	}
	
	

%>		  
<script>
	parent.progCurrentInfo_JS = progCurrentInfo_JS;
	parent.results="1";
</script>