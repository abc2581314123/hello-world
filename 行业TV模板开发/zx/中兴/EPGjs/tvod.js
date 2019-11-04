//节目dom缓存
var channel = document.getElementsByClassName('channel')[0].getElementsByTagName('li');
var tvod = document.getElementsByClassName('tvodlist')[0].getElementsByTagName('li');
var date = document.getElementsByClassName('date')[0].getElementsByTagName('li');
var page = document.getElementsByClassName('page');
var classic = document.getElementsByClassName('classic')[0].getElementsByTagName('li');
//各个区域配置参数
var channelMoveParas = [

];
var tvodMoveParas = [

];
var dateMoveParas = [
	{'up': 104, 'right':101, 'down': 1, 'left': 100},
	{'up': 0, 'right':101, 'down': 2, 'left': 100},
	{'up': 1, 'right':101, 'down': 3, 'left': 100},
	{'up': 2, 'right':101, 'down': 4, 'left': 100},
	{'up': 3, 'right':101, 'down': 5, 'left': 100},
	{'up': 4, 'right':101, 'down': 6, 'left': 100},
	{'up': 5, 'right':101, 'down': -1, 'left': 100}
];

var classicMoveParas = [
	{'up': -1, 'right':1, 'down': 101, 'left': -1},
	{'up': -1, 'right':2, 'down': 101, 'left': 0},
	{'up': -1, 'right':3, 'down': 101, 'left': 1},
	{'up': -1, 'right':4, 'down': 101, 'left': 2},
	{'up': -1, 'right':5, 'down': 101, 'left': 3},
	{'up': -1, 'right':6, 'down': 101, 'left': 4},
	{'up': -1, 'right':7, 'down': 101, 'left': 5},
	{'up': -1, 'right':-1, 'down': 101, 'left': 6}
];

var pageMoveParas = [
	{'up': -1, 'right':-1, 'down': 1, 'left': 101},
	{'up': 0, 'right':-1, 'down': -1, 'left': 101}
]

// 设置时间
function setDateM() {
	date = document.getElementsByClassName('date')[0].getElementsByTagName('li')
	dateMoveParas = []
	for(var i = 0, len = date.length; i < len; i++) {
		dateMoveParas.push({
			'up': i == 0 ? 104 : i - 1,
			'right': 101,
			'down': i== date.length - 1 ? -1 : i + 1,
			'left': 100
		})
	}
}

// 设置频道索引
function setChannelM() {
	channel = document.getElementsByClassName('channel')[0].getElementsByTagName('li')
	channelMoveParas = []
	for(var i = 0, len = channel.length; i < len; i++) {
		channelMoveParas.push({
			'up': i == 0 ? 104 : i-1,
			'right': 102,
			'down': i == len - 1 ? -1 : i+1,
			'left': -1
		})
	}
}
setChannelM()

// 设置节目单索引
function setTvodM() {
	tvod = document.getElementsByClassName('tvodlist')[0].getElementsByTagName('li');
	tvodMoveParas = []
	for(var i = 0, len = tvod.length; i < len; i++) {
		tvodMoveParas.push({
			'up': (i < 3 || i == 24 || i == 25 || i == 26 ||i == 48 ||i == 49 ||i == 50) ? 104 : i - 3,
			'right': i % 3 == 2 ? 103 : i+1,
			'down': (i+3 > len-1 || i == 23 || i == 22 || i == 21 || i == 47 || i == 46 || i == 45) ? -1 : i + 3,
			'left': i % 3 == 0 ? 102 : i-1
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
	104:{
		ele:classic,
		paras:classicMoveParas,
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
	fnRemoveEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnRemoveEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnRemoveEleClass(area[104].ele[area[104].currentIndex], 'focusx');
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);
	// 切换频道分类
	if(area.current == 104) {
		var code = current.ele.dataset['code']
		loadchanlist(code)
		var wn = getCookie('wn').split(',')
        var wn2 = getCookie('wn2').split(',')
        chanCode = 'ch0000000500000000' + wn[0];
        chanId = wn2[0];
        var chanTime = area[102].ele[0].dataset['day'];
        chidNum = 0;
        area[102].currentIndex = 0
        area[101].currentIndex = 0
        area[100].currentIndex = 0
		getProgramInfo(chanCode,chanId,chanTime)
		setTimeout(function(){
			var tArray = ["001","013","020","021","045","046","047","048","052","822","823","824","825","800","821"]
        	var cid = area[100].ele[area[100].currentIndex].dataset['cid']
        	if(tArray.indexOf(cid) >= 0) {
        		getDayList(-7)
        	} else {
        		getDayList(-3)
        	}
        },500)
	}
	fnAddEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnAddEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnAddEleClass(area[104].ele[area[104].currentIndex], 'focusx');
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
	fnRemoveEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnRemoveEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnRemoveEleClass(area[104].ele[area[104].currentIndex], 'focusx');
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);
	// 切换频道分类
	if(area.current == 104) {
		var code = current.ele.dataset['code']
		loadchanlist(code)
		var wn = getCookie('wn').split(',')
        var wn2 = getCookie('wn2').split(',')
        chanCode = 'ch0000000500000000' + wn[0];
        chanId = wn2[0];
        var chanTime = area[102].ele[0].dataset['day'];
        chidNum = 0;
        area[102].currentIndex = 0
        area[101].currentIndex = 0
        area[100].currentIndex = 0
		getProgramInfo(chanCode,chanId,chanTime);
		setTimeout(function(){
			var tArray = ["001","013","020","021","045","046","047","048","052","822","823","824","825","800","821"]
        	var cid = area[100].ele[area[100].currentIndex].dataset['cid']
        	if(tArray.indexOf(cid) >= 0) {
        		getDayList(-7)
        	} else {
        		getDayList(-3)
        	}
        },500)
	}
	fnAddEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnAddEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnAddEleClass(area[104].ele[area[104].currentIndex], 'focusx');
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
	fnRemoveEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnRemoveEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnRemoveEleClass(area[104].ele[area[104].currentIndex], 'focusx');
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);
	if(area.current == 102) {
		var chanTime = area[102].ele[area[102].currentIndex].dataset['day'];
        // var wn = sessionStorage.getItem('wn').split(',')
        // var wn2 = sessionStorage.getItem('wn2').split(',')
        var wn = getCookie('wn').split(',')
        var wn2 = getCookie('wn2').split(',')
        chanCode = 'ch0000000500000000' + wn[chidNum];
        chanId = wn2[chidNum]; 
        getProgramInfo(chanCode,chanId,chanTime);
	}
	if(area.current == 100) {
		chidNum--
		var oUl = document.getElementsByClassName('channel')[0].getElementsByTagName('ul')[0]
		if(current.ele.offsetTop < Math.abs(oUl.offsetTop)) {
			oUl.style.top = (oUl.offsetTop + current.ele.offsetHeight) + 'px'
		}
		area[102].currentIndex = 0
		var tArray = ["001","013","020","021","045","046","047","048","052","822","823","824","825","800","821"]
	    var chanTime = area[102].ele[area[102].currentIndex].dataset['day'];
       	var wn = getCookie('wn').split(',')
        var wn2 = getCookie('wn2').split(',')
        chanCode = 'ch0000000500000000' + wn[chidNum];
        chanId = wn2[chidNum]; 
        setCookie("id",chanId);
        setCookie("code",chanCode);
        getProgramInfo(chanCode,chanId,chanTime);
        setTimeout(function(){
        	var cid = area[100].ele[area[100].currentIndex].dataset['cid']
        	if(tArray.indexOf(cid) >= 0) {
        		getDayList(-7)
        	} else {
        		getDayList(-3)
        	}
        },500)
	}
	fnAddEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnAddEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnAddEleClass(area[104].ele[area[104].currentIndex], 'focusx');
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
	fnRemoveEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnRemoveEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnRemoveEleClass(area[104].ele[area[104].currentIndex], 'focusx');
	current.area.currentIndex=nextEle;
	fnSetCurrent();
	fnAddEleClass(current.ele,current.area.selStyle);
	if(area.current == 102) {
		var chanTime = area[102].ele[area[102].currentIndex].dataset['day'];
        var wn = getCookie('wn').split(',')
        var wn2 = getCookie('wn2').split(',')
        chanCode = 'ch0000000500000000' + wn[chidNum];
        chanId = wn2[chidNum]; 
        getProgramInfo(chanCode,chanId,chanTime);
	}
	if(area.current == 100) {
		var oUl = document.getElementsByClassName('channel')[0].getElementsByTagName('ul')[0]
		var iRB = document.getElementsByClassName('channel')[0].offsetHeight
		var tArray = ["001","013","020","021","045","046","047","048","052","822","823","824","825","800","821"]
		chidNum++
		if(current.ele.offsetTop + current.ele.offsetHeight + oUl.offsetTop > iRB) {
			oUl.style.top = (oUl.offsetTop - current.ele.offsetHeight) + 'px'
		}
		area[102].currentIndex = 0
		var chanTime = area[102].ele[area[102].currentIndex].dataset['day'];
        var wn = getCookie('wn').split(',')
        var wn2 = getCookie('wn2').split(',')
        chanCode = 'ch0000000500000000' + wn[chidNum]; 
        chanId = wn2[chidNum]; 
        setCookie("id",chanId);
        setCookie("code",chanCode);
        getProgramInfo(chanCode,chanId,chanTime);
        setTimeout(function(){
        	var cid = area[100].ele[area[100].currentIndex].dataset['cid']
        	if(tArray.indexOf(cid) >= 0) {
        		getDayList(-7)
        	} else {
        		getDayList(-3)
        	}
        },500)
	}
	fnAddEleClass(area[100].ele[area[100].currentIndex], 'focusx');
	fnAddEleClass(area[102].ele[area[102].currentIndex], 'focusx');
	fnAddEleClass(area[104].ele[area[104].currentIndex], 'focusx');
}

pageControl.ok=function(){
	setCookie( "Length",document.getElementsByClassName('channel')[0].getElementsByTagName('ul')[0].offsetTop)
    setCookie("currentIndex",area[100].currentIndex);
    setCookie("classicid",area[104].ele[area[104].currentIndex].dataset['code']);
    setCookie("livetime",area[102].ele[area[102].currentIndex].dataset['day']);
    setCookie("timeIndex",area[102].currentIndex);

	if(area.current == 100){
	} else if(area.current == 101){
		setTimeout(function(){
			programGo(current.index);
		}, 500)
   		
	} else if(area.current == 103) {
		if(current.index == 0) {
			// 上一页
			if(document.getElementById('curpn').innerHTML == 1) {
				return
			}
			document.getElementById('curpn').innerHTML = document.getElementById('curpn').innerHTML * 1 - 1
			curpageNum--

			var listUl = document.getElementsByClassName('tvodlist')[0].getElementsByTagName('ul')[0]
            var listLis = listUl.getElementsByTagName('li')
            for(var k = 0; k < listLis.length; k++) {
            	listLis[k].style.display = 'none'
            }
            for(var j = curpageNum * 24; j < curpageNum * 24 + 24; j++ ) {
                listLis[j].style.display = 'block'
            }
            setTvodM()
            area[101].paras = tvodMoveParas
	        area[101].currentIndex = area[101].currentIndex - 24
		} else {
			// 下一页
			if(document.getElementById('totpn').innerHTML == document.getElementById('curpn').innerHTML) {
				return
			}
			document.getElementById('curpn').innerHTML = document.getElementById('curpn').innerHTML * 1 + 1
			curpageNum++
			var listUl = document.getElementsByClassName('tvodlist')[0].getElementsByTagName('ul')[0]
			var listLis = listUl.getElementsByTagName('li')
			for(var k = 0; k < listLis.length; k++) {
            	listLis[k].style.display = 'none'
            }
            var len2 = 0
            if(curpageNum * 24 + 24 > listLis.length) {
            	len2 = listLis.length
            }else {
            	len2 = curpageNum * 24 + 24 
            }
            
            for(var j = curpageNum * 24; j < len2; j++ ) {
                listLis[j].style.display = 'block'
            }
            setTvodM()
            area[101].paras = tvodMoveParas
            if (area[101].currentIndex + 24 > listLis.length - 1) {
            	area[101].currentIndex = 24
            }else {
            	area[101].currentIndex = area[101].currentIndex + 24
            }
		}
	}
	
}
   function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*30);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

window.onload=function(){
	var areaFrom=fnGetQueryStringByName('area');
	var indexFrom=fnGetQueryStringByName('index');
	if(areaFrom!=''&&indexFrom!=''&&area[areaFrom].ele[indexFrom]){
		area.current=areaFrom;
		area[area.current].currentIndex=indexFrom;
	}
	getDayList(-7)
	//找到获取焦点元素
	fnSetCurrent();
	//添加样式
	fnAddEleClass(current.ele,current.area.selStyle);
}



function getDayList(num) {
	var dateUl = document.getElementsByClassName('date')[0].getElementsByTagName('ul')[0]
	dateUl.innerHTML = ''
	for(var i = 0; i >= num+1; i--) {
		dateUl.innerHTML += '<li data-day="'+  __fun_date1(i) +'">'+ __fun_date(i) +'</li>'
	}
	setDateM()
	area[102].paras = dateMoveParas
}

function __fun_date(aa){
    var date1 = new Date(),
    time1=date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();//time1表示当前时间
    var date2 = new Date(date1);
    date2.setDate(date1.getDate()+aa);
    var m = date2.getMonth()+1;
    m = m < 10 ? '0' + m : m;

 	var d = date2.getDate();
    d = d < 10 ? '0' + d : d;

    var time2 = date2.getFullYear()+"-"+(m)+"-"+d;
    return time2
}


function __fun_date1(aa){
    var date1 = new Date(),
    time1=date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();//time1表示当前时间
    var date2 = new Date(date1);
    date2.setDate(date1.getDate()+aa);
    var m = date2.getMonth()+1;
    m = m < 10 ? '0' + m : m;

 	var d = date2.getDate();
    d = d < 10 ? '0' + d : d;

    var time2 = date2.getFullYear()+"."+(m)+"."+d;
    return time2
}