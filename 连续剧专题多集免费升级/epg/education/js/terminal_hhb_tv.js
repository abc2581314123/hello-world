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


var items=[]
   ,current={}
   ,shades=document.getElementsByClassName('shade')
   ,list={}

function keyLeft(){
	// 2018-12-24新增加砸金蛋活动订购 区域拟定为10区
	if(current.area==10){
		if(current.index==0){
			return
		}else {
			current.index = 0
			document.getElementsByClassName('giveup')[0].style.border = '4px solid transparent'
			document.getElementsByClassName('go')[0].style.border = '4px solid #f6ff00'
		}
		return
	}
	// if(current.index==0){
	// 	return
	// }
	if(current.area==0){// 主演区

	}else if(current.area==1){	// 导演区

		
	}else if(current.area==2){// 功能区
		if(current.index==0){
			return
		}
		fnRemoveEleClass(items[current.area][current.index],'program-func-'+funcs[current.index]+'-sel')
		fnRemoveEleClass(items[current.area][current.index],'program-func-sel')
		current.index--
		fnAddEleClass(items[current.area][current.index],'program-func-'+funcs[current.index]+'-sel')
		fnAddEleClass(items[current.area][current.index],'program-func-sel')
	}else if(current.area==3){// 推荐区
		fnAddEleClass(items[current.area][current.index].getElementsByClassName('program-sel')[0],'dn')
		fnRemoveMarquee(items[current.area][current.index])
		current.index--
		fnRemoveEleClass(items[current.area][current.index].getElementsByClassName('program-sel')[0],'dn')
		fnAddMarquee(items[current.area][current.index])
	}else{// 选集
		selectorController.left();
	}
	
}

function keyRight(){
	if(current.area==10){
		if(current.index==1){
			return
		}else {
			current.index = 1
			document.getElementsByClassName('go')[0].style.border = '4px solid transparent'
			document.getElementsByClassName('giveup')[0].style.border = '4px solid #f6ff00'
		}
		return
	}
	if(current.index==items[current.area].length-1){
		return
	}
	// 主演区
	if(current.area==0){
		
	}
	// 导演区
	if(current.area==1){
		
		return
	}
	// 功能区
	if(current.area==2){
		if(current.index==funcs.length-1){
			return
		}
		fnRemoveEleClass(items[current.area][current.index],'program-func-'+funcs[current.index]+'-sel')
		fnRemoveEleClass(items[current.area][current.index],'program-func-sel')
		current.index++
		fnAddEleClass(items[current.area][current.index],'program-func-'+funcs[current.index]+'-sel')
		fnAddEleClass(items[current.area][current.index],'program-func-sel')
		return
	}
	// 推荐区
	if(current.area==3){
		fnAddEleClass(items[current.area][current.index].getElementsByClassName('program-sel')[0],'dn')
		fnRemoveMarquee(items[current.area][current.index])
		current.index++
		fnRemoveEleClass(items[current.area][current.index].getElementsByClassName('program-sel')[0],'dn')
		fnAddMarquee(items[current.area][current.index])
		return
	}
	if(current.area>3){
		selectorController.right();
	}
}

function keyUp(){
	if(current.area>3){
		selectorController.up();
		return
	}
	if(!items[current.area]||items[current.area].length==0){
		return
	}
	// 主演区
	if(current.area==0){
		return
	}
	// 导演区
	if(current.area==1){
		// fnRemoveEleClass(items[current.area][current.index],'program-staff-sel')
		// //进入主演区
		// current.area--
		// current.index=0
		// fnAddEleClass(items[current.area][current.index],'program-staff-sel')
		return
	}
	// 功能区
	if(current.area==2){
		
		// if(current.index==0){
		// fnRemoveEleClass(items[current.area][current.index],'program-func-play-sel')
		// }else{
		// fnRemoveEleClass(items[current.area][current.index],'program-func-list-sel')
		// }
		// fnRemoveEleClass(items[current.area][current.index],'program-func-sel')

		// //进入导演区
		// current.area--
		// current.index=0
		// fnAddEleClass(items[current.area][current.index],'program-staff-sel')
		// return
	}
	// 推荐区
	if(current.area==3){
		fnAddEleClass(items[current.area][current.index].getElementsByClassName('program-sel')[0],'dn')
		fnRemoveMarquee(items[current.area][current.index])
		// 进入功能区
		current.area--
		current.index=0
		fnAddEleClass(shades[0],'dn')
		// fnEleAnimat(document.getElementsByClassName('main')[0],'margin-top',-417,0,120,function(){
		// 	if(current.index==0){
		// 		fnAddEleClass(items[current.area][current.index],'program-func-play-sel')
		// 	}else{
		// 		fnAddEleClass(items[current.area][current.index],'program-func-list-sel')
		// 	}
		// 	fnAddEleClass(items[current.area][current.index],'program-func-sel')
		// 	fnRemoveEleClass(shades[1],'dn')
		// })
		if(current.index==0){
			fnAddEleClass(items[current.area][current.index],'program-func-play-sel')
		}else{
			fnAddEleClass(items[current.area][current.index],'program-func-list-sel')
		}
		fnAddEleClass(items[current.area][current.index],'program-func-sel')
		fnRemoveEleClass(shades[1],'dn')
		return
	}
	
}

function keyDown(){
	if(current.area>3){
		selectorController.down();
		return
	}
	if(!items[current.area+1]||items[current.area+1].length==0){
		return
	}
	// 主演区
	if(current.area==0){
		// fnRemoveEleClass(items[current.area][current.index],'program-staff-sel')
		// //进入导演区
		// current.area++
		// current.index=0
		// fnAddEleClass(items[current.area][current.index],'program-staff-sel')
		return
	}
	// 导演区
	if(current.area==1){
		// fnRemoveEleClass(items[current.area][current.index],'program-staff-sel')
		// //进入功能区
		// current.area++
		// current.index=0
		// fnAddEleClass(items[current.area][current.index],'program-func-sel')
		// if(current.index==0){
		// fnAddEleClass(items[current.area][current.index],'program-func-play-sel')
		// }else{
		// fnAddEleClass(items[current.area][current.index],'program-func-list-sel')
		// }
		return
	}
	// 功能区
	if(current.area==2){
		if(current.index==0){
			fnRemoveEleClass(items[current.area][current.index],'program-func-play-sel')
		}else{
			fnRemoveEleClass(items[current.area][current.index],'program-func-list-sel')
		}
		fnRemoveEleClass(items[current.area][current.index],'program-func-sel')
		// 进入推荐区
		current.area++
		current.index=0
		fnAddEleClass(shades[1],'dn')
		// fnEleAnimat(document.getElementsByClassName('main')[0],'margin-top',0,-417,-120,function(){
		// 	fnRemoveEleClass(items[current.area][current.index].getElementsByClassName('program-sel')[0],'dn')
		// 	fnAddMarquee(items[current.area][current.index])
		// 	fnRemoveEleClass(shades[0],'dn')
		// })

		fnRemoveEleClass(items[current.area][current.index].getElementsByClassName('program-sel')[0],'dn')
			fnAddMarquee(items[current.area][current.index])
			fnRemoveEleClass(shades[0],'dn')
		return
	}
	// 推荐区
	if(current.area==3){
		return
	}

	
}

function keyBack(){
	// 选集区
	if(current.area===4){
		document.getElementById('layer').addClass('dn')
		current.area=2

		return
		// current.index=1//回到选集按钮
	}

	// if(current.area == 10){
	// 	current.area = 1
	// 	current.index = 0
	// 	document.getElementById('book').style.display = 'none'
	// 	return
	// }
	
	//window.location='index.html'
	
	onkeyback();
}

function keyOk(){
	
	// 功能区
	// updater:mawei

	if(current.area == 10){
		if(current.index == 0){
			jumpEgg();
		}else {
			current.area =3
			current.index = 0
			document.getElementById('book').style.display = 'none'
		}
	}

	if(current.area==3){
    //功能推荐区
		
		
		   var code=codeList.split("@@");
		   
         window.location.href="tv_zpage_one_hd.jsp?code="+code[current.index]+"&category_id="+category_id_get+"&providerid="+providerid1+"&currentMenuListEleIndex1="+currentMenuListEleIndex12+"&lntvlspid="+lntvlspid;
        
		}
	
		 	
	if(current.area>3){// 选集
	    selectorController.ok();
	}
	  
	if(current.area===2){ 
		
		
	
		   if(jqresult=="1"){

		   	   fnAddEleClass(shades[0],'dn');
			   if(current.index==0){			   
				   	//如果鉴权未通过并且有免费剧集，显示选集区
				   	if(freecount!=null&&freecount!="null"&&Number(freecount)>0){
				   		
				   		document.getElementById('layer').removeClass('dn');
						selector.init(volumncountList);
						current.area=4// 弹窗
						// 选集集数
					    return;
				   	}
					Tryplay();// 播放
				}
				if(current.index==1)
				{
						//判断订购时间是否在活动时间内 如果订购时间不在活动范围之内不可以参加砸金蛋活动
					if(flag){
						//调未订购支付接口插入订购信息
						addUnpaid();
					}
					
					order();//订购	
				}
		   }
			if(jqresult=="2"){

					//鉴权通过所以节目免费,清空付费节目标识，不做多集免费逻辑处理
				 	try{
						
						if('CTCSetConfig' in Authentication) {
							  //是否订购标识1,未订购0已订购
							  Authentication.CTCSetConfig("isPay",0);						 
						   }else{
						   	  Authentication.CUSetConfig("isPay",0);
						   }
						}catch(e){

					}	


			if(current.index==0){
		if(volumncountList==""||volumncountList=="null"||volumncountList=="0"){
		     play();
		}else{
		   ChoseChannel(0);
		}
			}	  
			if(current.index===1){// 选集
				document.getElementById('layer').removeClass('dn');
					selector.init(volumncountList);
				current.area=4// 弹窗
				// 选集集数
				// 选集：mawei
			    return;
			
		}


			}
			if(current.index==2)
			{
				 // favorited();
				 
				 document.getElementById("collection").innerHTML="";
				 if(isFavorited ==0){
				 	favorited();
				 }else{
				 	delFavorited();
				 }
				 
			}

	}
}

var flag = false;
//判断是否在活动范围订购时间比较
function dateCompare(){
	//砸金蛋活动开始时间
	var eggStartTime = "";
	eggStartTime = "2019-01-29";
	//砸金蛋活动结束时间
	var eggEndTime = "";
	eggEndTime = "2019-02-11";

	var date =new Date().getTime();

    eggStartTime = eggStartTime.split('-');
    var start = new Date(eggStartTime[0],(eggStartTime[1]-1),eggStartTime[2]);
	var startTime = new Date(start).getTime();
    eggEndTime = eggEndTime.split('-');
    var endTime = new Date(eggEndTime[0],(eggEndTime[1]-1),eggEndTime[2]);
	endTime = new Date(endTime).getTime();

	if(date>=startTime && date<= endTime){

		flag = true;
		return flag;
	}else{
		flag = false

		return flag;
	}

}

// 获得菜单的dom结构
function fnIniParas(){
	items[0]=document.getElementsByClassName('program-actor')
	items[1]=document.getElementsByClassName('program-director')
	items[2]=document.getElementsByClassName('program-func')
	items[3]=document.getElementsByClassName('program')
	items[4]=document.getElementsByClassName('list-layer-nav-ele')
	items[5]=document.getElementsByClassName('list-layer-list-ele')
	// 区域 0：主演；1:导演；2:功能；3:推荐；4:选集
	current.area=2
	// 元素在各区域中的索引,有免费剧集取消试看按钮，区域索引+1

	current.index=0
	
	funcs=['play','list','favor']  
	
}
function fnIniLayout(){

}
window.onload=function(){
	fnIniParas()
	fnIniLayout()
	// getGys();

	//判断活动日期
	dateCompare();
	if(flag){
		//查看已订购接口（为了区分列表页订购用户和活动期间订购用户参与活动权限）返回点数值代表可以参加否则不可以
		//鉴权通过（代表订购成功）查询订购
		//测试改成1，现网改成2
		if(equals(jqresult,"2")){
			searchOrder();
		}
		// if(equals(jqresult,"2")){
		// 	searchOrder();
		// }

	}
	fnAddEleClass(items[current.area][current.index],'program-func-sel')
}
function fnAddMarquee(p){
	var mind=p.getElementsByClassName('program-sel-mind')[0];
	if(mind){
		var mindText=mind.innerText.trim();
		if(mindText&&mindText.length>8){
			if(mind.innerHTML.indexOf('<marquee>')===-1){// 不存在marquee
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
		if(mind.innerHTML.indexOf('<marquee>')>=0){// 存在marquee
			var mindText=mind.innerText.trim();
			mind.innerHTML=mindText;
		}
	}
}

var selector={
	navTemp:'<div class="selector-nav-ele">@</div>',
	singleTemp:'<div class="selector-single-ele">@</div>'
};
selector.init=function(num){
	this.currentArea='single';
	this.singleNum=num;
	this.currentNavIndex=0;
	this.currentNavIndexInScreen=0;
	this.navLengthInScreen=5;
	this.currentSingleIndex=0;
	this.initNav();
	this.initSingle(this.currentNavIndex);
	this.focusInSingle(this.currentSingleIndex);
};
selector.focusOutSingle=function(index){
	this.single.eles[index].removeClass('selector-single-ele-sel')
};
selector.focusInSingle=function(index){
	this.single.eles[index].addClass('selector-single-ele-sel')
};
selector.focusOutNav=function(index){
	this.nav.eles[index].removeClass('selector-nav-ele-sel')
};
selector.focusInNav=function(index){
	this.nav.eles[index].addClass('selector-nav-ele-sel')
};
selector.currentOutNav=function(index){
	this.nav.eles[index].removeClass('selector-nav-ele-current')
};
selector.currentInNav=function(index){
	this.nav.eles[index].addClass('selector-nav-ele-current')
};
selector.moveNav=function(pos){
	this.nav.container.setStyle('left',pos+'px');
};
selector.initNav=function(){
	var navNum=Math.ceil(this.singleNum/20);
	var html='';
	for(var i=0;i<navNum;i++){
		var start=i*20+1;
		var end=i*20+20;
		end=end>this.singleNum?this.singleNum:end;
		html+=this.navTemp.replace('@',start+'-'+end);
	}
	this.nav={};
	this.nav.container=document.getElementById('selectorNav');
	this.nav.container.innerHTML=html;
	this.nav.eles=this.nav.container.getElementsByClassName('selector-nav-ele');
	this.nav.eleWidth=this.nav.eles[0].offsetWidth;
	this.nav.container.setStyle('width',this.nav.eles.length*this.nav.eleWidth+'px');
	this.currentInNav(this.currentNavIndex);
};
selector.initSingle=function(navIndex){
	var start=20*navIndex+1;
	var end=20*navIndex+20;
	end=end>this.singleNum?this.singleNum:end;
	var html='';
	for(var i=start;i<=end;i++){
		html+=this.singleTemp.replace('@',i);
	}

	this.single={};
	this.single.container=document.getElementById('selectorSingle');
	this.single.container.innerHTML=html;

	if(jqresult == "1"){
		var colls = (this.single.container).getElementsByClassName('selector-single-ele');
		if(freecount > colls[0].innerHTML * 1) {
			for(var i = freecount; i < colls.length ; i++){
				// colls[i].innerHTML += '<span style="position:absolute; top:0; background:rgba(255, 108, 0, .7); left:0; width:100%; height:100%; display:inline-block;">VIP</span>'
				colls[i].innerHTML += '<span style="position:absolute; top:0; right:0; width:100%; height:100%; text-align:right; display:inline-block;"><img src="./education/img/viparrow.png"></span>'
			}
		} else {
			for(var i = 0; i < colls.length ; i++){
				colls[i].innerHTML += '<span style="position:absolute; top:0; right:0; width:100%; height:100%; text-align:right; display:inline-block;"><img src="./education/img/viparrow.png"></span>'
			}
		}
	}
	

	this.single.title=document.getElementById('singleTitle');
	this.single.eles=this.single.container.getElementsByClassName('selector-single-ele');
	this.single.title.innerHTML=start+'-'+end+'：';
	this.currentSingleIndex=0;
};
var selectorController={
	up:function(){
		if(selector.currentArea==='nav'){
			return;
		}else{
			if(selector.currentSingleIndex<=selector.single.eles.length/2-1){
				selector.currentArea='nav';
				selector.focusOutSingle(selector.currentSingleIndex);
				selector.currentOutNav(selector.currentNavIndex);
				selector.focusInNav(selector.currentNavIndex);
				return;
			}
			if(!selector.single.eles[selector.currentSingleIndex-10]){
				return
			}
			selector.focusOutSingle(selector.currentSingleIndex);
			selector.currentSingleIndex-=10;
			selector.focusInSingle(selector.currentSingleIndex);
		}
	},
	down:function(){
		if(selector.currentArea==='nav'){
			selector.currentArea='single';
			selector.focusOutNav(selector.currentNavIndex);
			selector.currentInNav(selector.currentNavIndex);
			selector.focusInSingle(selector.currentSingleIndex)
		}else{
			if(selector.currentSingleIndex>=selector.single.eles.length/2){
				return
			}
			if(!selector.single.eles[selector.currentSingleIndex+10]){
				return
			}
			selector.focusOutSingle(selector.currentSingleIndex);
			selector.currentSingleIndex+=10;
			selector.focusInSingle(selector.currentSingleIndex);
		}
	},
	left:function(){
		if(selector.currentArea==='nav'){
			if(selector.currentNavIndex>0){
				if(selector.currentNavIndexInScreen==0&&selector.currentNavIndex>0){
					// //----单个区间移动开始----
					// var
					// left=selector.nav.eleWidth*(selector.currentNavIndex-1);//一个一个区间移动
					// selector.moveNav(-left);
					// //----单个区间移动结束----
					// ----5个区间移动开始----
					var left=selector.nav.eleWidth*(selector.currentNavIndex-5);
					selector.currentNavIndexInScreen=4;
					selector.moveNav(-left);
					selector.focusOutNav(selector.currentNavIndex);
					selector.currentNavIndex--;
					selector.focusInNav(selector.currentNavIndex);
					selector.initSingle(selector.currentNavIndex);
					return;
					// ----5个区间移动结束----
				}
				selector.focusOutNav(selector.currentNavIndex);
				selector.currentNavIndex--;
				selector.currentNavIndexInScreen>0&&selector.currentNavIndexInScreen--;
				selector.focusInNav(selector.currentNavIndex);
				selector.initSingle(selector.currentNavIndex);
			}
		}else{// 光标在单集上
			if(selector.currentSingleIndex===0){
				if(selector.currentSingleIndex+selector.currentNavIndex*20===0){// 第一集
					return;
				}
				// 导航在当前屏的最后一个，移动导航
				if(selector.currentNavIndexInScreen==0&&selector.currentNavIndex>0){
					// //----单个区间移动开始----
					// var
					// left=selector.nav.eleWidth*(selector.currentNavIndex-1);//一个一个区间移动
					// selector.moveNav(-left);
					// //----单个区间移动结束----
					// ----5个区间移动开始----
					var left=selector.nav.eleWidth*(selector.currentNavIndex-5);
					selector.currentNavIndexInScreen=4;
					selector.moveNav(-left);
					selector.currentOutNav(selector.currentNavIndex);
					selector.currentNavIndex--;
					selector.currentInNav(selector.currentNavIndex);
					selector.initSingle(selector.currentNavIndex);
					selector.currentSingleIndex=19;
					selector.focusInSingle(selector.currentSingleIndex);
					return;
					// ----5个区间移动结束----
				}
				selector.currentOutNav(selector.currentNavIndex);
				selector.currentNavIndex--;
				selector.currentNavIndexInScreen>0&&selector.currentNavIndexInScreen--;
				selector.currentInNav(selector.currentNavIndex);
				selector.initSingle(selector.currentNavIndex);
				selector.currentSingleIndex=19;
				selector.focusInSingle(selector.currentSingleIndex);
				return
			}
			selector.focusOutSingle(selector.currentSingleIndex);
			selector.currentSingleIndex--;
			selector.focusInSingle(selector.currentSingleIndex);
		}
	},
	right:function(){

		if(selector.currentArea==='nav'){
			if(selector.currentNavIndex<selector.nav.eles.length-1){
				if(selector.currentNavIndexInScreen==selector.navLengthInScreen-1&&selector.currentNavIndex<selector.nav.eles.length-1){
					// //----单个区间移动开始----
					// var
					// left=selector.nav.eleWidth*(selector.currentNavIndex+1-(selector.navLengthInScreen-1));
					// selector.moveNav(-left);
					// //----单个区间移动结束----
					// ----5个区间移动开始----
					var left=selector.nav.eleWidth*(selector.currentNavIndex+1);// 5个区间移动
					selector.currentNavIndexInScreen=0;
					selector.moveNav(-left);
					selector.focusOutNav(selector.currentNavIndex);
					selector.currentNavIndex++;
					selector.focusInNav(selector.currentNavIndex);
					selector.initSingle(selector.currentNavIndex);
					return
					// ----5个区间移动结束----
				}
				selector.focusOutNav(selector.currentNavIndex);
				selector.currentNavIndex++;
				selector.currentNavIndexInScreen<selector.navLengthInScreen-1&&selector.currentNavIndexInScreen++;
				selector.focusInNav(selector.currentNavIndex);
				selector.initSingle(selector.currentNavIndex);
			}
		}else{// 光标在单集上
			if(selector.currentSingleIndex===selector.single.eles.length-1){// 单集选中每屏的最后一个元素
				if(selector.currentSingleIndex+selector.currentNavIndex*20===selector.singleNum-1){// 最后一集
					return;
				}
				// 导航在当前屏的最后一个，移动导航
				if(selector.currentNavIndexInScreen==selector.navLengthInScreen-1&&selector.currentNavIndex<selector.nav.eles.length-1){
					// //----单个区间移动开始----
					// var
					// left=selector.nav.eleWidth*(selector.currentNavIndex+1-(selector.navLengthInScreen-1));
					// selector.moveNav(-left);
					// //----单个区间移动结束----
					// ----5个区间移动开始----
					var left=selector.nav.eleWidth*(selector.currentNavIndex+1);// 5个区间移动
					selector.currentNavIndexInScreen=0;
					selector.moveNav(-left);
					selector.currentOutNav(selector.currentNavIndex);
					selector.currentNavIndex++;
					selector.currentInNav(selector.currentNavIndex);
					selector.initSingle(selector.currentNavIndex);
					selector.focusInSingle(selector.currentSingleIndex);
					return
					// ----5个区间移动结束----
				}
				selector.currentOutNav(selector.currentNavIndex);
				selector.currentNavIndex++;
				selector.currentNavIndexInScreen<selector.navLengthInScreen-1&&selector.currentNavIndexInScreen++;
				selector.currentInNav(selector.currentNavIndex);
				selector.initSingle(selector.currentNavIndex);
				selector.focusInSingle(selector.currentSingleIndex);
				return
			}
			selector.focusOutSingle(selector.currentSingleIndex);
			selector.currentSingleIndex++;
			selector.focusInSingle(selector.currentSingleIndex);
		}
	},
	ok:function(){
		if(selector.currentArea==='single'){
			// 跳转
			 var  programnum = selector.currentNavIndex*20+selector.currentSingleIndex;

			 //点击连续剧多集选择，存放页面标识，只有电视剧综艺混排和环球世嘉TV增加多集免费功能，控制播放
			if('CTCSetConfig' in Authentication) {
							  //是否订购标识
			  Authentication.CTCSetConfig("currentPage","TV_zpage_one_dj.jsp");
			
		    }else{
		   	  Authentication.CUSetConfig("currentPage","TV_zpage_one_dj.jsp");
		    }


			 if(jqresult=="1"){
			 	if(Number(programnum)>freecount-1){
			 		//订购
			 		order();

				 }else{
				 	 try{
						
						if('CTCSetConfig' in Authentication) {
							  //是否订购标识
							  Authentication.CTCSetConfig("isPay",1);
							  Authentication.CTCSetConfig("programnum",programnum);
							  Authentication.CTCSetConfig("freecount",freecount);
							  Authentication.CTCSetConfig("backurl_video",location.href.replace(/&/g,"*"));
						   }else{
						   	  Authentication.CUSetConfig("isPay",1);
						      Authentication.CUSetConfig("programnum",programnum);
							  Authentication.CUSetConfig("freecount",freecount);
							  Authentication.CUSetConfig("backurl_video",location.href.replace(/&/g,"*"));
						   }
						}catch(e){

					}	
				 	 ChoseChannel(programnum);
				 }
				 	
			 }else{
			 
			 	 try{
						
						if('CTCSetConfig' in Authentication) {
							  //是否订购标识1,未订购0已订购
							  Authentication.CTCSetConfig("isPay",0);						 
						   }else{
						   	  Authentication.CUSetConfig("isPay",0);
						   }
						}catch(e){

					}	
			 	ChoseChannel(programnum);	
			 }
			 
        
		}
	}
};


function setAuthentication(){

}