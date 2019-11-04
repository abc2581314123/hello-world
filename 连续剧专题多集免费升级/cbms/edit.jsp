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
		<script type="text/javascript" src="resource/js/ajaxfileupload.js"></script><!-- 有修改 by 张晋 -->
	</head>
	<body class="easyui-layout" id="bodyid">
		<div data-options="region:'center',title:'专题管理〉编辑专题'" border="false" style="background-color:#C4C4C4">
		    <!--form表单页面-->
		    <form action="special_save.do" method="post" id="form1" enctype="multipart/form-data">
		    	<input type="hidden" id="suffix1" value=""/>
		    	<input type="hidden" id="suffix2" value=""/>
		    	<input type="hidden" id="suffix3" value=""/>
		    	<input type="hidden" id="returnCategory" value="<s:property value='vo.category'/>"/>
		    	<input type="hidden" id="returnType" value="<s:property value='vo.type'/>"/>
		    	<input type="hidden" id="number" name="vo.number" value="<s:property value="vo.number"/>"/>
		    	<!-- 上半部分div -->
				<div>
		        	<ul class="addOneRow">
			          	<li>
			            	<label><a href="javascript:void(0)" style="color:red">＊ </a>专题名称: </label>
			            	<input type="text" id="name" maxlength="50" name="vo.name" value="<s:property value="vo.name"/>"/>
			          	</li>
		        	</ul>
		        	<ul class="addOneRow">
		        		<li>
		        			<label><a href="javascript:void(0)" style="color:red">＊ </a>专题类别: </label>
							<select class="selectBox" id="category" name="vo.category" onchange="categoryChange()">
								<option value="">请选择</option>
							   	<option value="0">普通专题</option>
							   	<option value="1">电影混排专题</option>
							   	<option value="2">电视剧混排专题</option>
							   	<option value="3">综艺混排专题</option>
							</select>
							<label id="priorityname" style="display: none"><a href="javascript:void(0)" style="color:red">＊ </a>专题优先级: </label>
			            	<input type="text" id="priority" name="vo.priority" value="<s:property value='vo.priority'/>" maxlength="3" style="display: none" onKeyUp="value=value.replace(/[^\d]/g,'')"/><a href="javascript:void(0)" id="prioritynum" style="display: none">（1~100）数字越大，优先级越高。</a>
						</li>
		        	</ul>
		        	<ul class="addOneRow">
		        		<li>
		        			<label><a href="javascript:void(0)" style="color:red">＊ </a>专题类型: </label> 
							<select class="selectBox" id="type" name="vo.type" onchange="typeChange()">
								<option value="">请选择</option>
								<option value="1">常规</option>
							   	<option value="0">限时免费</option>
							</select>
						</li>
		        	</ul>
		        	<ul class="timeRow" id="timeRow" style="display: none"></ul>
		      	</div>
		      	
		      	<!-- 中间部分div -->
		      	<div>
				   	<div class="mb10">
						<ul class="oneRow">
							<li><label>添加节目：</label></li>
						</ul><br/>
					</div>
					<!-- 上表格 -->
					<div id="myTable1">
						<table id="dgg1" style="max-height: 350px;"></table>
					</div>
					<div class="mb10">
						<ul class="oneRow">
							<li style="width:300px">
								<label>节目CODE：</label> <input type="text" id="pcode">
								<span id="prompting" style="display: none; margin-left: 80px; color:red">不可添加电影混排外的其他节目CODE</span>
							</li>
							<li style="margin-left: 10px;">
								<a href="javascript:void(0)" class="btn btn-primary" data-options="iconCls:'icon-add',plain:true" onclick="searchTable1()">查询</a> 
							</li>
						</ul>
					</div>
					<!-- 下表格 -->
					<div id="myTable">
						<table id="dgg" style="width: 100%;"></table>
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
							<div style="display:inline-block">
								<a style="display:block; margin-left: 8px">298 * 196</a>
								<a href="javascript:;" class="file">更换海报<input type="file" name="poster" id="poster1"></a>
							</div>
						</div>
						<span style="display:inline-block; width:100px"></span>
						<div style="display:inline">
							<img id="src2" src="<s:property value='vo.poster2url'/>" alt="" width="165" height="208"/>
							<div style="display:inline-block">
								<a style="display:block; margin-left: 8px">168 * 250</a>
								<a href="javascript:;" class="file">更换海报<input type="file" name="poster" id="poster2"></a>
							</div>
						</div>
					</div>
					<!---------- 选择节目列表模板 ---------->
					<div style="margin-top: 50px; height:50px">
						<ul class="oneRow">
							<li><label style="width:120px">选择节目列表模板：</label></li>
						</ul><br/>
					</div>
					<div style="margin-left: 200px;">
						<div style="display: inline;">
							<input type="radio" value="1" name="select" >
							<img src="resource/image/templet1.jpg" id="templet1" width="250" height="140"/>
						</div>
						<span style="display:inline-block; width:100px"></span>
						<div style="display:inline">
							<input type="radio" value="2" name="select" >
							<img src="resource/image/templet2.jpg" id="templet2" width="250" height="140"/>
						</div>
					</div>
					<!---------- 更换节目列表页背景图 ---------->
					<div style="margin-top: 50px; height:50px">
						<ul class="oneRow">
							<li><label style="width:150px">更换节目列表页背景图：</label></li>
						</ul><br/>
					</div>
					<div style="margin-left: 350px;">
						<div style="display: inline;">
							<img id="src3" src="<s:property value='vo.poster3url'/>" alt="" width="236" height="122"/>
							<div style="display:inline-block">
								<a style="display:block; margin-left: 8px">1280 * 720</a>
								<a style="display:block; href="javascript:;" class="file" id="blue">默认蓝色背景图</a>
								<a href="javascript:;" class="file">更换海报<input type="file" name="poster" id="poster3"></a>
							</div>
						</div>
					</div>
				</div>
			</form>
		
        	<div class="btnGroup" style="text-align: center; margin-top: 20px; margin-bottom: 50px;">
	        	<a href="javascript:void(0)" class="btn btn-primary" data-options="iconCls:'icon-add',plain:true" onclick="toSubmit()">保存</a> 
	        	<a href="javascript:void(0)" class="btn btn-space" data-options="iconCls:'icon-add',plain:true" onclick="toBack()">取消</a> 
	        </div>
		</div>
		
		<div id="dlg" class="easyui-dialog dlg" style="width: 50%; max-width: 400px; height: 200px;" data-options="closed:true"></div>
	</body>
	<script type="text/javascript">
	
		var idnum = 1;
		var stra = "";
	
	    $("#category option[value='" + $("#returnCategory").val() + "']").attr("selected","selected"); 
	    $("#type option[value='" + $("#returnType").val() + "']").attr("selected","selected");
	    if($("#returnCategory").val() == '1') {
			$("#priority").css("display", "");
			$("#prioritynum").css("display", "");
			$("#priorityname").css("display", "");
			$("#prompting").css("display", "");
	    }
	    //add by rendd 20190822 添加电视剧综艺混排专题类型
		 else if($("#returnCategory").val() == '2'||$("#returnCategory").val() == '3'){
			
			$("#priority").css("display", "");
			$("#prioritynum").css("display", "");
			$("#priorityname").css("display", "");
			$("#prompting").css("display", "none");
		}
		
	    if($("#returnType").val() == '0') {
	    	addFreeTimeDatas();
	    }
	    searchTable();
	    searchTable1();
	    addProgram();
	    selectTemplet();
	    
	    /** 加载免费时间(有数据) */
		function addFreeTimeDatas() {
			$.post("special_checkFreeTime.do", {
				"vo.number" : $("#number").val()
			}, function(data) {
				$.each(data.rows, function(index, obj) {
					var _input = "";
					if(index == "0") {
						_input = $("<li style='width: 1000px; margin-top: 0px' name='addtimeli' id='addtime'>" + 
		        			"<label style='width: 124px'><a href='javascript:void(0)' style='color:red'>＊ </a>选择免费时间: </label>" +
		        			"<input style='width: 158px' type='text' id='begintime' name='begintime' value='" + obj.begintime + "' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" + 
							"<span style='font-weight: 700'>到</span>" +
							"<input style='width: 158px' type='text' id='endtime' name='endtime' value='" + obj.endtime + "' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" +
							"<span><img src='resource/image/addtime.png' onclick='addtime()'></span>" +
						"</li>");
					} else {
						_input = $("<li style='width: 1000px; margin-top: 10px' name='addtimeli' id='addtime" + idnum + "'>" + 
							"<label style='width: 124px;'></label>" + 
							"<input style='width: 158px; 'type='text' id='begintime" + idnum + "' name='begintime' value='" + obj.begintime + "' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" + 
							"<span style='font-weight: 700'>到</span>" +  
							"<input style='width: 158px; 'type='text' id='endtime" + idnum + "' name='endtime' value='" + obj.endtime + "' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" + 
							"<span><img src='resource/image/removetime.png' onclick='removetime(this)'></span>" + 
						"</li>");
						idnum++;
					}
					$("#timeRow").append(_input);
				});
			}, "json");
			$("#timeRow").css("display", "");
		}
	    
		/** 加载免费时间(最初) */
		function addFreeTimeInitia() {
			var _input = $("<li style='width: 1000px; margin-top: 0px' name='addtimeli' id='addtime'>" + 
					"<label style='width: 124px;'><a href='javascript:void(0)' style='color: red'>＊ </a>选择免费时间: </label>" + 
					"<input style='width: 158px; 'type='text' id='begintime' name='begintime' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" + 
					"<span style='font-weight: 700'>到</span>" +  
					"<input style='width: 158px; 'type='text' id='endtime' name='endtime' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" + 
					"<span><img src='resource/image/addtime.png' onclick='addtime()'></span>" + 
				"</li>");
			$("#timeRow").append(_input);
			$("#timeRow").css("display", "");
		}
	    
		/** 加载相关节目 */
	    function addProgram() {
	    	$.post("special_checkProgram.do", {
				"vo.number" : $("#number").val()
			}, function(data) {
				$.each(data.rows, function(index, obj) {
					addSelect(obj.primaryid, obj.code, obj.name, obj.providerid);
				});
			}, "json");
	    }
		
	    /** 选择专题模板 */
		function selectTemplet() {
			var templetFlag = <s:property value="vo.templetFlag"/>;
			var select = document.getElementsByName("select");
			if(templetFlag == "1") {
				$(select[0]).prop("checked",true);
			} else if(templetFlag == "2"){
				$(select[1]).prop("checked",true);
			}
		}
	    
		/** 专题类别菜单切换监听 */
		function categoryChange(){
			var category = document.getElementById('category').value;// 专题类别 
	
			if(category == '1') {// 电影混排专题
				$("#priority").css("display", "");
				$("#prioritynum").css("display", "");
				$("#priorityname").css("display", "");
				$("#prompting").css("display", "");
			} else if(category == '' || category == '0'){// 普通专题
				$("#priority").val("");
				$("#priority").css("display", "none");
				$("#prioritynum").css("display", "none");
				$("#priorityname").css("display", "none");
				$("#prompting").css("display", "none");
			}
			//add by rendd 20190822 添加电视剧综艺混排专题类型
			 else if(category == '2'||category == '3'){
				$("#priority").css("display", "");
				$("#prioritynum").css("display", "");
				$("#priorityname").css("display", "");
				$("#prompting").css("display", "none");
			}
			$("#dgg1").datagrid('loadData', {"total" : 0, "rows" : []});
			stra = "";
		}
		
		/** 专题类型菜单切换监听 */
		function typeChange(){
			var type = document.getElementById('type').value;// 专题类型 
			if(type == '0') {// 限时免费
				if($("#returnType").val() == '1') {
					addFreeTimeInitia();
					$("#returnType").val("0");
				} else {
					$("#timeRow").css("display", "");
				}
			} else if(type == '' || type == '1') {// 常规
				var ids = new Array();
				var adds = document.getElementsByName('addtimeli');
				var length = adds.length;
				$("#begintime").val("");
				$("#endtime").val("");
				for(var o = 1; o < length; o ++) {
					ids[o - 1] = adds[o].id;
				}
				for(var j = 0; j < ids.length; j ++) {
					$("#" + ids[j]).remove();
				}
				idnum = 1;
				$("#timeRow").css("display", "none");
			}
			$("#dgg").datagrid('loadData', {"total" : 0, "rows" : []});
		}
	
		/** 新增一行免费时间 */
		function addtime() {
			var _input = $("<li style='width: 1000px; margin-top: 10px' name='addtimeli' id='addtime" + idnum + "'>" + 
								"<label style='width: 124px;'></label>" + 
								"<input style='width: 158px; 'type='text' id='begintime" + idnum + "' name='begintime' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" + 
								"<span style='font-weight: 700'>到</span>" +  
								"<input style='width: 158px; 'type='text' id='endtime" + idnum + "' name='endtime' class='ipt date-icon' autocomplete='off' readonly='readonly' onclick='time(this.id)'/>" + 
								"<span><img src='resource/image/removetime.png' onclick='removetime(this)'></span>" + 
							"</li>");
			$("#timeRow").append(_input);
			idnum++;
		}
		
		/** 删除一行免费时间 */
		function removetime(Obj) {
			Obj.parentNode.parentNode.parentNode.removeChild(Obj.parentNode.parentNode);
		}
		
		/** 定义免费时间格式 */
		function time(id) {
			laydate({istime: true, elem : '#' + id, format : 'YYYY-MM-DD hh:mm:ss'});
		}
		
		/** 生成上表格 */
		function searchTable() {
			$("#dgg1").datagrid({
				striped : true,
				nowrap : true,//数据长度超出列宽时将会自动截取。
				fitColumns : true,
				rowStyler: function() { 
					return 'height: 30px';
				},
				height : 'auto',
				loadMsg : '正在加载数据请稍后...',
				width : '99%',
				columns : [[{
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
				}, {
					field : 'index',
					title : '操作',
					width : 10,
					align : 'center',
					halign : 'center',
					formatter : function(value, row) {
						var str = "";
						str += '<a href="javascript:cancelPrd(\'' + row.primaryid + '\')" style="color:#444; text-decoration:underline">删除</a>';
						return str;
					}
				}]]
			});
		};
		
		/** 加载下表格 */
		function searchTable1() {
			var code = document.getElementById('pcode').value;
			var category = document.getElementById('category').value;
			$("#dgg").datagrid({
				url: 'special_searchPcode.do',
				queryParams: {
					"pvo.code": code,
					"vo.category": category
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
				}, {
					field : 'index',
					title : '操作',
					width : 10,
					align : 'center',
					halign : 'center',
					formatter : function(value, row) {
						var str = "";
						str += '<a href="javascript:addSelect(\'' + row.primaryid + '\',\'' + row.code + '\',\'' + row.name + '\',\'' + row.providerid + '\')" style="color:#444; text-decoration:underline">添加</a>';
						return str;
					}
				} ] ]
			});
		}
		
		/** 添加选中节目 */
		function addSelect(primaryid, code, name, providerid) {
			if($('#dgg1').datagrid("getData").rows.length == 20) {
				subDialog("一个专题最多添加20条节目！", "确定", canDel, "", "");
				return false;
			}
			var i = 0;
			var strb = "";
			var strd = "";
			var strid = "";
			// 获得用户选择的数据处理成特定格式字符串
			strb = '{"primaryid":"' + primaryid + '","code":"' + code + '","name":"' + name + '","providerid":"' + providerid + '"}@#$';
			strid += primaryid + ",";
			stra += "@#$" + createJson(strid, strb);
			var strdArray = stra.split("@#$");
			for (var a = 0; a < strdArray.length; a++) {
				if (strdArray[a] != null && strdArray[a] != "") {
					if (i == 0) {
						strd += strdArray[a];
					} else {
						strd += "," + strdArray[a];
					}
					i++;
				}
			} 
			var jsonArray = '{"total":"' + i + '","rows":[' + strd + ']}';
			arrangeTable(jsonArray);
			i = 0;
		}
		
		/** 处理用户选择的数据并将其处理成json */
		function createJson(strid, strb) {
			// 此处是判断用户是否可以重复选择同一个code的开关 off:关闭，open：开启
			var switchtype = "off";
			var idArray = strid.split(",");
			var abArray = strb.split("@#$");
			var strc = "";
			var straArray = stra.split("@#$");
			for (var i = 0; i < idArray.length; i++) {
				for (var j = 0; j < abArray.length; j++) {
					if (abArray[j] != null && abArray[j] != "" && idArray[i] != null && idArray[i] != "") {
						if ((idArray[i]) == eval("(" + abArray[j] + ")").primaryid) {
							for (var z = 0; z < straArray.length; z++) {
								if (straArray[z] != null && straArray[z] != '') {
									if (idArray[i] == eval("(" + straArray[z] + ")").primaryid && switchtype == "off") {
										subDialog("已添加节目中存在该节目，不能重复添加！", "确定", canDel, "", "");
										return "@#$";
									}
								}
							}
							strc += abArray[j] + "@#$";
						}
					}
				}
			}
			return strc;
		}
		
		/** 删除选中节目 */
		function cancelPrd(index) {
			var strdArray = stra.split("@#$");
			var i = 0;
			var strd = "";
			var strb = "";
			// 根据用户选择删除的primaryid在字符串中将该条数据筛选出去
			for (var a = 0; a < strdArray.length; a++) {
				if (strdArray[a] != null && strdArray[a] != "") {
					if (index != eval('(' + strdArray[a] + ')').primaryid) {
						if (i == 0) {
							strd += strdArray[a];
						} else {
							strd += "," + strdArray[a];
						}
						strb += strdArray[a] + "@#$";
						i++;
					}
				}
			}
			var jsonArray = '{"total":"' + i + '","rows":[' + strd + ']}';
			stra = strb;
			//调用生成表格
			arrangeTable(jsonArray);
			i = 0;
		}
		
		/** 修改后的上表格数据 */
		function arrangeTable(jsonArray) {
			var data = JSON.parse(jsonArray);
			$('#dgg1').datagrid('loadData', {
				"total" : data.total,
				"rows" : data.rows
			});
		}
		
		/** 背景图默认 */
		$("#blue").click(function() {
			var img = document.getElementById("src3");
			img.src = "resource/image/blue.jpg";
		});
		
		/** 更换海报 */
		$("#poster1").change(function(){
			var file = document.getElementById("poster1");
			var name = $("#poster1").val().substring($("#poster1").val().lastIndexOf("\\") + 1);
			var suffix = format(name);
			if("" == suffix) {
				subDialog("文件类型不正确！允许类型:jpg png jpeg！", "确定", canDel, "", "");
				return false;
			};
			document.getElementById("suffix1").value = suffix;
			var img = document.getElementById("src1");
			var reader = new FileReader();
		  	reader.readAsDataURL(file.files[0]);
		  	reader.onload = function() {
		  		img.src = this.result;
			};
		});
		$("#poster2").change(function(){
			var file = document.getElementById("poster2");
			var name = $("#poster2").val().substring($("#poster2").val().lastIndexOf("\\") + 1);
			var suffix = format(name);
			if("" == suffix) {
				subDialog("文件类型不正确！允许类型:jpg png jpeg！", "确定", canDel, "", "");
				return false;
			};
			document.getElementById("suffix2").value = suffix;
			var img = document.getElementById("src2");
			var reader = new FileReader();
		  	reader.readAsDataURL(file.files[0]);
		  	reader.onload = function() {
		  		img.src = this.result;
			};
		});
		$("#poster3").change(function(){
			var file = document.getElementById("poster3");
			var name = $("#poster3").val().substring($("#poster3").val().lastIndexOf("\\") + 1);
			var suffix = format(name);
			if("" == suffix) {
				subDialog("文件类型不正确！允许类型:jpg png jpeg！", "确定", canDel, "", "");
				return false;
			};
			document.getElementById("suffix3").value = suffix;
			var img = document.getElementById("src3");
			var reader = new FileReader();
		  	reader.readAsDataURL(file.files[0]);
		  	reader.onload = function() {
		  		img.src = this.result;
			};
		});
		
		/** 判断文件格式 */
		function format(obj) {
			var suffix = obj.substring(obj.lastIndexOf(".")).toLowerCase();
			if (suffix == ".jpg" || suffix == ".png" || suffix == ".jpeg") {
				return suffix;
			} else {
				return "";
			}
		}
		
		/** 关闭弹出框 */
		function canDel(){
			$("#dlg").dialog("close");
		}
		
		/** 确定保存 */
		function toSubmit() {
			subDialog("确定保存该专题么？", "确定", Yes, "", "");
		}
		
		/** 确定 */
		function Yes(){
			$("#dlg").dialog("close");
			Save();
		}
		
		/** 保存专题 */
		function Save() {
			var name = document.getElementById("name").value;
			if(name == null || name.trim() == ""){
				subDialog("请输入专题名称！", "确定", canDel, "", "");
				return false;
			}
			var category = document.getElementById("category").value;
			if(category == ""){
				subDialog("请选择专题类别！", "确定", canDel, "", "");
				return false;
			}
			var type = document.getElementById("type").value;
			if(type == ""){
				subDialog("请选择专题类型！", "确定", canDel, "", "");
				return false;
			}
			var priority = "";
			if(category == "1"||category == "2"||category == "3") {
				priority = document.getElementById("priority").value;
				if(priority == null || priority == ""){
					subDialog("请设置专题优先级！", "确定", canDel, "", "");
					return false;
				}
				if(parseInt(priority) > 100) {
					subDialog("专题优先级范围（1~100）！", "确定", canDel, "", "");
					return false;
				}
			}
			var beginTimeData = "";
			var endTimeData = "";
			if(type == "0") {
				var beginTimeList = document.getElementsByName("begintime");
				var endTimeList = document.getElementsByName("endtime");
				
				for(var i = 0; i < beginTimeList.length; i++) {
					if(null != beginTimeList[i].value && "" != beginTimeList[i].value && null != endTimeList[i].value && "" != endTimeList[i].value) {
						if(beginTimeList[i].value >= endTimeList[i].value) {
							subDialog("开始时间必须小于结束时间！", "确定", canDel, "", "");
							return false;
						}
					} else {
						subDialog("请选择免费时间！", "确定", canDel, "", "");
						return false;
					}
					beginTimeData += beginTimeList[i].value + ",";
					endTimeData += endTimeList[i].value + ",";
				}
			}
			var src1 = document.getElementById("src1").src;
			var src2 = document.getElementById("src2").src;
			if(src1.indexOf("resource/image/placeholder_") > -1 || src2.indexOf("resource/image/placeholder_") > -1) {
				subDialog("请上传海报图片！", "确定", canDel, "", "");
				return false;
			}
			var templetFlag = "";
			var select = document.getElementsByName("select");
			for(var i = 0; i < select.length; i++) {
				if(select[i].checked) {
					templetFlag = (i + 1) + "";
					break;
				}
				if (i == 1) {
					subDialog("请选择列表模板！", "确定", canDel, "", "");
	              	return false;
				}
			}
			var poster3Flag = "";
			var src3 = document.getElementById("src3").src;
			if(src3.indexOf("resource/image/blue.jpg") > -1) {
				poster3Flag = "1";
			}
			var dataRows = $("#dgg1").datagrid("getRows");
			
			subDialog("专题保存中，请稍后...", "", "", "", "");
			$.ajaxFileUpload({
				url: "special_edit.do",
				fileElementId : ["poster1", "poster2", "poster3"],
				secureuri: false,
				dataType: 'text',
				data: {
					"vo.number": $("#number").val(),
					"vo.name": name,
					"vo.category": category,
					"vo.priority": priority,
					"vo.type": type,
					"vo.suffix1": $("#suffix1").val(),
					"vo.suffix2": $("#suffix2").val(),
					"vo.suffix3": $("#suffix3").val(),
					"vo.templetFlag": templetFlag,
					"data": JSON.stringify(dataRows),
					"beginTimeData": beginTimeData,
					"endTimeData": endTimeData,
					"poster3Flag": poster3Flag
				},
				success : function(result, data) { //data是从服务器返回来的值
					$('#dlg').dialog('close');
					if (result == "no") {
					    setTimeDlg("保存专题失败！");
					} else if(result == "fail") {
					        setTimeDlg("保存专题成功，上传文件失败！");
				    } else {
				    	subDialog("保存专题成功！", "", "", "", "");
				    	setTimeout(function() {
				    		$('#dlg').dialog('close');
				    		window.location.href ="special_toListPage.do";
				    	}, 2500);
					}
				},
				error : function(data, status, e) {
					$('#dlg').dialog('close');
					setTimeDlg("保存专题失败！");
				}
			});
		}
		
		/** 取消 */
		function toBack() {
			window.location.href ="special_toListPage.do?kvc=special";
		}
	</script>
	
</html>