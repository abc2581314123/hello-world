//节目dom缓存
var ser = document.getElementsByClassName('ser')[0].getElementsByTagName('li');
var play = document.getElementsByClassName('play');


//各个区域配置参数
var serMoveParas = [

];
var playMoveParas = [
	{
		'up': 100,
		'right': -1,
		'down': -1,
		'left': -1
	}
];

// 设置频道索引
function setChannelM() {
	for(var i = 0, len = ser.length; i < len; i++) {
		serMoveParas.push({
			'up': -1,
			'right': i == len - 1 ? -1 : i+1,
			'down': 101,
			'left': i == 0 ? -1 : i-1
		})
	}
}
setChannelM()




var area = {
	100:{
		ele:ser,
		paras:serMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	101:{
		ele:play,
		paras:playMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	'current':100
}

var current = {};
var pageControl = {};

function fnSetCurrent(){
	var ca = area[area.current];
	current.area = ca;
	current.index = ca.currentIndex;
	current.ele = ca.ele[current.index]
}

function fnGetNextEleIndex(dir){
	return current.area.paras[current.index][dir];
}

pageControl.moveLeft = function(){
	var nextEle = fnGetNextEleIndex('left');
	if(nextEle==-1){
		return false;
	}
	if(nextEle>=100){
		area.current = nextEle;
		nextEle = current.index;
	}
	fnRemoveEleClass(current.ele,current.area.selStyle);
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);

	if(area.current == 100) {
		var oUl = document.getElementsByClassName('ser')[0].getElementsByTagName('ul')[0]
		if(current.ele.offsetLeft < Math.abs(oUl.offsetLeft)) {
			oUl.style.left = (oUl.offsetLeft + current.ele.offsetWidth + 5) + 'px'
		}
	}
}

pageControl.moveRight = function(){
	var nextEle = fnGetNextEleIndex('right');
	if(nextEle == -1){
		return false;
	}
	if(nextEle>=100){
		area.current = nextEle;
		nextEle = current.index;
	}

	fnRemoveEleClass(current.ele,current.area.selStyle);
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);

	if(area.current == 100) {
		var oUl = document.getElementsByClassName('ser')[0].getElementsByTagName('ul')[0]
		var iRB = document.getElementsByClassName('ser')[0].offsetWidth
		if(current.ele.offsetLeft + current.ele.offsetWidth + oUl.offsetLeft > iRB) {
			oUl.style.left = (oUl.offsetLeft - current.ele.offsetWidth - 5) + 'px'
		}
	}
}

pageControl.moveUp = function(){
	var nextEle = fnGetNextEleIndex('up');
	if(nextEle == -1){
		return false;
	}
	if(nextEle>=100){
		area.current = nextEle;
		nextEle = current.index;
	}
	fnRemoveEleClass(current.ele,current.area.selStyle);
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);
}
pageControl.moveDown=function(){
	var nextEle=fnGetNextEleIndex('down');
	var beforeEle = current.ele;
	if(nextEle==-1){
		return;
	}
	
	//跨区
	if(nextEle>=100){
		area.current=nextEle;
		nextEle=current.index;
	}

	fnRemoveEleClass(current.ele,current.area.selStyle);
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);
}

pageControl.ok=function(){
	if(area.current == 100){
		var url=current.ele.dataset['url'];
		window.location=url;
	} else if(area.current == 101){
		if(current.index == 1){
			window.location.href = 'special_2.html'
		}
	}
	
}


window.onload=function(){
	var areaFrom=fnGetQueryStringByName('area');
	var indexFrom=fnGetQueryStringByName('index');
	if(areaFrom!=''&&indexFrom!=''&&area[areaFrom].ele[indexFrom]){
		area.current=areaFrom;
		area[area.current].currentIndex=indexFrom;
	}
	//找到获取焦点元素
	fnSetCurrent();
	//添加样式
	fnAddEleClass(current.ele,current.area.selStyle);
}