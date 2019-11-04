<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="cbmstags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="zh">
	<head>
	    <meta charset="UTF-8">
	    <title>专题管理</title>
	    <meta name="renderer" content="webkit" />
		<meta name="force-rendering" content="webkit" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<link rel="stylesheet" href="resource/easyui/themes/metro/easyui.css" id="swicth-style">
		<link rel="stylesheet" href="resource/easyui/themes/icon.css">
		<link rel="stylesheet" href="resource/css/myEdit.css">
		<link rel="stylesheet" href="resource/font/font-awesome.css">
		<link rel="stylesheet" href="resource/css/ott_font.css">
		
		<script type="text/javascript" src="resource/easyui/jquery.min.js"></script>
		<script type="text/javascript" src="resource/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="resource/js/tableform.js"></script>
		<script type="text/javascript" src="resource/easyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="resource/js/util.js"></script>
		<script type="text/javascript" src="resource/js/laydate/laydate.js"></script>
	</head>
	<body class="easyui-layout" id="bodyid">
		<div data-options="region:'center',title:'专题管理〉查看专题'" border="false" style="background-color:#C4C4C4">
		    <!--form表单页面-->
		    <form id="form1">
		    	<input type="hidden" id="number" name="vo.number" value="<s:property value="vo.number"/>"/>
		    	<!-- 上半部分div -->
				<div>
		        	<ul class="addOneRow">
			          	<li>
			            	<label>专题名称: </label>
			            	<s:property value="vo.name"/>
			            	<s:if test="vo.category==0">
			            		<label>EPG路径: </label>
			            		<a>http://218.24.37.2/templets/epg/sp_3/dy_page_hhb_pro.jsp?number=</a><s:property value="vo.number"/><a>&templetFlag=</a><s:property value="vo.templetFlag"/>
			            	</s:if>
			          	</li>
		        	</ul>
		        	<ul class="addOneRow">
		        		<li>
		        			<label>专题类别: </label> 
		        			<a>
								<s:if test="vo.category==1">电影混排专题</s:if>
								<s:if test="vo.category==0">普通专题</s:if>
								<s:if test="vo.category==2">电视剧混排专题</s:if>
								<s:if test="vo.category==3">综艺混排专题</s:if>
							</a>
							<s:if test="vo.category==1||vo.category==2||vo.category==3">
								<label>专题优先级: </label>
								<s:property value="vo.priority"/>
							</s:if>
							
						</li>
		        	</ul>
		        	<ul class="addOneRow">
		        		<li>
		        			<label>专题类型: </label> 
		        			<a>
								<s:if test="vo.type==1">常规</s:if>
								<s:if test="vo.type==0">限时免费</s:if>
							</a>
						</li>
		        	</ul>
		        	<ul class="addOneRow" id="timeRow" style="display: none">
		        		<li><label>免费时间: </label></li>
		        	</ul>
		      	</div>
		      	
		      	<!-- 中间部分div -->
		      	<div>
				   	<div class="mb10">
						<ul class="oneRow">
							<li><label>节目：</label></li>
						</ul><br/>
					</div>
					<!-- 表格 -->
					<div id="myTable1">
						<table id="dgg1" style="max-height: 350px;"></table>
					</div>
				</div>
				
				<!-- 下半部分div -->
				<div>
					<!---------- 海报 ---------->
					<div style="height:50px">
						<ul class="oneRow">
							<li><label>海报：</label></li>
						</ul><br/>
					</div>
					<div style="margin-left: 200px;">
						<div style="display: inline;">
							<img id="src1" src="<s:property value='vo.poster1url'/>" alt="" width="236" height="122"/>
						</div>
						<span style="display:inline-block; width:100px"></span>
						<div style="display:inline">
							<img id="src2" src="<s:property value='vo.poster2url'/>" alt="" width="165" height="208"/>
						</div>
					</div>
					<!---------- 节目列表模板 ---------->
					<div style="margin-top: 50px; height:50px">
						<ul class="oneRow">
							<li><label style="width:120px">当前节目列表模板：</label></li>
						</ul><br/>
					</div>
					<div style="margin-left: 350px;">
						<div style="display: inline;">
							<img id="src4" src="" alt="" width="236" height="122"/>
						</div>
					</div>
					<!---------- 节目列表页背景图 ---------->
					<div style="margin-top: 50px; height:50px">
						<ul class="oneRow">
							<li><label style="width:150px">当前节目列表页背景图：</label></li>
						</ul><br/>
					</div>
					<div style="margin-left: 350px;">
						<div style="display: inline;">
							<img id="src3" src="<s:property value='vo.poster3url'/>" alt="" width="236" height="122"/>
						</div>
					</div>
				</div>
			</form>
		
        	<div class="btnGroup" style="text-align: center; margin-top: 20px; margin-bottom: 50px;">
	        	<a href="javascript:void(0)" class="btn btn-space" data-options="iconCls:'icon-add',plain:true" onclick="toBack()">返回</a> 
	        </div>
		</div>
		
		<div id="dlg" class="easyui-dialog dlg" style="width: 50%; max-width: 400px; height: 200px;" data-options="closed:true"></div>
	</body>
	<script type="text/javascript">
	
		/** 初始化信息 */
		$(function() {
			addFreeTime();
			selectTemplet();
			searchDatagrid();
		});
	
		/** 加载免费时间 */
		function addFreeTime() {
			if(<s:property value="vo.type"/> == '0') {
				$.post("special_checkFreeTime.do", {
					"vo.number" : $("#number").val()
				}, function(data) {
					$.each(data.rows, function(index, obj) {
						var _input = $("<li style='width: 1000px; margin-top: 10px'>" + 
							"<label style='width: 124px;'></label>" + 
							"<a>" + obj.begintime + "</a>" + 
							"<span style='display:inline-block; width:10px'></span>" + 
							"<a style='font-weight: 700'>到</a>" +  
							"<span style='display:inline-block; width:10px'></span>" + 
							"<a>" + obj.endtime + "</a>" + 
						"</li>");
						$("#timeRow").append(_input);
					});
				}, "json");
				$("#timeRow").css("display", "");
			}
		}
		
		/** 加载表格 */
		function searchDatagrid() {
			$("#dgg1").datagrid({
				url: 'special_checkProgram.do',
				queryParams: {
					"vo.number": $("#number").val()
				},
				method: 'POST',
				nowrap : true,//数据长度超出列宽时将会自动截取。
				fitColumns : true,//自动使列适应表格宽度以防止出现水平滚动。
				rowStyler: function() { 
					return 'height: 30px';
				},
				height : 'auto',
				width : '99%',
				loadMsg : '正在加载数据请稍后...',
				striped : true,
				columns : [ [ {
					field : 'ln',
					title : '序号',
					align : 'center',
					formatter : function(value, rowData, rowIndex) {
						return rowIndex + 1;
					}
				}, {
					field : 'primaryid',
					title : '节目ID',
					align : 'center',
					width : 0,
					halign : 'center',
					hidden : true,
					formatter : function(value) {
						return "<span title='" + value + "'>" + value + "</span>";
					}
				}, {
					field : 'code',
					title : '节目CODE',
					align : 'center',
					width : 30,
					halign : 'center',
					formatter : function(value) {
						return "<span title='" + value + "'>" + value + "</span>";
					}
				}, {
					field : 'name',
					title : '节目名称',
					align : 'center',
					width : 50,
					halign : 'center',
					formatter : function(value) {
						return "<span title='" + value + "'>" + value + "</span>";
					}
				}, {
					field : 'providerid',
					title : '所属平台',
					align : 'center',
					width : 20,
					halign : 'center',
					formatter : function(value) {
						return "<span title='" + value + "'>" + value + "</span>";
					}
				} ] ]
			});
		};
		
		/** 选择专题模板 */
		function selectTemplet() {
			var templetFlag = <s:property value="vo.templetFlag"/>;
			var img = document.getElementById("src4");
			if(templetFlag == "1") {
				img.src = "resource/image/templet1.jpg";
			} else if(templetFlag == "2"){
				img.src = "resource/image/templet2.jpg";
			}
		}
		
		/** 返回 */
		function toBack() {
			window.location.href ="special_toListPage.do?kvc=special";
		}
	</script>
	
</html>