<%-- Copyright (C),BesTV. Co., Ltd. --%>

<%-- Author:Caiyuhong --%>

<%-- CreateAt:20080502 --%>

























<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="java.io.ByteArrayInputStream"%>

<%@ page import="org.dom4j.io.SAXReader"%>

<%@ page import="org.dom4j.Document"%>

<%@ page import="org.dom4j.Element"%>

<%@ page import="java.net.URLEncoder"%>

<%@ page import="java.net.URLDecoder"%>

<%@ page import="java.text.*" %>

<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>

<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>

<%@ page import="com.huawei.iptvmw.util.StringUtil"%>

<%@ page import="com.huawei.iptvmw.util.SingleReturn"%>

<%@ page import="com.huawei.iptvmw.util.IPTVConstants"%>

<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>

<%@ page import="com.huawei.iptvmw.util.DataValidation"%>

<%@ page import="com.huawei.iptvmw.logger.EPGSysLogger"%>

<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>

<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>

<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>





<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>



		<title>Process Vas Request</title>



		<meta http-equiv="pragma" content="no-cache">

		<meta http-equiv="cache-control" content="no-cache">

		<meta http-equiv="expires" content="0">

		<script type="text/javascript">

		

			//此处URL需根据所使用的模板做相应的调整



			//0:Portal 1:VOD_Menu 2:LiveTV_Menu 3:TVOD_Menu

			var tempurllist = new Array();

			tempurllist[0] = "./Category.jsp";

	        tempurllist[1] = "./VodAction.jsp?MainPage=1&INDEXPAGE=0&STATION=0&LENGTH=25&TYPE_ID=-1&ISFIRST=1&subjectType=" + <%=EPGConstants.SUBJECTTYPE_VOD%> + "|" + <%=EPGConstants.SUBJECTTYPE_VIDEO_VOD%> + "|" + <%=EPGConstants.SUBJECTTYPE_AUDIO_VOD%> + "|" + <%=EPGConstants.SUBJECTTYPE_MIXED%>;

	        tempurllist[2] = "./ChanAction.jsp?TYPE_ID=-1&LENGTH=54&STATION=0&ISFIRST=1&subjectType=" + <%=EPGConstants.SUBJECTTYPE_CHANNEL%> + "|" + <%=EPGConstants.SUBJECTTYPE_VIDEO_CHANNEL%> + "|" + <%=EPGConstants.SUBJECTTYPE_AUDIO_CHANNEL%> + "|" + <%=EPGConstants.SUBJECTTYPE_MIXED%>;

	        tempurllist[3] = "./ProgRecordTable.jsp?ISFIRST=1";

		</script>

	</head>



	<body bgcolor="transparent">

		<%

		 final String ACTION_PLAY_4K = "play_4k";

		

         final String ACTION_PLAY_TV = "play_tv";

         final String ACTION_PLAY_TVOD = "play_tvod";

         final String ACTION_PLAY_VOD = "play_vod";

		 final String ACTION_PLAY_TRAILER = "play_trailer";

		 final String ACTION_FULLSCREEN = "fullscreen";

         final String ACTION_BACK = "back";

         final String ACTION_GOTO_PAGE = "goto_page";



         final String GOTO_PAGE_PORTAL = "portal";

         final String GOTO_PAGE_LIVETV_MENU = "LiveTV_Menu";

         final String GOTO_PAGE_TVOD_MENU = "TVOD_Menu";

         final String GOTO_PAGE_VOD_MENU = "VOD_Menu";

         final String GOTO_PAGE_THIRD_PAGE = "Third_page";

         final String GOTO_PAGE_OTHER = "Other";



         

         String vas_action = null;



         String mediacode = null;

		 String mediatype = null;



         String vas_back_url = null;

         String hwType=null;

         String epg_page = null;



         String schedule_time = null;



		 String additional = null;



		 String width = null, height = null, top = null, left = null;

		 String trailer_type = null;



         SingleReturn ret = new SingleReturn(true, IPTVConstants.PROCESS_OK);

         

		 ServiceHelp serviceHelp = new ServiceHelp(request);

		 ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);

         MetaData metaData = new MetaData(request);
		
		try{		

			String test = request.getParameter("vas_info") != null ? request.getParameter("vas_info"):(String) session.getAttribute("vas_info");
        	session.removeAttribute("vas_info");
			test = URLDecoder.decode(test);
			 String str = test;

	         String vas_info = "<?xml version=\"1.0\" encoding=\"GB2312\"?><root>" + str + "</root>";
                         
			 vas_info = vas_info.replaceAll("&","&amp;");

	         SAXReader reader = new SAXReader();

			 Document doc = reader.read(new ByteArrayInputStream(vas_info.getBytes()));

	         Element root = doc.getRootElement();



	         vas_action = root.elementText("vas_action");

	         mediacode = root.elementText("mediacode");	

			 mediatype = root.elementText("mediatype");	

			 hwType = root.elementText("hwType");	

			 additional = root.elementText("additional");

			 if(additional != null) {

			     

			 }

			 vas_back_url = root.elementText("vas_back_url");


			 if(vas_back_url != null) {

				 vas_back_url = vas_back_url.replaceAll("!_!-!_!","&amp;");  

			 }

	         /*if(vas_back_url != null) {

				 vas_back_url = vas_back_url.replaceAll("&amp;","&");

				 

				 vas_back_url = URLEncoder.encode(vas_back_url);

			 }*/

			 ////System.out.println("VasToMem.jsp=================vas_back_url"+vas_back_url);

	         epg_page = root.elementText("epg_page");

			 

	         schedule_time = root.elementText("schedule_time");

			 System.out.println("mediatype ="+mediatype);
			if(mediatype.equalsIgnoreCase("4KOTT")){
						 
				vas_action = ACTION_PLAY_4K;
				System.out.println("vas_action ="+vas_action);
			}
			



			 //支持fullscreen，将其分发到具体的三种类型

			 if(ACTION_FULLSCREEN.equalsIgnoreCase(vas_action)) {
				
				 if(mediatype == null && !(mediatype.equalsIgnoreCase("TV") || mediatype.equalsIgnoreCase("TVOD")

					 || mediatype.equalsIgnoreCase("VOD")) ) {
					
					 ret.setSuccessOrFail(false);
					 System.out.println("ACTION_FULLSCREEN");

					 ret.setMessage("fullscreen's parameter of mediatype is missing.");

				 }else {

					 if(mediatype.equalsIgnoreCase("TV")){
					         vas_action = ACTION_PLAY_TV;

					 }else if(mediatype.equalsIgnoreCase("TVOD")){
						  vas_action = ACTION_PLAY_TVOD;

					 }else if(mediatype.equalsIgnoreCase("VOD")){
						   vas_action = ACTION_PLAY_VOD;

					 }else if(mediatype.equalsIgnoreCase("4K,OTT")){					 
						  vas_action = ACTION_PLAY_4K;						   
					 }
				 }

			 }

	         

			 // ==================开始：校验============================

	         if (ACTION_PLAY_TV.equalsIgnoreCase(vas_action)

	             || ACTION_PLAY_VOD.equalsIgnoreCase(vas_action)

	             || ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))

	         {

			 	

	             // LiveTV 、点播、TVOD

	             if (StringUtil.isNullString(mediacode)

	                 || StringUtil.isNullString(vas_back_url))

	             {

				 	
					System.out.println("isNullString");
	                 ret.setMessage("mediacode or vas_back_url can not be null or empty.");

	                 ret.setSuccessOrFail(false);

	             }

	         }

			else if(ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action)) 

			{

				 width  = root.elementText("width");

				 height = root.elementText("height");

				 top  = root.elementText("top");

				 left = root.elementText("left");

				 

				 if(width == null || height == null || top == null 

					 || left == null) 

				{

					 ret.setSuccessOrFail(false);

	                 ret.setMessage("play trailer's parameters are missing.");

				 }

				else 

				{

					 try 

					{

						 Integer.parseInt(width);

						 Integer.parseInt(height);

						 Integer.parseInt(top);

						 Integer.parseInt(left);

						 

					 }

					catch(NumberFormatException e) 

					{

						 ret.setSuccessOrFail(false);

						 ret.setMessage("play trailer'parameters is not numeral.");

					 }					

				 }



			 }

			else if (ACTION_BACK.equalsIgnoreCase(vas_action))

	         {

				 //Mask By Caiyuhong 2008-05-08

	             // 返回到进入的Epg页面

	             //if (StringUtil.isNullString(epg_page))

	             //{

	                 //ret.setMessage("epg_page can not be null or empty.");

	                 //ret.setSuccessOrFail(false);

	             //}

	         }

			else if (ACTION_GOTO_PAGE.equalsIgnoreCase(vas_action))

	         {

	             // 与epg_page相结合，进入相应的Page页面

	         }else if(ACTION_PLAY_4K.equalsIgnoreCase(vas_action)){

			 

			 	

			 }

			else

	         {
				System.out.println("vas_action type is error.1111");
	             ret.setSuccessOrFail(false);

	             ret.setMessage("vas_action type is error.");

	         }

		}

		catch(Exception e)

		{
			System.out.println("vas_action type is error.22222");
			e.printStackTrace();

			ret.setSuccessOrFail(false);

			ret.setMessage("parse xml error. vas_info:"+request.getParameter("vas_info"));

		}

		 // ==================结束：校验============================

		 //Modifyed by Caiyuhong in 2008-05-16**********************

		 String progId = "";

		 String FATHERVODID ="";

		 int intProgId = 0;

		 int retCode =0x07020100; //初始化为数据库异常，防止出

		

		 if (ret.isSuccessOrFail() && !ACTION_BACK.equalsIgnoreCase(vas_action))

         {

			 	

				if(ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action) && mediatype !=null) 

				{

					 if(mediatype.equalsIgnoreCase("TV"))        trailer_type = "CHAN";

					 else if(mediatype.equalsIgnoreCase("VOD"))  trailer_type = "VOD";

					 //else if(mediatype.equalsIgnoreCase("TVOD"))  trailer_type = "TVOD";

					 else 

					{

					 //ret.setSuccessOrFail(false);

					 //ret.setMessage("Trailer can only support CHAN and VOD now.");

				 	}

			 	}

            

			 int typeid = -1;

			 if(ACTION_PLAY_TV.equalsIgnoreCase(vas_action))

			{

				typeid = 1;

			}

			 else if(ACTION_PLAY_VOD.equalsIgnoreCase(vas_action)|| ACTION_PLAY_4K.equalsIgnoreCase(vas_action))

			{

			  typeid = 0;

			}

			//else if((ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))||(mediatype.equalsIgnoreCase("TVOD")))

			else if(ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))

			{

				typeid = 300;

			}

			 else

			{ 

				typeid = -1;

			}

////System.out.println("VasToMem.jsp =================== vas_action==="+vas_action);

////System.out.println("VasToMem.jsp =================== typeid==="+typeid);

////System.out.println("VasToMem.jsp =================== trailer_type==="+trailer_type);

////System.out.println("VasToMem.jsp =================== mediatype==="+mediatype);

			 if(typeid != -1 &&  !ACTION_PLAY_4K.equalsIgnoreCase(vas_action)) 

			{

				

				if(mediacode.equals("Umai:CHAN/22034@BESTV.SMG.SMG"))

				{

					mediacode = "Umai:CHAN/13045@BESTV.STA.SMG";

				}

				else if(mediacode.equals("Umai:PROG/67769@BESTV.SMG.SMG"))

				{

					mediacode = "Umai:PROG/52179@BESTV.SMG.SMG";

				}

				////System.out.println(mediacode+"==============="+typeid);

				HashMap result = metaData.getContentDetailInfoByForeignSN(mediacode,typeid);

				////System.out.println(result+"===============");

				if(result == null) 

				{				
					System.out.println("vas_action type is error.3333");
					ret.setSuccessOrFail(false);



					if(ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))

					{

						 ret.setSuccessOrFail(true);

					}

					

				}

				 else 

				{

					

					 if(typeid == 1) 

					{

						 progId = ((Integer)result.get("CHANNELINDEX")).toString();

						 intProgId = ((Integer)result.get("CHANNELID")).intValue();

						 trailer_type = "CHAN";

					 }

					else if(typeid == 0) 

					{

						 progId = ((Integer)result.get("VODID")).toString();

						 intProgId = ((Integer)result.get("VODID")).intValue();

                         FATHERVODID = ((Integer)result.get("FATHERVODID")).toString();
                      
						 trailer_type = "VOD";

					 }

					else if(typeid == 300) 

					{

						

						try{

						 progId = ((Integer)result.get("PROGRAMID")).toString();

						 intProgId = ((Integer)result.get("PROGRAMID")).intValue();

						 }catch(Exception e){

						 

						 }

						 trailer_type = "TVOD";

				 	}

				}

		    //**********************************************************//

			////System.out.println("=======1========");

			if(progId.equals("") && typeid != -1) 

			{
				System.out.println("vas_action type is error.44444");
				ret.setSuccessOrFail(false);

				if(ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))

				{

					ret.setSuccessOrFail(true);

				}

                ret.setMessage("Play Media action, but missing progId.");

			}

			////System.out.println("=======2======trailer_type=="+trailer_type);



			if(trailer_type == null && ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action)) 

			{

				////System.out.println("=======3======ACTION_PLAY_TRAILER=="+ACTION_PLAY_TRAILER);

				////System.out.println("=======4======vas_action=="+vas_action);

				 int tmp = 0;

				 result = metaData.getContentDetailInfoByForeignSN(mediacode,0);

				 if(result != null) tmp = ((Integer)result.get("VODID")).intValue();

				 else tmp = 0;

				 if(tmp == 0) 

				{

					 result = metaData.getContentDetailInfoByForeignSN(mediacode,1);

					 if(result != null) 

					{

						 tmp = ((Integer)result.get("CHANNELID")).intValue();

						 trailer_type = "CHAN";

					 }

					 else

					{

						 tmp = 0;

					}

				 }

				else 

				{

					 trailer_type = "VOD";

				 }

				 if(tmp == 0) 

				{
					System.out.println("vas_action type is error.5555");
					 ret.setSuccessOrFail(false);

					 ret.setMessage("Can not find the Trailer's type.");

				 }					 

			}

		 }

		}

				////System.out.println("=======5======ACTION_PLAY_TRAILER=="+ACTION_PLAY_TRAILER);

				////System.out.println("=======6======vas_action=="+vas_action);

				////System.out.println("=======7======ret.isSuccessOrFail()=="+ret.isSuccessOrFail());

		

         if (ret.isSuccessOrFail())

         {

					if(EPGUtil.isValidateUser(request))

					{

					Map retMap = null;

					String gaoQing = "0";

					//int supportHD = 0 ;

					try

					{

						gaoQing = String.valueOf(session.getAttribute("gaoQingFlag"));

						//supportHD = Integer.valueOf((String)session.getAttribute("SupportHD")).intValue();

					}

					catch(Exception e)

					{

						gaoQing = "0";

						//supportHD = 0;

					}

					

					if (ACTION_PLAY_TV.equalsIgnoreCase(vas_action))

					{

						session.setAttribute("MEDIAPLAY","1");

						//高清的直播流程

						if(gaoQing.equals("1"))

						{

							//session.removeAttribute("gaoQingFlag");

							retMap = serviceHelpHWCTC.authorizationHWCTC(intProgId,2,1,2, "-1", -2);

							if (null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE)) 

							{

								retCode = ((Integer) retMap.get(EPGConstants.KEY_RETCODE)).intValue();

								// 0 : 授权成功   授权不成功既没有订购高清产品包 出提示页面

								if (retCode != 0&&retCode != 117572096)

								{

									

									%>

									<script>

										window.location.href ="gaoQingInfo.jsp?backUrl=<%=vas_back_url%>";

										return;

									</script>

									<%

								

								}

							}

						}

						//播放TV

						%>

							<script>

								

								window.location.href.target = "_top";

								window.location.href = "play_ControlChannel.jsp?CHANNELNUM=<%=progId%>&backurl=<%=vas_back_url%>";

							</script>

						<%

					}

					else if (ACTION_PLAY_TRAILER.equalsIgnoreCase(vas_action))

					{

							////System.out.println("trailer_type====="+trailer_type);

							// 播放trailer

							%>

							<script>

							

								window.location.href.target = "_top";

								window.location.href = "PlayTrailerInVas.jsp?mediacode=<%=mediacode%>&type=<%=trailer_type%>&width=<%=width%>&height=<%=height%>&top=<%=top%>&left=<%=left%>";

							</script>

							<%

					}

					else if (ACTION_PLAY_VOD.equalsIgnoreCase(vas_action))

					{

							//进入高清的点播流程

							if(gaoQing.equals("1"))

							{

								//由于高清点播默认是授权成功所以利用直播授权是否通过来判断用户是否购买高清产品包

								retMap = serviceHelpHWCTC.authorizationHWCTC(277,2,1,2, "-1", -2);

								if (null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE)) 

								{

									retCode = ((Integer) retMap.get(EPGConstants.KEY_RETCODE)).intValue();	

									// 0 : 授权成功   授权不成功既没有订购高清产品包 出提示页面 0x07020100:操作超时

									if (retCode != 0&&retCode != 117572096) 

									{	

										%>

										<script>

											window.location.href ="gaoQingInfo.jsp?backUrl=<%=vas_back_url%>";

											return;

										</script>

										<%

									}

								}						

							}

							%>

							<script>

								window.location.href.target = "_top";							
								 var GOTOType =Authentication.CTCGetConfig("STBType");

								    if(GOTOType == null||GOTOType == ""){

								    GOTOType =  Authentication.CUGetConfig("device.stbmodel");	

								      }
								      var backurl1 = "<%=vas_back_url%>";
                                 setCookie("backurl",backurl1);
								window.location.href = "play_controlVod_bf_new.jsp?PROGID=<%=progId%>&FATHERSERIESID=<%=FATHERVODID%>&backurl=<%=vas_back_url%>&PLAYTYPE=1&vasFlag=1&spflag=sp&hwType=<%=hwType%>";
								   
						function setCookie(name,value)
	{
		document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
	}
	function getCookie(name)
	{
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
		else
		return null;
	}

							

							

							</script>

							<%

					}

					else if (ACTION_PLAY_TVOD.equalsIgnoreCase(vas_action))

					{
		
							// 校验时间的格式是否正确

							//System.out.println("=======8======");

							

							DataValidation dv = new DataValidation();

							dv.addDatetime("schedule_time", schedule_time);

							ret = dv.validate();

							////System.out.println("=======8=====dv="=dv);

							////System.out.println("=======8=====schedule_time="+schedule_time);

							////System.out.println("=======8=====ret.isSuccessOrFail()="+ret.isSuccessOrFail());

	

							// 播放TVOD

							if (ret.isSuccessOrFail())

							{

								

								//String playBillCode = null;

								StringBuffer sb = null;

							

								if (EPGSysLogger.isDebug())

								{

									sb = new StringBuffer(50);

									sb.append("The parameter : chanCode = ").append(mediacode);

									sb.append(" schedule_time=").append(schedule_time);

									EPGSysLogger.debug(sb.toString());

								}



								HashMap resultBill = metaData.getContentDetailInfoByForeignSN(mediacode,1);//文广传入类型错误

								
								// HashMap resultBill = metaData.getContentDetailInfoByForeignSN(mediacode,300);

								//System.out.println("=======9=====resultBill="+resultBill);

								//System.out.println("=======9=====mediacode="+mediacode);

								

                                progId = "0";

								String channelID = null;

								String progStartTime = null;

								String progEndTime = null;

								int intChannelID =0;

								ArrayList progRecord = null;

								if(null!=resultBill)

								{

								    

										channelID = (resultBill.get("CHANNELID")).toString();

									    intChannelID = Integer.parseInt(channelID); 

										//根据channel ID 获取节目单,参数详见接口文档

										

										progRecord = metaData.getChannelRecBill(intChannelID,999,0,1,"-1");

									

									

									

									



								}



								

								

								

								// 没有在中间件中通过code找到对应的内部channelId

                                if (null == channelID)

                                {

                                  // 频道不存在，直接返回错误

                                  ret.setMessage("cannot find the channel according to mediacode:"

                                     + mediacode + ".");

                                  ret.setSuccessOrFail(false);

                                }

                                // 找到channelId，则做进一步处理

                                else

                                {

								  String playBillCode = null; //控制是否播放TVOD



									

									 

								 if(progRecord == null || ((ArrayList)progRecord.get(1)).size() == 0)

								 {

								

									EPGSysLogger.debug("This channel doesn't have playbills.");

								 } 

								 else

								 {

									ArrayList vas_billRecord = (ArrayList)progRecord.get(1);

												//本次获取的实际频道数

									int progSize = vas_billRecord.size();

									

									if(progSize == 0)

									{

									EPGSysLogger.debug("This channel doesn't have playbills.");

									

									}

									//有节目单的，则做节目单遍历，找到schedule_time对应的节目CODE

									else

									{

										 //PlayBillRecord playBillRec = null;

										

										 HashMap progMap = new HashMap();

										//频道名称数组

										String[] PROGNAME = new String[progSize];

										//频道ID数组

										int[] PROGRAMID = new int[progSize];

										//节目单开始时间

										String [] STARTTIME =  new String[progSize];

										//节目单结束时间

										String [] ENDTIME = new String[progSize];

										//节目的录制状态

										int[] STATUS = new int[progSize];

										//节目的录制状态

										int[] ISCONTROLLED = new int[progSize];

										//节目的录制状态

										int[] ISSERVICED = new int[progSize];

										int j = 0;

										for (j = 0; j < progSize; j++)

										{

											// 获取当前节目单的状态

											progMap=(HashMap)vas_billRecord.get(j);

											

											STATUS[j] = ((Integer)progMap.get("STATUS")).intValue();

											PROGNAME[j] = (String)progMap.get("PROGNAME");

											// 只获取录制成功的节目单

											// 计算开始和结束时间                    

											progStartTime = (String)progMap.get("STARTTIME");

											progStartTime = progStartTime.substring(0,progStartTime.length() - 2)+ "00";

											progEndTime = (String)progMap.get("ENDTIME");

											progEndTime = progEndTime.substring(0,progEndTime.length() - 2)+ "00";

											if (progStartTime.compareTo(schedule_time) <= 0

											&& progEndTime.compareTo(schedule_time) > 0) //录播的节目单时间必须完全在时间范围跨度内

											{

												////System.out.println("000000000000000000");

												PROGRAMID[j] = ((Integer)progMap.get("PROGRAMID")).intValue();

												progId = ((Integer)progMap.get("PROGRAMID")).toString();

												playBillCode = "ok";

												

												break;

											}

											

										}



									

								     }	  

										  

									

									 

									

									 

									 if (null == playBillCode || "".equals(playBillCode))

								     {

									 	

									   ret.setSuccessOrFail(false);

									   ret.setMessage("the playbill does not exists.");

								     }

								     else

								     {

									

									  %>

									    <script>

										window.location.href.target = "_top";

									    window.location.href = "play_controlTVod.jsp?PROGID=<%=progId%>&PLAYTYPE=<%=EPGConstants.PLAYTYPE_TVOD%>&PROGSTARTTIME=<%=progStartTime%>&PROGENDTIME=<%=progEndTime%>&backurl=<%=vas_back_url%>&CHANNELID=<%=channelID%>";

									    </script>

									  <%

						

								     }

								  }

								}



							}

							

					}

					else if (ACTION_BACK.equalsIgnoreCase(vas_action))

					{

						//new TurnPage(request).getNewTurnList();

						//turnPage.getNewTurnList();

						// 返回到进入的Epg页面

						

						%>

						<script type="text/javascript">

								window.location.href = "<%=new TurnPage(request).getLast()%>";

						</script>

						<%

					}else if(ACTION_PLAY_4K.equalsIgnoreCase(vas_action)){

						//System.out.println("zr==progId==    ACTION_PLAY_4K");

						

						%>

						<script>

							window.location.href = "http://60.19.28.15:33200/EPG/jsp/default/en/Playcontrol4Kvod.jsp?mediacode=<%=mediacode%>&backurl=<%=vas_back_url%>&PLAYTYPE=1&vasFlag=1";

						</script>

						<%

					}

					else if (ACTION_GOTO_PAGE.equalsIgnoreCase(vas_action))

					{

						// 与epg_page相结合，进入相应的Page页面

						int index = -1;

	

						if (epg_page.equalsIgnoreCase(GOTO_PAGE_PORTAL))

						{

							// Portal

							index = 0;

						}

						else if (epg_page.equalsIgnoreCase(GOTO_PAGE_VOD_MENU))

						{

							// VOD_Menu

							index = 1;

						}

						else if (epg_page.equalsIgnoreCase(GOTO_PAGE_LIVETV_MENU))

						{

							// LiveTV_Menu

							index = 2;

						}

						else if (epg_page.equalsIgnoreCase(GOTO_PAGE_TVOD_MENU))

						{

							// TVOD_Menu

							index = 3;

						}

						else

						{

							ret.setSuccessOrFail(false);

							ret.setMessage("epg_page type is error or not realized. ");

						}

	

						if (ret.isSuccessOrFail())

						{

							%>

							<script type="text/javascript">window.location.href = tempurllist[<%=index%>];</script>

							<%

						}

	

					}

					

				}

				else

				{
					System.out.println("Vas_InfoDisplay.1111");
					%>

					<jsp:forward page="Vas_InfoDisplay.jsp?ERROR_ID=002&ERROR_TYPE=2" />

					<%

				}

            }

            if (!ret.isSuccessOrFail())

            {
				System.out.println("Vas_InfoDisplay.2222");
                EPGSysLogger.debug("VASTOMEM: " + ret.toString());
				
				%>

					<jsp:forward page="Vas_InfoDisplay.jsp?ERROR_ID=001&ERROR_TYPE=2" />

				<%

				

			}

		%>

								

	</body>

</html>

