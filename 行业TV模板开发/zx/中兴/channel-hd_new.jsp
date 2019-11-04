
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%> 
<%@page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.web.ChannelForeshowQueryValueIn" %>
<%@ page import="com.zte.iptv.newepg.datasource.ChannelOneForeshowDataSource" %>
<%@ page import="com.zte.iptv.newepg.decorator.ChannelOneForeshowDecorator" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zte.iptv.newepg.datasource.EpgResult" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.net.URLEncoder"%>

<%@ page import="java.security.SecureRandom" %>
<%@ page import="javax.crypto.Cipher" %>
<%@ page import="javax.crypto.KeyGenerator" %>
<%@ page import="javax.crypto.SecretKey" %>
<%@ page import="javax.crypto.spec.SecretKeySpec" %>
<%@ page import="org.apache.axis.encoding.Base64" %>
<%@ page import="javax.crypto.spec.IvParameterSpec" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<epg:PageController name="channel-hd.jsp"/>
<%!
	String replaceApp(HttpServletRequest req, String expression) throws Exception{
		
	String ret = expression;
	if(ret == null) return "";
		UserInfo userInfo = (UserInfo)req.getSession().getAttribute(EpgConstants.USERINFO);
		String pathTemp = PortalUtils.getPath(req.getRequestURI(), req.getContextPath());
		HashMap paramTemp = PortalUtils.getParams(pathTemp, "GBK");
		String backepgurl = req.getRequestURL().toString();
		ret = ret.replaceAll("\\{framedir\\}", userInfo.getUserModel());
		ret=ret.replaceAll("\\{frameid\\}",userInfo.getUserModel().substring(5,userInfo.getUserModel().length()));
		ret = ret.replaceAll("\\{epgIp\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{epgip\\}", userInfo.getEpgserverip());
		ret = ret.replaceAll("\\{stbId\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{stbid\\}", userInfo.getStbId());
		ret = ret.replaceAll("\\{userId\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userid\\}", userInfo.getUserId());
		ret = ret.replaceAll("\\{userToken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{usertoken\\}", userInfo.getUserToken());
		ret = ret.replaceAll("\\{userTokenExpiretime\\}", userInfo.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{usertokenexpiretime\\}", userInfo.getUserTokenExpiretime());
		ret = ret.replaceAll("\\{areaCode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{areacode\\}", userInfo.getCitycode());
		ret = ret.replaceAll("\\{returnUrl\\}", backepgurl);
		ret = ret.replaceAll("\\{returnurl\\}", backepgurl);
		return ret;
    }
	String getinfoapp1(HttpServletRequest req)
	{
	  	  //update by qiaolinqiang 20160125
	  UserInfo iaspuserInfo = (UserInfo)req.getSession().getAttribute(EpgConstants.USERINFO);
	  String iaspadsl = "";
	  iaspadsl = iaspuserInfo.getAccountNo();//宽带账号
	  String iaspmac = ""; 
	  iaspmac = iaspuserInfo.getStbMac();//MAC信息
	  String iaspip = ""; 
	  iaspip = iaspuserInfo.getUserIP();//IP信息
	  String  iaspuserid = "";
	  iaspuserid = iaspuserInfo.getUserId();//用户信息
	  //update by qiaolinqiang 20160125
	   String returnstr="&iaspmac="+iaspmac+"&iaspip="+iaspip+"&iaspuserid="+iaspuserid;
		return returnstr;
	}
	
	

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
	
	

	<%  
			String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());//获取配置文件路径
		    HashMap param = PortalUtils.getParams(path, "GBK");


			String channelcolumnid = (String)param.get("column00");
			String channelListSql =  " columncode='"+ channelcolumnid + "'";
			String channelOrder = "usermixno asc";
			
		    
		    
		    //查询节目单参数
		    UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
			String startTime = "00:01";
			String endTime = "23:59";
			Date now = new Date();
			SimpleDateFormat curday1 = new SimpleDateFormat("yyyy.MM.dd");
			String nowdate = curday1.format(now);	    
		    SimpleDateFormat curday2 = new SimpleDateFormat("HH:mm");
	        String nowhour = curday2.format(now);
		    String channelid = "";
		    session.setAttribute("pushportal", "0");
		    	
	    //String sql = "status==0";
	%>
	
	
<%!
	
	public static String[] getStrDigits(){
		String[] strDigits = { "0", "1", "2", "3", "4", "5","6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };
		return strDigits;
	}
	
	private static String byteToArrayString(byte bByte) {
        int iRet = bByte;
        // System.out.println("iRet="+iRet);
        if (iRet < 0) {
            iRet += 256;
        }
        int iD1 = iRet / 16;
        int iD2 = iRet % 16;
        String[] strDigits=getStrDigits();
        return strDigits[iD1] + strDigits[iD2];
    }

    // 返回形式只为数字
    private static String byteToNum(byte bByte) {
        int iRet = bByte;
        System.out.println("iRet1=" + iRet);
        if (iRet < 0) {
            iRet += 256;
        }
        return String.valueOf(iRet);
    }

    // 转换字节数组为16进制字串
    private static String byteToString(byte[] bByte) {
        StringBuffer sBuffer = new StringBuffer();
        for (int i = 0; i < bByte.length; i++) {
            sBuffer.append(byteToArrayString(bByte[i]));
        }
        return sBuffer.toString();
    }

    public static String GetMD5Code(String strObj) {
        String resultString = null;
        try {
            resultString = new String(strObj);
            MessageDigest md = MessageDigest.getInstance("MD5");
            // md.digest() 该函数返回值为存放哈希值结果的byte数组
            resultString = byteToString(md.digest(strObj.getBytes()));
        } catch (NoSuchAlgorithmException ex) {
            ex.printStackTrace();
        }
        return resultString;
    }
    
    public static String base64(String str) {  
	     return new sun.misc.BASE64Encoder().encode(str.getBytes());  
	}   
	
	public static String  ase(String str) {
		try {
			String key = "rockrollformusic";
			String iv =  "rockrollformusic";

			Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
			int blockSize = cipher.getBlockSize();

			byte[] dataBytes = str.getBytes("UTF-8");
			int plaintextLength = dataBytes.length;
			if (plaintextLength % blockSize != 0) { 
				plaintextLength = plaintextLength
						+ (blockSize - (plaintextLength % blockSize));
			}

			byte[] plaintext = new byte[plaintextLength];
			System.arraycopy(dataBytes, 0, plaintext, 0, dataBytes.length);

			SecretKeySpec keyspec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
			IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

			cipher.init(Cipher.ENCRYPT_MODE, keyspec, ivspec);
			byte[] encrypted = cipher.doFinal(plaintext);

			return URLEncoder.encode(new sun.misc.BASE64Encoder().encode(encrypted));

		} catch (Exception e) {
			
			e.printStackTrace();
			
			return null;
		}
	}
%>
<%
	long time=System.currentTimeMillis();
	String besto="besto";
	String riddle=GetMD5Code(besto+time); 
	String fromproject="iptv";
	String toproject="ums";
	String interfacename="user_searchlockorder.do";
 	UserInfo userinfo = (UserInfo)request.getSession().getAttribute(EpgConstants.USERINFO);
	String user_id = "";
 	user_id = userinfo.getUserId();
	String userID=base64(user_id);
	String params="user_id="+userID+"&time="+time+"&riddle="+riddle;
	params=ase(params);
	//http://218.24.37.2:89/
	//http://60.19.30.89/
	String k4Url="http://218.24.37.2:89/authbilling/authenticationIptv_commonEntrance.do?";
	k4Url+="time="+time;
	k4Url+="&riddle="+riddle;
	k4Url+="&temptoken=";
	k4Url+="&fromproject=iptv";
	k4Url+="&toproject=ums";
	k4Url+="&interfacename=user_searchlockorder.do";
	k4Url+="&params="+params;
	
	
%>	
<script type="text/javascript">
		
var chanList = [];
var chanList1 = [];
var chanList2 = [];
var chanList3 = [];
var chanList4 = [];
var chanList5 = [];
var chanList6 = [];
var chanList7 = [];
var chanList8 = [];//新增4K频道
		
		
</script>

<ex:search tablename="user_channel" fields="channelname,channelcode,mixno,channeltype" 
	condition="<%=channelListSql%>" curpagenum="1" 
	pagecount="999" order="<%=channelOrder%>" var="list">

		
		<!--${it.channelname }&lt;${it.channelcode }&lt;${it.mixno }&lt;${it.channeltype }-->
		<%
			List channelInfos = (List)pageContext.getAttribute("list");
		    String channelCount = channelInfos.size()+"";

		
		    String program = "";
			if(channelInfos!=null&&channelInfos.size()>0){
				for(int i=0;i<channelInfos.size();i++){
				Map channelInfo=(Map)channelInfos.get(i);
				channelid = channelInfo.get("channelcode").toString();
				Map mmap = new HashMap();	
				mmap = getOneChannelTVOD(nowdate,nowhour,nowhour,"01",channelid,userInfo);	
				Vector mname = (Vector)mmap.get("name");
				Vector vstart = (Vector)mmap.get("start");
	            Vector vend = (Vector)mmap.get("end");
				if(mname.size()>0){
					
				program = (String)mname.get(0);	
				
				if(program.length()>8){
				
				program = program.substring(0,8);
				
				}

				}
				else{
				program="";
				}
			
           %>
           	   
<script type="text/javascript">
           	   
function contains(arr, obj) {
  var i = arr.length;
  while (i--) {
    if (arr[i] === obj) {
      return true;
    }
  }
  return false;
}         	   

var channelCount = '<%=channelCount%>';


var channelCount1 = '<%=channelCount%>';
var channelCount2 = '<%=channelCount%>';
var channelCount3 = '<%=channelCount%>';
var channelCount4 = '<%=channelCount%>';
var channelCount5 = '<%=channelCount%>';
var channelCount6 = '<%=channelCount%>';
var channelCount7 = '<%=channelCount%>';
var channelCount8 = '<%=channelCount%>';
	var chan = {};

	
		
	chan["channelIndex"] = '<%=channelInfo.get("mixno")%>';

	chan["channelName_cut"] = '<%=channelInfo.get("channelname")%>';
	chan["logourl"] = '<%=channelInfo.get("filename")%>';

	chan["progName"] = '<%=program%>';
	
    chan["channelcode"] = '<%=channelInfo.get("channelcode")%>';
	
	if(Number(chan["channelIndex"])>0 && Number(chan["channelIndex"])<17){
		chanList1.push(chan);
	}
	//把cctv高清频道放到央视下面
	//update by mawei
	var yangshi =["801","802","804","807","809","810","812","814","817"]; 
	
	if(contains(yangshi,chan["channelIndex"])){
		
	       chanList1.push(chan);	
	       
	     }
	
	var weishi =["20","45","46","47","48","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","84","90","821","822","823","824","825","826","827","828","829","830","831","833","834","800","851","852"];
         
    if(contains(weishi,chan["channelIndex"])){
         		
       chanList2.push(chan);
         	
     }
		
	var difang = ["20","21","22","23","24","25","26","27","30","31","34","35","36","37","38","39","40","41","43","44","77","78","79","80","81","82","83","85","86","116","117"];
         
    if(contains(difang,chan["channelIndex"])){
         		
       chanList3.push(chan);
         	
     }
     
     
     	var shaoer = ["306","307","308","305","304","401","839","14","310","839","302","303"];
         
    if(contains(shaoer,chan["channelIndex"])){
         		
       chanList4.push(chan);
         	
     }
     
     
      var dianying = ["111","106","105","107","109","836","838","3","6","8"];
         
    if(contains(dianying,chan["channelIndex"])){
         		
       chanList5.push(chan);
         	
     }
     
     
     var juchang = ["103","102","112","113","108","101","110","837","836","101","104","108"];
         
    if(contains(juchang,chan["channelIndex"])){
         		
       chanList6.push(chan);
         	
     }
     
     
    var qita = ["18","114","201","202","203","205","301","19","402","403","408","410","501","502","506","507","601","602","603","605","606","701","115","126","127","128","206","702","820","703","604","503","504","505","406","407","409","204","704","125"];
         
    if(contains(qita,chan["channelIndex"])){
         		
       chanList7.push(chan);
         	
     }
	
    var fourk=["890"];//890
    if(contains(fourk,chan["channelIndex"])){
 		
        chanList8.push(chan);
          	
      }
	
	chanList.push(chan);
	channelCount1 = chanList1.length;
    channelCount2 = chanList2.length;
    channelCount3 = chanList3.length;
    channelCount4 = chanList4.length;
    channelCount5 = chanList5.length;
    channelCount6 = chanList6.length;
    channelCount7 = chanList7.length;
    channelCount8 = chanList8.length;
	   
           		   
           	   
           </script>	   
			<%
			
			
			
					
				}
			}
		%>

</ex:search>
<!DOCTYPE html>

<html lang="zh-CN">
<head>
	<meta charset="UTF-8">
	<title>列表页</title>
	<meta name="Page-View-Size" content="1280*720">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
</head>
<script type="text/javascript">
	
var tpageCount = 0; // 频道总页数
var typeCountTotal = '19';//频道数量
var pageSize = 9; // 每页数量
var tIndex = 1;   //频道当前页码
var vIndex = 1; //  节目当前页码
function setCookie(name,value){
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days*24*60*60*30);
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function GetDateStr(AddDayCount) { 
var dd = new Date(); 
dd.setDate(dd.getDate()-AddDayCount);//获取AddDayCount天前的日期 

var d = dd.getDate();
var y = dd.getFullYear(); 
var m = dd.getMonth()+1;//获取当前月份的日期 
if(m<10){
m="0"+m; 
}   

if(d<10){

d="0"+d; 
}   
return y+"."+m+"."+d; 
}


	
var date = GetDateStr(0);



function loadchanlist(type){
	//绘制页面数据块
	loaddivs(type);
	
	//预留type--区别频道类型  1-全部
	initAndShowData(type);
}
function loaddivs(type){
var chandivs="";
	if(Number(type)==0){
		typeCountTotal = channelCount;
	}else if(Number(type)==1){
		typeCountTotal = channelCount1;
	}else if(Number(type)==2){
		typeCountTotal = channelCount2;
	}else if(Number(type)==3){
		typeCountTotal = channelCount3;
	}else if(Number(type)==4){
		typeCountTotal = channelCount4;
	}else if(Number(type)==5){
		typeCountTotal = channelCount5;
	}else if(Number(type)==6){
		typeCountTotal = channelCount6;
	}else if(Number(type)==7){
		typeCountTotal = channelCount7;
	}else if(Number(type)==8){
		typeCountTotal = channelCount8;
	}
	document.getElementById("num").innerHTML = typeCountTotal;
	document.getElementById("totalline").innerHTML =  Math.ceil(typeCountTotal/3);	
	chandivs += '<div class="channel-list">';
	for(var i=0;i<typeCountTotal;i++){		
		chandivs += '<div class="channel" id="url-1-'+i+'"><div class="channel-content"><div class="channel-id" id="sid-1-'+i+'">223</div><div class="channel-detail"><div class="channel-name" id="s-1-'+i+'">江苏卫视</div><div class="channel-cp" id="programname-1-'+i+'" >我们相爱吧</div></div></div><div class="channel-link" id="lurl-1-'+i+'"><img src="hd-img/lblink.png" width="60" height="75" alt=""></div></div>';		
	}
	chandivs += '</div>';
	document.getElementById("part-list").innerHTML = chandivs;
}
var tpageCount = 0; // 频道总页数
var ids = [];
var pageSize = 9; // 每页数量
var tIndex = 1;   //频道当前页码
var vIndex = 1; //  节目当前页码
function initAndShowData(type)
{
	var nowChanIndex = (tIndex-1)*pageSize;
	var showSize = 999;
	if(Number(type)==0){
		typeCountTotal = channelCount;
	}else if(Number(type)==1){
		typeCountTotal = channelCount1;
	}else if(Number(type)==2){
		typeCountTotal = channelCount2;
	}else if(Number(type)==3){
		typeCountTotal = channelCount3;
	}else if(Number(type)==4){
		typeCountTotal = channelCount4;
	}else if(Number(type)==5){
		typeCountTotal = channelCount5;
	}else if(Number(type)==6){
		typeCountTotal = channelCount6;
	}else if(Number(type)==7){
		typeCountTotal = channelCount7;
	}else if(Number(type)==8){
		typeCountTotal = channelCount8;
	}
	var tempindex = 0;
	//先放高清
	for(var i=0;i<typeCountTotal;i++)
	{
		var tempObj;
		if(Number(type)==0){
			tempObj= chanList[i];
		}else if(Number(type)==1){
			tempObj= chanList1[i];
		}else if(Number(type)==2){
			tempObj= chanList2[i];
		}else if(Number(type)==3){
			tempObj= chanList3[i];
		}else if(Number(type)==4){
			tempObj= chanList4[i];
		}else if(Number(type)==5){
			tempObj= chanList5[i];
		}else if(Number(type)==6){
			tempObj= chanList6[i];
		}else if(Number(type)==7){
			tempObj= chanList7[i];
		}else if(Number(type)==8){
			tempObj= chanList8[i];
		}
	
		var id = tempObj["channelIndex"];
		var imgurl = tempObj["logourl"];
		var programname = tempObj["progName"];
		var channelcode = tempObj["channelcode"];
		
		
		var idLength = id.length;
		if(idLength<3)
		{
			for(var m = 0;m<(3-idLength);m++)
			{
				id = "0" + id;
			}
		}
		var typeName = tempObj["channelName_cut"];	
		if(Number(id)<900 && Number(id)>799){
			document.getElementById("sid-1-"+tempindex).innerHTML = id;
			document.getElementById("s-1-"+tempindex).innerHTML = typeName;
			document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname;
			document.getElementById("lurl-1-"+tempindex).setAttribute("data-url","hk-detail.jsp?channelid="+channelcode+"&date="+date+"&showid="+id+"&showname="+typeName+"&showpic="+imgurl+"&initsel=6&backurl="+compile(location.href));
			document.getElementById("url-1-"+tempindex).setAttribute("data-url","channel_detail.jsp?mixno="+Number(id));
			
	
			
			tempindex++;
		}
	}
	
		//再放标清
	for(var i=0;i<typeCountTotal;i++)
	{
		var tempObj;
		if(Number(type)==0){
			tempObj= chanList[i];
		}else if(Number(type)==1){
			tempObj= chanList1[i];
		}else if(Number(type)==2){
			tempObj= chanList2[i];
		}else if(Number(type)==3){
			tempObj= chanList3[i];
		}else if(Number(type)==4){
			tempObj= chanList4[i];
		}else if(Number(type)==5){
			tempObj= chanList5[i];
		}else if(Number(type)==6){
			tempObj= chanList6[i];
		}else if(Number(type)==7){
			tempObj= chanList7[i];
		}
	
		var id = tempObj["channelIndex"];
		var imgurl = tempObj["logourl"];
		var programname = tempObj["progName"];
		var channelcode = tempObj["channelcode"];
		
		var idLength = id.length;
		if(idLength<3)
		{
			for(var m = 0;m<(3-idLength);m++)
			{
				id = "0" + id;
			}
		}
			ids.push(id);
		var typeName = tempObj["channelName_cut"];	
		if(Number(id)<800 || Number(id)>899){
			document.getElementById("sid-1-"+tempindex).innerHTML = id;
			document.getElementById("s-1-"+tempindex).innerHTML = typeName;
			document.getElementById("programname-1-"+tempindex).innerHTML = ""+programname;
			document.getElementById("lurl-1-"+tempindex).setAttribute("data-url","hk-detail.jsp?channelid="+channelcode+"&date="+date+"&showid="+id+"&showname="+typeName+"&showpic="+imgurl+"&initsel=6&backurl="+compile(location.href));
			document.getElementById("url-1-"+tempindex).setAttribute("data-url","channel_detail.jsp?mixno="+Number(id));
			tempindex++;
		}
	}
		setCookie('zb', ids);
}






	
var pwd = "gdyzs";
//加密
function compile(str) {
  if(pwd == null || pwd.length <= 0) {
    
    return null;
  }
  var prand = "";
  for(var i=0; i<pwd.length; i++) {
    prand += pwd.charCodeAt(i).toString();
  }
  var sPos = Math.floor(prand.length / 5);
  var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
  var incr = Math.ceil(pwd.length / 2);
  var modu = Math.pow(2, 31) - 1;
  if(mult < 2) {
    
    return null;
  }
  var salt = Math.round(Math.random() * 1000000000) % 100000000;
  prand += salt;
  while(prand.length > 10) {
    prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
  }
  prand = (mult * prand + incr) % modu;
  var enc_chr = "";
  var enc_str = "";
  for(var i=0; i<str.length; i++) {
    enc_chr = parseInt(str.charCodeAt(i) ^ Math.floor((prand / modu) * 255));
    if(enc_chr < 16) {
      enc_str += "0" + enc_chr.toString(16);
    } else enc_str += enc_chr.toString(16);
    prand = (mult * prand + incr) % modu;
  }
  salt = salt.toString(16);
  while(salt.length < 8)salt = "0" + salt;
  enc_str += salt;
  return enc_str;
}
//解密
function uncompile(str) {
	
  if(str == null || str.length < 8) {
    
    return;
  }
  if(pwd == null || pwd.length <= 0) {
    
    return;
  }
  var prand = "";
  for(var i=0; i<pwd.length; i++) {
    prand += pwd.charCodeAt(i).toString();
  }
  var sPos = Math.floor(prand.length / 5);
  var mult = parseInt(prand.charAt(sPos) + prand.charAt(sPos*2) + prand.charAt(sPos*3) + prand.charAt(sPos*4) + prand.charAt(sPos*5));
  var incr = Math.round(pwd.length / 2);
  var modu = Math.pow(2, 31) - 1;
  var salt = parseInt(str.substring(str.length - 8, str.length), 16);
  str = str.substring(0, str.length - 8);
  prand += salt;
  while(prand.length > 10) {
    prand = (parseInt(prand.substring(0, 10)) + parseInt(prand.substring(10, prand.length))).toString();
  }
  prand = (mult * prand + incr) % modu;
  var enc_chr = "";
  var enc_str = "";
  for(var i=0; i<str.length; i+=2) {
    enc_chr = parseInt(parseInt(str.substring(i, i+2), 16) ^ Math.floor((prand / modu) * 255));
    enc_str += String.fromCharCode(enc_chr);
    prand = (mult * prand + incr) % modu;
  }
  return enc_str;
}







</script>

<body>
<jsp:include page="adloadzx_zb_HD.jsp">
<jsp:param name="pageID" value="channel-hd.jsp"/>
<jsp:param name="onepageID" value=""/>
</jsp:include>	
	
		         <div style="width:200px;height:30px;margin-left:1024px;margin-top:60px;position: absolute;" >
		<font  id="channel_num" color=green size=20></font>
		</div>
	         
	

	<script>
		// var GOTOType;
		// if ('CTCSetConfig' in Authentication) {
		// 	GOTOType = Authentication.CTCGetConfig("STBType");
		// } else {
		// 	GOTOType = Authentication.CUGetConfig("STBType");
		// }
		// if(GOTOType.indexOf("HG680")>=0){	
		// 	document.documentElement.className='b860'
		// }
			//document.documentElement.className='b860'
 //获取支付锁宽带速率
        function getk4Info(){
				var data;
				var xmlHttp;
				xmlHttp = createXmlHttpRequest();
				xmlHttp.open("GET", "<%=k4Url%>",true);
				xmlHttp.send(null);
				xmlHttp.onreadystatechange = function() {
					if(xmlHttp.readyState == 4) {
						if(xmlHttp.status == 200||xmlHttp.status==0) {
							//document.getElementById("k4Result").innerHTML = xmlHttp.responseText;
							//data = document.getElementById("k4Result").innerText;
							data= xmlHttp.responseText;
							if(data != null && data != "") {
								var datas = JSON.parse(data);
								user_portalidnum=datas.user_portalidnum;
							}else{
								data=xmlHttp.responseText;
								if(data!=null&&data!=""){
									var datas = JSON.parse(data);
									user_portalidnum=datas.user_portalidnum;
								}
							}
							document.getElementById("programNav").innerHTML=user_portalidnum;
							//宽带速率为1时可以正常播放
							if(user_portalidnum=="1"){
								document.getElementById("programNav").innerHTML=document.getElementById("programNav").innerHTML+"继续走";	
							}
							//宽带速率为234或者空时弹出提示页
							else{
								 document.getElementById("programNav").innerHTML=document.getElementById("programNav").innerHTML+"不走了";	
								 var url=compile(location.href);
								if(user_portalidnum=="2")
								{
									window.location.href='4Kerror2.jsp?backurl='+url;
								}	
								if(user_portalidnum=="3")
								{
									window.location.href='4Kerror3.jsp?backurl='+url;
								}	
								if(user_portalidnum=="4"||user_portalidnum==null||"".equals(user_portalidnum))
								{
									window.location.href='4Kerror4.jsp?backurl='+url;
								}	
								return;
								}
						}
					}
				}
			}
			
        function createXmlHttpRequest() {
        	if (window.XMLHttpRequest) {
        		xmlHttp = new XMLHttpRequest();
        		if (xmlHttp.overrideMimeType) {
        			xmlHttp.overrideMimeType("text/xml");
        		}
        	} else if (window.ActiveXObject) {
        		var MSXML = ['MSXML2.XMLHTTP.6.0', 'MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.4.0',
        			'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP', 'Microsoft.XMLHTTP'
        		];
        		for (var n = 0; n < MSXML.length; n++) {
        			try {
        				xmlHttp = newActiveXObject(MSXML[n]);
        				break;
        			} catch (e) {}
        		}
        	}
        	if (!xmlHttp) {
        		//window.alert("你的浏览器不支持创建XMLhttpRequest对象");
        	}
        	return xmlHttp;
        }
	</script>
</body>
</html>