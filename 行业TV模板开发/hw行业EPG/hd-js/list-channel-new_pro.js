//menu={
//	state:-1：未展开，0：专题菜单，1：类型菜单+专题菜单
//	container:菜单容器dom缓存，用于展开
//	menus:[
//		{
//			ele:菜单容器dom缓存,用于上下移动
//			selIndex:选中行索引
//			currentIndex:当前行索引
//		}
//	]
//}
// program={
// 	current:{
// 		listIndex:
// 		colIndex:
// 		rowIndex:
// 		ele:
// 	}
// 	programLists:[
// 		{
// 			ele:
// 			rows:[
// 				{
// 					programs:
// 				}
// 			]
// 		}
// 	]
// }

var menu={}
   ,program={}
   ,menuHint=document.getElementsByClassName('menu-hint')[0]
   ,animatParas={
   	    programListOutDesPos:{top:-652,bottom:652}	
   	   ,moveUnit:{long:150,middle:120,short:60}	
   	   ,intervalTimer:20
   }
   ,isAnimat=false
   ,arrowUp=document.getElementById("arrowUp")
   ,arrowDown=document.getElementById("arrowDown")
      var flag = 0;
//元素高度
var channelHeight;
//获取channel元素的长度
var channelLen;
//channel总行数
var channelRow;
//每次移动的距离
var moveLength;
//获取方框DOM元素
var square;
var ranges

function keyLeft(){
	if(isAnimat){
		return
	}
	//没有菜单情况下
	if(menu.current==-1){
		//光标在节目列表最左侧，呼出所属专题菜单（左提示+专题菜单），光标进入专题菜单
		if(program.current.channelIndex%4===0&&program.current.subIndex===0){
			//去掉节目选中效果
			fnRemoveCurrentStyle()
			//改变菜单状态标识为显示专题菜单
			menu.current=0
			//为当前菜单添加背景色
			//fnAddEleClass(menu.menus[menu.current].ele,'menu-list-container-sel')
			fnAddEleClass(document.getElementById('search'),'search-sel')
			fnAddEleClass(menu.menus[menu.current].subEles[menu.menus[menu.current].selIndex],'menu-list-content-sel')
			fnRemoveEleClass(menu.menus[menu.current].subEles[menu.menus[menu.current].selIndex],'menu-list-content-current')
		}else{//在节目列表移动光标
			fnRemoveCurrentStyle()
			var ci=program.current.channelIndex
			   ,si=program.current.subIndex
			if(program.current.linkType==='content'){
				ci--
				si=0
			}else{
				si=0
			}
			fnIniProgramCurrent(ci,si)
			fnAddCurrentStyle()
		}
	}
}

function keyRight(){
	if(isAnimat){
		return
	}
	//没有菜单
	if(menu.current==-1){
		if(program.current.channelIndex===program.total-1 || program.current.channelIndex%4==3){
			return
		}
		//屏幕最后一列，换行
		if(program.current.channelIndex%4===2&&program.current.subIndex===1){
			// //屏幕最后一行换屏
			// if(program.current.rowIndex==1){
			// 	//最后一屏
			// 	if(program.current.listIndex==program.programLists.length-1){
			// 		return
			// 	}
			// 	//移除选中节目
			// 	fnRemoveCurrentStyle()
			// 	//选中下一屏的第一个节目
			// 	fnIniProgramCurrent(program.current.listIndex+1,0,0)
			// 	//显示下一节目单
			// 	fnRemoveEleClass(program.programLists[program.current.listIndex].ele,'dn')
			// 	fnMoveInNextList()
				//return
			//}
			
			return
		}
		fnRemoveCurrentStyle()
		//选中右侧节目
		var ci=program.current.channelIndex
		   ,si=program.current.subIndex

		if(program.current.linkType==='content'){
			ci++
			si=0
		}else{
			ci++
			si=0
		}
		fnIniProgramCurrent(ci,si)
		fnAddCurrentStyle()
	}else{//有菜单
		// program.selIndexInScreen=0;
		fnRemoveEleClass(menu.menus[menu.current].ele,'menu-list-container-sel')
		fnRemoveEleClass(document.getElementById('search'),'search-sel')
		fnRemoveEleClass(menu.menus[menu.current].subEles[menu.menus[menu.current].selIndex],'menu-list-content-sel')
		fnAddEleClass(menu.menus[menu.current].subEles[menu.menus[menu.current].selIndex],'menu-list-content-current')
		//改变菜单状态标识为不显示菜单
		menu.current=-1
		fnAddCurrentStyle()
	}
}
//显示选中菜单数据，增加列表元素选中、当前效果
function fnEffectSelMenu(){
	var currentMenu=menu.menus[menu.current]
	//为当前菜单添加背景色
	fnAddEleClass(currentMenu.ele,'menu-list-container-sel')
	//ul显示数据
	fnRemoveEleClass(currentMenu.menu,'dn')
	//fnAddEleClass(currentMenu.subEles[currentMenu.currentIndex],'menu-list-content-current')
}

function fnMoveInNextList(){
	var imgSel=arrowDown.getAttribute('data-src')
	var imgUnSel=arrowDown.getAttribute('src')
	arrowDown.setAttribute('src',imgSel)
	fnElesAnimat(program.programLists[program.current.listIndex-1].ele,'top',0,animatParas.programListOutDesPos.top,-animatParas.moveUnit.long,program.programLists[program.current.listIndex].ele,'top',animatParas.programListOutDesPos.bottom,0,-animatParas.moveUnit.long,function(){
		arrowDown.setAttribute('src',imgUnSel)
		arrowDown.setAttribute('data-src',imgSel)
		fnAddCurrentStyle()
		fnLoadData()
	})
}
var curMenuIndex = 0;
function keyUp(){
	if(isAnimat){
		return
	}
	if (menu.current==-1) {
		//首行
		if(program.current.channelIndex<4){
			return
		}
		//屏幕首行，且上面有数据
		if(program.selIndexInScreen===0){//&&program.current.channelIndex>=3
			panel.scrollTop-=103
			flag--;
			ranges = 40+flag*moveLength;
			square.style.top = ranges+'px';
		}
		fnRemoveCurrentStyle()
		//选中右侧节目
		var ci=program.current.channelIndex
		   ,si=program.current.subIndex
		ci-=4
		loadcurlinenumber(ci);
		fnIniProgramCurrent(ci,si)
		fnAddCurrentStyle()
		program.selIndexInScreen>0&&program.selIndexInScreen--

	}else{//有菜单，菜单光标上移
		//选中菜单
		var currentMenu=menu.menus[menu.current]
		if(currentMenu.selIndex>0){
			//当选中元素在屏幕内的索引到达边界但没到达列表边界时，滚动
			//上边界
			if(currentMenu.selIndexInScreen==0&&currentMenu.selIndex>0){
				currentMenu.ele.scrollTop-=72
			}
			//移除当前选中元素的选中效果
			fnRemoveEleClass(currentMenu.subEles[currentMenu.selIndex],'menu-list-content-sel')
			//改变选中列表元素索引
			currentMenu.selIndex--;
			curMenuIndex = currentMenu.selIndex;
			//改变选中列表元素在屏幕内索引
			currentMenu.selIndexInScreen>0&&currentMenu.selIndexInScreen--
			//添加新选中元素的选中效果
			fnAddEleClass(currentMenu.subEles[currentMenu.selIndex],'menu-list-content-sel')
			//更改菜单，节目数据，如果是类型菜单需更新专题菜单和影片，如果是专题菜单更新影片
			//更改导航
			fnUpdateProgramNav(currentMenu.subEles[currentMenu.selIndex].innerHTML);
			
			loadchanlist(currentMenu.selIndex);
			panel.scrollTop = 0;
			document.getElementById('currentPage').innerHTML= 1;
			flag = 0;
			square.style.top = '40px';
			channelLen = document.getElementsByClassName('channel').length;
			//channel总行数
			channelRow = Math.ceil(channelLen/4);
			//每次移动的距离
			moveLength = (652-38)/(channelRow-6);
			refreshpro();
		    fnIniProgramCurrent(0,0,0);
		}
	}
}

function keyDown(){
	if(isAnimat){
		return
	}
	//没有菜单，选中节目
	if(menu.current==-1){
		//最后一行
		if(program.current.channelIndex+4>program.total-1){
			return
		}
		//显示非首屏
		if(program.selIndexInScreen>=program.lengthInScreen-1){
			// //最后一行
			// if(program.programLists.length-1-program.current.channelIndex<3){
			// 	return
			// }
			panel.scrollTop+=103
			flag++
			ranges = 40+flag*moveLength;
			square.style.top = ranges+'px';
		}
		fnRemoveCurrentStyle()
		var ci=program.current.channelIndex
		   ,si=program.current.subIndex
		ci+=4
		loadcurlinenumber(ci);
		fnIniProgramCurrent(ci,si)
		fnAddCurrentStyle()
		program.selIndexInScreen<5&&program.selIndexInScreen++
	}else{//有菜单，菜单光标下移
		//选中菜单
		var currentMenu=menu.menus[menu.current]
		if(currentMenu.selIndex<currentMenu.subEles.length-1){//不是列表最后一个元素
			//当选中元素在屏幕内的索引到达边界但没到达列表边界时，滚动
			//下边界，不是列表最后的元素
			if(currentMenu.selIndexInScreen==menu.lengthInScreen-1&&currentMenu.selIndex<currentMenu.subEles.length-1){
				currentMenu.ele.scrollTop+=73
			}
			//移除当前选中元素的选中效果
			fnRemoveEleClass(currentMenu.subEles[currentMenu.selIndex],'menu-list-content-sel')
			fnRemoveEleClass(menu.menus[menu.current].subEles[menu.menus[menu.current].selIndex],'menu-list-content-current')
			//改变选中列表元素在列表内索引
			currentMenu.selIndex++;
			curMenuIndex = currentMenu.selIndex;
			//改变选中列表元素在屏幕内索引
			currentMenu.selIndexInScreen<menu.lengthInScreen-1&&currentMenu.selIndexInScreen++
			//添加新选中元素的选中效果
			fnAddEleClass(currentMenu.subEles[currentMenu.selIndex],'menu-list-content-sel')
			//更改菜单，节目数据，如果是类型菜单需更新专题菜单和影片，如果是专题菜单更新影片
			//更改导航
			fnUpdateProgramNav(currentMenu.subEles[currentMenu.selIndex].innerHTML);
			loadchanlist(currentMenu.selIndex);
			panel.scrollTop = 0;
			document.getElementById('currentPage').innerHTML= 1;
			flag = 0;
			square.style.top = '40px';
			channelLen = document.getElementsByClassName('channel').length;
			//channel总行数
			channelRow = Math.ceil(channelLen/4);
			//每次移动的距离
			moveLength = (652-38)/(channelRow-6);
			refreshpro();
		    fnIniProgramCurrent(0,0,0);
		}
	}
}
function fnCalculateIndex(){
	return program.current.listIndex*10+program.current.rowIndex*5+program.current.colIndex
}
function fnUpdateProgramNav(menuContent){
	var content=menuContent
	if(menuContent.indexOf('<img')>=0){
		//content=''
		return;
	}
	document.getElementById('programNav').innerHTML=content
}

function fnLoadData(ele){
    //document.getElementById('currentPage').innerHTML=program.current.listIndex+1
}

function fnRemoveData(ele){
}
			
//获得菜单的dom结构
function fnIniParas(){
	panel=document.getElementsByClassName('part-list')[0]
	var mls=document.getElementsByClassName('menu-list-container')
	menu.current=0
	menu.lengthInScreen=9
	menu.container=document.getElementsByClassName('area-menu')[0]
	menu.menus=[]
	for(var i=0;i<mls.length;i++){
		var menuInfo={}
		menuInfo.ele=mls[i]
		//------在加载数据时候用到--------
		//设置选中行索引
		menuInfo.selIndex=0
		//设置当前播放节目索引
		menuInfo.currentIndex=0
		//设置选中元素在屏幕内的索引
		menuInfo.selIndexInScreen=0
		//列表ul
		menuInfo.menu=mls[i].getElementsByClassName('menu-list')[0]
		//当前菜单元素
		menuInfo.subEles=mls[i].getElementsByTagName('li')
		menu.menus.push(menuInfo)
	}
	//初始化节目单
	var cls=document.getElementsByClassName('channel')
	//用于存放节目单dom缓存
	program.programLists=[]
	program.current={}
	program.total=cls.length;
	program.lengthInScreen=6
	//遍历节目单
	for(var j=0;j<cls.length;j++){
		var pl=cls[j]
		//节目单dom缓存
		var plEle={}
		plEle.ele=pl
		plEle.eles=[]
		plEle.eles[0]=pl.getElementsByClassName('channel-content')[0]//直播链接
		// //用于存放节目单每行节目dom缓存
		// plEle.rows=[[],[]]
		// var currentRowIndex=0
		// //将节目分别缓存到rows数组中
		// for(var pi=0;pi<ps.length;pi++){
		// 	//每节目单两行，每行5个节目
		// 	var ri=pi>=5?1:0
		// 	plEle.rows[ri].push(ps[pi])
		// }
		program.programLists.push(plEle)
	}
	fnIniProgramCurrent(0,0)
	program.selIndexInScreen=0
}
function refreshpro(){
		//初始化节目单
	var cls=document.getElementsByClassName('channel')
	//用于存放节目单dom缓存
	program.programLists=[]
	program.current={}
	program.total=cls.length;
	program.lengthInScreen=6
	//遍历节目单
	for(var j=0;j<cls.length;j++){
		var pl=cls[j]
		//节目单dom缓存
		var plEle={}
		plEle.ele=pl
		plEle.eles=[]
		plEle.eles[0]=pl.getElementsByClassName('channel-content')[0]//直播链接
		// //用于存放节目单每行节目dom缓存
		// plEle.rows=[[],[]]
		// var currentRowIndex=0
		// //将节目分别缓存到rows数组中
		// for(var pi=0;pi<ps.length;pi++){
		// 	//每节目单两行，每行5个节目
		// 	var ri=pi>=5?1:0
		// 	plEle.rows[ri].push(ps[pi])
		// }
		program.programLists.push(plEle)
	}
}
//设置current对象
function fnIniProgramCurrent(ci,si){
	program.current.channelIndex=ci
	program.current.subIndex=si
	program.current.ele=fnCacheCurrentEle()
	program.current.linkType=si===0?"content":"link"
}
//获得当前节目元素
function fnCacheCurrentEle(){
	return program.programLists[program.current.channelIndex].eles[program.current.subIndex]
}
function fnIniLayout(){
	//fnAddCurrentStyle()
	fnAddEleClass(menu.menus[0].subEles[menu.menus[0].selIndex],'menu-list-content-current')
}
window.onload=function(){
	loadchanlist(0);
	fnIniParas();
	fnIniLayout();
	var ref = '';  
	 if (document.referrer.length > 0) {  
	  ref = document.referrer;  
	 }  
	 try {  
	  if (ref.length == 0 && opener.location.href.length > 0) {  
	   ref = opener.location.href;  
	  }  
	 } catch (e) {} 
	 
	 
	 	var vodUrl = window.location.href;
    var zxdownindex = Util.getURLParameter("zxdownindex",vodUrl)==""?0:Util.getURLParameter("zxdownindex",vodUrl);
		
		
		if(zxdownindex != "null"&&zxdownindex!=""&&zxdownindex!="undefined"){
		
		for(var i=0;i<Number(zxdownindex);i++){
			 keyDown();
			 isAnimat = false;
		  }
		
	    }
	 
	 
	 
	
	if(ref.indexOf("play_ControlChannel")>=0 || ref.indexOf("zb-channellist")>=0 ||ref.indexOf("hk-detail")>=0){
		keyLeft();
		isAnimat = false;
		  var fdown = getCookie("zbtempmenuindex");
		  for(var i=0;i<Number(fdown);i++){
			 keyDown();
			 isAnimat = false;
		  }
		  keyRight();
		  isAnimat = false;
		  var totalmove = getCookie("zblistchanindex");
		  var fright = totalmove%4;
		  var sdown = (totalmove-fright)/4;
		  for(var j=0;j<Number(sdown);j++){
			  keyDown();
			  isAnimat = false;
		  }
		  for(var k=0;k<Number(fright)*2;k++){
			  keyRight();
			  isAnimat = false;
		  }
		  if(ref.indexOf("hk-detail")>=0){
			   keyRight();
		  }
    }
	//获取channel元素的长度
	channelLen = document.getElementsByClassName('channel').length;
	//channel总行数
	channelRow = Math.ceil(channelLen/4);
//	channelRow = Math.ceil(channelLen/4);
	//每次移动的距离
	moveLength = (652-38)/(channelRow-6);
	//获取方框DOM元素
	square = document.getElementById('square');  
	document.getElementById('programNav').innerHTML = document.getElementsByClassName('channel-backLook').length;
}
window.onbeforeunload = function(){
	
}
function setCookie(name,value)
{
	document.cookie = name + "="+ escape (value) + ";expires=";
}
function getCookie(name)
{
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
		else
		return null;
}
function keyOk(){	
       var curIndex = program.current.channelIndex;
	   if(menu.current==-1){
	   if(program.current.linkType==='content'){
			url=document.getElementById("url-1-"+curIndex).getAttribute('data-url');
	   }else{
		    url=document.getElementById("lurl-1-"+curIndex).getAttribute('data-url');
	   }
	   
	    setCookie("zbtempmenuindex",curMenuIndex);
		setCookie("zblistchanindex",curIndex);	 
	    window.location=url;
		}
}
function loadcurlinenumber(tolnum){
	var curnum = tolnum+1;
	var curnumber = Math.ceil(curnum/4);
	document.getElementById("currentPage").innerHTML = curnumber;	   
}
//移除当前节目效果
function fnRemoveCurrentStyle(){
	fnRemoveEleClass(program.current.ele,'channel-'+program.current.linkType+'-focus')
}
//添加当前节目效果
function fnAddCurrentStyle(){
	fnAddEleClass(program.current.ele,'channel-'+program.current.linkType+'-focus')
}

function fnAddMarquee(p){
	var mind=p.getElementsByClassName('program-sel-mind')[0];
	if(mind){
		var mindText=mind.innerText.trim();
		if(mindText&&mindText.length>8){
			if(mind.innerHTML.indexOf('<marquee>')===-1){//不存在marquee
				mind.innerHTML='';
				var ma=document.createElement('marquee');
				ma.innerText=mindText;
				mind.appendChild(ma);
			}
		}
	}
}
function fnRemoveMarquee(p){
	var mind=p.getElementsByClassName('program-sel-mind')[0];
	if(mind){
		if(mind.innerHTML.indexOf('<marquee>')>=0){//存在marquee
			var mindText=mind.innerText.trim();
			mind.innerHTML=mindText;
		}
	}
}

function keyBack(){
	var vodUrl = window.location.href;
    var right = Util.getURLParameter("right",vodUrl)==""?0:Util.getURLParameter("right",vodUrl);
	var down = Util.getURLParameter("down",vodUrl)==""?0:Util.getURLParameter("down",vodUrl);
	window.location='category_Index_epghd.jsp?right='+right+'&down='+down;
}