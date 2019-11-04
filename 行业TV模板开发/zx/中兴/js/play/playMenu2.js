var myDate = new Date();
var year=myDate.getFullYear();    //获取完整的年份(4位,1970-????)
var month=myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
if(month<10) 
{
month="0"+month;
}
var day=myDate.getDate();        //获取当前日(1-31)
if(day<10)
	{
	day="0"+day;
	}
var jsonCategoryData={
		list:[
			{name:'全部'}
		   ,{name:'央视'}
		   ,{name:'卫视'}
		   ,{name:'地方'}
		   ,{name:'少儿'}
		   ,{name:'电影'}
		   ,{name:'剧场'}
		   ,{name:'其他'}
		]
	   ,currentIndex:0
}
   ,jsonChannelData={
		list:[
			{name:'辽宁卫视',program:'阳光剧场：猎魔25',cid:'001',t:''}
	   ,{name:'广东卫视',program:'阳光剧场：猎魔25',cid:'002',t:''}
	   ,{name:'山东卫视',program:'阳光剧场：猎魔25',cid:'003',t:''}
	   ,{name:'江西卫视',program:'阳光剧场：猎魔25',cid:'004',t:''}
	   ,{name:'宁夏卫视',program:'阳光剧场：猎魔25',cid:'005',t:''}
	   ,{name:'广东卫视',program:'阳光剧场：猎魔25',cid:'006',t:''}
	   ,{name:'山东卫视',program:'阳光剧场：猎魔25',cid:'007',t:''}
	   ,{name:'江西卫视',program:'阳光剧场：猎魔25',cid:'008',t:''}
	   ,{name:'宁夏卫视',program:'阳光剧场：猎魔25',cid:'009',t:''}
	   ,{name:'广东卫视',program:'阳光剧场：猎魔25',cid:'010',t:''}
	   ,{name:'山东卫视',program:'阳光剧场：猎魔25',cid:'011',t:''}
	   ,{name:'江西卫视',program:'阳光剧场：猎魔25',cid:'012',t:''}
	   ,{name:'宁夏卫视',program:'阳光剧场：猎魔25',cid:'013',t:''}
		]
	   ,currentIndex:10
}
   ,jsonDateData={
		today:year+"/"+month+"/"+day
}
   ,jsonProgramData={
		list:[
			{name:'上午剧场:福根进',time:'09:56',type:'回看'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'回看'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'回看'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'回看'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'回看'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'回看'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'回看'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'直播'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'预约'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'预约'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'预约'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'预约'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'预约'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'预约'}
		   ,{name:'上午剧场:福根进',time:'09:56',type:'预约'}
		]
	   ,currentIndex:7
}
,jsonChannelData2={
		list:[
			{name:'周星驰专场',program:'大话西游之仙履奇缘',cid:'001',t:''}
	   ,{name:'怀旧港片',program:'整盅专家',cid:'002',t:''}
	   ,{name:'华语经典',program:'下午茶剧场:雪豹(26)',cid:'003',t:''}
	   ,{name:'健康保健',program:'新北方：天天一身轻',cid:'004',t:''}
	   ,{name:'美食旅行',program:'荒野求生',cid:'005',t:'<div style="padding:2px 4px;">vip</div>'}
	   ,{name:'红叶动漫',program:'火影忍者（136）',cid:'006',t:''}
	   ,{name:'泡泡剧场',program:'三生三世十里桃花（15）',cid:'007',t:''}
		]
	   ,currentIndex:0
}
,jsonProgramData2={
		list:[
			{name:'功夫',time:'09:56',type:'点播'}
		   ,{name:'千王之王',time:'09:56',type:'点播'}
		   ,{name:'喜剧之王',time:'09:56',type:'点播'}
		   ,{name:'大话西游',time:'09:56',type:'点播'}
		   ,{name:'大话西游',time:'09:56',type:'点播'}
		   ,{name:'九品芝麻官',time:'09:56',type:'点播'}
		   ,{name:'逃学威龙3',time:'09:56',type:'点播'}
		]
	   ,currentIndex:0
}
var animatParas={
   		isAnimat:false
   	   ,moveUnit:{long:180,middle:120,short:60}	
   	   ,intervalTimer:20
   }
   ,gaps=document.getElementsByClassName('menu-gap')
   ,layer=-1
   ,leftArrow=document.getElementsByClassName('menu-hint-left')[0]
   ,rightArrow=document.getElementsByClassName('menu-hint-right')[0]
   ,currentInfoTimer
   ,htmlTemplates=[
	'<li class="menu-list-category">@name</li>',
	'<li>'
		+'<div class="menu-list-channel-name">@name</div>'
		+'<div class="menu-list-channel-program">@program</div>'
		+'<div class="menu-list-channel-id">@cid</div>'
		+'<div class="menu-list-channel-type">@t</div>'
	+'</li>',
	'<li>'
		+'<div class="menu-list-program-name">@name</div>'
		+'<div class="menu-list-program-time">@time</div>'
		+'<div class="menu-list-program-type">@type</div>'
	+'</li>',
	'<li>'
		+'<div class="menu-list-day">@day</div>'
		+'<div class="menu-list-date">@date</div>'
	+'</li>'
]
   ,week=['周日','周一','周二','周三','周四','周五','周六']
   ,menu={}
   ,isAnimat=false

function fnMoveInMenu(){
	var cm=menu.menus[menu.current]
	//菜单选中效果
	fnAddEleClass(cm.container,'menu-list-container-sel')
	//菜单元素选中效果
	fnAddEleClass(cm.listEles[cm.selIndex],'menu-list-content-sel')
}
function fnMoveOutMenu(){
	var cm=menu.menus[menu.current]
	//移除菜单选中效果
	fnRemoveEleClass(cm.listEles[cm.selIndex],'menu-list-content-sel')
	//移除菜单元素选中效果
	fnRemoveEleClass(cm.container,'menu-list-container-sel')
}
function fnOperateMenuLayer(key){
	if(key=='left'){
		return
		// → 分类菜单+频道菜单*   初始
		if(menu.current==-1){
			//选中频道菜单，选中菜单在右侧
			menu.current=1
			//当前菜单在屏幕的位置（用于判断显示新菜单还是切换屏幕内菜单）0：左侧；1：右侧
			//默认频道菜单，在右侧
			menu.currentInScreen=1
			fnEleAnimat(menu.container,'left',-451,0,animatParas.moveUnit.short,function(){
				var dataCategory=fnGetMenuData(0)
				fnLayoutMenu(menu.menus[0],dataCategory.currentIndex,RenderMenuList(dataCategory,htmlTemplates[0]))
                getChannelInfo(1)
				//日期 当天
            	var datas=year+"."+month+"."+day;
                timerLoadData6 = setTimeout(function() {
	            //铺数据
				if(results=="1"){
				clearTimeout(timerLoadData6)
				}else{
				//getProgramInfo(0,chanId,0,datas);
				getProgramInfo(showId,chanId,datas);
				}
                },500) 
				var dataChannel=fnGetMenuData(1)
				fnLayoutMenu(menu.menus[1],dataChannel.currentIndex,RenderMenuList(dataChannel,htmlTemplates[1]))
				//添加选中菜单样式，选中元素样式
				fnMoveInMenu()
				//显示频道菜单后的gap
				fnRemoveEleClass(gaps[menu.current],'dn')
				//显示→层
				fnRemoveEleClass(rightArrow,'dn')
			})
			return
		}
		//分类菜单+频道菜单* → 分类菜单*+频道菜单
		if(menu.current==1&&menu.currentInScreen==1){
			//移除选中菜单样式，选中元素样式
			fnMoveOutMenu()
			//选中分类菜单,选中菜单在屏幕左侧
			menu.current=0
			menu.currentInScreen=0
			//添加选中菜单样式，选中元素样式
			fnMoveInMenu()
			return
		}
		//频道菜单*+节目菜单 → 分类菜单*+频道菜单
		if(menu.current==1&&menu.currentInScreen==0){
			//移除选中菜单样式，选中元素样式
			fnMoveOutMenu()
			//移除节目菜单数据
			menu.menus[2].ele.innerHTML=''
			//隐藏节目菜单后的gap层
			fnAddEleClass(gaps[2],'dn')
			//隐藏←层
			fnAddEleClass(leftArrow,'dn')
			fnElesAnimat(menu.container,'left',-100,0,animatParas.moveUnit.short,menu.menus[2].container,'width',300,0,-animatParas.moveUnit.middle,function(){
				// //显示分类菜单
				// fnRemoveEleClass(menu.menus[0].ele,'vh')
				//选中节目菜单
				menu.current=0
				menu.currentInScreen=0
				//添加选中菜单样式，选中元素样式
				fnMoveInMenu()
				if(menu.type===1){
					fnRemoveEleClass(rightArrow.getElementsByTagName('img')[0],'dn')
				}
			})
			return
		}
		//频道菜单+节目菜单* → 频道菜单*+节目菜单
		if(menu.current==2&&menu.currentInScreen==1){
			//移除选中菜单样式，选中元素样式
			fnMoveOutMenu()
			//选中频道菜单，选中菜单在右侧
			menu.current=1
			menu.currentInScreen=0
			//移除子菜单所属频道的频道菜单元素效果
			fnRemoveEleClass(menu.menus[menu.current].listEles[menu.menus[menu.current].selIndex],'menu-list-content-sel-p')
			//添加选中菜单样式，选中元素样式
			fnMoveInMenu()
			return
		}
		//节目菜单*+日期菜单 → 频道菜单*+节目菜单
		if(menu.current==2&&menu.currentInScreen==0){
			//移除选中菜单样式，选中元素样式
            var mlpn = document.getElementsByClassName('menu-list-program-name');
			if(mlpn.length>0)
			{
			fnMoveOutMenu()
			}
			//移除日期菜单数据
			menu.menus[3].ele.innerHTML=''
			// //隐藏日期菜单
			// fnAddEleClass(menu.menus[3].ele,'dn')
			//隐藏节目菜单后的gap层
			fnAddEleClass(gaps[3],'dn')
			//隐藏←层
			fnAddEleClass(leftArrow,'dn')
			//显示→
			fnRemoveEleClass(rightArrow.getElementsByTagName('img')[0],'dn')
			fnElesAnimat(menu.container,'left',-401,-105,animatParas.moveUnit.short,menu.menus[3].container,'width',150,0,-animatParas.moveUnit.middle,function(){
				// //显示频道菜单
				// fnRemoveEleClass(menu.menus[1].ele,'vh')
				//选中节目菜单
				menu.current=1
				menu.currentInScreen=0
				//移除频道菜单选中元素的选中效果
				fnRemoveEleClass(menu.menus[menu.current].listEles[menu.menus[menu.current].selIndex],'menu-list-content-sel-p')
				//添加选中菜单样式，选中元素样式
				fnMoveInMenu()
				//显示←层
				fnRemoveEleClass(leftArrow,'dn')
			})
			return
		}
		//节目菜单+日期菜单* → 节目菜单*+日期菜单
		if(menu.current==3&&menu.currentInScreen==1){
			//移除选中菜单样式，选中元素样式			
            //移除选中菜单样式，选中元素样式update
			var mlpn = document.getElementsByClassName('menu-list-program-name');
			if(mlpn.length>0)
			{
			fnMoveOutMenu()
			}
			//添加当前效果
			fnAddEleClass(menu.menus[menu.current].listEles[menu.menus[menu.current].selIndex],'menu-list-content-current')
			//选中节目菜单
			menu.current=2
			menu.currentInScreen=0
			//添加选中菜单样式，选中元素样式
			if(mlpn.length>0)
			{
			fnMoveInMenu()
			}
			return
		}
	}
	if(key=='right'){
		return
		//分类菜单*+频道菜单 → 分类菜单+频道菜单*
		if(menu.current==0&&menu.currentInScreen==0){
			//移除选中菜单样式，选中元素样式
			fnMoveOutMenu()
			//添加子菜单的父级元素样式
			fnAddEleClass(menu.menus[menu.current].listEles[menu.menus[menu.current].selIndex],'menu-list-content-current')
			//选中频道菜单，选中菜单在右侧
			menu.current=1
			menu.currentInScreen=1
			//添加选中菜单样式，选中元素样式
			fnMoveInMenu()
			return
		}
		//分类菜单+频道菜单* → 频道菜单+节目菜单*    节目初始
		if(menu.current==1&&menu.currentInScreen==1){
			//移除选中菜单样式，选中元素样式
			fnMoveOutMenu()
			// //显示节目菜单
			// fnRemoveEleClass(menu.menus[2].ele,'dn')
			// //隐藏分类菜单，用于显示←层
			// fnAddEleClass(menu.menus[0].ele,'vh')
			fnElesAnimat(menu.container,'left',0,-105,-animatParas.moveUnit.short,menu.menus[2].container,'width',0,300,animatParas.moveUnit.middle,function(){
				//添加子菜单所属频道的频道菜单元素效果
				fnAddEleClass(menu.menus[menu.current].listEles[menu.menus[menu.current].selIndex],'menu-list-content-sel-p')
				//选中节目菜单，选中菜单在右侧
				menu.current=2
				menu.currentInScreen=1
	
				//频道id
                //var chanids=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-type')[0].innerHTML;
                //showid
                //var showid=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-id')[0].innerHTML;
				//日期 当天
            	//var datas=year+"."+month+"."+day;
                //getProgramInfo(chanids,showid,datas);
				//var dataProgram=fnGetMenuData(2)
				//fnLayoutMenu(menu.menus[menu.current],dataProgram.currentIndex,RenderMenuList(dataProgram,htmlTemplates[menu.current]))
				timerLoadData4 = setTimeout(function() {
	            //铺数据
				if(results=="1"){
				clearTimeout(timerLoadData4)
				showProgram();
				//添加选中菜单样式，选中元素样式
				fnMoveInMenu()
				}
                },500)
				
				//显示节目菜单后的gap层
				fnRemoveEleClass(gaps[menu.current],'dn')
				//显示←层
				fnRemoveEleClass(leftArrow,'dn')
				if(menu.type===1){
					//隐藏→
					fnAddEleClass(rightArrow.getElementsByTagName('img')[0],'dn')
				}
			})
			return
		}
		//频道菜单*+节目菜单 → 频道菜单+节目菜单*
		if(menu.current==1&&menu.currentInScreen==0){
			//移除选中菜单样式，选中元素样式
			fnMoveOutMenu()
			//添加子菜单所属频道的频道菜单元素效果
			fnAddEleClass(menu.menus[menu.current].listEles[menu.menus[menu.current].selIndex],'menu-list-content-sel-p')
			//选中节目菜单
			menu.current=2
			menu.currentInScreen=1
			//添加选中菜单样式，选中元素样式
			var mlpn = document.getElementsByClassName('menu-list-program-name');
			if(mlpn.length>0)
			{
			fnMoveInMenu()
			}			
            return
		}
		//频道菜单+节目菜单* → 节目菜单+日期菜单*
		if(menu.current==2&&menu.currentInScreen==1){
			if(menu.type===1){
				return
			}
			//移除选中菜单样式，选中元素样式
			var mlpn = document.getElementsByClassName('menu-list-program-name');
			if(mlpn.length>0)
			{
			fnMoveOutMenu()
			} 
        	//隐藏←层
			fnAddEleClass(leftArrow,'dn')
			// //显示节目菜单
			// fnRemoveEleClass(menu.menus[3].ele,'dn')
			// //隐藏节目菜单后的gap层
			// fnAddEleClass(gaps[3],'dn')
			// //隐藏分类菜单，用于显示←层
			// fnAddEleClass(menu.menus[1].ele,'vh')
			fnElesAnimat(menu.container,'left',-100,-401,-animatParas.moveUnit.middle,menu.menus[3].container,'width',0,150,animatParas.moveUnit.short,function(){
				//显示←层
				fnRemoveEleClass(leftArrow,'dn')
				//选中日期菜单，选中菜单在右侧
				menu.current=3
				menu.currentInScreen=1
				var dataDate=fnGetMenuData(3)
				fnLayoutMenu(menu.menus[menu.current],dataDate.currentIndex,RenderMenuList(dataDate,htmlTemplates[menu.current]))
				//添加选中菜单样式，选中元素样式
				fnMoveInMenu()
				fnRemoveEleClass(gaps[menu.current],'dn')
				//隐藏→
				fnAddEleClass(rightArrow.getElementsByTagName('img')[0],'dn')
			})
			return
		}
		//节目菜单*+日期菜单 → 节目菜单+日期菜单*
		if(menu.current==2&&menu.currentInScreen==0){
			//移除选中菜单样式，选中元素样式
			fnMoveOutMenu()
			//选中节目菜单
			menu.current=3
			menu.currentInScreen=1
			//添加选中菜单样式，选中元素样式
			fnMoveInMenu()
			return
		}
	}
	if(key=='up'){
		//当前菜单
		var currentMenuList=menu.menus[menu.current].ele
		//当前菜单元素
		var currentMenuListEles=menu.menus[menu.current].listEles
		//当前选中元素索引
		var currentMenuListEleIndex=menu.menus[menu.current].selIndex
		//当前选中元素在屏幕内索引
		var currentMenuListEleIndexInScreen=menu.menus[menu.current].selIndexInScreen
		//非列表第一个元素
		if(currentMenuListEleIndex>0){
			
			//当选中元素在屏幕内的索引到达边界但没到达列表边界时，滚动
			//上边界
			if(menu.menus[menu.current].selIndexInScreen==0&&currentMenuListEleIndex>0){
				menu.menus[menu.current].container.scrollTop-=100
			}
			//移除当前选中元素的选中效果
			fnRemoveEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel')
			//改变选中列表元素在列表内索引
			currentMenuListEleIndex--
			//改变选中列表元素在屏幕内索引
			currentMenuListEleIndexInScreen>0&&currentMenuListEleIndexInScreen--
			//添加新选中元素的选中效果
			fnAddEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel')
			//更新选中元素在列表内索引
			menu.menus[menu.current].selIndex=currentMenuListEleIndex
			//更新列表元素在屏幕内索引，最大值为屏幕内显示元素数量-1
			menu.menus[menu.current].selIndexInScreen=currentMenuListEleIndexInScreen
			//更改菜单，节目数据，如果是类型菜单需更新专题菜单和影片，如果是专题菜单更新影片
			
			//类型菜单、日期菜单逻辑：当前、选中永远是同一个
			if(menu.current==0||menu.current==3){
                //移动导航 改变频道
                if(menu.current==0)	
                	{
                	getChannelInfo(currentMenuListEleIndex+1);
    				var dataChannel=fnGetMenuData(1);
                	fnLayoutMenu(menu.menus[1],dataChannel.currentIndex,RenderMenuList(dataChannel,htmlTemplates[1]))
                	}
                //移动日期 改变节目
                if(menu.current==3)	
            	{
                    //频道id
                    var chanids=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-type')[0].innerHTML;
                    //showid
                    var showid=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-id')[0].innerHTML;
                    //日期
                	var datas=currentMenuListEles[currentMenuListEleIndex].getElementsByClassName('menu-list-date')[0].innerHTML.replace(/-/g,".");
                	showJz();
                    getProgramInfo(chanids,showid,datas); 
                   timerLoadData5 = setTimeout(function() {
	            //铺数据
				if(results=="1"){
				clearTimeout(timerLoadData5)
				showProgram();
				}
                },500)

            	}
				//移除选中效果
				fnRemoveEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-current')
			}
			//移动频道 改变节目
			if(menu.current==1)	
        	{
					//频道id
	                var chanids=currentMenuListEles[currentMenuListEleIndex].getElementsByClassName('menu-list-channel-type')[0].innerHTML;
	                //频道id
	                var showid=currentMenuListEles[currentMenuListEleIndex].getElementsByClassName('menu-list-channel-id')[0].innerHTML;
	            	//日期 当天1
	            	var datas=year+"."+month+"."+day;
                    showJz();
	                getProgramInfo(chanids,showid,datas);
					timerLoadData2 = setTimeout(function() {
	            //铺数据
				if(results=="1"){
				clearTimeout(timerLoadData2)
				showProgram();
				}
                },500)
//					var dataProgram=fnGetMenuData(2);
//					fnLayoutMenu(menu.menus[2],dataProgram.currentIndex,RenderMenuList(dataProgram,htmlTemplates[2]));

        	}
		}
	}
	if(key=='down'){
		//当前菜单ul
		var selMenuList=menu.menus[menu.current].ele
		//选中菜单元素
		var selMenuListEles=menu.menus[menu.current].listEles
		//选中选中元素在列表内索引
		var selMenuListEleIndex=menu.menus[menu.current].selIndex
		//选中选中元素在屏幕内索引
		var selMenuListEleIndexInScreen=menu.menus[menu.current].selIndexInScreen
		
		if(selMenuListEleIndex<selMenuListEles.length-1){//不是列表最后一个元素
			
			//当选中元素在屏幕内的索引到达边界但没到达列表边界时，滚动
			//下边界，不是列表最后的元素
			if(selMenuListEleIndexInScreen==menu.lengthInScreen-1&&selMenuListEleIndex<selMenuListEles.length-1){
				menu.menus[menu.current].container.scrollTop+=100
			}
			//移除选中元素的选中效果
			fnRemoveEleClass(selMenuListEles[selMenuListEleIndex],'menu-list-content-sel')
			//改变选中列表元素在列表内索引
			selMenuListEleIndex++
			//改变选中列表元素在屏幕内索引
			selMenuListEleIndexInScreen<menu.lengthInScreen-1&&selMenuListEleIndexInScreen++
			//添加新选中元素的选中效果
			fnAddEleClass(selMenuListEles[selMenuListEleIndex],'menu-list-content-sel')
			//更新选中元素在列表内索引
			menu.menus[menu.current].selIndex=selMenuListEleIndex
			//更新列表元素在屏幕内索引，最大值为屏幕内显示元素数量-1
			menu.menus[menu.current].selIndexInScreen=selMenuListEleIndexInScreen
			//更改菜单，节目数据，如果是类型菜单需更新专题菜单和影片，如果是专题菜单更新影片
			
			
			//类型菜单、日期菜单逻辑：当前、选中永远是同一个
			if(menu.current==0||menu.current==3){
                //移动导航 改变频道
                if(menu.current==0)	
                	{
                	getChannelInfo(selMenuListEleIndex+1);
    				var dataChannel=fnGetMenuData(1);
                	fnLayoutMenu(menu.menus[1],dataChannel.currentIndex,RenderMenuList(dataChannel,htmlTemplates[1]))
                	//重置频道
					menu.menus[1].container.scrollTop=0;
                    //移除选中效果
				    fnRemoveEleClass(selMenuListEles[selMenuListEleIndex],'menu-list-content-current')
					}
                //移动日期 改变节目
                if(menu.current==3)	
            	{
                //频道id
                var chanids=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-type')[0].innerHTML;
                //showid
                var showid=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-id')[0].innerHTML;
                
				//日期
            	var datas=selMenuListEles[selMenuListEleIndex].getElementsByClassName('menu-list-date')[0].innerHTML.replace(/-/g,".");
            	showJz();
                getProgramInfo(chanids,showid,datas);
                 timerLoadData5 = setTimeout(function() {
	            //铺数据
				if(results=="1"){
				menu.menus[2].container.scrollTop=0;
				clearTimeout(timerLoadData5)
				showProgram();
				//移除选中效果
				fnRemoveEleClass(selMenuListEles[selMenuListEleIndex],'menu-list-content-current')
				}
                },500)
//				var dataProgram=fnGetMenuData(2)
//				fnLayoutMenu(menu.menus[2],dataProgram.currentIndex,RenderMenuList(dataProgram,htmlTemplates[2]))
            	}
     			}
			//移动频道 改变节目
			if(menu.current==1)	
        	{
				//频道id
                var chanids=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-type')[0].innerHTML;
                //showid
                var showid=menu.menus[1].listEles[menu.menus[1].selIndex].getElementsByClassName('menu-list-channel-id')[0].innerHTML;
                //日期 当天
                if(typeof(chanids)!="undefined")
				{
            	var datas=year+"."+month+"."+day;
                showJz();
                getProgramInfo(chanids,showid,datas);
                timerLoadData2 = setTimeout(function() {
	            //铺数据
				if(results=="1"){
				clearTimeout(timerLoadData2)
				showProgram();
				}
                },500)
                }
//				var dataProgram=fnGetMenuData(2);
//				fnLayoutMenu(menu.menus[2],dataProgram.currentIndex,RenderMenuList(dataProgram,htmlTemplates[2]));
            	
        	}
		}
	}
	if(key=="back"){
	    top.hideOSD();
	    //parent.location.reload(); 
		//移除选中菜单效果
		fnMoveOutMenu()
		//移除节目菜单、日期菜单数据
		menu.menus[2].ele.innerHTML=''
		menu.menus[3].ele.innerHTML=''
		//隐藏节目菜单、日期菜单
		fnUpdateEleStyle(menu.menus[2].container,'width',0)
		fnUpdateEleStyle(menu.menus[3].container,'width',0)
		//隐藏节目菜单、日期菜单后的缝隙
		fnAddEleClass(gaps[3],'dn')
		fnAddEleClass(gaps[2],'dn')
		//隐藏←层
		fnAddEleClass(leftArrow,'dn')
		fnEleAnimat(menu.container,'left',menu.container.offsetLeft,-451,-animatParas.moveUnit.short,function(){
			menu.menus[0].ele.innerHTML=''
			menu.menus[1].ele.innerHTML=''
			//隐藏频道菜单后的gap
			fnAddEleClass(gaps[1],'dn')
			//显示→，隐藏→层
			fnAddEleClass(rightArrow,'dn')
			fnRemoveEleClass(rightArrow.getElementsByTagName('img')[0],'dn')
			menu.current=-1
			layer=-1
		})
	}
	if(key=='ok'){
		if(menu.current==1){
			//频道id
        var chanid=menu.menus[menu.current].listEles[menu.menus[menu.current].selIndex].getElementsByClassName('menu-list-channel-id')[0].innerHTML;
		window.location.href="channel_detail.jsp?mixno="+chanid;
		} 
		if(menu.current==2){
			programGo(menu.menus[menu.current].selIndex);
		}
	}
}
function showJz()
{
var mlpn = document.getElementsByClassName('menu-list-program-name')
	var mlpt = document.getElementsByClassName('menu-list-program-time')
	for (var i = 0; i < mlpn.length; i++) {
		mlpn[i].innerHTML = '数据加载中...'
		mlpt[i].innerHTML = '数据加载中...'
	}
}
function showProgram()
{   
	if(progCurrentInfo_JS.length==0)
	{
	getProgramInfo1();
	}
	var dataProgram=fnGetMenuData(2)
	fnLayoutMenu(menu.menus[2],dataProgram.currentIndex,RenderMenuList(dataProgram,htmlTemplates[2]))	
}
function fnGetMenuData(menuid){
    if(menuid==0){
		return jsonCategoryData
	}
	if(menuid==1){
		return jsonChannelData
	}
	if(menuid==2){
		return jsonProgramData
	}
	if(menuid==3){
		fnSetDateMenuData(new Date(jsonDateData.today))
		return jsonDateData
	}
}

//模板+数据生成html代码
//props可以传入指定替换的属性
function RenderMenuList(jsonData,template,props){
	var data=jsonData.list[0]
	//生成的菜单html
    var html=''
    //单个模板替换数据后的html
    var templateHTML=template
	//拼模板
	for (var i = 0; i < jsonData.list.length; i++) {
		for(var key in jsonData.list[i]){  
		   templateHTML=templateHTML.replace('@'+key,jsonData.list[i][key])
		}
		//可以指定属性替换
		// for(var j=0;j<props.length;j++){
		// 	templateHTML=template.replace('@'+props[j],jsonData.list[i][props[j]])
		// }
		html+=templateHTML
		templateHTML=template
	}
	return html
}

//加载菜单元素，并设置当前元素参数，调整菜单布局（不满屏的占位，当前元素移到屏幕中间）
function fnLayoutMenu(menu,currentIndex,html){
	menu.ele.innerHTML=html
	//保存添加的菜单元素dom缓存
	menu.listEles=menu.ele.getElementsByTagName('li')
	//设置菜单当前元素索引
	menu.selIndex=currentIndex
	//设置菜单选中元素索引，默认当前元素即选中元素
	menu.currentIndex=currentIndex
	//添加当前效果
	fnAddEleClass(menu.listEles[currentIndex],'menu-list-content-current')
	//调整菜单元素布局
	fnIniMenuLocationInScreen(menu)
}
//调整菜单布局（不满屏的上方占位，当前元素移动到屏幕中间，并设置屏幕内元素索引）
function fnIniMenuLocationInScreen(ele){
	//当前元素在屏幕外
	if(ele.currentIndex>=menu.lengthInScreen){
		//菜单在初始化时，列表内索引为3的元素（也就是第四个元素）会在屏幕中间（屏幕内元素个数为7）。
		//列表内索引为7的元素要移到索引为3的元素的位置。位移为（currentIndex-3）*height
		//如果移动距离超过最大滚动距离，则会设置为滚动最大距离，即（scrollHeight-clientheight）
		//ele.container.scrollTop=100*(ele.currentIndex-3)
		//如果移动距离超过最大滚动距离,不能移动到屏幕中间
		if(100*(ele.currentIndex-3)>(ele.container.scrollHeight-ele.container.clientHeight)){
			ele.container.scrollTop=ele.container.scrollHeight-ele.container.clientHeight
			//设置选中元素在屏幕内的索引。屏幕元素数量-选中元素下方的数量=选中元素在屏幕中是第几个。
			ele.selIndexInScreen=menu.lengthInScreen-(ele.listEles.length-1-ele.selIndex)-1
		}else{//当前在屏幕中间
			ele.container.scrollTop=100*(ele.currentIndex-3)
			//设置选中元素在屏幕内的索引
			ele.selIndexInScreen=3
		}
	}else{//元素在屏幕内
		//在屏幕下方
		if(ele.currentIndex>=3){
			//如果移动距离超过最大滚动距离,不能移动到屏幕中间
			if(100*(ele.currentIndex-3)>(ele.container.scrollHeight-ele.container.clientHeight)){
				ele.container.scrollTop=ele.container.scrollHeight-ele.container.clientHeight
				//设置选中元素在屏幕内的索引
				ele.selIndexInScreen=menu.lengthInScreen-1-(ele.listEles.length-1-ele.selIndex)
				//console.log(ele.selIndexInScreen)
			}else{//当前在屏幕中间
				ele.container.scrollTop=100*(ele.currentIndex-3)
				//设置选中元素在屏幕内的索引
				ele.selIndexInScreen=3
			}
		}else{
			//设置选中元素在屏幕内的索引
			ele.selIndexInScreen=ele.currentIndex
		}
		
	}
	//菜单元素个数少于一屏显示个数，让菜单垂直居中
	if(ele.listEles.length<menu.lengthInScreen){
		// var topPlaceholderLength=Math.floor((menu.lengthInScreen-ele.listEles.length)/2)
		var topPlaceholderLength=(menu.lengthInScreen-ele.listEles.length)/2
		fnUpdateEleStyle(ele.ele,'margin-top',topPlaceholderLength*100+'px')
		//设置选中元素在屏幕内的索引
		ele.selIndexInScreen=ele.currentIndex+topPlaceholderLength
	}
	else {
		fnUpdateEleStyle(ele.ele,'margin-top',0+'px')
	}
}
//根据当前时间生成日期菜单jason数据
function fnSetDateMenuData(date){
	var startDate=fnMinusDate(date,6)
	jsonDateData.list=[]
	jsonDateData.currentIndex=0
	for(var i=6;i>=0;i--){
		var dateData={}
		var d=fnAddDate(startDate,i)
		var years=fnFormatDate(d).split("-")[0];
		var months=fnFormatDate(d).split("-")[1];
		if(months<10)
		{
		months="0"+months;
		}
		var days=fnFormatDate(d).split("-")[2];
		if(days<10)
		{
		days="0"+days;
		}
		dateData.date=years+"."+months+"."+days;
		dateData.day=week[d.getDay()]
		jsonDateData.list.push(dateData)
	}
}
function fnIniMenuParas(){
	//所有菜单的大容器(div)dom缓存，通过改变left值移入移出菜单
	menu.container=document.getElementsByClassName('menu-container')[0]
	//各菜单的容器(div)dom缓存
	var mls=menu.container.getElementsByClassName('menu-list-container')
	//当前菜单索引：-1：隐藏菜单；
	menu.current=-1

	//屏幕内菜单元素的行数，用于判断菜单是否上下移动（改变scrollTop值）
	menu.lengthInScreen=7
	//用于存放各个菜单参数
	menu.menus=[]
	for(var i=0;i<mls.length;i++){
		var menuInfo={}
		//每个菜单的容器(div)dom缓存
		menuInfo.container=mls[i]
		//每个菜单的(ul)dom缓存
		menuInfo.ele=mls[i].getElementsByClassName('menu-list')[0]
		menu.menus.push(menuInfo)
	}
	menu.type=0

}

function getChannelInfo1(typeid){
	jsonChannelData.list=[{name:'辽宁卫视11',program:'阳光剧场：猎魔25',cid:'001',t:'aa'}
	   ,{name:'广东卫视',program:'阳光剧场：猎魔25',cid:'002',t:''}];

	jsonChannelData.currentIndex=0;
}
//获取频道信息
function getChannelInfo(typeid){
var array = [];

	var data = chanList;
	if(typeid==0)
	{
	data = chanList1
	}
	if(typeid==1)
	{
	data = chanList
	}
	if(typeid==2)
	{
	data = chanList1
	}
	if(typeid==3)
	{
	data = chanList2
	}
	if(typeid==4)
	{
	data = chanList3
	}
	if(typeid==5)
	{
	data = chanList4
	}
	if(typeid==6)
	{
	data = chanList5
	}
	if(typeid==7)
	{
	data = chanList6
	}
	if(typeid==8)
	{
	data = chanList7
	}
	
    var xz=0;
	for(var i = 0;  i<data.length; i++){
    var programname=data[i].progName;
		if(programname.length>8){
			programname=programname.substring(0,7)+"...";
		}
		if(data[i].channelIndex==chanId)
			{
			xz=i;
			}
	     var temp = {name:data[i].channelName_cut,program:programname,cid:data[i].channelIndex,t:data[i].channelcode};

	     array.push(temp)

	}
	jsonChannelData.list=array;
	jsonChannelData.currentIndex=xz;

	
}
function showjson()
{
var array = [];  
	var data =progCurrentInfo_JS;
	var xs=0;
	var programname="";
	var type="";
	for(var i = 0;  i<data.length; i++){
	     programname=data[i].progName;
			if(programname.length>8){
				programname=programname.substring(0,7)+"...";
			}
			 if (data[i].tvod ==1)
			{
				type="直播";
				xs=i;
			}
			else 
			{   
			if(data[i].palyable=="true"&&data[i].recordsystem=='1'){
				type="回看";
				}
			else{type="无信息";}
			}
		     var temp = {name:programname,time:data[i].progStartTime,type:type};

		     array.push(temp)

		}
	jsonProgramData.list=array;
	jsonProgramData.currentIndex=xs;

}
var progCurrentInfo_JS="";
var results="";
function getProgramInfo(chanIds,showid,getDateStr){  
results="0";
loadFilmData(chanIds,showid,getDateStr);
timerLoadData1 = setTimeout(function() {
	//获取数据
	if(results=="1")
	{
	clearTimeout(timerLoadData1)
	showjson();
	}
    },500)
}

function getProgramInfo1(d){  
jsonProgramData.list=[{name:'暂无记录',time:'',type:''}
];
jsonProgramData.currentIndex=0;

}
//获取回看节目
function loadFilmData(chanIds,showid,getDateStr)
{  
//var channelid=menu.menus[1].listEles[menu.menus[1].selIndex+1].getElementsByClassName('menu-list-channel-type')[0].innerHTML;
//var showid=menu.menus[1].listEles[menu.menus[1].selIndex+1].getElementsByClassName('menu-list-channel-id')[0].innerHTML;    
recommDataIfr.location.href = "hk-detaildata.jsp?channelid="+chanIds+"&date="+getDateStr+"&showid="+showid;
}


