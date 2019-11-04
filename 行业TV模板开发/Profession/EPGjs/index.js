//节目dom缓存
var adp = document.getElementsByClassName('adp');
var search = document.getElementsByClassName('searchBtn');
var inScreenEnd = 4;
var oneWidth = adp[2].offsetWidth + 17;
var lineNum = Math.ceil((adp.length-2)/3);
  if(privateImageUrl=="none"||privatePageUrl=="none"){
   inScreenEnd = 5;
    lineNum = 0;

}


for(var i = 0; i < lineNum; i++) {
	document.getElementsByClassName('showLine')[0].getElementsByTagName('ul')[0].innerHTML += '<li></li>'
}
var linep = document.getElementsByClassName('showLine')[0].getElementsByTagName('li')

//各个区域配置参数
var adpMoveParas = [

];

var searchMoveParas = [
	{'up': -1, 'right': -1, 'down': 100, 'left': -1}
];

for(var i = 0, len = adp.length; i < len; i++) {
	adpMoveParas.push({
		'up': i==1 ? 0: 101,
		'right': i==len-1? -1 : (i==0)?2:i + 1,
		'down': i==0 ? 1: -1,
		'left': i==0 ? -1 : i - 1
	})
}

var area = {
	100:{
		ele:adp,
		paras:adpMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	101:{
		ele:search,
		paras:searchMoveParas,
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
	var title = (current.ele).parentNode.getElementsByClassName('title')[0]
	fnRemoveEleClass(current.ele,current.area.selStyle);
	fnRemoveEleClass(title,current.area.selStyle);
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	var title = (current.ele).parentNode.getElementsByClassName('title')[0]
	fnAddEleClass(current.ele,current.area.selStyle);
	fnAddEleClass(title,current.area.selStyle);
	if(current.index >= inScreenEnd) {
		var disL = (current.index - inScreenEnd) * oneWidth;
		document.getElementsByClassName('move_main')[0].style.left = -disL + 'px'
	}
	for(var i = 0, len = linep.length; i < len; i++) {
		linep[i].style.background = '#fff'
	}
	linep[Math.floor((current.index + 1)/3)==0 ? 0 : Math.floor((current.index + 1)/3) - 1].style.background = '#f00'
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
	var title = (current.ele).parentNode.getElementsByClassName('title')[0]
	fnRemoveEleClass(current.ele,current.area.selStyle);
	fnRemoveEleClass(title,current.area.selStyle);
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	var title = (current.ele).parentNode.getElementsByClassName('title')[0]
	fnAddEleClass(current.ele,current.area.selStyle);
	fnAddEleClass(title,current.area.selStyle);
	if(current.index > inScreenEnd) {
		var disL = (current.index - inScreenEnd) * oneWidth;
		document.getElementsByClassName('move_main')[0].style.left = -disL+ 'px'
	}
	for(var i = 0, len = linep.length; i < len; i++) {
		linep[i].style.background = '#fff'
	}
	linep[Math.floor((current.index + 1)/3)==0 ? 0 : Math.floor((current.index + 1)/3) - 1].style.background = '#f00'
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
	var title = (current.ele).parentNode.getElementsByClassName('title')[0]
	fnRemoveEleClass(current.ele,current.area.selStyle);
	if(area.current == 101) {
		fnRemoveEleClass(title,current.area.selStyle);
	}
	
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
	var title = (current.ele).parentNode.getElementsByClassName('title')[0]
	fnAddEleClass(current.ele,current.area.selStyle);
	fnAddEleClass(title,current.area.selStyle);
}

pageControl.ok=function(){
	if(area.current == 100){
		var url=current.ele.dataset['url'];
		if(url.indexOf('list') > 0) {
			sessionStorage.setItem("gonum", 0);
			sessionStorage.setItem("gopage", 1);
		}
		window.location=url;
	} else if(area.current == 101){
		if(current.index == 1){
			window.location.href = 'special_2.html'
		}
        var url=current.ele.dataset['url'];
        window.location=url;
	}
	
}











function keyBack(){
	//二院首页
	var second_college_url = "";
   if('CTCSetConfig' in Authentication) {
      //是否订购标识1,未订购0已订购
      second_college_url = Authentication.CTCGetConfig("second_college_url");            
   }else{
      second_college_url = Authentication.CUGetConfig("second_college_url");
   }
   if(second_college_url!="" && second_college_url!=null){
   		window.location.href = second_college_url;
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
	  if(privateImageUrl=="none"||privatePageUrl=="none"){
	area[100].paras[0].right = 3
	area[100].paras[1].right = 3
	area[100].paras[3].left = 0
}
}