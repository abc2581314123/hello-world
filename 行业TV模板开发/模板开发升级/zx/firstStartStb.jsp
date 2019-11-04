<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.zte.iptv.epg.util.PortalUtils"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.zte.iptv.epg.utils.Utils"%>
<%@ page import="com.zte.iptv.epg.account.UserInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Vector"%>
<%@ page import="com.zte.iptv.epg.content.*"%>
<%@ page import="com.zte.iptv.epg.util.EpgConstants"%>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew"%>
<%@ page import="com.zte.iptv.newepg.datasource.*"%>
<%@ page import="com.zte.iptv.epg.web.*"%>
<%@ page import="java.util.*"%>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg"%>

<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.KeyGenerator"%>
<%@ page import="javax.crypto.SecretKey"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="org.apache.axis.encoding.Base64"%>
<%@ page import="javax.crypto.spec.IvParameterSpec"%>










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


<%!
  public String getPath(String uri){
    String path = "";
    int begin = 0;
    int end = uri.lastIndexOf('/');
    if(end > 0){
      path = uri.substring(begin, end + 1) + path;
    }
    return path;
  }
%>


<%

 String path=getPath(request.getRequestURI());
%>


<%




        long time1 = System.currentTimeMillis();
        String riddle = GetMD5Code("gl"+time1);


%>


















<%
    String normalPoster ="";
	    String surcolumnid="";
	    String programid="";
        String surcolumnid1="";
        String programid1="";
        String surcolumnid2="";
        String programid2="";
        String surcolumnid3="";
        String programid3="";
        String surcolumnid4="";
        String programid4="";
        String surcolumnid5="";
        String programid5="";
        String surcolumnid6="";
        String programid6="";
        String surcolumnid7="";
        String programid7="";
        String surcolumnid8="";
        String programid8="";
        String surcolumnid9="";
        String programid9="";
        String surcolumnid10="";
        String programid10="";
        String surcolumnid11="";
        String programid11="";
        String surcolumnid12="";
        String programid12="";
        String surcolumnid13="";
        String programid13="";
  

    UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
        int hasSub = 0;
        int hasSub1 = 0;
        int hasSub2 = 0;
        int hasSub3 = 0;
        int hasSub4 = 0;
        int hasSub5 = 0;
        int hasSub6 = 0;
        int hasSub7 = 0;
        int hasSub8 = 0;
        int hasSub9 = 0;
        int hasSub10 = 0;
        int hasSub11 = 0;
        int hasSub12 = 0;
        int hasSub13 = 0;
      UserInfo iaspuserInfo = (UserInfo)request.getSession().getAttribute(EpgConstants.USERINFO);
	  String iaspadsl = "";
	  iaspadsl = iaspuserInfo.getAccountNo();//¿í´øÕËºÅ
	  String iaspmac = ""; 
	  iaspmac = iaspuserInfo.getStbMac();//MACÐÅÏ¢
	  String iaspip = ""; 
	  iaspip = iaspuserInfo.getUserIP();//IPÐÅÏ¢
	  String  iaspuserid = "";
	  iaspuserid = iaspuserInfo.getUserId();//ÓÃ»§ÐÅÏ¢
      String areaId = iaspuserInfo.getAreaNo();
	  String temstr="&iaspmac="+iaspmac+"&iaspip="+iaspip+"&iaspuserid="+iaspuserid;
%>
<%@ include file="getFitString.jsp"%>




<%
    if (hasSub == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060301");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
			int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid = vodConInf.getColumnId();
                    programid = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>

<%
    if (hasSub1 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060300");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid1 = vodConInf.getColumnId();
                    programid1 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>



<%
    if (hasSub2 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060302");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid2 = vodConInf.getColumnId();
                    programid2 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>


<%
    if (hasSub3 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060303");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid3 = vodConInf.getColumnId();
                    programid3 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>


<%
    if (hasSub4 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060304");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid4 = vodConInf.getColumnId();
                    programid4 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>


<%
    if (hasSub5 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060305");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid5 = vodConInf.getColumnId();
                    programid5 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>


<%
    if (hasSub6 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060306");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid6 = vodConInf.getColumnId();
                    programid6 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>


<%
    if (hasSub7 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060307");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid7 = vodConInf.getColumnId();
                    programid7 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>


<%
    if (hasSub8 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060308");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid8 = vodConInf.getColumnId();
                    programid8 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>



<%
    if (hasSub9 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("0506060309");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid9 = vodConInf.getColumnId();
                    programid9 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>



<%
    if (hasSub10 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("050606030A");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid10 = vodConInf.getColumnId();
                    programid10 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>



<%
    if (hasSub11 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("050606030B");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid11 = vodConInf.getColumnId();
                    programid11 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>



<%
    if (hasSub12 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("050606030C");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid12 = vodConInf.getColumnId();
                    programid12 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>



<%
    if (hasSub13 == 0) {
        try {
            VodDataSource vodDs = new VodDataSource();
            VoDQueryValueIn vodValueIn = (VoDQueryValueIn) vodDs.getValueIn();
            vodValueIn.setColumnId("050606030D");
            vodValueIn.setUserInfo(userInfo);
            vodValueIn.setNumPerPage(999);
            vodValueIn.setPage(1);
            EpgResult result = vodDs.getData();
            int s1 = 0;
            List vVodData = (Vector) result.getData();
            if (vVodData.size() > 0) {
                for (int i = 0; i < vVodData.size(); i++) {

                    VoDContentInfo vodConInf = (VoDContentInfo) vVodData.get(0);

                    normalPoster = vodConInf.getNormalPoster();

                    surcolumnid13 = vodConInf.getColumnId();
                    programid13 = vodConInf.getProgramId();

    }


        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
} 
%>
<html>
<head>
<title>update epgeditor1</title>
</head>

  <body>



				

<script language="javascript" type="text/javascript">
var surcolumnid = "<%=surcolumnid%>";
var programid ="<%=programid%>";
var surcolumnid1 = "<%=surcolumnid1%>";
var programid1 ="<%=programid1%>";
var surcolumnid2= "<%=surcolumnid2%>";
var programid2 ="<%=programid2%>";
var surcolumnid3 = "<%=surcolumnid3%>";
var programid3 ="<%=programid3%>";
var surcolumnid4 = "<%=surcolumnid4%>";
var programid4 ="<%=programid4%>";
var surcolumnid5 = "<%=surcolumnid5%>";
var programid5 ="<%=programid5%>";
var surcolumnid6 = "<%=surcolumnid6%>";
var programid6 ="<%=programid6%>";
var surcolumnid7 = "<%=surcolumnid7%>";
var programid7 ="<%=programid7%>";
var surcolumnid8 = "<%=surcolumnid8%>";
var programid8 ="<%=programid8%>";
var surcolumnid9 = "<%=surcolumnid9%>";
var programid9 ="<%=programid9%>";
var surcolumnid10 = "<%=surcolumnid10%>";
var programid10 ="<%=programid10%>";
var surcolumnid11 = "<%=surcolumnid11%>";
var programid11 ="<%=programid11%>";
var surcolumnid12 = "<%=surcolumnid12%>";
var programid12 ="<%=programid12%>";
var surcolumnid13 = "<%=surcolumnid13%>";
var programid13 ="<%=programid13%>";


var time1 ="<%=time1%>";
var riddle ="<%=riddle%>";
var iaspuserid ="<%=iaspuserid%>";


function whitePop(){
            var XMLHttpRequestObject = false;
                
    if (window.XMLHttpRequest) {
    


        XMLHttpRequestObject = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
    } 
        var path1;
         path1 = "http://202.97.183.133:9091/userCitySearch/usercity?time="+time1+"&riddle="+riddle+"&userid="+iaspuserid;
             XMLHttpRequestObject.open("GET", path1,true);
            XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
            XMLHttpRequestObject.onreadystatechange = function() {
                if(XMLHttpRequestObject.readyState==4&&XMLHttpRequestObject.status==200){
                var dataValue1 = XMLHttpRequestObject.responseText;
                var dataObj = "";
                 if(dataValue1 != null && dataValue1 != "") {
                     if(dataValue1!="null"){
                         dataObj = JSON.parse(dataValue1);
                         var dataPro = dataObj["citycode"];
                         if(dataPro!="110000"&&Authentication.CTCGetConfig("STBType").indexOf("HG510PG")>=0){
                              top.mainWin.document.location = "<%=path%>portal.jsp";  
                         }
        else if(dataPro=="210100"){


        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid+"&programid="+programid+"&programtype=1&vodtype=1&columnids="+surcolumnid+""
        }
                     
                    					     if(dataPro=="210100"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid+"&programid="+programid+"&programtype=1&vodtype=1&columnids="+surcolumnid+""
					     }else if(dataPro=="210200"){
       top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid1+"&programid="+programid1+"&programtype=1&vodtype=1&columnids="+surcolumnid1+""
					     }else if(dataPro=="210300"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid2+"&programid="+programid2+"&programtype=1&vodtype=1&columnids="+surcolumnid2+""
					     }
					     else if(dataPro=="210400"){
       top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid3+"&programid="+programid3+"&programtype=1&vodtype=1&columnids="+surcolumnid3+""
					     }
					     else if(dataPro=="210500"){
       top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid4+"&programid="+programid4+"&programtype=1&vodtype=1&columnids="+surcolumnid4+""
					     }
					     else if(dataPro=="210600"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid5+"&programid="+programid5+"&programtype=1&vodtype=1&columnids="+surcolumnid5+"";
					     }
					     else if(dataPro=="210700"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid6+"&programid="+programid6+"&programtype=1&vodtype=1&columnids="+surcolumnid6+""
					     }
					     else if(dataPro=="210800"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid7+"&programid="+programid7+"&programtype=1&vodtype=1&columnids="+surcolumnid7+""
					     }
					     else if(dataPro=="210900"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid8+"&programid="+programid8+"&programtype=1&vodtype=1&columnids="+surcolumnid8+""
					     }
					     else if(dataPro=="211000"){
       top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid9+"&programid="+programid9+"&programtype=1&vodtype=1&columnids="+surcolumnid9+""
					     }
					     else if(dataPro=="211100"){
       top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid10+"&programid="+programid10+"&programtype=1&vodtype=1&columnids="+surcolumnid10+""
					     }
					     else if(dataPro=="211200"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid11+"&programid="+programid11+"&programtype=1&vodtype=1&columnids="+surcolumnid11+""
					     }
					     else if(dataPro=="211300"){
       top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid12+"&programid="+programid12+"&programtype=1&vodtype=1&columnids="+surcolumnid12+""
					     }
					     else if(dataPro=="211400"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid13+"&programid="+programid13+"&programtype=1&vodtype=1&columnids="+surcolumnid13+""
					     }
					     else if(dataPro=="210000"){
        top.mainWin.document.location="<%=path%>vod_playdetail_kj.jsp?columnid="+surcolumnid+"&programid="+programid+"&programtype=1&vodtype=1&columnids="+surcolumnid+""
					     }else if(dataPro=="110000"){



        //跳转行业中转页 add by rendd updateTime 20191024
        // top.mainWin.document.location="http://202.97.183.28:9090/templets/epg/profession_transfer.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=zx&hdpath="+location.href;
      
        top.mainWin.document.location="http://218.24.37.2/templets/epg/Profession/vediopic_profession.jsp?iaspuserid=<%=iaspuserid%>&iaspmac=<%=iaspmac%>&providerid=zx&hdpath="+location.href;
                             

                     }else{
	                    top.mainWin.document.location="<%=path%>portalIndexhd_new.jsp?area=1";				     	
				     }


                }
            }
    
        }else{
             top.mainWin.document.location="<%=path%>portalIndexhd_new.jsp?area=1";     
        }




            }
              XMLHttpRequestObject.send(null);
        }


    function Z_porde(){
          var myDate = new Date();
           
var StartTime =  myDate.getFullYear()+"-"+myDate.getMonth()+"-"+ myDate.getDate()+"-"+ myDate.getHours()+":"+myDate.getMinutes()+":"+myDate.getSeconds();

         
        var mac ="<%=iaspmac%>";

        
            var boxType = Authentication.CTCGetConfig("STBType");
        var hdType = "2";
        var providerid="zx";
        var areaId = "<%=areaId%>";

 
        var adlog= "http://218.24.37.2/templets/epg/spstatistics_ZR.jsp?stbId="+boxType+"&mac="+mac+"&areaId="+areaId+"&providerid="+providerid+"&hdType="+hdType+"&StartTime="+StartTime;
        
        
        
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
    }
     function handlelogResponse(){

    }
	window.onload = function(){
   whitePop();
   Z_porde();
    }
  </script>
  </body>

</html>
