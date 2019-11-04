//节目dom缓存
var channel = document.getElementsByClassName('channel')[0].getElementsByTagName('li');
var tvod = document.getElementsByClassName('tvodlist')[0].getElementsByTagName('li');
var date = document.getElementsByClassName('date')[0].getElementsByTagName('li');
var page = document.getElementsByClassName('page');
//各个区域配置参数
var channelMoveParas = [

];
var tvodMoveParas = [

];
var dateMoveParas = [
	{'up': 100, 'right':101, 'down': 1, 'left': -1},
	{'up': 0, 'right':101, 'down': 2, 'left': -1},
	{'up': 1, 'right':101, 'down': 3, 'left': -1},
	{'up': 2, 'right':101, 'down': 4, 'left': -1},
	{'up': 3, 'right':101, 'down': 5, 'left': -1},
	{'up': 4, 'right':101, 'down': 6, 'left': -1},
	{'up': 5, 'right':101, 'down': -1, 'left': -1}
];

var pageMoveParas = [
	{'up': -1, 'right':-1, 'down': 1, 'left': 101},
	{'up': 0, 'right':-1, 'down': -1, 'left': 101}
]

// 设置频道索引
function setChannelM() {
	for(var i = 0, len = channel.length; i < len; i++) {
		channelMoveParas.push({
			'up': -1,
			'right': i == len - 1 ? -1 : i+1,
			'down': 101,
			'left': i == 0 ? -1 : i-1
		})
	}
}
setChannelM()

// 设置节目单索引
function setTvodM() {
	for(var i = 0, len = tvod.length; i < len; i++) {
		tvodMoveParas.push({
			'up': i < 5 ? 100 : i - 5,
			'right': i % 5 == 4 ? 103 : i+1,
			'down': i+5 > len-1 ? -1 : i + 5,
			'left': i % 5 == 0 ? 102 : i-1
		})		
	}
}
setTvodM()


var area = {
	100:{
		ele:channel,
		paras:channelMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	101:{
		ele:tvod,
		paras:tvodMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	102:{
		ele:date,
		paras:dateMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	103:{
		ele:page,
		paras:pageMoveParas,
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
		var oUl = document.getElementsByClassName('channel')[0].getElementsByTagName('ul')[0]
		if(current.ele.offsetLeft < Math.abs(oUl.offsetLeft)) {
			oUl.style.left = (oUl.offsetLeft + current.ele.offsetWidth + 30) + 'px'
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
		var oUl = document.getElementsByClassName('channel')[0].getElementsByTagName('ul')[0]
		var iRB = document.getElementsByClassName('channel')[0].offsetWidth
		if(current.ele.offsetLeft + current.ele.offsetWidth + oUl.offsetLeft > iRB) {
			oUl.style.left = (oUl.offsetLeft - current.ele.offsetWidth - 30) + 'px'
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