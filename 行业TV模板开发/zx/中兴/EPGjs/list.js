//节目dom缓存
var adp = document.getElementsByClassName('adp');
var nav = document.getElementsByClassName('nav')[0].getElementsByTagName('li');
var oNavUl = document.getElementsByClassName('nav')[0].getElementsByTagName('ul')[0];
//各个区域配置参数
var adpMoveParas = [

];
var navMoveParas = [

];
for(var i = 0, len = nav.length; i < len; i++) {
	navMoveParas.push({
		'up': -1,
		'right': i==len-1? -1 : i + 1,
		'down': 101,
		'left': i==0 ? -1 : i - 1
	})
}


function adpM() {
	for(var i = 0, len = adp.length; i < len; i++) {
		adpMoveParas.push({
			'up': i > 0 ? i > 4 ? i - 5 : 100 : 100,
			'right': i==len-1? -1 : i + 1,
			'down': i > 0 ? (i + 5)>adp.length - 1 ? adp.length - 1 : i + 5 : -1,
			'left': i==0 ? -1 : i - 1
		})
	}
}
adpM()

var area = {
	100:{
		ele:nav,
		paras:navMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	101:{
		ele:adp,
		paras:adpMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	'current':101
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
		if(current.ele.offsetLeft < Math.abs(oNavUl.offsetLeft)) { // 1183为导航区域右侧边界
			oNavUl.style.left = (oNavUl.offsetLeft + current.ele.offsetWidth + 50) + 'px'
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
	if(area.current == 101) {
		if((current.index - 1) % 5 == 4) {
			alert('更新数据')
		}
	}
	fnRemoveEleClass(current.ele,current.area.selStyle);
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);
	if(area.current == 100) {
		if(current.ele.offsetLeft + current.ele.offsetWidth  + document.getElementsByClassName('nav')[0].getElementsByTagName('ul')[0].offsetLeft > 1183) { // 1183为导航区域右侧边界
			oNavUl.style.left = (oNavUl.offsetLeft - current.ele.offsetWidth - 50) + 'px'
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