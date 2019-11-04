<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="cbmstags"%>
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
		<link rel="stylesheet" href="resource/css/normalize.css">
		<link rel="stylesheet" href="resource/easyui/themes/metro/easyui.css" id="swicth-style">
		<link rel="stylesheet" href="resource/easyui/themes/icon.css">
		<link rel="stylesheet" href="resource/css/sidebar.css">
		<link rel="stylesheet" href="resource/font/font-awesome.css">
		<link rel="stylesheet" href="resource/css/myEdit.css">
		<link rel="stylesheet" href="resource/css/ott_font.css">
		
		<script src="resource/easyui/jquery.min.js"></script>
		<script src="resource/easyui/jquery.easyui.min.js"></script>
		<script src="resource/easyui/locale/easyui-lang-zh_CN.js"></script>
		<script src="resource/js/bootstrap.min.js"></script>
		<script src="resource/js/index-layout.js"></script>
		<script src="resource/js/util.js"></script>
		<script src="resource/js/dialog.js"></script>
		<script src="resource/js/laydate/laydate.js"></script>
		
		<style>
			.oneRow {
				width: 1000px;
			}
			.btn.btnTool {
				width: 50px;
			}
		</style>
	</head>	
	<body class="easyui-layout">
		<div data-options="region:'center',title:'专题管理'" border="false" style="background-color:#C4C4C4">
			<input type="hidden" id="numberForUpdate"/>
			<input type="hidden" id="flagForUpdate"/>
		    <div class="easyui-layout" data-options="fit:true">
		    	<div data-options="region:'center'" border="false" style="background-color:#C4C4C4" class="ott_font">
		    	
					<!--上部分表单开始-->
					<div class="topForm">
						<ul class="oneRow">
							<li><label>专题名称：</label><input type="text" id="name" value="<s:property value="vo.name"/>" ></li>
							<li><label>专题编号：</label><input type="text" id="number" value="<s:property value="vo.number"/>" maxlength="5" onKeyUp="value=value.replace(/[^\d]/g, '')"></li>
							<li style="padding-left: 35px;display:inline;"> 
								专题类别 : 
								<select id="special" onchange="" style="height:28px;">
									<option label="全部" value=""></option>
									<option label="普通专题" value="0"></option>
									<option label="电影混排专题" value="1"></option>
									<option label="电视剧混排专题" value="2"></option>
								    <option label="综艺混排专题" value="3"></option>
							    </select>
							</li>
							
							<li style="width: 80px; float: right"><input class="btn btnTool" data-options="iconCls:'icon-add',plain:true" id="clear" value="重置"/></li>
	        				<li style="width: 80px; float: right"><input class="btn btnTool" data-options="iconCls:'icon-add',plain:true" id="search" value="查询"/></li>
						</ul>
					</div>
					<!--上部分表单结束-->
					<table id="dg" style="width: 100%;"></table>
					<div id="tb" style="height:auto;background-color:#C4C4C4" class="tb">
						<c:btnIfTag btncode='special_add'>
							<a href="javascript:void(0)" id="add" class="btn btnTool" data-options="iconCls:'icon-add',plain:true">新增＋</a>
						</c:btnIfTag>
					</div>
				</div>
			</div>
			<div id="dlg" class="easyui-dialog dlg" style="width: 50%; max-width: 400px; height: 200px" data-options="closed:true"></div>
		</div>
	</body>
</html>

<script type="text/javascript">

	getlistdata(<s:property value = "vo.pageid"/>, <s:property value = "vo.pagecount"/>);
	
	function getlistdata(page, rows) {
		var name = $("#name").val();
		var number = $("#number").val();
		
		var specal = $("#special").val();
		$("#dg").datagrid({
			url: 'special_searchList.do',
			queryParams: {
				"vo.name": name,
				"vo.number": number,
				"vo.category":specal
			},
			toolbar: '#tb',
			rowStyler: function(){ return 'height: 30px; background-color: #B3B3B3'; },
			height: 'auto',
			striped: true,
			loadMsg: '正在加载数据请稍后...',
 			pagination: true,// -------- 分页控件 
			pageNumber: page,
			pageSize: rows,
			pageList: [10, 20, 30, 40, 50],
			rownumbers: true,// -------- 行号
			nowrap : true,// ----------- 数据长度超出列宽时将会自动截取。
			fitColumns : true,// ------- 自动使列适应表格宽度以防止出现水平滚动。
			rowStyler: function() { 
				return 'height: 30px';
			},
			columns: [[
				{field: 'number', title: '专题编号', align: 'center', width: fixWidth(0.10), },
				{field: 'name', title: '专题名称', align: 'center', width: fixWidth(0.45), },
				{field: 'category', title: '专题类别', align: 'center', width: fixWidth(0.15), 
					formatter: function (value, row, index) {
						if (row.category == '0') {
							value = "普通专题";
						} else if (row.category == '1') {
							value = "电影混排专题";
						}
						else if (row.category == '2') {
							value = "电视剧混排专题";
						}
						else if (row.category == '3') {
							value = "综艺混排专题";
						}
						return "<span title='" + value + "'>" + value + "</span>";
					}
				},
				{field: 'type', title: '专题类型', align: 'center', width: fixWidth(0.15), 
					formatter: function (value, row, index) {
						if (row.type == '1') {
							value = "常规";
						} else if (row.type == '0') {
							value = "限时免费";
						}
						return "<span title='" + value + "'>" + value + "</span>";
					}
				},
				{field: '操作', title: '操作', align: 'center', width: fixWidth(0.15), 
					formatter: function(value, row) {
						var str = "";
						var category = row.category;
						var flag = row.flag;
						if (category == '0') {
							str += '<c:btnIfTag btncode="special_check">';
							str += '<input type="button" class="btn blue-btn" value="查看" onclick="check(\''+row.number+'\')"/>';
							str += '</c:btnIfTag>';
							str += '<span style="display:inline-block; width:10px"></span>';
							str += '<c:btnIfTag btncode="special_edit" >';
							str += '<input type="button" class="btn blue-btn" value="编辑" onclick="edit(\''+row.number+'\')"/>';
							str += '</c:btnIfTag>';
							return str;
						} else if (category == '1') {
							if (flag == '1') {
								str += '<c:btnIfTag btncode="special_flag" >';
								str += '<input type="button" class="btn blue-btn" value="生效中" onclick="confirm(\''+row.number+'\',  \''+flag +'\')"/>';
								str += '</c:btnIfTag>';
								str += '<span style="display:inline-block; width:10px"></span>';
								str += '<c:btnIfTag btncode="special_check">';
								str += '<input type="button" class="btn blue-btn" value="查看" onclick="check(\''+row.number+'\')"/>';
								str += '</c:btnIfTag>';
							} else if (flag == '0') {
								str += '<c:btnIfTag btncode="special_flag" >';
								str += '<input type="button" class="btn blue-btn" value="已失效" onclick="confirm(\''+row.number+'\',  \''+flag +'\')"/>';
								str += '</c:btnIfTag>';
								str += '<span style="display:inline-block; width:10px"></span>';
								str += '<c:btnIfTag btncode="special_edit" >';
								str += '<input type="button" class="btn blue-btn" value="编辑" onclick="edit(\''+row.number+'\')"/>';
								str += '</c:btnIfTag>';
							};
						}
						else if (category == '2'||category == '3') {
							if (flag == '1') {
								str += '<c:btnIfTag btncode="special_flag" >';
								str += '<input type="button" class="btn blue-btn" value="生效中" onclick="confirm(\''+row.number+'\',  \''+flag +'\')"/>';
								str += '</c:btnIfTag>';
								str += '<span style="display:inline-block; width:10px"></span>';
								str += '<c:btnIfTag btncode="special_check">';
								str += '<input type="button" class="btn blue-btn" value="查看" onclick="check(\''+row.number+'\')"/>';
								str += '</c:btnIfTag>';
							} else if (flag == '0') {
								str += '<c:btnIfTag btncode="special_flag" >';
								str += '<input type="button" class="btn blue-btn" value="已失效" onclick="confirm(\''+row.number+'\',  \''+flag +'\')"/>';
								str += '</c:btnIfTag>';
								str += '<span style="display:inline-block; width:10px"></span>';
								str += '<c:btnIfTag btncode="special_edit" >';
								str += '<input type="button" class="btn blue-btn" value="编辑" onclick="edit(\''+row.number+'\')"/>';
								str += '</c:btnIfTag>';
							};
						}
						return str;
					}
				}
			]]
		});
	}
	
	function fixWidth(percent) {  
	    return document.body.clientWidth * percent;
	}
	
	/** 查询 */
	$("#search").on("click",function(){
		getlistdata(<s:property value="vo.pageid"/>,<s:property value="vo.pagecount"/>);
	});
	
	/** 重置 */
	$("#clear").on("click", function() {
		$("#name, #number").val("");
		$("#special option:first").prop("selected",'selected');
	});
	
	/** 新增页面 */
	$("#add").on('click', function() {
		window.location.href ="special_addPage.do";
	});
 	
	/** 编辑页面 */
 	function edit(number) {
 		window.location.href ="special_editPage.do?vo.number=" + number;
 	}
 	
 	/** 查看页面 */
 	function check(number) {
 		window.location.href ="special_check.do?vo.number=" + number;
 	}
 	
 	/** 确认框 */
 	function confirm(number, flag) {
 		var str = flag == '0' ? "生效" : "失效";
 		document.getElementById("numberForUpdate").value = number;
 		document.getElementById("flagForUpdate").value = flag;
 		subDialog("是否将专题状态变更为“" + str +"”?", "确定", updateFlag, "取消", canDel);
 	}
 	
	/** 关闭弹出框 */
	function canDel(){
		$("#dlg").dialog("close");
	}
	
	/** 变更专题状态 */
	function updateFlag() {
		canDel();
		$.ajax({
			url: "special_updateFlag.do",
			data: {
				"vo.number": $("#numberForUpdate").val(),
				"vo.flag": $("#flagForUpdate").val(),
			},
			dataType: 'text',
			success : function(result, data) { //data是从服务器返回来的值
				if (result == "no") {
				    setTimeDlg("变更失败！");
				} else {
			    	subDialog("变更成功！", "", "", "", "");
			    	setTimeout(function() {
			    		$('#dlg').dialog('close');
			    		window.location.href ="special_toListPage.do?kvc=special";
			    	}, 2500);
				}
			},
			error : function(data, status, e) {
				setTimeDlg("变更失败！");
			}
		});
	}
 	
</script>