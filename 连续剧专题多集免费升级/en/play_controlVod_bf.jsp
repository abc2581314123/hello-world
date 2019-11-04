


<!-- Copyright (C), Huawei Tech. Co., Ltd. -->
<!-- Author:duanxiaohui -->
<!-- CreateAt:20050811 -->
<!-- FileName:PlayControleVod.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.*"%>
<%@ page import="java.net.URLEncoder"%>
<!--更改处-->





<%@ page language="java" import="java.util.Date" %>
<%@ page import="java.text.*"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp"%>
<%@ include file="OneKeySwitch.jsp"%>
<%@ include file="statisticsHw.jsp"%>
<%@ include file="MemToVas.jsp" %>
<%@ include file="config/config_CategoryHD.jsp" %>
<%-- <%@ include file="util/util_GetCategoryRecAllHD.jsp"%> --%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ include file="spstatistics_H5_db.jsp"%>
<%
	UserProfile userProfile = new UserProfile(request);
		String iaspuserid = userProfile.getUserId();//用户名
		String iaspadsl = "";//userProfile.toString();//宽带账号
		String iaspip = userProfile.getStbIp();//机顶盒IP
		String iaspmac = userProfile.getSTBMAC()+"&hdpath=hdpathflag";//机顶盒mac地址
		String stbId = userProfile.getStbId();//机顶盒ID
		
		int areaId = userProfile.getAreaId();//区域ID
		String tjparamsInfo = getEpgInfo(request);

		String vod_poster_url=""; 
		String hwType=request.getParameter("hwType");
%>
<html>

<head>
<meta   name="page-view-size" content="640*530" />
<!-- <meta name="page-view-size" content="width=device-width, initial-scale=1"> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<link rel="stylesheet" href="hd-css/terminal.css">
<title>PlayControleVod.jsp</title>

<style type="text/css">
#volumeDiv{position:absolute;top:400px;width:515px;height:50px; left:60px; display:none;}
.grid{position:absolute;height:50px;width:10px; background-color:#FFFFFF;}
#volumeText{width:60px;height:20px;position:absolute;right:24px;height:50px;top: 15px;font-size:24px; color:#00FF00}
</style>

</head>
<script type="text/javascript">
var recommendListRecAll = [];
var recommendList_all = [];
<%
	String strEpgInfo = getEpgInfo(request);
MetaData metaDataRecAll = new MetaData(request);
ServiceHelp serviceHelpRecAll = new ServiceHelp(request);
int s = 0;
for(int x = 0; x < recommendTypeIdNew.length; x++)
{
	JSONArray jsonRecList = new JSONArray();
	JSONObject jsonObj = new JSONObject(); 
	ArrayList resultRecAll = metaDataRecAll.getVasListByTypeId(recommendTypeIdNew[x], 999, 0);
	List recommendListRecAll = null;
	int countTotalRecAll = 0;
	if(null != resultRecAll && resultRecAll.size() == 2)
	{
		countTotalRecAll = ((Integer)((HashMap)resultRecAll.get(0)).get("COUNTTOTAL")).intValue();
		if(countTotalRecAll > 0)
		{
			recommendListRecAll = ((ArrayList)resultRecAll.get(1));
			if(null != recommendListRecAll)
				countTotalRecAll = recommendListRecAll.size();
			else
				countTotalRecAll = 0;
		}
	}
	for(int i=0; i<countTotalRecAll; i++)
	{
		JSONObject jsonType = new JSONObject();
		Map vasMap = (HashMap)recommendListRecAll.get(i);
		String vasName = vasMap.get("VASNAME").toString().trim();
		if (vasName.length() > 10)
		{
			//vasName = vasName.substring(0, 10);
		}
		int vasId = ((Integer)vasMap.get("VASID")).intValue();
		String vasUrl = serviceHelpRecAll.getVasUrl (vasId);
		
		if(vasUrl.indexOf("?") == -1)
		{
			vasUrl = vasUrl +"?tv=1";
		}
		else
   		{
			vasUrl = vasUrl +"&tv=1";
		}
		
		vasMap = metaDataRecAll.getVasDetailInfo(vasId);
		Map vasPicMap = (HashMap)vasMap.get("POSTERPATHS");
		String intemptr="";
		if(!"".equals(vasMap.get("INTRODUCE"))&&null!=vasMap.get("INTRODUCE")){
			intemptr = vasMap.get("INTRODUCE").toString().trim();
		}
		String[] picPath = null;
		String vasPic = "";
		int mapLength = 0;
		if(vasPicMap.containsKey("0"))
		{
			picPath = (String[]) vasPicMap.get("0");
			mapLength = picPath.length;
		}

		String pagePath = request.getRealPath("./");
		for(int j = 0; j < mapLength; j++)
		{
			int numTemp = picPath[j].lastIndexOf("images/universal/film");
			if(numTemp > 0)
			{
				String strTemp = picPath[j].substring(numTemp);
				strTemp = "/jsp/" + strTemp;
				File imagesFile = new File(pagePath + strTemp);
				if(imagesFile.exists())
				{
					vasPic = picPath[j];
					break;
				}
			}
		}

		jsonType.put("vasName",vasName);
		jsonType.put("vasUrl",vasUrl);
		jsonType.put("vasPic",vasPic);
		jsonType.put("intemptr",intemptr);
		jsonRecList.add(jsonType);

	}
	jsonObj.put("list",jsonRecList);
	
%>	
var recObj = <%=jsonObj%>;
recommendListRecAll = recObj.list;
recommendList_all[<%=s%>] = recommendListRecAll;
<%
	s++;		
}
%>



var picIndexLeftTop = 0;
var picIndexLeftBot = 0;
var picIndexRight = 0;
//角标广告
function showPicPoster1(){
if(picIndexLeftBot == recommendList_all[80].length)
{
	picIndexLeftBot = 0;
}
if(null == recommendList_all[80][picIndexLeftBot])
{
	recommendList_all[80][picIndexLeftBot] = {};
	recommendList_all[80][picIndexLeftBot].vasPic = "images/display/category/recm_2.jpg";
}else if(recommendList_all[80][picIndexLeftBot].vasPic == "" || recommendList_all[80][picIndexLeftBot].vasPic == null)
{
	recommendList_all[80][picIndexLeftBot].vasPic = "images/display/category/recm_2.jpg";
}
document.getElementById("posterPic1").src = "images/adimages/hwjb.jpg";	
//posterPic posterDiv
<%-- document.getElementById("urlad2").setAttribute("data-url",recommendList_all[80][picIndexLeftBot].vasUrl+"&providerid=hw&iaspuserid=<%=iaspuserid%>&iaspadsl="+NetUserID+"&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&right=0&down=1"); 
//document.getElementById("posterDiv1").href="mrs/lt/index.jsp?providerid=hw&iaspuserid=<%=iaspuserid%>&iaspadsl="+NetUserID+"&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&right=0&down=1";--%>
}

//退出点播时广告
function showPicPoster2(){
if(picIndexLeftBot == recommendList_all[81].length)
{
	picIndexLeftBot = 0;
}
if(null == recommendList_all[81][picIndexLeftBot])
{
	recommendList_all[81][picIndexLeftBot] = {};
	recommendList_all[81][picIndexLeftBot].vasPic = "images/display/category/recm_2.jpg";
}else if(recommendList_all[81][picIndexLeftBot].vasPic == "" || recommendList_all[81][picIndexLeftBot].vasPic == null)
{
	recommendList_all[81][picIndexLeftBot].vasPic = "images/display/category/recm_2.jpg";
}
var GOTOType =Authentication.CTCGetConfig("STBType");
	if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("HG680-L")>=0){
	document.getElementById("posterPic2").src = "images/adimages/hwtb.jpg";	
//posterPic posterDiv

document.getElementById("posterDiv2").href="adijsp/v10/commonwealpage/commonwealpage.jsp?providerid=hw&iaspuserid=<%=iaspuserid%>&iaspadsl="+NetUserID+"&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&right=0&down=1";
}else{
document.getElementById("posterPic2").src = "images/adimages/hwtb_bq.jpg";	
document.getElementById("posterDiv2").href="adijsp/v10/commonwealpage/commonwealpage.jsp?";
}
}
//暂停广告
function showPicPoster3(){
if(picIndexLeftBot == recommendList_all[3].length)
{
	picIndexLeftBot = 0;
}
if(null == recommendList_all[3][picIndexLeftBot])
{
	recommendList_all[3][picIndexLeftBot] = {};
	recommendList_all[3][picIndexLeftBot].vasPic = "images/display/category/recm_2.jpg";
}else if(recommendList_all[3][picIndexLeftBot].vasPic == "" || recommendList_all[3][picIndexLeftBot].vasPic == null)
{
	recommendList_all[3][picIndexLeftBot].vasPic = "images/display/category/recm_2.jpg";
}
var GOTOType =Authentication.CTCGetConfig("STBType");
	if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("HG680-L")>=0){

document.getElementById("posterPic3").src = "images/adimages/hwzt.jpg";	
document.getElementById("posterDiv3").href="adijsp/v10/commonwealpage/commonwealpage.jsp?providerid=hw&iaspuserid=<%=iaspuserid%>&iaspadsl="+NetUserID+"&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&right=0&down=1";
}else{
document.getElementById("posterDiv3").src = "images/adimages/hwzt_bq.jpg";	
document.getElementById("posterDiv3").href="adijsp/v10/commonwealpage/commonwealpage.jsp?";
}

}
	var isFromVas = false; 
</script> 
<%

    TurnPage turnPage = new TurnPage(request);
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
  	UserProfile userInfo = new UserProfile(request);
  /* 	String vodUrl = turnPage.go(-1); */
 
 
    String userId = userInfo.getUserId();
    String playUrl  = "";
    String cdrUrl = "";
    int filmId = -1;
    int playType = -1; //播放类型
    
    String typeId = (String)request.getParameter("TYPE_ID");
    String parentTypeId = request.getParameter("parentTypeId")==null?"-1":request.getParameter("parentTypeId");
    String motherTypeId = (request.getParameter("motherTypeId") == null || "".equals(request.getParameter("motherTypeId")) )?typeId:request.getParameter("motherTypeId");
    if(typeId==null || "".equals(typeId))
    {
        typeId = "-1";
    }
    
    String beginTime = "0";  //书签时间
    String productId = (String)request.getParameter("PRODUCTID");
    String serviceId = (String)request.getParameter("SERVICEID");
    String bookMarkTime = (String)request.getParameter("BOOKMARKTIME");
    String price = (String)request.getParameter("PRICE");

    String strFilmId = request.getParameter("PROGID");
    String strPlayType = request.getParameter("PLAYTYPE");
    String superVodID = request.getParameter("FATHERSERIESID");
    String spflag = (String)request.getParameter("spflag");
	  String vodCode = "";
	  String newname="";//影片名称
	String statisticsprogId = (String)request.getParameter("PROGID");



    //根据类行判断是否是片花，如果是片花推出时直接退出
    if(null != strFilmId && strFilmId.length() > 0)
    {
        filmId = Integer.parseInt(strFilmId);
    }

	  else if (request.getParameter("value") != null && !"".equals(request.getParameter("value")) && request.getParameter("vodIndex") == null)
  	{
  		vodCode = request.getParameter("value");
  		int vodId = 0;
  		Map entityMap = metaData.getContentDetailInfoByForeignSN(vodCode, 0);
  		if (entityMap != null) vodId = ((Integer) entityMap.get("VODID")).intValue();
  		if (strFilmId == null || "".equals(strFilmId)) 
  		{
  			strFilmId = String.valueOf(vodId);
  			filmId = vodId;
  		}
  		strPlayType = EPGConstants.PLAYTYPE_VOD + "";
  	}
    if(null != strPlayType && strPlayType.length() > 0)
    {
        playType = Integer.parseInt(strPlayType);
    }
    if(playType == EPGConstants.PLAYTYPE_BOOKMARK && null != bookMarkTime)
    {
        beginTime = bookMarkTime;
    }
    String assessFalg = "0"; //是否是片花标志
    if(playType == EPGConstants.PLAYTYPE_ASSESS)
    {
        assessFalg = "1";
    }
    String contentType = EPGConstants.CONTENTTYPE_VOD + "";

    int busiNessType = EPGConstants.BUSINESSTYPE_VOD;

    String cdrType = EPGConstants.CDRTYPE_BUILDCDR;



    //if(playType == EPGConstants.PLAYTYPE_VOD||playType == EPGConstants.PLAYTYPE_ASSESS||playType == EPGConstants.PLAYTYPE_BOOKMARK)

    playUrl = serviceHelp.getTriggerPlayUrl(playType,filmId,beginTime);
    cdrUrl = serviceHelp.getSubmitCdrUrl(playType,filmId,price,productId,serviceId,cdrType,contentType);

    if(playUrl != null && playUrl.length() > 0)
    {

        int tmpPosition = playUrl.indexOf("rtsp");
        if(-1 != tmpPosition)
		    {
            playUrl = playUrl.substring(tmpPosition,playUrl.length());
		    }
    }
  //  System.out.println("filmId======:"+filmId);
    Map vodInfoMap = metaData.getVodDetailInfo(filmId);
  //  System.out.println("vodInfoMap=========:"+vodInfoMap);
    
/*    int fatherId = -1;

    if(null != vodInfoMap)
    {
        fatherId = ((Integer)vodInfoMap.get("FATHERVODID")).intValue();
    }*/
    List SubVodIdList = null;   //子集id
    List SubVodNumist = null;   //子集集号
    String isSitcom = "0";      //是否是连续剧标志 isSitcom = 0 不是 isSitcom = 1 是
    String preEpisId = "-1"; // 上一集ID
    String nextEpisId = "-1"; // 下一集ID
    String nextSitnum = "";  //下一集集号
    String strFatherId = "";
    if(null != vodInfoMap)
{
    vodCode = (String)vodInfoMap.get("CODE");
	newname = (String)vodInfoMap.get("VODNAME");
	vod_poster_url = (String)vodInfoMap.get("PICPATH");
}
    int currIndex = 0;
    int totalSitNum = 0;    //总集数
    String currSitnum = "-1";     //当前子集号
    if(!"-1".equals(superVodID))
    {
		strFatherId = superVodID + "";
		ArrayList resultList = metaData.getSitcomList(String.valueOf(superVodID), 999, 0);
		
        ArrayList subVodList = null;
		if(resultList != null && resultList.size() > 1)
		{
			subVodList = (ArrayList)resultList.get(1);
		}
        if(subVodList != null && subVodList.size() > 0)
        {
			totalSitNum = subVodList.size();
			isSitcom = "1";
            for(int i = 0; i < totalSitNum; i++)
            {
				Map sitVodMap = (HashMap)subVodList.get(i);
				Integer sitVodId = (Integer)sitVodMap.get("VODID");
                if(sitVodId.toString().equals(strFilmId))
                {
                    currIndex = i;
					currSitnum = ((Integer)sitVodMap.get("SITCOMNUM")).toString();
					break;
                }
            }
            if(currIndex - 1 >= 0)
            {
				Map sitVodMap = (HashMap)subVodList.get(currIndex - 1);
				preEpisId = ((Integer)sitVodMap.get("VODID")).toString();
            }
            if(currIndex + 1 <  totalSitNum)
            {
				Map sitVodMap = (HashMap)subVodList.get(currIndex + 1);
				nextEpisId = ((Integer)sitVodMap.get("VODID")).toString();
            }
		}
    }
	
	//栏目下的影片,栏目下是否能播放下一条
	String comeFrom = request.getParameter("FROM") == null ? "-1":request.getParameter("FROM");
	String nextFilm = "-1";
	String preFilm = "-1";
	String preFilmUrl = "";
	String nextFilmUrl = "";
	String nextFinishId = "-1";
	String nextFinishFatherId = "-1";
	ArrayList vodList = null;
	if(comeFrom.equals("tongNian") || comeFrom.equals("xinWen") || comeFrom.equals("liaoNing"))
	{
		int filmIndex = -1;
		vodList = metaData.getVodListByTypeId(typeId,999,0);
		if(null != vodList && vodList.size()==2)
		{
			 ArrayList filmLsInfo = (ArrayList)vodList.get(1);
			 for(int m=0; m<filmLsInfo.size(); m++)
			 {
				 HashMap filmHash = (HashMap)filmLsInfo.get(m);
				 Integer vodId = (Integer)filmHash.get("VODID");
				 if(isSitcom.equals("1")) //当前影片为连续剧
				 {
					 if(vodId.toString().equals(superVodID))
					 {
						 filmIndex = m;
						 break;
					 }
				 }
				 else
				 {
					 if(vodId.toString().equals(strFilmId))
					 {
						 filmIndex = m;
						 break;
					 }
				 }
			 }
			if(filmIndex - 1 >= 0)
            {
				Map vodMap = (HashMap)filmLsInfo.get(filmIndex - 1);
				preFilm = ((Integer)vodMap.get("VODID")).toString();
				Map preMap = (HashMap)metaData.getVodDetailInfo(Integer.valueOf(preFilm).intValue()); //判断上一个影片是否为连续剧
				if(null != preMap)
				{
					int tempSitcom = ((Integer)preMap.get("ISSITCOM")).intValue();
					if(tempSitcom == 1)   //是连续剧
					{
						ArrayList sitArray = (ArrayList)preMap.get("SUBVODIDLIST");
						if(null !=sitArray && sitArray.size() > 0)
						{
							int sitVodId = ((Integer)sitArray.get(0)).intValue();  //如果下一条是连续剧,就取下一条的第一个子集播放
							preFilmUrl = "au_PlayFilm.jsp?TYPE_ID="+typeId
							+"&PROGID="+ sitVodId
							+"&PLAYTYPE="+ EPGConstants.PLAYTYPE_VOD 
							+ "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_VOD_VIDEO
							+ "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD
							+"&FATHERSERIESID="+preFilm
							+"&FROM="+comeFrom;
						}
					}
					else
					{
						preFilmUrl = "au_PlayFilm.jsp?TYPE_ID="+typeId
							+"&PROGID="+ preFilm
							+"&PLAYTYPE="+ EPGConstants.PLAYTYPE_VOD 
							+ "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_VOD_VIDEO
							+ "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD
							+"&FATHERSERIESID=-1"
							+"&FROM="+comeFrom;
					}
				}
            }
            if(filmIndex + 1 <  filmLsInfo.size()&& filmIndex + 1 > 0 )
            {
				Map vodMap = (HashMap)filmLsInfo.get(filmIndex + 1);
				nextFilm = ((Integer)vodMap.get("VODID")).toString();
				Map nextMap = (HashMap)metaData.getVodDetailInfo(Integer.valueOf(nextFilm).intValue()); //判断上一个影片是否为连续剧
				if(null != nextMap)
				{
					int tempSitcom = ((Integer)nextMap.get("ISSITCOM")).intValue();
					if(tempSitcom == 1)   //是连续剧
					{
						ArrayList sitArray = (ArrayList)nextMap.get("SUBVODIDLIST");
						if(null !=sitArray && sitArray.size() > 0)
						{
							int sitVodId = ((Integer)sitArray.get(0)).intValue();  //如果下一条是连续剧,就取下一条的第一个子集播放
							nextFinishId = String.valueOf(sitVodId);
							nextFinishFatherId = nextFilm;
							nextFilmUrl = "au_PlayFilm.jsp?TYPE_ID="+typeId
							+"&PROGID="+ sitVodId
							+"&PLAYTYPE="+ EPGConstants.PLAYTYPE_VOD 
							+ "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_VOD_VIDEO
							+ "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD
							+"&FATHERSERIESID="+nextFilm
							+"&FROM="+comeFrom;
						}
					}
					else
					{
						nextFinishId = nextFilm;
						nextFinishFatherId = "-1";
						nextFilmUrl = "au_PlayFilm.jsp?TYPE_ID="+typeId
							+"&PROGID="+ nextFilm
							+"&PLAYTYPE="+ EPGConstants.PLAYTYPE_VOD 
							+ "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_VOD_VIDEO
							+ "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD
							+"&FATHERSERIESID=-1"
							+"&FROM="+comeFrom;
					}
				}
            }
		}
	}
	
	
    //推荐影片
    int NUM_RECOMMEND = 3;
    int recommendFilmSize = 0;
    //ArrayList resultList = metaData.getRecommendFilms(NUM_RECOMMEND,0);
    ArrayList recommendFilms = new ArrayList();
	  String inPosition = "RightSubPage";
	  int inIsSubject = 0;
	  int[] inLayouttype = {1};
	  int[] inContentType = {0};
	  int inStation = 0;
	  int inLength = NUM_RECOMMEND;	

	/**
	 * description : 获取展示内容维护中信息
	 * @param inMetaData IPTV获取数据对象
	 * @param position 内容展示位置，可以是页面约定好的展示位置标识，也可以直接是栏目ID
	 * @param inIsSubject 展示位置是否是栏目0：非栏目 1：栏目
	 * @param inLayouttype 展示类型1：推荐2：最新上线3：即将下线4：热点排行
	 * @param inContentType 内容类型0：视频VOD1：视频频道2：音频频道4：音频VOD100：增值业务（VAS）200：栏目300：节目（录播节目）
	 * @param inStation 从station参数指定的位置开始获取（值≥0）
	 * @param inLength 返回结果的最大个数（值≥0）
	 * @return ArrayList 标识每个影片信息HashMap封装到ArrayList
	 */		 

  /*  recommendFilms = getLayoutContentByPositionFunction(metaData ,inPosition,inIsSubject,inLayouttype,inContentType,inStation,inLength);		
    String[] recommendUrlList = null;
    String[] recommendImgList = null;
    if(null != recommendFilms && recommendFilms.size() > 0)
    {
        //recommendFilms = (ArrayList)resultList.get(1);
        HashMap film = null;
        recommendFilmSize = recommendFilms.size();
        recommendUrlList = new String[recommendFilmSize];
        recommendImgList = new String[recommendFilmSize];
        String tmpImg = null;
        for(int i = 0; i < recommendFilmSize; i++)
        {
            film = (HashMap)recommendFilms.get(i);
			      HashMap posterMap=(HashMap)film.get("POSTERPATHS");		
    		    /!*
            *
            * 函数说明：根据传入参数，获得特定海报
            * @param posterMap: POSTERPATHS 键值对应的HashMap  由调用处进行校验，非null
            * @param posterFlag：  获得海报类型的标志。 0：缩略图 1：海报 2：剧照  其他：以上三种之和
            * @param displayFlag： 显示方式： 0：获得图片中的第一张  其他：获得所有图片
            * @return ：  String类型数组,和接口中的返回类型保持一致
            *--/
            int posterFlag = 1;
            int displayFlag = 0;
            String[] temp = null;
            String [] tempPos = GetPosterPathFunction(posterMap,posterFlag, displayFlag);
            if(null == tempPos)
            {
                temp = new String[1];
                temp[0] = "images/vodbrowse/default.jpg";
            }
            else
            {
                temp = tempPos;
            } 	
      			tmpImg = temp[0];
            recommendImgList[i] = tmpImg;
            recommendUrlList[i] = "IPTVseriesListDetail.jsp?FILM_ID=" + film.get("CONTENTID").toString();
        }
    }*/
    session.removeAttribute("MEDIAPLAY");
    session.removeAttribute("PROGID");
    session.removeAttribute("PLAYTYPE");
    session.removeAttribute("PRODUCTID");
    session.removeAttribute("SERVICEID");
    session.removeAttribute("PRICE");
    //playUrl = vodUrl;
    //playUrl = "rtsp://192.168.28.183/88888888/16/0/268435602/qsgy.ts";
    String returnUrl = turnPage.go(0);
    //将返回页替换
    if(returnUrl.indexOf("programDetail_xj.jsp")>=0)
    {
    	returnUrl=returnUrl.replace("programDetail_xj.jsp", "programDetail.jsp");
    }
	if(returnUrl.indexOf("newfilmDetail_pro.jsp")>=0)
    {
    	returnUrl=returnUrl.replace("newfilmDetail_pro.jsp", "newfilmDetail.jsp");
    }
	  String backurl = "";	
    if (request.getParameter("returnUrl") != null && !"".equals(request.getParameter("returnUrl")))
	{   
        returnUrl = request.getParameter("returnUrl");
	}
    
    if (session.getAttribute("vas_back_url") != null && !"".equals(session.getAttribute("vas_back_url"))) {
        backurl = (String) session.getAttribute("vas_back_url");
        returnUrl = backurl;
%>
<script type="text/javascript">
       isFromVas = true;
</script>
<%
        //backurl = URLEncoder.encode(backurl);
    } else {
        session.removeAttribute("vas_back_url");
    }
	
	if(request.getParameter("backurl") != null && !"".equals(request.getParameter("backurl")))
	{
		backurl = request.getParameter("backurl");
		returnUrl = backurl;
%>
<script type="text/javascript">
       isFromVas = true;
	   var spflag = '<%=spflag%>';

</script>
<%
	}
	if(request.getParameter("backurl1") != null && !"".equals(request.getParameter("backurl1")))
	{
		
		returnUrl= request.getParameter("backurl1");
		returnUrl+="&TYPE_ID="+request.getParameter("TYPE_ID");
		returnUrl+="&ECTYPE="+request.getParameter("ECTYPE");
		returnUrl+="&TYPE="+request.getParameter("TYPE");
		returnUrl+="&motherTypeId="+request.getParameter("motherTypeId");
		returnUrl+="&parentTypeId="+request.getParameter("parentTypeId");
		returnUrl+="&SUPVODID="+request.getParameter("SUPVODID");
		returnUrl+="&FROM="+request.getParameter("FROM");
		returnUrl+="&tuijianflag="+request.getParameter("tuijianflag");
		returnUrl+="&right="+request.getParameter("right");
		returnUrl+="&down="+request.getParameter("down");
		returnUrl+="&dblisturl="+request.getParameter("dblisturl");
	}
    String miniUrl = "MiniInfo.jsp?ProgID=" + filmId + "&isSitcom=" + isSitcom + "&currSitnum=" + currSitnum + "&FatherId=" + strFatherId;

%>

<script>
    //Utility.setBrowserWindowAlpha(60);
    //Utility.setAreaAlpha(100,0,0,646,534);
    var tcFlag=0;
    var loadFlag = false;
    var iframeFlag = "close";
    var tzFlag = "close";
	var xjFlag = "close";
	var DjFlag = "close";
	var OjFlag="close";
    var miniUrl = '<%=miniUrl%>';
    var returnUrl = "<%=returnUrl%>";
    var userid = '<%=userId%>'; // 用户Id 增加书签使用
    var strFatherId = '<%=strFatherId%>';
    var currSitnum = '<%=currSitnum%>';
    var strFilmId = '<%=strFilmId%>';
    // 提示信息定时器
    var showTimer = "";
    var hideTimer = "";
    // 控制OnOk键是否响应
    var infoEnable = true;
    var number = 0;
    var mp = new MediaPlayer();
    var json = '[{mediaUrl:"<%=playUrl%>",';
    json += 'mediaCode: "jsoncode1",';
    json += 'mediaType:2,';
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
    var speed = 1;   // 快进速度
    var playStat = "play"; //播放状态 playStat = "pause"
    // 是否是书签
    var isBookMark = <%=playType == EPGConstants.PLAYTYPE_BOOKMARK%>;
    // 是否是片花
    var isAssess = <%=playType == EPGConstants.PLAYTYPE_ASSESS%>;
    var audioIndex = 0;
    var seekTimeString = "|__:__:__";

    var timeIndex = 0;
    var hour = 0;
    var min = 0;
    var sec = 0;
    var state = "";   //快进快退
    var volume = mp.getVolume();
    var subtitlePIDs = "";
    var subtitleIndex = 0;
    var mediaTime = 0;
    var miniFlag = false;   //信息栏目是否显示标志
    var isJumpTime = 1;//跳转输入框是否显示,1默认显示
    var pressFavo = 0;//是否按下收藏键而退出
    var pressBookMark = 0;//是否按下书签键而退出
    var favoUrl = "FavoAction.jsp?ACTION=show&enterFlag=check";
    var bookMarkUrl = "BookMark.jsp";
    var preEpisId = '<%=preEpisId%>';
    var nextEpisId = '<%=nextEpisId%>';
    var nextSitnum = '<%=nextSitnum%>';
    var isSitcom = '<%=isSitcom%>';
	var muteTimer = -1;
	
	var comeFrom = "<%=comeFrom%>";
	var preFilmId = '<%=preFilm%>';
	var nextFilmId = '<%=nextFilm%>';
	
	var hwType='<%=hwType%>';

    document.onirkeypress = keyEvent ;

    document.onkeypress = keyEvent;



    function keyEvent()

    {

        var val = event.which ? event.which : event.keyCode;

        return keypress(val);

    }



    function keypress(keyval)
    {
        switch(keyval)

        {

            //*号键 277

            case <%=KEY_0%>:
         if(iframeFlag=="close"||tzFlag=="close"){
	    inputNum(0);
        }
                

                break;

            case <%=KEY_1%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(1);
            	        }

                break;

            case <%=KEY_2%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(2);
            	        }

                break;

            case <%=KEY_3%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(3);
            	        }

                break;

            case <%=KEY_4%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(4);
            	        }

                break;

            case <%=KEY_5%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(5);
            	        }

                break;

            case <%=KEY_6%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(6);
            	        }

                break;

            case <%=KEY_7%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(7);
            	        }

                break;

            case <%=KEY_8%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(8);
            	        }

                break;

            case <%=KEY_9%>:

            	  if(iframeFlag=="close"||tzFlag=="close"){
            		    inputNum(9);
            	        }

                break;

            case <%=KEY_UP%>:

               
            if(iframeFlag=="close"||tzFlag=="close"||xjFlag=="open"){
            	 arrowUp();
                }

                break;

            case <%=KEY_DOWN%>:
            if(iframeFlag=="close"||tzFlag=="close"||xjFlag=="open"){
			   arrowDown();
			}
			   
			
            		 
            	
               

                break;

			case <%=KEY_PAGEDOWN%>: 

				
			  if(iframeFlag=="close"||tzFlag=="close"){
				  pageDown();
                 }
				break;

			case <%=KEY_PAGEUP%>: 
				
				
			
			  if(iframeFlag=="close"||tzFlag=="close"){
				  pageUp();
               }
				break;

			case <%=KEY_FAST_FORWARD%>: 
				  if(iframeFlag=="close"||tzFlag=="close"){
					  fastForward();
	               }
				

				break;

			case <%=KEY_FAST_REWIND%>: 

			
			 if(iframeFlag=="close"||tzFlag=="close"){
					fastRewind();
              }
				break;

            //case KEY_PAGEDOWN:

            //    mp.pause();

            //    break;

            case <%=KEY_LEFT%>:   //控制节目单左翻页
            	if(iframeFlag=="close"||xjFlag=="open"){
            		 arrowLeft();
              }
               

                //fastRewind();

                break;

            case <%=KEY_RIGHT%>:   //快进，或者，获得焦点后机顶盒处理

               
            if(iframeFlag=="close"||xjFlag=="open"){
            	 arrowRight();
               }
                //fastForward();

                break;

            case <%=KEY_PAUSE_PLAY%>:          
            if(iframeFlag=="close"||tzFlag=="close"){
            	pauseOrPlay();
          
                return 0;
            }
                break;
            case <%=KEY_MUTE%>:
            	if(iframeFlag=="close"||tzFlag=="close"){
            		 setMuteFlag();
                  }
               

                break;
            case <%=KEY_GO_END%>:
            	if(iframeFlag=="close"||tzFlag=="close"){
            		  gotoEnd();
                 }
              

                break;

            case <%=KEY_GO_BEGINNING%>:
            	if(iframeFlag=="close"||tzFlag=="close"){
            		 gotoStart();
               }
               

                break;
			case 1060:
            case <%=KEY_TRACK%>:
            	if(iframeFlag=="close"||tzFlag=="close"){
            		 switchTrack();
              }
               

                break;

            case <%=KEY_VOL_UP%>:
            	if(iframeFlag=="close"||tzFlag=="close"){
            		 incVolume();
             }
               

                break;

            case <%=KEY_VOL_DOWN%>:

                //volumeDown();
            	if(iframeFlag=="close"||tzFlag=="close"){
            		decVolume();
            }
                

                break;

            case <%=KEY_BACKSPACE%>:

            case <%=KEY_RETURN%>:

            case <%=KEY_STOP%>:

            case <%=0x1a4%>:
             	if(iframeFlag=="close"||tzFlag=="close"){
             	   showQuit();  //退出时处理
                   return 0;
            }
             

            case <%=KEY_IPTV_EVENT%>:
             	if(iframeFlag=="close"||tzFlag=="close"){
             		  goUtility();
             }
              

                break;

             case <%=KEY_OK%>:

             		//新添加20190901 rendd
 		    		if(flag){
 		    			window.location.href = orderUrl.replace(/\*/g,"&");
 		    		}

            		if(iframeFlag=="close"||tzFlag=="close"||xjFlag=="open"){
            			  pressOK();
               }
              

                break;
             default:
				return videoControl(keyval);

        }

        return true;

    }



    function goUtility()

    {

        eval("eventJson = " + Utility.getEvent());

        var typeStr = eventJson.type;

        switch(typeStr)

        {

            case "EVENT_MEDIA_ERROR":

                //mediaError();

                return false;

            case "EVENT_MEDIA_END":

                fullSeekStatus();

                setTimeout("finishedPlay()",500);

                return false;

            case "EVENT_MEDIA_BEGINING":

                //resume();

				beginning();

                //displaySeekTable();

                break;

            case "EVENT_PLAYMODE_CHANGE":

				playModeChange(eventJson);

                return false;

            default :

                break;

        }

        return true;

    }





    
    
    
    

    
    
    
    
    
    function playModeChange(eventJson)

    {

    	var mode = eventJson.new_play_mode;

    	// 第一次载入时，读取一下内容时间

    	if (mode == 2 && !loadFlag)

    	{

    		loadFlag = true;

    		mediaTime = mp.getMediaDuration();

    		document.getElementById("filmInfo").src = miniUrl;

    	}



    	var pausePic = '<img src="images/playcontrol/pause_top.gif">';

    	var playPic = '<img src="images/playcontrol/play.gif">';

    	var fastPic = '<img src="images/playcontrol/fast.gif">';

    	var rewindPic = '<img src="images/playcontrol/rewind.gif">';



    	if (mp.getNativeUIFlag() == 0)

    	{

    		clearTimeout(topTimer);

	    	// 处理状态切换时的图片

	    	if(mode == 1) // 暂停状态

	    	{

	    		document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + pausePic + '</td></tr></table>';

				if(isSeeking == 1)

				{

				//	document.getElementById("jumpTime").focus();  //bm wangxg 2016/9/2520160925

				}

	    	}



	    	if(mode == 2) // 正常状态

	    	{

	    		document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + playPic + '</td></tr></table>';

	    		topTimer = setTimeout("hideTopFrm()", 5000);

	    	}



	    	if(mode == 3) // 快速状态

	    	{



	    		var playRate = eventJson.new_play_rate;

	    		/*

	    		if (playRate > 0)

	    		{

	    			fastPic = '<img src="images/vodbrowse/playvod/fast' + playRate + '.gif">';

	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100 height=40>' + fastPic + '</td></tr></table>';

	    		}

	    		else

	    		{

	    			rewindPic = '<img src="images/vodbrowse/playvod/rewind' + (-playRate) + '.gif">';

	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100  height=40>' + rewindPic + '</td></tr></table>';

	    		}

	    		*/



	    		if (playRate > 0)

	    		{

	    			fastPic = '<img src="images/playcontrol/_' + playRate + '.gif">';

	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100 height=40>' + fastPic + '</td></tr></table>';

	    		}

	    		else

	    		{

	    			var tmpplayRate = -playRate;



	    			rewindPic = '<img src="images/playcontrol/_x' + tmpplayRate + '.gif">';

	    			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td width=100  height=40>' + rewindPic + '</td></tr></table>';

	    		}

	    	}



    	}

    }

    function hideTopFrm()

    {

    	document.getElementById("topframe").innerHTML = "";

    }



	/*

	 *弹出错误信息页面

	 */

	function mediaError()

	{

		iPanel.overlayFrame.location ="MediaError_vod_tvod.jsp?PARAM=1"; //断流

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



    /**

     *vod播放完毕后，跳转到提示页面

     */

    function finishedPlay()
    {
		    var tempUrl = "";	
		    document.getElementById("seekDiv11").innerHTML =''; 
		    document.getElementById("seekDiv12").innerHTML =''; 
		    var tempUrl = "PlayVodFinished.jsp?TYPE_ID="+"<%=typeId%>"+"&FILM_ID=" + "<%=filmId%>"+"&superVodID="+<%=superVodID%>+"&isSitcom=" + isSitcom + "&nextEpisId=" + nextEpisId + "&nextSitnum=" + nextSitnum + "&backurl="+"<%=backurl%>"+"&FROM="+comeFrom+"&nextFinishId="+"<%=nextFinishId%>"+"&nextFinishFatherId="+"<%=nextFinishFatherId%>";
        if (isFromVas)
            document.location.href = tempUrl;//"backToVis.jsp";
        else
            document.location.href = tempUrl;
    }





    var timerTrack = "";

    function switchTrack()

    {

		

		/*

        mp.switchAudioTrack();

        var tabdef = "<table width=120 height=30><tr><td><font color=white size=20>";

        tabdef += mp.getAudioTrack();

        tabdef += "</font></td></tr></table>";

        document.getElementById("bottomframe").innerHTML = tabdef;

        clearTimeout(timerTrack);

        timerTrack = setTimeout("hideTrack();",5000)

		*/

		

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

	        document.getElementById("TrackImg").innerHTML = tabdef;

	        clearTimeout(timerTrack);

            timerTrack = setTimeout("hideTrackImg();",5000)

        }

    }
 function hideTrackImg()
    {
        document.getElementById("TrackImg").innerHTML = "";
    }



    function hideTrack()

    {

        document.getElementById("bottomframe1").innerHTML = "";

    }





    function switchSubTitle()

    {



        var tabdef = "<table width=120 height=30><tr><td><font color=white size=20>";

        tabdef += mp.getSubtitle();

        tabdef += "</font></td></tr></table>";

        document.getElementById("bottomframe1").innerHTML = tabdef;

    }



    function goBack()
    {

         window.location.href = returnUrl;

    }





    var timeID_volume = "";

	/*

	 * 隐藏音量显示

	 */

	function unVolume()

	{

		document.getElementById("volumeDiv").style.display = "none";

	}



	/*

	 * 显示音量显示

	 */

	function disVolume()

	{

		document.getElementById("volumeDiv").style.display = "block";

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
		changeVolume(5);

    }
	function changeVolume(value)
	{
		var muteFlag = mp.getMuteFlag();
    	if(muteFlag == 1)
    	{
            mp.setMuteFlag(0);
			document.getElementById("bottomframeMute").innerHTML = "";
    	}
		disVolume();
		var volume = mp.getVolume() + value;
		volume = volume > 100 ? 100 : volume;
		volume = volume < 0 ? 0 : volume;
		mp.setVolume(volume);
		showVolume();
		clearTimeout(timeID_volume);
		timeID_volume = setTimeout("unVolume()",5000);
		//top.document.getElementById("muteDiv").style.background = "url()";
	}

	function showVolume()
	{
		var volume = Math.round(mp.getVolume() / 5);
		for(var i=0; i<20; i++) document.getElementById("grid"+i).style.backgroundColor = i < volume ? "#00FF00" : "#FFFFFF";
		document.getElementById("volumeText").innerText = volume;
	}


	/*

	 *减小音量

	 */



	function decVolume()
	{
		changeVolume(-5);
	}



    /**

     * 状态标志判断 需要增加判断是否已经按了退出键

     */

    function arrowUp()

    {

	/*     if(disLockFlag == 1) return;

        if(!infoEnable || isSeeking == 1)  //有提示信息 或显示进度条

        {

            return 0;

        }

        if(miniFlag)   //鏈夋彁绀轰俊鎭?

        {

            return 0;

        }		

		


		var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101||rc_model == 106)

		{

			return ;

		}

		else

		{

        	gotoEnd();

		} */
    	   
    /* 	
    	if(isSitcom!=0){
    		document.getElementById("seekDiv12").style.display = "none";
    	}
    	if(isSitcom==0){
    		document.getElementById("seekDiv11").style.display="none";
    	} */
		if(isSitcom!=0){
    		document.getElementById("filmInfo2").contentWindow.keyUp();
    	}
		 
    }



    function arrowDown()

    {

	/*     if(disLockFlag == 1) return;

        if(!infoEnable || isSeeking == 1)  //有提示信息

        {

            return 0;

        }

        if(!infoEnable || isSeeking == 1)  //鏈夋彁绀轰俊鎭?

        {

            return 0;

        }

		var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101||rc_model == 106)

		{

			return ;

		}

		else

		{

        	gotoStart();

		} */
// 		if(iframeFlag=="close")
// 			{
// 			iframeFlag=="open";
// 			}else{
// 				iframeFlag=="close";
// 			}
	/* 	var right = Util.getURLParameter("right",vodUrl)==""?0:Util.getURLParameter("right",vodUrl);
		var down = Util.getURLParameter("down",vodUrl)==""?0:Util.getURLParameter("down",vodUrl);
		var parentTypeId = Util.getURLParameter("parentTypeId",vodUrl)==""?0:Util.getURLParameter("parentTypeId",vodUrl);
		var motherTypeId = Util.getURLParameter("motherTypeId",vodUrl)==""?"":Util.getURLParameter("motherTypeId",vodUrl); */
	//	var url_1 = getCookie("url1");
		<%--  hideInfo();
	//	var miniUrl1="newfilmDetail_pro.jsp?PROGID=<%=strFilmId%>&TYPE_ID=<%=typeId%>&ECTYPE=0&TYPE=null&motherTypeId=<%=motherTypeId%>&parentTypeId=10000100000000090000000000038597&SUPVODID=-1&FROM=-1&tuijianflag=1&right=19&down=0";
		var miniUrl1="vod_FilmDetail_List-hd_pro.jsp?FILM_ID=<%=strFilmId%>&TYPE_ID=<%=typeId%>&parentTypeId=<%=parentTypeId%>&motherTypeId=<%=motherTypeId%>&FROM=-1&right=19&down=0&twovodname=%E6%88%8F%E6%9B%B2"
		//		var miniUrl2="programDetail_xj.jsp?PROGID=1250926&TYPE_ID=10000100000000090000000000020089&ECTYPE=0&TYPE=null&motherTypeId=10000100000000090000000000020089&parentTypeId=10000100000000090000000000020080&SUPVODID=-1&FROM=-1&tuijianflag=null&right=19&down=0";
		var miniUrl2="programDetail_xj.jsp?TYPE_ID="+"<%=typeId%>"+"&PROGID=<%=superVodID%>&ECTYPE=0&TYPE=null&motherTypeId=<%=motherTypeId%>&parentTypeId=<%=parentTypeId%>&FROM=-1&tuijianflag=null&right=19&down=0"; --%>
	if(tcFlag==1||OjFlag=="open"){
			return;
		}else{
			var GOTOType =Authentication.CTCGetConfig("STBType");

	        if(GOTOType == null||GOTOType == ""){
		
	        GOTOType =  Authentication.CUGetConfig("device.stbmodel");	

	          }
	       if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("HG680-L")>=0){	
	    	  hideInfo();
	    	  <%-- 	//	var miniUrl1="newfilmDetail_pro.jsp?PROGID=<%=strFilmId%>&TYPE_ID=<%=typeId%>&ECTYPE=0&TYPE=null&motherTypeId=<%=motherTypeId%>&parentTypeId=10000100000000090000000000038597&SUPVODID=-1&FROM=-1&tuijianflag=1&right=19&down=0"; --%>
	    	  		var miniUrl1="vod_FilmDetail_List-hd_pro.jsp?FILM_ID=<%=strFilmId%>&TYPE_ID=<%=typeId%>&parentTypeId=<%=parentTypeId%>&motherTypeId=<%=motherTypeId%>&FROM=-1&right=19&down=0&twovodname=%E6%88%8F%E6%9B%B2"
	    	  		//		var miniUrl2="programDetail_xj.jsp?PROGID=1250926&TYPE_ID=10000100000000090000000000020089&ECTYPE=0&TYPE=null&motherTypeId=10000100000000090000000000020089&parentTypeId=10000100000000090000000000020080&SUPVODID=-1&FROM=-1&tuijianflag=null&right=19&down=0";
	    	  		var miniUrl2="programDetail_xj.jsp?TYPE_ID="+"<%=typeId%>"+"&PROGID=<%=superVodID%>&ECTYPE=0&TYPE=null&motherTypeId=<%=motherTypeId%>&parentTypeId=<%=parentTypeId%>&FROM=-1&tuijianflag=null&right=19&down=0";

	    	  if(iframeFlag=="close"){
	  			
	    	    	    
	    	    	if(isSitcom==0){
	    	    		if(GOTOType.indexOf("B860AV1.1")>=0){	
	    	    		document.getElementById("seekDiv11").innerHTML ='<iframe name="filmInfo1" id="filmInfo1" scroll="no" height="530px" width="640px" src="'+miniUrl1+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
	    	    	     }else{
						 document.getElementById("seekDiv11").innerHTML ='<iframe name="filmInfo1" id="filmInfo1" scroll="no" height="720px" width="1280px" src="'+miniUrl1+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
						 }
	    	    	} 
	    	    	else{
					if(GOTOType.indexOf("B860AV1.1")>=0){	
	    	    		document.getElementById("seekDiv12").innerHTML ='<iframe name="filmInfo2" id="filmInfo2" scroll="no" height="530px" width="640px" src="'+miniUrl2+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
					}else{
					document.getElementById("seekDiv12").innerHTML ='<iframe name="filmInfo2" id="filmInfo2" scroll="no" height="720px" width="1280px" src="'+miniUrl2+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
                    }					
	    	    	}
					 if(GOTOType.indexOf("E900")>=0||GOTOType.indexOf("B860AV1.1")>=0){	
					xjFlag="open";
					}
	    	    	iframeFlag="open";
                    tzFlag="open";
				
	    	    }else{

	    	    	if(isSitcom==0){
	    	    		 document.getElementById("filmInfo1").contentWindow.keyDown();
	    	    		//document.getElementById("seekDiv11").innerHTML =''; 
	    	    	    // iframeFlag="close";
					    // tzFlag="close";
	    	    	}
	    	    	else{
                         document.getElementById("filmInfo2").contentWindow.keyDown();
	    	    		//document.getElementById("seekDiv12").innerHTML ='';
						//xjFlag="close";
	    	    	}
	    	    	
				
	    	    }
	         }else{
	          EndF();
		
	           }
		}
        
      function EndF(){
    	  if(disLockFlag == 1) return;

          if(!infoEnable || isSeeking == 1)  //有提示信息

          {

              return 0;

          }

          if(!infoEnable || isSeeking == 1)  //鏈夋彁绀轰俊鎭?

          {

              return 0;

          }

  		var rc_model = iPanel.ioctlRead("rc_model");

  		if(rc_model == 101||rc_model == 106)

  		{

  			return ;

  		}

  		else

  		{

          	gotoStart();

  		}
      }
		/* if(iframeFlag=="close"){
			
    	
    	if(isSitcom==0){
    		if(GOTOType.indexOf("B860AV1.1")>=0){	
    		document.getElementById("seekDiv11").innerHTML ='<iframe name="filmInfo1" id="filmInfo1" scroll="no" height="530px" width="640px" src="'+miniUrl1+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
    	     }else{
			 document.getElementById("seekDiv11").innerHTML ='<iframe name="filmInfo1" id="filmInfo1" scroll="no" height="720px" width="1280px" src="'+miniUrl1+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
			 }
    	} 
    	else{
		if(GOTOType.indexOf("B860AV1.1")>=0){	
    		document.getElementById("seekDiv12").innerHTML ='<iframe name="filmInfo2" id="filmInfo2" scroll="no" height="530px" width="640px" src="'+miniUrl2+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
    	}else{
		document.getElementById("seekDiv12").innerHTML ='<iframe name="filmInfo2" id="filmInfo2" scroll="no" height="720px" width="1280px" src="'+miniUrl2+'" bgcolor="transparent" allowtransparency="true" style="border:0px"></iframe>'; 
		}
		}
    	iframeFlag="open";

    }else{

    	if(isSitcom==0){
    		
    		document.getElementById("seekDiv11").innerHTML =''; 
    	     
    	}
    	else{
    		document.getElementById("seekDiv12").innerHTML =''; 
    	}
    	iframeFlag="close";
    } */
		
		
		
// 		document.getElementById("test").innerHTML=miniUrl1;
		
    }
	

	function pageDown()
	{
		if(disLockFlag == 1) return;

        if(!infoEnable)  //鏈夋彁绀轰俊鎭?鎴栨樉绀鸿繘搴︽潯

        {

            return 0;

        }	

        if(miniFlag)   //鏈夋彁绀轰俊鎭?

        {

            return 0;

        }		

		  //  gotoEnd();
		  if(isSitcom == 1)
		  {
			  if(nextEpisId  == -1)   //是连续剧最后一集
			  {
				  if((comeFrom == "liaoNing" || comeFrom == "xinWen")&& nextFilmId != -1)
				  {
					  nextFilm();
				  }
				  else 
				  {
					  gotoEnd();
				  }
			  }
			  else
			  { 
			 	 nextPlay();
			  }
		  }
		  else if(isSitcom == 0)
		  {
			  if((comeFrom == "liaoNing" || comeFrom == "xinWen")&& nextFilmId != -1)
			  {
				   nextFilm();
			  }
			  else 
			  {
				  gotoEnd();
			  } 
		  }
	}

	

	function pageUp()

	{

		if(disLockFlag == 1) return;

        if(!infoEnable)  //鏈夋彁绀轰俊鎭?鎴栨樉绀鸿繘搴︽潯

        {

            return 0;

        }

		

        if(miniFlag)   //鏈夋彁绀轰俊鎭?

        {

            return 0;

        }		

		//gotoStart();
		  if(isSitcom == 1)
		  {
			  if(preEpisId  == -1)   //连续剧第一集
			  {
				  if((comeFrom == "liaoNing" || comeFrom == "xinWen")&& preFilmId != -1)
				  {
					  preFilm();
				  }
				  else 
				  {
					  gotoStart();
				  }
			  }
			  else
			  { 
			 	 prePlay();
			  }
		  }
		  else if(isSitcom == 0)
		  {
			  if((comeFrom == "liaoNing" || comeFrom == "xinWen")&& preFilmId != -1)
			  {
				   preFilm();
			  }
			  else 
			  {
				  gotoStart();
			  } 
		  }
	}



    function gotoStart()

    {

        mp.gotoStart();

    }



    function gotoEnd()

    {

        mp.gotoEnd();

    }



   function showQuit()
    {
	    tcFlag = 1;
	    if(disLockFlag == 1) return;
        if(infoEnable == false)
        {
            return 0;
        }
        infoEnable = false;
        hideInfo();
		var yesLeft = 90;
		var noLeft = 40;
		var oneButton = false;  //上一集,下一集只有其中一个
		if((nextEpisId != -1 && preEpisId == -1) ||(nextEpisId == -1 && preEpisId != -1))
		{
			oneButton = true;		
		}
		//if((isAssess || isFromVas))
 		//{
	    //将"加入书签并退出"按钮去掉,把"否","是"按钮向中间移一点
			yesLeft = 150; 
			noLeft = 100;
 		//}
        var tabdef = '';
		tabdef += '<div style="position:absolute; left:0px; top:0px; width:380px; height:262px;">';
		tabdef += '<img src="images/playcontrol/playVod/quit.jpg" height="262" width="380">';
		tabdef += '</div>';
		tabdef += '<div style="position:absolute; left:'+noLeft+'px; top:45px; width:70px; height:40px;">';
		tabdef += '<a id="type0" href="javascript:cancel()">';
		tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="60">';
		tabdef += '</a>';
		tabdef += '</div>';
		tabdef += '<div style="position:absolute; left:'+yesLeft+'px; top:45px; width70px; height:40px;">';
        if(!(isAssess || isFromVas)){
		//从观看记录进入的二号平台节目
		if('<%=spflag%>'== 'sp')
		{
		tabdef += '<a id="type2" href="javascript:ensureQuit()">';	
		}else{
		tabdef += '<a id="type2" href="javascript:SaveQuit()">';
		}
		}
		else{
		tabdef += '<a id="type2" href="javascript:ensureQuit()">';	
		}
		tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="60">';
		tabdef += '</a>';
		tabdef += '</div>';
		tabdef += '<div style="position:absolute; left:50px; top:10px; width:300px; height:30px;">您是否要退出当前收看节目?</div>';
		tabdef += '<div style="position:absolute; left:'+(noLeft+20)+'px; top:55px; width:50px; height:30px;">否</div>';
		tabdef += '<div style="position:absolute; left:'+(yesLeft+20)+'px; top:55px; width:50px; height:30px;">是</div>';
		
		tabdef += '<div style="position:absolute; left:15px; top:140px; width:348px; height:30px;">';
		tabdef += '<img src="img/prompt.jpg" height="30" width="348"></div>';
		tabdef += '<div style="position:absolute; left:15px; top:170px; width:348px; height:84px;">';
		tabdef += '<a id="posterDiv2" href="">';
		tabdef += '<img src="images/playcontrol/playVod/poster.gif" height="84" width="348" id="posterPic2">';
		tabdef += '</a>';
		tabdef += '</div>'; 
// 		if(!(isAssess || isFromVas))
// 		{
//			tabdef += '<div style="position:absolute; left:220px; top:65px; width70px; height:40px;">';
//		    tabdef += '<a id="type2" href="javascript:zhibo()">';
//		    tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="60">';
//		    tabdef += '</a>';
//		    tabdef += '</div>';
// 			tabdef += '<div style="position:absolute; left:150px; top:45px; width:215px; height:40px;">';
// 			tabdef += '<a id="type1" href="javascript:SaveQuit()">';
// 			tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="200">';
// 			tabdef += '</a>';
// 			tabdef += '</div>';
// 			tabdef += '<div style="position:absolute; left:150px; top:55px; width:215px; height:30px;">加入历史记录并退出</div>';
//           tabdef += '<div style="position:absolute; left:228px; top:75px; width:60px; height:30px;">直播</div>';
// 		}
		if(nextEpisId != -1)
		{
			var divLeft = oneButton? 125:75;
			tabdef += '<div style="position:absolute; left:'+divLeft+'px; top:95px; width:150px; height:40px;">';
			tabdef += '<a id="nextPlay" href="javascript:nextPlay()">';
			tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="100" >'; 
			tabdef += '</a>';
			tabdef += '</div>';
			tabdef += '<div id="preProg" style="position:absolute; left:'+(divLeft+15)+'px; top:105px; width:100px; height:30px;">下一集</div> ';
		}
		if(preEpisId != -1)
		{
			var divLeft = oneButton? 125:175;
			tabdef += '<div style="position:absolute; left:'+divLeft+'px; top:95px; width:150px; height:40px;">';
			tabdef += '<a id="prePlay" href="javascript:prePlay()">';
			tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="100" >';
			tabdef += '</a>';
			tabdef += '</div>';
			tabdef += '<div id="nextProg" style="position:absolute; left:'+(divLeft+15)+'px; top:105px; width:100px; height:30px;">上一集</div>';
		
		}
		createNextFilm(tabdef);
       // document.getElementById("playdisplay").innerHTML = tabdef;

        if(isSeeking == 1)
        {
            displaySeekTable();
        }
        pause();
        //delete 出现退出提示 快速移动焦点问题
        //setTimeout('document.getElementById("type1").focus();',1000);
		  document.getElementById("type2").focus(); 
		  	document.getElementById("advertDiv1").style.display = "none";
		  OjFlag="close";
		  //modify  焦点在“是”上
		  //  document.getElementById("type1").focus();
      //显示退出时广告
		    showPicPoster2();
    }
	//退出层,如果 金色童年,新闻频道,退出时播放下一条,上一条
	function createNextFilm(tabdef)
	{
		if(isSitcom != 1 && (comeFrom == "tongNian"||comeFrom=="xinWen" || comeFrom=="liaoNing"))  //不是连续剧
		{
			var oneButton = false;
			if((nextFilmId != -1 && preFilmId == -1) ||(nextFilmId == -1 && preFilmId != -1))
			{
				oneButton = true;		
			}
			if(nextFilmId != -1)
			{
				var divLeft = oneButton? 125:75;
				tabdef += '<div style="position:absolute; left:'+divLeft+'px; top:115px; width:150px; height:40px;">';
				tabdef += '<a id="nextPlay" href="javascript:nextFilm()">';
				tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="100" >';
				tabdef += '</a>';
				tabdef += '</div>';
				tabdef += '<div id="preProg" style="position:absolute; left:'+(divLeft+15)+'px; top:125px; width:100px; height:30px;">下一条</div> ';
			}
			if(preFilmId != -1)
			{
				var divLeft = oneButton? 125:175;
				tabdef += '<div style="position:absolute; left:'+divLeft+'px; top:115px; width:150px; height:40px;">';
				tabdef += '<a id="prePlay" href="javascript:preFilm()">';
				tabdef += '<img src="images/playcontrol/link-dot.gif" height="40" width="100" >';
				tabdef += '</a>';
				tabdef += '</div>';
				tabdef += '<div id="nextProg" style="position:absolute; left:'+(divLeft+15)+'px; top:125px; width:100px; height:30px;">上一条</div>';
			
			}
		}
       document.getElementById("playdisplay").innerHTML = tabdef;
	}




    /**

     * 确认取消

     */

    function cancel()

    {
    	tcFlag=0;

        //var tabdef = '<div style="position:absolute;left:0px; top:0px; width:646px; height:100px; z-index:1">';

        //tabdef += '<table width="640" height="100" border="0" cellpadding="0" cellspacing="0" bgcolor="transparent"></table>';

        infoEnable = true;

        document.body.bgcolor="transparent";

        document.getElementById("playdisplay").innerHTML = "";

        document.body.bgcolor="transparent";

        pressFavo = 0;

        pressBookMark = 0;

        resume();

    }



    /**

     * 确认退出

     */
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
	//二号平台添加观看记录
    function ensureQuit()
    {
        var tempUrl = returnUrl;
		//var tempUrl = getCookie("onereturn");
		//var spflag = '<%=spflag%>';
		//if(spflag == 'sp'){
			//tempUrl = returnUrl;
		//}
		var collect_type="2";//观看记录
		
    		
            mp.stop();
			//华为添加观看记录
			if(hwType=="1")
			{
		    setHistorys();
			}
			setTimeout("goBack()", 100);
			//document.location.href = tempUrl;
		
    }

	
	//观看记录
	 var xmlhttp;
	 function setHistorys()
	 {
	 var progTime = mp.getCurrentPlayTime(); //读取当前播放的时间
     var endTime = mp.getMediaDuration(); //该vod播放时长
	 var url="?vo.userid=<%=iaspuserid%>&vo.collect_type=2&vo.vod_program_code="+strFilmId+"&vo.vod_name=<%=URLEncoder.encode(newname)%>&vo.vod_poster_url=<%=vod_poster_url%>&vo.vod_total_time="+endTime+"&vo.vod_current_time="+progTime;
	 
	 if (window.XMLHttpRequest) {
				//isIE   =   false; 
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				//isIE   =   true; 
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//http://218.24.37.24:9090
			var URL = "http://218.24.37.24:9091/ugms/userCollectProgram_save.do"+url;
			xmlhttp.open("GET", URL, true);
			xmlhttp.onreadystatechange = handleResponse;
			xmlhttp.setRequestHeader("If-Modified-Since", "0");
			xmlhttp.send(null);
	}
	//加密
	function Encrypt(word){  
         var key = CryptoJS.enc.Utf8.parse("rockrollformusic");   
  
         var srcs = CryptoJS.enc.Utf8.parse(word);  
         var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});  
         return encrypted.toString();  
    } 
	function handleResponse(){
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			
				var result=xmlhttp.responseText;
				
				xmlhttp = null;
				//var obj=eval('('+result+')');
				
				
						}
	}

/////书签添加////////=============wsj=======//////////
    function SaveQuit()

    {   
	//var tempUrl = getCookie("onereturn");
    	if (showTimer != "")
        {
            clearTimeout(showTimer);
        }
        document.getElementById("filmInfodiv").style.display = "none";
        
    
        var progTime = mp.getCurrentPlayTime(); //读取当前播放的时间
    		var endTime = mp.getMediaDuration(); //该vod播放时长
    		
       // var addBMUrl="";
       // addBMUrl+=userid;
      //  addBMUrl+="|";
      //  addBMUrl+=strFilmId;
      //  addBMUrl+="|";
      //  addBMUrl+=progTime;
        mp.stop();
        var nextUrl = '<%=returnUrl%>';
		
        //var iRet = iPanel.ioctlWrite("addBookmark",addBMUrl);
		var addBookMarkUrl = "query_BookMarkAction.jsp?ACTION=insert&SUPVODID="+<%=superVodID%>+"&PROGID=";
		addBookMarkUrl+= strFilmId+"&BEGINTIME="+progTime+"&ENDTIME="+endTime;
		addBookMarkUrl+="&onekeySwitchTurnPage="+nextUrl;
		var meta = document.getElementsByTagName('meta')[0];
        meta.setAttribute('content','1280*720') 
        window.location.href = addBookMarkUrl;
		
    }
    function zhibo(){
	var GOTOType =Authentication.CTCGetConfig("STBType");
	if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0||GOTOType.indexOf("HG680-L")>=0){
	window.location.href="zb-channellist.jsp";
	}else{
	window.location.href="chan_RecordList.jsp";
	}
    	
    }

    function inputNum(i)

    {

	    if(!infoEnable)  //当显示退出提示信息，数字键不相应

		{

		    return;

		}

	    if(isSeeking == 1)  //当显示退出提示信息，数字键不相应

		{

		    return;

		}		

        /*

        if(state == "seek")

        {

            seekInput(i);

        }

        else

        {

        */

            if(number * 10 >= 1000)

            {

                return 0;

            }

            number = number * 10 + i;

            showChannelNum(number);



            //iPanel.debug.debug("tabdef=" + tabdef);

            //setTimeout('"joinChannel(' + number + ')"',1000);

            clearTimeout(timeID);

            timeID = setTimeout("playChannel("+ number +")", 1000);

        //}

    }



    function showChannelNum(num)

    {

        var tabdef = '<table width=200 height=30><tr align="right"><td><font color=green size=20>';

        tabdef += num;

        tabdef += '</font></td></tr></table>';

        document.getElementById("topframe").innerHTML=tabdef;

    }



	function hideChannelNum()

	{

	    document.getElementById("topframe").innerHTML = "";

	}



    function playChannel(chanNum)

    {

		document.getElementById("img_2").blur();

	    disLockFlag = 1;

		order.style.display = "block";

		document.getElementById("img_1").focus();

		disChanngeChannelInfo();

        //var tempUrl = "ChannelNumAction.jsp?channelNum=" + chanNum;

        //window.location.href = tempUrl;

    }

	

	function disChanngeChannelInfo()

	{

	    document.getElementById("displayLockInfo").innerHTML = '您是否要跳转<' + number + '>频道，请选择操作：';

	}

	

	

	var disLockFlag = 0;// 0 不显示, 1 显示

	/**

	 * 跳转频道前进行提示

	 */

	 

	 //跳转

	 function ensureCheckPass()
	 {

         var tempUrl = "ChanDirectAction.jsp?chanNum=" + number;

        window.location.href = tempUrl;		 

    }



	 //取消

	 function cancleCurrAction()

	 {

	     number = 0;

	     disLockFlag = 0;

		 order.style.display = "none";

		 hideChannelNum();

		 //document.getElementById("img_1").blur();

		 document.getElementById("img_2").blur();

	 }



    function seekInput(i)

    {

        // 最大时间99:59:59

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

                hour = hour * 10 + i;

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

            hour = 0;

            min = 0;

            sec = 0;

            timeIndex = 0;

            seekTimeString = "|__:__:__";



            // 一秒钟这后切换频道

            setTimeout("seekPlay(" + timeStamp + ")", 1000);

        }

    }





    function seek()

    {

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



    function seekPlay(timePos)

    {

         mp.playByTime(1,timePos,1);

         document.getElementById("topframe").innerHTML = "";

    }





    function play()
    {

        mp.setVideoDisplayArea(0,0,0,0);

        mp.setVideoDisplayMode(1);

        mp.refreshVideoDisplay();
        mp.playFromStart();

        //mp.setVideoDisplayArea(20,20,200,150);





    }



    function playByTime(beginTime)

    {if(isSeeking == 1)

        {

            //beginTime = tempCurrTime;

        }



        //nomal play time

        var type = 1;

        var speed = 1;



        //mp.playFromStart();

       

        mp.playByTime(type,beginTime,speed);

        //tempCurrTime = 0;

        currTime = mp.getCurrentPlayTime();

        //mp.setVideoDisplayArea(20,20,200,150);

        mp.setVideoDisplayMode(1);

        mp.refreshVideoDisplay();

    }



    function pause()

    {

        playStat = "pause";

        mp.pause();



        /*

        if(mp.getNativeUIFlag() == 0)

        {

            var tabdef = "<table width=200 height=30><tr><td><font color=blue size=20>";

            tabdef += "暂停";

            tabdef += "</font></td></tr></table>";

            document.getElementById("topframe").innerHTML = tabdef;

        }

        */

        return;

    }



    function arrowLeft()

    {
    	
        var GOTOType =Authentication.CTCGetConfig("STBType");

	        if(GOTOType == null||GOTOType == ""){
		
	        GOTOType =  Authentication.CUGetConfig("device.stbmodel");	

	          }
	       if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("E900")>=0){	
	    if(GOTOType.indexOf("E900")>=0||GOTOType.indexOf("B860AV1.1")>=0){		
           if(iframeFlag=="open"){
		   if(isSitcom==0){
		   document.getElementById("filmInfo1").contentWindow.keyLeft();
		   }else{
		    document.getElementById("filmInfo2").contentWindow.keyLeft();
		   }
		   return;
           }		   
		   if(tzFlag=="open")
		   {
		    document.getElementById("bf").contentWindow.fnOperatePlayBar('back');
		   }else
		   {
		   showTz();
		   }
		   }else{
		    showTz();
		   }
        return;
        }
	    if(disLockFlag == 1) return;

		       

		var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101||rc_model == 106)

		{

			if(!infoEnable || (isSeeking == 1 && isJumpTime == 1) || miniFlag)

			{

				return true;

			}

			else

			{

				decVolume();

			}

		}

		else

		{

        	fastRewind();

		}

    }


    function showTz(){
        if(disLockFlag == 1) return;

		

		var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101||rc_model == 106)

		{

			if(!infoEnable || (isSeeking == 1 && isJumpTime == 1) || miniFlag)

			{

				return true;

			}

			else

			{

				incVolume();

				return false;

			}

		}
		else{
// 			document.getElementById("test").innerHTML=tzFlag+"---"+isSeeking+"---"+isJumpTime;
			 if(!infoEnable)   //有提示信息

		        {

		            return 0;

		        }



		        hideInfo();



		        if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0))  //是否进行快进

		        {

		            if(isSeeking == 0)

		            {

		                displaySeekTable_bf(1);

		                clearTimeout(timeID_jumpTime);

		                isJumpTime = 0;

		                document.getElementById("jumpTimeDiv").style.display = "none";

		                //document.getElementById("jumpTimeImg").style.display = "none"; //new

		            }else{
		if(tzFlag=="close"){
		    var GOTOType =Authentication.CTCGetConfig("STBType");

	        if(GOTOType == null||GOTOType == ""){
		
	        GOTOType =  Authentication.CUGetConfig("device.stbmodel");	

	          }
	    if(GOTOType.indexOf("E900")>=0){		
			document.getElementById("bfmovie").innerHTML ='<iframe  src="bf-movie1.jsp" id="bf" height="600px" width="700px"></iframe>'; 
	    	}else{
			document.getElementById("bfmovie").innerHTML ='<iframe  src="bf-movie.jsp" id="bf" height="530px" width="640px"></iframe>'; 
	    	}
		    	tzFlag="open";
			
			}
		            }

		    }
		}
    }

    function arrowRight()

    {  
	var GOTOType =Authentication.CTCGetConfig("STBType");

	        if(GOTOType == null||GOTOType == ""){
		
	        GOTOType =  Authentication.CUGetConfig("device.stbmodel");	

	          }
	       if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("E900")>=0){	
          if(GOTOType.indexOf("E900")>=0||GOTOType.indexOf("B860AV1.1")>=0){		   
		   if(iframeFlag=="open"){
		   if(isSitcom==0){
		   document.getElementById("filmInfo1").contentWindow.keyRight();
		   }else{
		   document.getElementById("filmInfo2").contentWindow.keyRight();
		   }
		   return;
           }
		   if(tzFlag=="open")
		   {
		    document.getElementById("bf").contentWindow.fnOperatePlayBar('forward');
		   }else
		   {
		   showTz();
		   }
		   }else{
		    showTz();
		   }
        return;
        }
    	
	    if(disLockFlag == 1) return;

		

		var rc_model = iPanel.ioctlRead("rc_model");

		if(rc_model == 101||rc_model == 106)

		{

			if(!infoEnable || (isSeeking == 1 && isJumpTime == 1) || miniFlag)

			{

				return true;

			}

			else

			{

				incVolume();

				return false;

			}

		}

		else

		{

        	fastForward();

		}   

    }



    function fastForward()

    {
       tcFlag=1;
        if(!infoEnable)   //有提示信息

        {

            return 0;

        }



        hideInfo();



        if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0))  //是否进行快进

        {

            if(isSeeking == 0)

            {

                displaySeekTable(1);

                clearTimeout(timeID_jumpTime);

                isJumpTime = 0;

                document.getElementById("jumpTimeDiv").style.display = "none";

                //document.getElementById("jumpTimeImg").style.display = "none"; //new

            }



            if(speed >= 32 && playStat == "fastforward")

            {

                //resume();

                displaySeekTable();

                return 0;

            }

            else

            {

                if(playStat == "fastrewind") speed = 1;

                speed = speed * 2;

                playStat = "fastforward";

                //iPanel.debug.debug("fastForward();speed="+speed);



                mp.fastForward(speed);

                document.getElementById("statusImg").innerHTML = speed + 'X&nbsp;<img src="images/playcontrol/fastForward.gif" width="20" height="20"/>';

            }





            /*

            if(mp.getNativeUIFlag() == 0)

            {

                var tabdef = "<table width=200 height=30><tr><td><font color=blue size=20>";

                tabdef += "快进" + speed;

                tabdef += "</font></td></tr></table>";

                document.getElementById("topframe").innerHTML = tabdef;

            }

            */

        }

    }



    function fastRewind()

    {
      tcFlag=1;
        if(!infoEnable)  //有提示信息

        {

            return 0;

        }



        hideInfo();



        if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0))

        {

            if(isSeeking == 0)

            {

                displaySeekTable(1);

                clearTimeout(timeID_jumpTime);

                isJumpTime = 0;

                document.getElementById("jumpTimeDiv").style.display = "none";

                //document.getElementById("jumpTimeImg").style.display = "none"; //new

            }

            if(speed >= 32 && playStat == "fastrewind")

            {

                //resume();

                displaySeekTable();

                return 0;

            }

            else

            {

                if (playStat == "fastforward") speed = 1;

                speed = speed * 2;

                playStat = "fastrewind";

                mp.fastRewind(-speed);

                document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/fastRewind.gif" width="20" height="20"/>&nbsp;X' + speed;

            }



            /*

            if(mp.getNativeUIFlag() == 0)

            {

                var tabdef = "<table width=200 height=30><tr><td><font color=blue size=20>";

                tabdef += "快退" + speed;

                tabdef += "</font></td></tr></table>";

                document.getElementById("topframe").innerHTML = tabdef;

            }

            */

        }

    }





    function resume()

    {

	

        //判断进度条是否存在

        if(isSeeking == 1)

        {

            document.getElementById("seekDiv").style.display = "none";
             trFlag=0;
			//并且停掉进度条时间

            clearTimeout(timeID_jumpTime);

            clearTimeout(timeID_check);  			

        }

        speed = 1;

        playStat = "play";

        mp.resume();

        if(mp.getNativeUIFlag() == 0)

        {

            document.getElementById("topframe").innerHTML = "";

			var playPic = '<img src="images/playcontrol/play.gif">';

			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + playPic + '</td></tr></table>';

	        topTimer = setTimeout("hideTopFrm()", 5000);			

			

        }

        return;

    }

	

	function beginning()

	{

        //判断进度条是否存在

        if(isSeeking == 1)

        {

			//将进度条清空

			//processSeek(0);

			EventBeginForSeek();

			document.getElementById("seekDiv").style.display = "none";
           trFlag=0;
			document.getElementById("jumpTimeDiv").style.display = "block";

			//并且停掉进度条时间

            clearTimeout(timeID_jumpTime);

            clearTimeout(timeID_check);  

            

            isSeeking = 0;

            isJumpTime = 1;   

            

            document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/pause.gif" width="20" height="22"/>';                       			

            			

        }

        speed = 1;

        playStat = "play";

        //mp.resume();

        if(mp.getNativeUIFlag() == 0)

        {

            document.getElementById("topframe").innerHTML = "";

			var playPic = '<img src="images/playcontrol/play.gif">';

			document.getElementById("topframe").innerHTML = '<table width=200><tr align=left><td width=100></td><td>' + playPic + '</td></tr></table>';

	        topTimer = setTimeout("hideTopFrm()", 5000);			

        }

        return;	

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

		setTimeout("hideSeekDive();",500);

		//document.getElementById("seekDiv").style.display = "none";

	}



	function hideSeekDive()

	{

		document.getElementById("seekDiv").style.display = "none";
		tcFlag=0;

	}



	

	

    function setSpeed(s_speed)

    {

        speed = s_speed;

        if(speed > 0)

        {

            mp.fastForward(speed);

        }

        else if(speed < 0)

        {

            mp.fastRewind(speed);

        }

        if(speed == 0)

        {

            mp.pause();

        }

    }



    function destoryMP()

    {

        mp.stop();

    }



    function goEnd()

    {

        mp.gotoEnd();

    }



    function goBeginning()

    {

        mp.gotoStart();

    }



    function switchAudioChannel()

    {

        mp.switchAudioChannel();

    }



    function switchAudioTrack()

    {

        mp.switchAudioTrack();

    }



    function switchSubtitle()

    {

        mp.switchSubtitle();

    }



    function stop()

    {

        //pr.submit();

        mp.stop();

    }



    var initMediaTime = 0;

	//预约--变量
	var xmlhttp;
    var img;
    var desc;
	var starttime;
	var endtime;
	var twotime = new Array();
	var timearr = new Array();
    function init()

    {
		//预约--start
		//if (window.XMLHttpRequest) {
			//isIE   =   false; 
		//	xmlhttp = new XMLHttpRequest();
		//} else if (window.ActiveXObject) {
			//isIE   =   true; 
		//	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		//}
			
		//var d = new Date();
		//var testtime = d.getTime();
		//var riddle = hex_md5('besto' + testtime);
		//var URL = "http://218.24.37.2/appepg/retrieveWinData?time="+testtime+"&riddle="+riddle+"&win=yyindex&clientType=iptv";
		//xmlhttp.open("GET", URL, true);
		//xmlhttp.onreadystatechange = handleResponse;
		//xmlhttp.setRequestHeader("If-Modified-Since", "0");
		//xmlhttp.send(null);
		
	var boxType = Authentication.CTCGetConfig("STBType");
       	var hdType = "2";
	      var boxCity = "<%=areaId%>";
		var stbId = "<%=stbId%>";
		var pageID="hwdbplayHD.jsp";
		var categoryID ="<%=typeId%>";
		var parentcategoryID ="";
		var contentID ="<%=statisticsprogId%>";	
		
		var categoryType="2";
		var adlog= 'http://218.24.37.2/templets/epg/spstatistics_HD.jsp?deviceToken=<%=iaspuserid%>&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&boxType='+boxType+'&hdType='+hdType+'&boxCity='+boxCity+'&stbId='+stbId+'&pageID='+pageID+'&orignal=5'+'&categoryID='+categoryID+'&contentID='+contentID+'&code=<%=vodCode%>'+'&categoryType='+categoryType;
		
		
		
		var xmlhttpforadlog; 
			 if (window.XMLHttpRequest) 
			 { 
				  xmlhttpforadlog   =   new   XMLHttpRequest(); 
			 } 
			 else if (window.ActiveXObject) 
			 { 
				  xmlhttpforadlog   =   new   ActiveXObject("Microsoft.XMLHTTP"); 
			 } 
			 
			 xmlhttpforadlog.open("GET",adlog, true); 
			 xmlhttpforadlog.onreadystatechange = handlelogResponse; 
			 xmlhttpforadlog.setRequestHeader("If-Modified-Since", "0");
			 xmlhttpforadlog.send(null); 
			 function handlelogResponse() 
			 { 
				 if(xmlhttpforadlog.readyState == 4 && xmlhttpforadlog.status==200) 
				 { 
				 } 
			 }
        initMediaPlay();
        mp.setSingleMedia(json);

        mp.setAllowTrickmodeFlag(0);

        //mp.setSingleMedia(jsonstr);



        mp.setNativeUIFlag(1);

		mp.setAudioTrackUIFlag(0);

        //mp.setNativeUIFlag(0);   //测试本地UI显示

        //mp.setMuteUIFlag(1);

        mp.setMuteUIFlag(0);

		mp.setAudioVolumeUIFlag(0);  //本地音量

        // 防止上次播放的频道的干扰

        //mp.leaveChannel();



        //genSeekTable();



        //var ua = navigator.userAgent;

        var app = navigator.appName;

        if(app == "Microsoft Internet Explorer")

        {

            mp.setNativeUIFlag(0);

        }







        if(isBookMark)

        {

            //mp.playFromStart();

            //playByTime("<%=beginTime%>");

            setTimeout('playByTime("<%=beginTime%>")',500);

        }

        else

        {

            play();

        }

		iPanel.ioctlWrite("mediacode","<%=vodCode%>");

        document.getElementById("cdr").src = "<%=cdrUrl%>";

        mediaTime = mp.getMediaDuration();

        initMediaTime = mediaTime;//有时机顶盒取出的时长不准确，用此变量保存第一次取出的时长





        timePerCell = mediaTime / 100;//进度条中每1%所占的时间

		convertTime();  //获取节目时间

        //document.getElementById("filmInfo").src = miniUrl;

      //  document.getElementById("filmInfodiv").style.display = "none";



        // 五秒种展示提示信息

     //   showTimer = setTimeout("showInfo()", 5000);

		

		// 增加静音的判断

        //if(mp.getMuteFlag() == 1 && (mp.getNativeUIFlag() == 0 && mp.getMuteUIFlag() == 0))
		// document.getElementById("bottomframeMute").innerHTML = mp.getMuteFlag() == 1 ? "url(images/playcontrol/playVod/muteon.png)" : "url()";
	//显示角标广告
		showPicPoster1();
		//document.getElementById("posterDiv1").focus();
//		OjFlag="open";
        setTimeout("showposterDiv1_pro()", 5000);
		var GOTOType =Authentication.CTCGetConfig("STBType");
	    if(GOTOType.indexOf("EC6108V9")>=0||GOTOType.indexOf("B860AV1.1")>=0||GOTOType.indexOf("E900")>=0||GOTOType.indexOf("HG680-RLK9H-12")>=0){
		//时钟广告-高清盒子
		setInterval("showTimePic()",100);
		}    
    }
	function showTime(count) {
    document.getElementById('showPicDiv2').innerHTML = count+"秒";

    if (count == 0) {
	jumpFlag='close';
    document.getElementById('showPicDiv2').style.display  ="none";
	document.getElementById('showPicDiv3').style.display  ="none";
    } else {
        count -= 1;
        setTimeout(function () {
            showTime(count);
        }, 1000);
    }

    }
	function showTimePic(){
        var dateObj= new Date();
        var a=dateObj.getTime();//得到时间,
        var b=dateObj.getHours();//得到小时,
        var c=dateObj.getMinutes();//得到分,
        var d=dateObj.getSeconds();//得到秒,

        if(d=="0"&&c=="0")  
		{
	  	document.getElementById("showPicDiv3").style.display = "block";
		document.getElementById("showPicDiv2").style.display = "block"; 
		showTime(5);
		jumpFlag='open';

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



        var cycleFlag = 1;  //不循环播放

        var randomFlag = 0;

        var autoDelFlag = 0;

        var useNativeUIFlag = 1;

        mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);

        //setTimeout("showInfo()",1000);
		showInfo();
    }



    function showInfo()
    {
        if(hideTimer != "")

        {

            clearTimeout(hideTimer);

        }



        if (showTimer != "")

        {

            clearTimeout(showTimer);

        }



    //   var tabdef = '<iframe name="filmInfo" id="filmInfo" scroll="no" height="210px" width="640px" src="<%=miniUrl%>" bgcolor="transparent" allowtransparency="true"></iframe>';



     //   document.getElementById("filmInfodiv").innerHTML = tabdef;
		document.getElementById("filmInfo").src = miniUrl;
        document.getElementById("filmInfodiv").style.display = "block";
		miniFlag = true;
		hideTimer = setTimeout("hideInfo()",4000);
		
		setTimeout("hideAdvert()",10000);
		//时钟点播前动画显示
//if(DjFlag=="open"){
	
		//}else{
		     //setInterval("showPic()",100);
			 //setTimeout("hideAdvert2()",100);
		     //setTimeout("hideAdvert1()",5000);
		//}
       

    }
function showPic(){
var dateObj= new Date();
var a=dateObj.getTime();//得到时间,
var b=dateObj.getHours();//得到小时,
var c=dateObj.getMinutes();//得到分,
var d=dateObj.getSeconds();//得到秒,

if(d=="0"&&c=="0")
		{
	 document.getElementById("showPicDiv1").style.display = "block";
	 document.getElementById("showPicDiv1").innerHTML=b+":00:00";
	 document.getElementById("showPicDiv").style.display = "block";
	 setTimeout("hidePic()",5000);
		}

	}
	function hidePic(){
 document.getElementById("showPicDiv").style.display = "none";
  document.getElementById("showPicDiv1").style.display = "none";
	}
   //将角标广告位隐藏
    function hideAdvert()
    {
		 OjFlag="close";
		 DjFlag="open";
    	 document.getElementById("advertDiv").style.display = "none";
		 document.getElementById("type2").focus();
    }
 function hideAdvert1()
    {
		 
		resume();
		OjFlag="close";
		
    	document.getElementById("advertDiv1").styladvertDiv1e.display = "none";
		setTimeout("showposterDiv1_pro()",100);
		
		document.getElementById("type2").focus();
    }
	 function hideAdvert2()
    {
		
		  mp.pause();
	
    }
	function showposterDiv1_pro(){
		OjFlag="open";
		document.getElementById("advertDiv").style.display = "block";
	    //showPicPoster1();
		//document.getElementById("posterDiv22").focus();
		
  

		setTimeout("hideAdvert()",5000);
		
	
	}



    function hideInfo()

    {

        if(hideTimer != "")

        {

            clearTimeout(hideTimer);

        }



        if (showTimer != "")

        {

            clearTimeout(showTimer);

        }



        miniFlag = false;
        document.getElementById("filmInfo").src = miniUrl;
        document.getElementById("filmInfodiv").style.display = "none";
		

    }
    function pauseOrPlay()

    { 
		 iframeFlag ="close";
		 tzFlag="close";
	     
    
	

	    if(disLockFlag == 1)

		{

		    return;

		}

		

		

        if(!infoEnable)  // add by duanxiaohui for 当出现退出提示信息的时候，暂停播放键不响应

        {

 

            return;       

        }

         

		clearTimeout(showTimer);

        if(miniFlag)

        {

            clearTimeout(hideTimer);

            hideInfo();

            displaySeekTable();  //显示进度条

			hideInfo();

            return;

        }



        speed = 1;



        if(playStat == "play")  //重点

        {//显示暂停广告
        	showPicPoster3();

            pause();

            displaySeekTable();
           tcFlag=1;
            return;

        }

        else

        {

            resume();
            tcFlag=0;
            displaySeekTable();

            return;

        }



        return;

    }



    function setMuteFlag()
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
    function prePlay()

    {

	   	//当前连续剧产品未订购时进行多集免费判断，其他的播放原逻辑不动
		if(currentPage.indexOf("TV_zpage_one_dj")>-1||currentPage.indexOf("db_zpage_one_dj")>-1){
			//节目付费鉴权标识
			if(Number(isPay) == 1){ 
	    		--programnum;
	    		setAuthenticationData();
    		}    	
	  
    	}
    
    	


		if(preEpisId  == -1)
		{
			return 0;
		}
        mp.stop();
        var tmpUrl = "au_PlayFilm.jsp?TYPE_ID="+"<%=typeId%>"+"&PROGID=" + preEpisId

                 + "&PLAYTYPE=" + <%=EPGConstants.PLAYTYPE_VOD%> + "&CONTENTTYPE=" + <%=EPGConstants.CONTENTTYPE_VOD_VIDEO%>

                 + "&BUSINESSTYPE=" + <%=EPGConstants.BUSINESSTYPE_VOD%>+"&FATHERSERIESID="+<%=superVodID%>+"&FROM="+comeFrom;
      top.location.href = tmpUrl;

    }



	//------------------------------ add by rendd 20190902
    var flag = false;
    var freecount = 0;
	var orderUrl = "";

	var programnum = ('CTCSetConfig' in Authentication)?Number(Authentication.CTCGetConfig("programnum")):Number(Authentication.CUGetConfig("programnum"));
	programnum = programnum==null?0:programnum;


	//判断是否是需要订购的节目，节目付费鉴权标识0鉴权通过不走免费剧集判断逻辑按原播放逻辑走
	var isPay = ('CTCSetConfig' in Authentication)?Authentication.CTCGetConfig("isPay"):Authentication.CUGetConfig("isPay");
	isPay = isPay==null?0:isPay;

	//点击连续剧多集选择，存放页面标识，只有电视剧综艺混排和环球世嘉TV增加多集免费功能，控制播放
	var currentPage = ('CTCSetConfig' in Authentication)?Number(Authentication.CTCGetConfig("currentPage")):Number(Authentication.CUGetConfig("currentPage"));
	currentPage = currentPage==null?"":currentPage;


	//获取缓存的多集信息
	function getAuthenticationData(){
		try{
			if('CTCSetConfig' in Authentication) {
				  freecount= Number(Authentication.CTCGetConfig("freecount"));
				  orderUrl= Authentication.CTCGetConfig("backurl_video");
				  programnum= Number(Authentication.CTCGetConfig("programnum"));
			   }else{
				  freecount =Number(Authentication.CUGetConfig("freecount"));
				  orderUrl =Authentication.CUGetConfig("backurl_video");
				  programnum = Number(Authentication.CUGetConfig("programnum"));
			   }
			}catch(e){

		}	
	
	}

	//上下选集时重新记录存放当前剧集
	function setAuthenticationData(){
		try{
			if('CTCSetConfig' in Authentication) {
				  Authentication.CTCSetConfig("programnum",programnum);
			   }else{
			   	  Authentication.CUSetConfig("programnum",programnum);
				
			   }
			}catch(e){

		}	
		
	}

	//免费节目结束弹窗提示用户
	function freeProgrameControl(){	

	   if(programnum>freecount-1){
	   		flag = true;
	   		document.getElementById("playdisplay").style.display = "none";
	   		document.getElementById("nextVipPop").style.display = "block";  		
	   				 
	   }else{
	   		flag = false;	   	
	   }
	
	}
//----------------------------------------------------------------------------


    function nextPlay()
    {

    	
    	//如果是电视剧综艺混排、环球、世嘉TV电视剧点击的播放进入多集判断逻辑
    	if(currentPage.indexOf("TV_zpage_one_dj")>-1||currentPage.indexOf("db_zpage_one_dj")>-1){    	
    	//当前连续剧产品未订购时进行多集免费判断
    	if(Number(isPay) == 1){ 	
	    	++programnum;
	    	setAuthenticationData();
	    	getAuthenticationData();
	    	freeProgrameControl();
	    	if(flag){return;}
    		}
		}




		if(nextEpisId  == -1)
		{
			return 0;
		}
        mp.stop();
        var tmpUrl  = "au_PlayFilm.jsp?TYPE_ID="+"<%=typeId%>"+"&PROGID=" + nextEpisId;
        tmpUrl += "&PLAYTYPE=" + <%=EPGConstants.PLAYTYPE_VOD%> + "&CONTENTTYPE=" + <%=EPGConstants.CONTENTTYPE_VOD_VIDEO%>+ "&BUSINESSTYPE=" + <%=EPGConstants.BUSINESSTYPE_VOD%>+"&FATHERSERIESID="+<%=superVodID%>+"&FROM="+comeFrom;
        top.location.href = tmpUrl;
    }
	//播放上一条影片
	function preFilm()
	{
		if(preFilm != -1)
		{
			window.location.href = "<%=preFilmUrl%>";
		}
	}
	//播放下一条影片
	function nextFilm()
	{


			//如果是电视剧综艺混排、环球、世嘉TV电视剧点击的播放进入多集判断逻辑
		if(currentPage.indexOf("TV_zpage_one_dj")>-1||currentPage.indexOf("db_zpage_one_dj")>-1){ //节目付费鉴权标识
	    	if(Number(isPay) == 1){ 
				++programnum;
		    	setAuthenticationData();
		    	getAuthenticationData();   	
		    	freeProgrameControl();
		    	if(flag){return;}
	    	}
    	}



		if(nextFilm != -1)
		{
			window.location.href = "<%=nextFilmUrl%>";
		}
	}

    function recommendPlay(i)
    {

        mp.stop();
        var tmpUrl = recommendUrlList[i];
		window.location.href = tmpUrl;
    }



    function showFavourite()

    {

        //var tmpUrl = "FavoAction.jsp?ACTION=show&enterFlag=check";

        //pr.submit(tmpUrl);

        pressFavo = 1;

        showQuit();

    }



    function showBookmark()

    {

        pressBookMark = 1;

        showQuit();

    }



    function pressOK()

    {
   if(OjFlag=="close"){
        var GOTOType =Authentication.CTCGetConfig("STBType");

	        if(GOTOType == null||GOTOType == ""){
		
	        GOTOType =  Authentication.CUGetConfig("device.stbmodel");	

	          }
           if(GOTOType.indexOf("E900")>=0||GOTOType.indexOf("B860AV1.1")>=0){		   
		   if(iframeFlag=="open"){
		   mp.stop();
		   if(isSitcom==0){
		   document.getElementById("filmInfo1").contentWindow.keyOk();
		   }else{
		    document.getElementById("filmInfo2").contentWindow.keyOk();
		   }
		   return;
           }
        } 
		if(disLockFlag == 1)

		{

		    return;

		}

		if(isSeeking == 1) return;

        // 如果有提示对话框则直接返回true;

        if (infoEnable == false)

        {

            return true;

        }



        if (miniFlag == true)

        {

            hideInfo();

        }

        //else if(isSeeking == 1 && isJumpTime == 1)

		else if(isSeeking == 1)

        {

            return;

        }

        else

        {

            showInfo();

        }
}else{

Tiaozuan();
}
    }

    /**

     *seek相关的参数及方法begin

     */
    /***********************************************************/
    //Utility.setBrowserWindowAlpha(0);
    var currTime = mp.getCurrentPlayTime();

    //mediaTime = mp.getMediaDuration();节目总时长

    var timePerCell = mediaTime / 100;

    var currCellCount = 0;

    var seekStep = 1;//每次移动的百分比

    var isSeeking = 0;      //

    var tempCurrTime = 0;

    var timeID_playByTime = 0;

    var timeID_jumpTime = "";

    var leftPress_temp = 0;



    function displaySeekTable(playFlag)   //核心方法

    {

        mediaTime = mp.getMediaDuration();

        //有时机顶盒取出的vod总时长有问题，在这里重新获取

        if(undefined == mediaTime || typeof(mediaTime) != "number" || mediaTime.length == 0 || 0 == mediaTime || initMediaTime != mediaTime)

        {

            mediaTime = mp.getMediaDuration();  //片源总时长

            timePerCell = mediaTime / 100;

        }



        /*

        if (infoEnable == false)

        {

            //document.getElementById("seekDiv").style.display = "none";

            //resetPara_seek();

            return 0;

        }

        */



        if(isSeeking == 0)  // isSeeking = 1 进度条显示

        {

            isSeeking = 1;

            currTime = mp.getCurrentPlayTime();  //当前播放时间



            processSeek(currTime);   //处理当前已经播放时间



            var fullTimeForShow = "";



            fullTimeForShow = convertTime();   // 返回片源总时长



            document.getElementById("fullTime").innerHTML = fullTimeForShow;



            document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/pause.gif" width="20" height="22"/>';



            document.getElementById("seekDiv").style.display = "block";

			//document.getElementById("jumpTime").focus(); //bm wangxg 20160925





            //5秒后隐藏跳转输入框所在的div

            clearTimeout(timeID_jumpTime);



            //dele by duanxiaohui

            timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000); //15秒后跳转

            

			if (playFlag != 1)

			{

            	pause();

            }

			checkSeeking();

        }

        else

        {

            clearTimeout(timeID_check);

            resetPara_seek();

			if (playFlag != 2 && playFlag != 3)

			{

            	resume();//恢复播放状态

            }

            //resume();

            document.getElementById("seekDiv").style.display = "none";
            tcFlag=0;

        }

    }

    function displaySeekTable_bf(playFlag)   //核心方法

    {

        mediaTime = mp.getMediaDuration();

        //有时机顶盒取出的vod总时长有问题，在这里重新获取

        if(undefined == mediaTime || typeof(mediaTime) != "number" || mediaTime.length == 0 || 0 == mediaTime || initMediaTime != mediaTime)

        {

            mediaTime = mp.getMediaDuration();  //片源总时长

            timePerCell = mediaTime / 100;

        }



        /*

        if (infoEnable == false)

        {

            //document.getElementById("seekDiv").style.display = "none";

            //resetPara_seek();

            return 0;

        }

        */



        if(isSeeking == 0)  // isSeeking = 1 进度条显示

        {

            isSeeking = 1;

            currTime = mp.getCurrentPlayTime();  //当前播放时间



            processSeek(currTime);   //处理当前已经播放时间



            var fullTimeForShow = "";



            fullTimeForShow = convertTime();   // 返回片源总时长



            document.getElementById("fullTime").innerHTML = fullTimeForShow;



            document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/pause.gif" width="20" height="22"/>';



//             document.getElementById("seekDiv").style.display = "block";

			//document.getElementById("jumpTime").focus(); //bm wangxg 20160925





            //5秒后隐藏跳转输入框所在的div

            clearTimeout(timeID_jumpTime);



            //dele by duanxiaohui

            timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000); //15秒后跳转

            

			if (playFlag != 1)

			{

            	pause();

            }

			checkSeeking();

        }

        else

        {

            clearTimeout(timeID_check);

            resetPara_seek();

			if (playFlag != 2 && playFlag != 3)

			{

            	resume();//恢复播放状态

            }

            //resume();

            document.getElementById("seekDiv").style.display = "none";

        }

    }




    function genSeekTable()

    {

        var seekTableDef = "";

        seekTableDef = '<table width="500" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';

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



    /* 画满进度条 */
    function fullSeekStatus()

    {

	    clearTimeout(timeID_check);

        if(isSeeking == 0)   //进度条无显示

        {

            return 0;

        }

		

		document.getElementById("progressBar").style.width = "420px";

		/*

        var seekTableDef = "";

        seekTableDef = '<table width="500" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';

        seekTableDef +='<td width="500" height="25" bgColor = "#DAA520" style="border-style:none;"></td>';

        seekTableDef += '</tr></table>';

        document.getElementById("seekTable").innerHTML = seekTableDef;   //进度条显示满

		*/

        document.getElementById("seekPercent").innerHTML = '<span style="color:black;">' + 100 + "%</span>";  //显示百分比

        //document.getElementById("currTimeShow").innerText = currTimeDisplay;

    }





    /**

     * 处理单前已经播放时间

     */

    function processSeek(_currTime)

    {

        if(null == _currTime || _currTime.length == 0)

        {

            _currTime = mp.getCurrentPlayTime();

        }



        if(_currTime < 0)

        {

            _currTime = 0;

        }



        currCellCount = Math.floor(_currTime / timePerCell);

		

		/*

        var tempIndex = -1;

        tempIndex = (String(_currTime / timePerCell)).indexOf(".");

        if(tempIndex != -1)

        {

            currCellCount = (String(_currTime / timePerCell)).substring(0,tempIndex);

            //currCellCount = (String(_currTime / timePerCell + 1));

        }

        else

        {

            currCellCount = String(_currTime / timePerCell);

        }

		*/





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

        var currTimeDisplay = convertTime(_currTime);

        document.getElementById("currTimeShow").innerHTML = currTimeDisplay;



		document.getElementById("progressBar").style.width = currCellCount / 100 * 420 + "px";

        /*for(var i = 0; i < 100; i++)

        {

            if(i < currCellCount)

            {

                document.getElementById("td_" + String(i + 1)).bgColor = "#DAA520";

                //document.getElementById("td_" + String(i + 1)).filters.item("Alpha").Opacity = 20;

                //document.getElementById("td_" + String(i + 1)).style.backgroundImage = "url(images/playcontrol/seeking.gif)";

                //document.getElementById("td_" + String(i + 1)).filters.item("AlphaImageLoader").src = "images/playcontrol/seeking.gif";

                //document.getElementById("td_" + String(i + 1)).style.filter="progid:DXImageTransform.Microsoft.BasicImage(opacity=0.5)";



            }

            else

            {

                document.getElementById("td_" + String(i + 1)).bgColor = "transparent";

                //document.getElementById("td_" + String(i + 1)).filters.item("Alpha").Opacity = 0;

                //document.getElementById("td_" + String(i + 1)).style.backgroundImage = "url(none)";

                //document.getElementById("td_" + String(i + 1)).filters.item("AlphaImageLoader").src = "images/link-dot.gif";

                //document.getElementById("td_" + String(i + 1)).style.filter="progid:DXImageTransform.Microsoft.BasicImage(opacity=0.0)";

    }

        }*/

    }



    /*

    function leftArrow()

    {



        if(isSeeking == 1)

        {

            //按下左右键时，先重置延迟调用进度条检测方法

            clearTimeout(timeID_check);

            timeID_check = setTimeout("checkSeeking();",1000);



            currTime = mp.getCurrentPlayTime();



            if(tempCurrTime == 0)

            {

                tempCurrTime = currTime;

                setTimeout("playByTime(tempCurrTime);",1000);

            }



            tempCurrTime = String(parseInt(tempCurrTime,10) - seekStep * timePerCell);



            //定位后如果时间早于当前时间，重新播放

            if(tempCurrTime <= 0)

            {

                tempCurrTime = 0;

                isSeeking = 0;

                displaySeekTable();

                mp.playFromStart();

            }

            else

            {

                setTimeout("processSeek(tempCurrTime);",500);



                //clearTimeout(timeID_playByTime);

                //timeID_playByTime = setTimeout("playByTime(tempCurrTime);",1000);

            }



            return 0;

        }

        else

        {

            return 1;

        }



    }



    function rightArrow()

    {

        if(isSeeking == 1)

        {

            //按下左右键时，先重置延迟调用进度条检测方法

            clearTimeout(timeID_check);

            timeID_check = setTimeout("checkSeeking();",1000);



            currTime = mp.getCurrentPlayTime();



            if(tempCurrTime == 0)

            {

                tempCurrTime = currTime;

                setTimeout("playByTime(tempCurrTime);",1000);

            }



            tempCurrTime = String(parseInt(tempCurrTime,10) + seekStep * timePerCell);



            if(tempCurrTime >= mediaTime)

            {

                tempCurrTime = 0;

                isSeeking = 0;

                displaySeekTable();

                //mp.stop();

                finishedPlay();

                return 0;

            }

            else

            {

                processSeek(tempCurrTime);

                //setTimeout("processSeek();",1000);

                //playByTime(tempCurrTime);

                //clearTimeout(timeID_playByTime);

                //timeID_playByTime = setTimeout("playByTime(tempCurrTime);",1000);

            }



            return 0;

        }

        else

        {

            return 1;

        }



    }

    */



    var timeID_check = 0;  //检查进度条状态 timerid

    var preInputValue = ""; //判断用是否输入跳转时间

    function checkSeeking()

    {

        if(isSeeking == 0)

        {

            clearTimeout(timeID_check);

            //clearTimeout(timeID_check);

        }

        else

        {



            //下面一行代码的作用：获取不到文本框中的值，动态刷新文本框所在div可以解决



            if(playStat != "fastrewind" && playStat != "fastforward")

            {

                document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/pause.gif" width="20" height="22"/>';

            }



            var inputValue =""; // document.getElementById("jumpTime").value;

            currTime = mp.getCurrentPlayTime();



            //每隔1秒检测一次进度条的显示情况

            clearTimeout(timeID_check);

            timeID_check = setTimeout("checkSeeking();",1000);



            if(playStat == "fastrewind" || playStat == "fastforward")

            {

                processSeek(currTime);

            }





            if(preInputValue != inputValue)

            {

                var tempTimeID = timeID_jumpTime;

                //5秒后隐藏跳转输入框所在的div

                clearTimeout(tempTimeID);

                timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);

                preInputValue = inputValue;

            }









            /*

            if(isSeeking == 1)

            {

                if(tempCurrTime != 0)

                {

                    //tempCurrTime != 0 时，用户正在移动进度条，重新延迟调用方法

                    clearTimeout(timeID_check);

                    timeID_check = setTimeout("checkSeeking();",1000);

                }

                else

                {

                    processSeek(currTime);

                }



            }

            */

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



		// add second

		

		var time_second = "";



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

		time_second = _time % 60; //显示秒









        if("" == time_hour || 0 == time_hour)

        {

            time_hour = "00";

        }



        if("" == time_min || 0 == time_min)

        {

            time_min = "00";

        }

        if("" == time_second || 0 == time_second)

        {

            time_second = "00";

        }		



        if(time_hour.length == 1)

        {

            time_hour = "0" + time_hour;

        }



        if(time_min.length == 1)

        {

            time_min = "0" + time_min;

        }

        if(("" + time_second).length == 1)

        {

            time_second = "0" + time_second;

        }		



        returnTime = time_hour + ":" + time_min + ":" + time_second;



        return returnTime;

    }


    //判断是否在播放时长内
    function isInMediaTime(pHour,pMin)
    {
		pHour = pHour.replace(/^0*/,"");//去掉字符串里的0
		if(pHour == "")
		{
			pHour = "0";
		}
		
		pMin = pMin.replace(/^0*/,"");
		if(pMin == "")
		{
			pMin = "0";
		}
		
		var allTime = pHour * 3600 + pMin * 60;//输入的总时间  输入的小时 + 输入的分钟 = 总时间
		
		mediaTime = mp.getMediaDuration();//影片的总时长
		
		return (allTime <= mediaTime);
    }

function checkJumpTime(pHour, pMin)
{        
    if(isEmpty(pHour)) //如果小时为空，返回false
	{
		return false;
	}
	else if(!isNum(pHour))//如果小时不为数字，返回false
	{
	    return false;
	}
	if(isEmpty(pMin))//如果分钟为空，返回false
	{
	    return false;
	}
	else if(!isNum(pMin))//如果分钟不为数字，返回false
	{
	    return false;
	}
    else if(!isInMediaTime(pHour,pMin))//如果不在播放时长内，返回false
	{
	    return false;
	}
    else  //否则，返回true
	{
	    return true;
	}
        
  }


    function isEmpty(s)

    {

        return ((s == null) || (s.length == 0));

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

    var timeForShow = 0;
	var pauseTimeId = 0;
    function jumpToTime(_time)

    {

        timeForShow = 0;

        _time = parseInt(_time,10);



        playByTime(_time);

        processSeek(_time);

        //pause();

        pauseTimeId = setTimeout("pause();",200);

        //pause();

    }



    /**

     *用户在文本框中输入时，重置调用隐藏文本框所在层的方法的延迟时间

     */

    function inputOnChange()

    {
       // var inputValue = document.getElementById("jumpTime").value;   //bm wangxg 20160925
        var inputValue ="";
        if(inputValue.length < 4)

        {

            //5秒后隐藏跳转输入框所在的div

            clearTimeout(timeID_jumpTime);

            timeID_jumpTime = setTimeout("hideJumpTimeDiv();",5000);

        }

    }



    //跳转提示信息隐藏后，重置相关参数

    function resetPara_seek()

    {

        clearTimeout(timeID_jumpTime);

        isSeeking = 0;

        isJumpTime = 1;

        document.getElementById("jumpTimeDiv").style.display = "block";

        //document.getElementById("jumpTimeImg").style.display = "block";

      //  document.getElementById("jumpTime").value = ""; //bm wangxg 20160925

        //document.getElementById("timeError").innerHTML = "请输入时间！";

        document.getElementById("timeError").innerHTML = "";

        document.getElementById("statusImg").innerHTML = '<img src="images/playcontrol/pause.gif" width="20" height="22"/>';

    }


    /**

     * 当输入时间后，跳转框隐藏时不进行跳转

     */

    function hideJumpTimeDiv()

    {

        clearTimeout(timeID_jumpTime);

        isJumpTime = 0;

        preInputValue = "";

     ///   document.getElementById("jumpTime").value = "";   //bm wangxg 20160925

        document.getElementById("jumpTimeDiv").style.display = "none";

    }


    /**

     * 判断输入时间格式

     */

    var disErrInfo = ""; //显示的错误提示信息
    function clickJumpBtn()
    {
	
        clearTimeout(timeID_jumpTime);
       var inputValueHour = document.getElementById("jumpTimeHour").value;
		var inputValueMin = document.getElementById("jumpTimeMin").value;
		if(isEmpty(inputValueHour))
		{
			inputValueHour = "00";
		}
		if(isEmpty(inputValueMin))
		{
			inputValueMin = "00";
		}
	
		//如果输入的时间合法
		if(checkJumpTime(inputValueHour,inputValueMin))
		{
			var hour = parseInt(inputValueHour,10);//将inputValueHour 转换为10进制
			
			var mins = parseInt(inputValueMin,10);//将inputValueMin 转换为10进制
			
			var timeStamp = hour * 3600 + mins * 60+1;
			
			//timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
			
			clearTimeout(timeID_jumpTime);
			timeID_jumpTime = "";
			
			// document.getElementById("jumpTimeDiv").style.display = "none";
			document.getElementById("jumpTimeHour").value = "";
			document.getElementById("jumpTimeMin").value = "";
			
			document.getElementById("seekDiv").style.display = "none";
			trFlag=0;
			isSeeking = 0 ;
			playByTime(timeStamp);
			playStat = "play";
		
		}
		 //校验不通过，提示用户时间输入不合理
		 else
		 {
			 document.getElementById("jumpTimeHour").value = "";
			 document.getElementById("jumpTimeMin").value = "";
			 document.getElementById("timeError").innerHTML =  "<font color='white'>时间输入不合理，请重新输入！</font>";
			
			 jumpPos = 0;
			 preInputValueHour = "";
			 preInputValueMin = "";
			 
			 document.getElementById("jumpTimeHour").focus();
			 
			 //15秒后隐藏跳转输入框所在的div"
			 clearTimeout(timeID_jumpTime);
			 timeID_jumpTime = "";
			 //timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
			 
		 }
		//更改处
	//document.getElementById("test").innerHTML=tzFlag+"---"+iframeFlag+"---";

    }
    function disErrorInfo()

    {

		//document.getElementById("jumpTime").focus();//bm wangxg 20160925

      //  document.getElementById("jumpTime").value = "";//bm wangxg 20160925

        document.getElementById("timeError").innerHTML = disErrInfo;



        clearTimeout(timeID_jumpTime);

        preInputValue = "";

        //timeID_jumpTime = setTimeout("hideJumpTimeDiv();",5000);

    }


    /**

     * 跳转进行数据初始化

     */

    function jumpByTime(_time)

    {

        clearTimeout(timeID_jumpTime);

        isJumpTime = 0;

        document.getElementById("jumpTimeDiv").style.display = "none";

      //  document.getElementById("jumpTime").value = ""; //bm wangxg 20160925

        preInputValue = "";

        document.getElementById("timeError").innerHTML = "";

        //jumpToTime(inputValue);

        jumpToTime(_time);

    }





    /**

     * 退出时隐藏仍在屏幕上显示的信息

     */

    function hideAllInfo()

    {

        hideSeekTable(); //进度条

    }



    /**

     * 隐藏进度条

     */

    function hideSeekTable()

    {

        clearTimeout(timeID_check);

        resetPara_seek();

        //resume();

        document.getElementById("seekDiv").style.display = "none";
        tcFlag=0;

    }



    function addSitBookmark()

    {

        if(isSitcom != 1)

        {

            return;

        }



		var addBMUrlSitCom="";

		addBMUrlSitCom += userid;

		addBMUrlSitCom += "|";

		addBMUrlSitCom += strFatherId;

		addBMUrlSitCom += "|";

		addBMUrlSitCom += currSitnum;

		addBMUrlSitCom += "|";

		addBMUrlSitCom += strFilmId;



		var iRetIsSitCom = iPanel.ioctlWrite("addSitcommark",addBMUrlSitCom);



    }

function Tiaozuan(){
//window.location.href=recommendList_all[80][picIndexLeftBot].vasUrl+"&providerid=hw&iaspuserid=<%=iaspuserid%>&iaspadsl="+NetUserID+"&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&right=0&down=1";
}
function ZanTing(){
window.location.href="adijsp/v10/commonwealpage/commonwealpage.jsp?providerid=hw&iaspuserid=<%=iaspuserid%>&iaspadsl="+NetUserID+"&iaspip=<%=iaspip%>&iaspmac=<%=iaspmac%>&right=0&down=1";
}


</script>
<script type="text/javascript" src="js/webxiri_1.0.6.js" > </script>
<script type="text/javascript" src="js/aes.js"></script> 
    <script type="text/javascript">

    function  onloadxiri(){
        var sence = getScence();
        //此处是回调函数 command对应sence中的command的key，例如command['_PLAY'] = ["$P(_PLAY)"];，那么回调中intent.._command的值就为_PLAY
        var callback = function(intent){
            var command = intent._command;
            if(command == '_PLAY'){
                var action = intent._action;
                if(action == 'PLAY'){
                	//播放
					if(playStat == 'pause')
					{
                	pauseOrPlay();
					}
                }else if(action == 'PAUSE'){
                	//暂停
					if(playStat == 'play')
					{
					playStat = "pause";
                    mp.pause();
					isSeeking=0;
                    displaySeekTable(1);
					}
                }else if(action == 'RESUME'){
                	//继续播放
					if(playStat == 'pause')
					{
                	pauseOrPlay();
					}
                }else if(action == 'RESTART'){
                    //做重头播放操作操作
                	gotoStart();
                }else if(action == 'SEEK'){
				document.getElementById("seekDiv").style.display = "none";
                    var position = intent.position;
                    //调到指定位置操作
//                    var jumpTimeMin="";//秒
//                    if(position>60)
//                    {
//                    	 jumpTimeMin=Math.round(position/60);
//                    	 document.getElementById("jumpTimeMin").value=jumpTimeMin;
//                    }
//                    else{
//                    	 document.getElementById("jumpTimeMin").value=1;
//                   }
//		             clickJumpBtn();
                     if(position>mp.getMediaDuration())
					 {  
					 mp.gotoEnd();
					 }
					 else{
					 mp.playByTime(1,position,1);
					 }
					 playStat = "play";
                }else if(action == 'FORWARD'){
				document.getElementById("seekDiv").style.display = "none";
                	var position = intent.position;
                	//快进
                	//arrowRight();
					 var fOffset = intent.offset;
                	 var  currTime = mp.getCurrentPlayTime();
                 	
                	 var jumpTimeMin=parseInt(fOffset)+parseInt(currTime);//需要跳转到的时间将当前时间转换为int
					 if(jumpTimeMin>mp.getMediaDuration())
					 {
					  mp.gotoEnd();
					 }else{
					 mp.playByTime(1,jumpTimeMin,1);//直接跳转到具体时间  以秒为单位
					 }
					 playStat = "play";
                } else if(action == 'BACKWARD') {
                	//快退
                	//arrowLeft();
					document.getElementById("seekDiv").style.display = "none";
					 var fOffset = intent.offset;
                	 var  currTime = mp.getCurrentPlayTime();
                	 if(currTime>fOffset){
                	 var jumpTimeMin=parseInt(currTime)-parseInt(fOffset);//需要跳转到的时间 将当前时间转换为int
                	 mp.playByTime(1,jumpTimeMin,1);//直接跳转到具体时间  以秒为单位

                	 }
                	 else{
                		 gotoStart(); 
                	 }
					playStat = "play";
                }
            }
			//else if(command == 'homeKey'){
            //做相应操作
            //}
        };

        var listener = new Xiri.Listener(callback);
        listener.regist(sence);
    }
    onloadxiri();
    function getScence(){
        var sence = {};
        var command = {};
        var feedback = {};
        var fuzzy_words = {};
        sence['_scene'] = "com.iflytek.xiri.MyScene";
        //以下为添加科大讯飞的预装命令词
        command['_PLAY'] = ["$P(_PLAY)"];
        // command['_PAGE'] = ["$P(_PAGE)"];
        // command['_EPISODE'] = ["$P(_EPISODE)"];
        // command['_SELECT'] = ["$P(_SELECT)"];
        /**
        *以下为根据页面内容添加自定义语音命令词
        * 此处的$W(home)定义的是一个模糊槽短语 在fuzzy_words对象中定义相应home的值，意思为用户说fuzzy_words中home这个对象里面的语音，对应的command都是homeKey
        */
        //command['homeKey'] = ["$W(home)"];

        //此处为组织命令词的反馈信息，值为根据具体操作由epg开发商定义，feedback中的key值必须和command中的key对应
        //feedback['homeKey'] = "正在执行key2关键词命令";
        sence['_feedbacks'] = feedback;
        //组织模糊命令词 例如希望用户发出"主页","首页","返回主页"，"返回首页"这个语音的时候，都回调command['home']这个命令
        fuzzy_words['home'] = ["主页","首页","返回主页","返回首页"];
        sence['_fuzzy_words'] = fuzzy_words;

        sence['_commands'] = command;
        return sence;
    }
    </script>


<body bgcolor="transparent" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="background-color: transparent" onLoad="javascript:init()" onUnload="javascript:addSitBookmark();hideAllInfo();destoryMP();">
<!------加图片-------->
<!--<div style="position:absolute;top:340px;left:410px;z-index:20;"><img id="adimg" src="#" width="136" height="136></div>
-->
<!--div id="topframe" style="position:absolute;left:400px; top:20px; width:200px; height:30px;">

</div-->
<div id="showPicDiv1" style="position:absolute;top:0;width:100px;height:133px;display:none"></div>
<div id="showPicDiv" style="position:absolute;top:10;width:100px;height:133px;display:none">
    
 <img src="images/vod_1.jpg" height="100px" width="133px"/>
    
</div>
<center><div id="showPicDiv2" style="position:absolute;top:336;width:100px;height:25px;left:527px;color:white;background-color:gray;display:none"></div></center>
<div id="showPicDiv3" style="position:absolute;top:206;width:100px;height:130px;left:527px;display:none">
    
<img id ="img1" src="images/adimages/vodtime.png" height="130px" width="100px"/>
    
</div>


<div id="topframe" style="position:absolute;left:375px; top:8px; width:200px; height:30px; z-index:1">

</div>

<div id="playdisplay" style="position:absolute;left:120px; top:100px; width:380px;height:262px; color:#FFFFFF; font-size:22px;">

		<!--<div style="position:absolute; left:0px; top:0px; width:380px; height:262px;">
		<img src="images/playcontrol/playVod/quit.jpg" height="262" width="380" >
		</div>
		<div style="position:absolute; left:35px; top:65px; width:70px; height:40px;">
		<a id="type0" href="javascript:ensureQuit()">
		<img src="images/playcontrol/link-dot.gif" height="40" width="70" >
		</a>
		</div>
		<div style="position:absolute; left:85px; top:65px; width70px; height:40px;">
		<a id="type2" href="javascript:cancel()">
		<img src="images/playcontrol/link-dot.gif" height="40" width="70" >
		</a>
		</div>
		<div style="position:absolute; left:50px; top:30px; width:300px; height:30px;">您是否要退出当前收看节目?</div>
		<div style="position:absolute; left:60px; top:75px; width:50px; height:30px;">是</div>
		<div style="position:absolute; left:110px; top:75px; width:50px; height:30px;">否</div>
		
		<div style="position:absolute; left:15px; top:170px; width:348px; height:84px;">
		<img src="images/playcontrol/playVod/poster.gif" height="84" width="348" ></div>
		
        <div style="position:absolute; left:140px; top:65px; width:200px; height:40px;">
			<a id="type1" href="javascript:SaveQuit()">
			<img src="images/playcontrol/link-dot.gif" height="40" width="200">
			</a>
			</div>
			<div style="position:absolute; left:160px; top:75px; width:200px; height:30px;">加入书签并退出</div>
        
        <div style="position:absolute; left:75px; top:115px; width:150px; height:40px;">
		<a id="prePlay" href="#">
		<img src="images/playcontrol/link-dot.gif" height="40" width="100" >
		</a>
        </div>
        <div style="position:absolute; left:175px; top:115px; width:150px; height:40px;">
		<a id="nextPlay" href="#">
		<img src="images/playcontrol/link-dot.gif" height="40" width="100" >
		</a>
        </div>
       <div id="preProg" style="position:absolute; left:90px; top:125px; width:100px; height:30px;">上一集</div>
       <div id="preProg" style="position:absolute; left:190px; top:125px; width:100px; height:30px;">下一集</div> -->

</div>

<div id="filmInfodiv" style="position:absolute;left:0px; top:395px; width:636px; height:135px; z-index:10;">

<iframe name="filmInfo" id="filmInfo" scroll="no" height="135px" width="640px" src="" bgcolor="transparent" allowtransparency="true" style="border:0px;"></iframe>

</div>

<!--div id="bottomframe" style="position:absolute;left:40px; top:420px; width:600px; height:150px;color:green;font-size:36;">

</div-->
<div id="volumeDiv">
<div id="grid0" class="grid" style="left:10px;"></div>
<div id="grid1" class="grid" style="left:30px;"></div>
<div id="grid2" class="grid" style="left:50px;"></div>
<div id="grid3" class="grid" style="left:70px;"></div>
<div id="grid4" class="grid" style="left:90px;"></div>
<div id="grid5" class="grid" style="left:110px;"></div>
<div id="grid6" class="grid" style="left:130px;"></div>
<div id="grid7" class="grid" style="left:150px;"></div>
<div id="grid8" class="grid" style="left:170px;"></div>
<div id="grid9" class="grid" style="left:190px;"></div>
<div id="grid10" class="grid" style="left:210px;"></div>
<div id="grid11" class="grid" style="left:230px;"></div>
<div id="grid12" class="grid" style="left:250px;"></div>
<div id="grid13" class="grid" style="left:270px;"></div>
<div id="grid14" class="grid" style="left:290px;"></div>
<div id="grid15" class="grid" style="left:310px;"></div>
<div id="grid16" class="grid" style="left:330px;"></div>
<div id="grid17" class="grid" style="left:350px;"></div>
<div id="grid18" class="grid" style="left:370px;"></div>
<div id="grid19" class="grid" style="left:390px;"></div>
<div id="volumeText"></div>
<!--更改处-->
<div style="position:absolute;width:75;height:75;left:470;top:-30px">
<img src="images/adimages/hwvolume.jpg" height="133" width="100">
    </div>
</div>

<div id="bottomframe1" style="position:absolute;left:50px; top:400px; width:590px; height:130px; z-index:1">
</div>
<!-- 左下显示静音信息需要特殊处理-->
<div id="bottomframeMute" style="position:absolute;left:15px; top:400px; width:600px; height:130px; z-index:1">

</div>
<div id="TrackImg" style="position:absolute; top:320px; left:15px;">
</div>

<!-- div id="bottomframeMute" style="position:absolute; left: 50px; top: 253px; width:31; height:33px; z-index:1; background:url(images/playcontrol/playVod/muteon.png)"></div -->


<div id="playRecordDiv" style="position:absolute;left:0px; top:0px; width:0px; height:0px;">

</div>
<div id="advertDiv" style="position:absolute;width:100px;height:133px;left:535px;top:300px;z-index:1; display:none">
    
		
    <img src="images/adimages/hwjb_new.jpg" height="133" width="100" id="posterPic1">
    

</div>

<!--更改处-->
<div id="advertDiv1" style="position:absolute; top:0px;width:640px;height:530px;display:none"> 
    
 <img src="images/adimages/hwdb_new.jpg" height="530px" width="640px">
    
</div>
<div id="bfmovie">
</div>

<div id="seekDiv11">

<!-- <iframe name="filmInfo1" id="filmInfo1" scroll="no" height="720px" width="1280px" src="" bgcolor="transparent" allowtransparency="true" style="border:0px;"></iframe> -->
		

</div>
<div id="seekDiv12">
</div>
 <div id="seekDiv" style="position:absolute;width:636px;height:200px;left:0px;top:300px; z-index:1; display:none;">
<div style="position:absolute;width:100;height:163;left:0;top:0; z-index:2;margin-left: 536px;" id="posterDiv3">
	  <a href = "javascript:ZanTing()" id ="posterDiv3"><img src="images/adimages/hwzt_new.jpg" height="163" width="100" id="posterPic3"></a>
       </div>

    <div id="seekPercent" style="position:absolute;color:#FFFFFF;width:50;height:30;top:24%;left:300px;z-index:3; font-size:22px;"></div>

    <div id="" style="position:absolute;width:536;height:80;left:0;top:0; background-image:url(images/playcontrol/bg-seek.gif);z-index:2;color:white;">

        <table width="520" height="80" border="0" cellpadding="0" cellspacing="0">

            <tr height="40">

                <td></td>

				<td></td>

                <td height="40">

                    <table width="320" border="0" cellpadding="0" cellspacing="0">

                        <tr>

                            <td id="currTimeShow" width="205" valign="middle" align="right" style="font-size:22px; color:#FFF;"></td>

                            <td id="statusImg" height="40" align="right" style="font-size:22px; color:#FFF;"></td>

                            <td width="5"></td>

                        </tr>

                    </table>

                </td>

                <td></td>

            </tr>

            <tr>

			    <td width="5">&nbsp;</td>

                <td width="100" height="40" valign="middle" align="center" style="font-size:22px; color:#FFF;">00:00:00</td>

                <td width="320" valign="top">

                    <table width="" height="" border="0" cellpadding="0" cellspacing="0">

                        <tr>

                            <td width="320" height="30" bgcolor="#000080">

							  <table height="30" width="0" border="0" cellspacing="0" cellpadding="0">

                        <tr>

                                  <td id="progressBar" bgcolor="#DAA520"></td>

                                </tr>

                              </table>

                            </td>

                        </tr>

                    </table>

                </td>

				<td width="3">&nbsp;</td>

                <td width="100" valign="middle" align="center" id="fullTime" style="font-size:22px; color:#FFF;"></td>

            </tr>

        </table>

    </div>

<!--     输入跳转时间 -->

    <div id="jumpTimeDiv" style="position:absolute;width:536px;height:76px;left:0px;top:82px; background-image:url(images/playcontrol/bg-seek.gif);z-index:9;color:white;">

	<form  name="passForm" action="javascript:clickJumpBtn()">
   <table width="536" height="83" border="0" cellpadding="0" cellspacing="0" background="images/playcontrol/playVod/bg-seek.gif">
      
	  <tr>
        <td height="10" colspan="6"></td>
      </tr>
     
	  <tr height="36">
        <td width="40"></td>
        <td width="180" height="36" valign="middle" align="center" style="color:#FFF; font-size:22px;">跳转到</td>
		
        
		<!--  跳转框的输入时和分的输入框 -->
          <td width="40" valign="middle" align="center">
		      <input id="jumpTimeHour" type="text" width="40" height="28" maxlength="2" size="4" style="color:#000; font-size:22px" />
          </td>
          <td width="30" valign="middle" align="center" style="color:#FFF; font-size:22px;">时</td>
		  
          <td width="40" valign="middle" align="center">
		      <input id="jumpTimeMin" type="text" width="40" height="28" maxlength="2" size="4" style="color:#000; font-size:22px"/>
          </td>
          <td width="30" valign="middle" align="center" style="color:#FFF;font-size:22px;">分</td>
	
		
	<!-- 	 跳转框的确认跳转和取消跳转的按钮 -->
        <td width="140" valign="middle" align="center" height="36">
			<a id="ensureJump" href="javascript:clickJumpBtn();"><img src="images/playcontrol/playVod/ensureJump.gif" width="73" height="28"/></a></td>
		<td width="140" valign="middle" align="left" height="36">	
			<a id="cancelJump" href="javascript:pauseOrPlay();"><img src="images/playcontrol/playVod/cancelJump.gif" width="73" height="28"/></a> 
		</td>
      </tr>
     
	  <tr>
<!--         跳转框下的提示信息 -->
        <td id="timeError" width="640" height="30" valign="middle" align="center" colspan="7" style="color:DAA520; font-size:22px;"></td>
      </tr>
	  
   </table>
	</form>
  </div>

</div> 

<div>

	<iframe name="cdr" id="cdr" scroll="no" height="0px" width="0px" src="" style="border:0px;">

    </iframe>

</div>

<div id="order" style="left:0px; top:226px; width:600px; height:110px; position:absolute;display:none; alpha:85%; z-index:1;">

  <table id="lock" width="600" height="110" background="images/playcontrol/bg-seek.gif" cellpadding="0" cellspacing="0">

    <tr>

      <td id = "displayLockInfo" colspan="5" align="center"  style="color:#FFFFFF; font-size:20px"></td>

    </tr>

     <tr>

      <td colspan="5" height="2"></td>

    </tr>

    <tr>

      <td height="39" width="165"></td>

      <td width="122" align="right"><a id="img_1" href="javascript:ensureCheckPass();"><img src="images/playcontrol/nextView_yes.gif" width="102" height="39"/></a></td>

      <td width="96">&nbsp;</td>

      <td width="141" align="left"><a id="img_2" href="javascript:cancleCurrAction();"><img src="images/playcontrol/nextView_no.gif" width="102" height="39"/></a></td>

      <td width="120"></td>

    </tr>

     <tr>

      <td colspan="5" height="14"></td>

    </tr>

  </table>

</div>
<img src="images/playcontrol/playVod/quit.jpg" style="display:none"/>



<!-- 2019-09-02vip弹出 start-->
<div id="nextVipPop">
	<p>免费剧集观看结束,继续观看请返回后"订购"</p>
	<div class="btn">返回</div>
</div>

<style>
	#nextVipPop	{
		height: 360px;
		position: absolute;
		left: 0;
		top: 150px;
		width: 640px;
		text-align: center;
		background: rgba(0,0,0,.6);
		display:none;
	}
	#nextVipPop p {
		color: #fff;
		width: 100%;
		text-align: center;
		margin-top: 80px;
		font-size: 26px;
	}
	#nextVipPop .btn {
		width: 150px;
		height: 50px;
		margin: 20px auto;
		color: #fff;
		line-height: 50px;
		background: #666;
	}
</style>

<!-- 2019-09-02vip弹出 end-->


</body>

</html>

