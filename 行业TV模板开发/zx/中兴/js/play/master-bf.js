function keyRight(){
	if(isAnimat){
		return
	}
	//呼出播放进度条层
	if(layer==-1){
		layer=1
	}
	//菜单层
	if(layer==0){
		fnOperateMenuLayer('right')
	}
	//播放进度条层
	if(layer==1){
		fnOperatePlayBar('forward')
	}
}
function keyLeft(){
	if(isAnimat){
		return
	}
	//呼出播放进度条层
	if(layer==-1){
		layer=1
	}
	//菜单层
	if(layer==0){
		fnOperateMenuLayer('left')
	}
	//播放进度条层
	if(layer==1){
		fnOperatePlayBar('back')
	}
}
function keyUp(){
	if(isAnimat){
		return
	}
	//菜单层
	if(layer==0){
		fnOperateMenuLayer('up')
	}
	//没弹出层，换台
	if(layer==-1){
		fnShowCurrentInfo()
	}
}
function keyDown(){
	if(isAnimat){
		return
	}
	//菜单层
	if(layer==0){
		fnOperateMenuLayer('down')
	}
	//没弹出层，换台
	if(layer==-1){
		fnShowCurrentInfo()
	}
}
function keyOk(){
	if(isAnimat){
		return
	}
	//呼出菜单层
	if(layer==-1){
		layer=0
		fnOperateMenuLayer('left')
		return
	}
	if(layer===1){
		fnPause()
	}
	if(layer===0){
//		if(menu.current===0&&menu.currentInScreen===0){
//			if(menu.menus[0].selIndex===5){//轮播
//				menu.type=1//轮播菜单
//				fnLayoutMenu(menu.menus[1],jsonChannelData2.currentIndex,RenderMenuList(jsonChannelData2,htmlTemplates[1]))
//			}else{
//				menu.type=0//轮播菜单
//				fnLayoutMenu(menu.menus[1],jsonChannelData.currentIndex,RenderMenuList(jsonChannelData,htmlTemplates[1]))
//			}
//		}
//		if(menu.type===1&&menu.current===2){`
//			window.location='index/terminal-lxj.html'
//		}
		fnOperateMenuLayer('ok')
		return
	}
}
function keyBack(){
	if(isAnimat){
		return
	}
	//有菜单
	if(layer==0){
		fnOperateMenuLayer('back')
		return
	}
	if(layer==1){
		fnAddEleClass(playBarContainer,'dn')
		playBarState=-1
		layer=-1
		return
	}
	if(backState===-1){
		backState=0;
		setTimeout(function(){
			backState=-1;
			document.getElementById('back').addClass('dn');
		},3000);
		document.getElementById('back').removeClass('dn');
	}else{
		history.back()
	}
}
window.onload=function(){
	isAnimat=false;
	layer=-1;
	backState=-1;
	animatParas={
   		isAnimat:false
   	   ,moveUnit:{long:180,middle:120,short:60}	
   	   ,intervalTimer:20
    };
    currentInfoTimer=undefined;
	fnIniMenuParas()
	fnIniVol()
	fnInitPlayBar()
	keyOk()
}

//更改元素样式
function fnUpdateEleStyle(ele,styleName,val){
	ele.style[styleName]=val
}
//移除元素样式
function fnRemoveEleClass(ele,className){
	var classNames=ele.className
	if(classNames.indexOf(className)==0){

		ele.className=classNames.replace(className,'')
	}
	if(classNames.indexOf(className)>0){
		ele.className=classNames.replace(' '+className,'')
	}
}
//添加元素样式
function fnAddEleClass(ele,className){
	var classNames=ele.className
	if(classNames.indexOf(className)>=0){
		return
	}
	if(classNames.length>0){
		className=' '+className
	}
	ele.className+=className
}
//修改元素样式
function fnModifyEleClass(ele,oldClassName,newClassName){
	if(ele.className.indexOf(oldClassName)>=0){
		fnRemoveEleClass(ele,oldClassName)
	}
	fnAddEleClass(ele,newClassName)
}
//移除当前节目效果
function fnRemoveCurrentStyle(){
	fnAddEleClass(program.current.ele.getElementsByClassName('program-sel')[0],'dn')
}
//添加当前节目效果
function fnAddCurrentStyle(){
	fnRemoveEleClass(program.current.ele.getElementsByClassName('program-sel')[0],'dn')
}

function fnMinusDate(date,day){
	return new Date(date.valueOf() - day*24*60*60*1000);
}

function fnAddDate(date,day){
	return new Date(date.valueOf() + day*24*60*60*1000);
}

function fnFormatDate(date){
	return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}