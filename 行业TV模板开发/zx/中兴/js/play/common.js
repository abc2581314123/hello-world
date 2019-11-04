//一个元素动画
function fnEleAnimat(ele,styleName,current,des,mul,callback,callbackParas){
	isAnimat=true;
	animat();
	function animat(){
		current+=mul;
		if(moveEnd()){
			current=des;
			ele.setStyle(styleName,current+'px');
			callback&&callback(callbackParas);
			isAnimat=false;
			return;
		}
		ele.setStyle(styleName,current+'px');
		setTimeout(animat,50);
	}
	function moveEnd(){
		return mul>0?current>=des:current<=des;
	}
}
//两个元素同时动画
function fnElesAnimat(ele1,styleName1,current1,des1,mul1,ele2,styleName2,current2,des2,mul2,callback,callbackParas){
	isAnimat=true;
	animat();
	function animat(){
		var ele1MoveEnd=false;
		var ele2MoveEnd=false;
		current1+=mul1;
		current2+=mul2;
		if(!ele1MoveEnd){
			if(moveEnd1()){
				current1=des1;
				ele1.setStyle(styleName1,current1+'px');
				ele1MoveEnd=true;
			}else{
				ele1.setStyle(styleName1,current1+'px');
			}
		}
		if(!ele2MoveEnd){
			if(moveEnd2()){
				current2=des2;
				ele2.setStyle(styleName2,current2+'px');
				ele2MoveEnd=true;
			}else{
				ele2.setStyle(styleName2,current2+'px');
			}
		}
		//两个动画都结束
		if(ele1MoveEnd&&ele2MoveEnd){
			callback&&callback(callbackParas);
			isAnimat=false;
			return;
		}
		setTimeout(animat,50);
	}
	function moveEnd1(){
		return mul1>0?current1>=des1:current1<=des1;
	}
	function moveEnd2(){
		return mul2>0?current2>=des2:current2<=des2;
	}
}
//获得地址参数
function fnGetUrlPara(name) {
    var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
    if (result == null || result.length < 1) {
        return "";
    }
    return result[1];
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
	if(ele.className.indexOf(className)>=0){
		return
	}
	ele.className+=' '+className
}
//修改元素样式
function fnModifyEleClass(ele,oldClassName,newClassName){
	if(ele.className.indexOf(oldClassName)>=0){
		fnRemoveEleClass(ele,oldClassName)
	}
	fnAddEleClass(ele,newClassName)
}
function fnChangeWallPaper(){
	var wallpapers=['body','body1','body2']
	var pi=(pi=localStorage.getItem('EPGWallpaper'))?Number(pi):0//默认
	document.body.style.backgroundImage='url(img/'+wallpapers[pi]+'.jpg)'
}
