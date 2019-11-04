//节目dom缓存
var adp = document.getElementsByClassName('adp');
var tv = document.getElementsByClassName('tv');
var nav = document.getElementsByClassName('nav')[0].getElementsByTagName('li');
var oNavUl = document.getElementsByClassName('nav')[0].getElementsByTagName('ul')[0];
var search = document.getElementsByClassName('search');
var move_main = document.getElementsByClassName('move_main')[0];
var page = document.getElementsByClassName('page');

//各个区域配置参数
var adpMoveParas = [

];
var searchMoveParas = [
	{'up': -1, 'right': -1, 'down':100, 'left': -1}
];
var tvMoveParas = [
	{'up': 100, 'right': 101, 'down':-1, 'left': -1}
];
var navMoveParas = [

];
var pageMoveParas = [
	{'up': 101, 'right': 1, 'down':-1, 'left': -1},
	{'up': 101, 'right': -1, 'down':-1, 'left': 0}
];
for(var i = 0, len = nav.length; i < len; i++) {
	navMoveParas.push({
		'up': 102,
		'right': i==len-1? -1 : i + 1,
		'down': 101,
		'left': i==0 ? -1 : i - 1
	})
}


function adpM() {
	var adp = document.getElementsByClassName('adp');
	adpMoveParas = []
	if(adp.length > 5) {
		for(var i = 0, len = adp.length; i < len; i++) {
			adpMoveParas.push({
				'up': i >= Math.ceil((adp.length)/2) ? i-Math.ceil((adp.length)/2) : 100,
				'right': (i==len-1 || i == Math.ceil(adp.length/2)-1) ? -1 : i + 1,
				'down': i >= Math.ceil((adp.length)/2) ? 104 : i + Math.ceil((adp.length)/2) > adp.length -1 ? adp.length - 1 : i + Math.ceil((adp.length - 1)/2),
				'left': (i == 0 || i == Math.ceil((adp.length-1)/2)) ? 103 :i - 1
			})
		}
	}else {
		for(var i = 0, len = adp.length; i < len; i++) {
			adpMoveParas.push({
				'up': 102,
				'right': i == (adp.length - 1) ? -1 : i + 1,
				'down': 104,
				'left': i==0 ? 103 : i - 1
			})
		}
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
	102:{
		ele:search,
		paras:searchMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	103:{
		ele:tv,
		paras:tvMoveParas,
		currentIndex:0,
		selStyle:'sel'
	},
	104:{
		ele:page,
		paras:pageMoveParas,
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

pageControl.pageUp = function(){
	// 翻页
    currentPage = current.ele.dataset['currentpage'];
    var index = current.ele.dataset['index'];
    if (currentPage > 1) {
        currentPage--;
        changeProgramForPagination(current.ele.dataset['categoryid'],currentPage);
        if(index == 0){
    		nextEle = 4
    		sessionStorage.setItem("gonum", 4);
        }else {
        	nextEle = 9
        	sessionStorage.setItem("gonum", 9);
        }
	}
}

pageControl.pageDown = function(){
	// 翻页
    currentPage = current.ele.dataset['currentpage'];
    if(currentPage == totalPage) {
    	return
    }
    var index = current.ele.dataset['index'];
    currentPage++;
    changeProgramForPagination(current.ele.dataset['categoryid'],currentPage);
    if(index == 4){
    	area[101].currentIndex = 0;
    	sessionStorage.setItem("gonum", 0);
    }else {
    	var currentPage = current.ele.dataset['currentpage'];
    	if(totalPage == (currentPage*1 + 1)) {
    		area[101].currentIndex = 0;
    		sessionStorage.setItem("gonum", 0);
    	}else {
    		area[101].currentIndex = 5;
    		sessionStorage.setItem("gonum", 5);
    	}
    }
}

pageControl.moveLeft = function(){
	var nextEle = fnGetNextEleIndex('left');
	if(nextEle==-1){
		return false;
	}

    if(area.current == 101) {
        // 翻页 start
        var index = current.ele.dataset['index'];
        if (index == 0 || index == 5) {
            currentPage = current.ele.dataset['currentpage'];
            if (currentPage > 1) {
                currentPage--;
                changeProgramForPagination(current.ele.dataset['categoryid'],currentPage);
                if(index == 0){
            		nextEle = 4
            		sessionStorage.setItem("gonum", 4);
	            }else {
	            	nextEle = 9
	            	sessionStorage.setItem("gonum", 9);
	            }
			}
        }

        // 翻页end
    }

        // 870为右侧边界
        var move_main = document.getElementsByClassName('move_main')[0]
        if(current.ele.offsetLeft < Math.abs(move_main.offsetLeft)) {
            move_main.style.left = move_main.offsetLeft + (adp[1].offsetWidth + 16) + 'px'
        }

	if(nextEle>=100 ){
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
		sessionStorage.setItem("gonum", 0);
		area[101].currentIndex = 0;
        changeProgram(current.ele.dataset['id']);
	}

}

pageControl.moveRight = function(){
	var nextEle = fnGetNextEleIndex('right');

	// 10个节目区
	if (area.current == 101) {
        var index = current.ele.dataset['index'];
        if (index == 4 || index == 9) {
            // 翻页
            currentPage = current.ele.dataset['currentpage'];
            if(currentPage == totalPage) {
            	return
            }
            currentPage++;
            changeProgramForPagination(current.ele.dataset['categoryid'],currentPage);
            if(index == 4){
            	area[101].currentIndex = 0;
            	sessionStorage.setItem("gonum", 0);
            }else {
            	var currentPage = current.ele.dataset['currentpage'];
		    	if(totalPage == (currentPage*1 + 1)) {
		    		area[101].currentIndex = 0;
		    		sessionStorage.setItem("gonum", 0);
		    	}else {
		    		area[101].currentIndex = 5;
		    		sessionStorage.setItem("gonum", 5);
		    	}
            }
            
        }
    }


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
		if(current.ele.offsetLeft + current.ele.offsetWidth  + document.getElementsByClassName('nav')[0].getElementsByTagName('ul')[0].offsetLeft > 1183) { // 1183为导航区域右侧边界
			oNavUl.style.left = (oNavUl.offsetLeft - current.ele.offsetWidth - 50) + 'px'
		}

        setTimeout(function (){
            var dataId = current.ele.dataset['id'];
            sessionStorage.setItem("gonum", 0);
            area[101].currentIndex = 0;
            changeProgram(dataId);
        },100);

	}
	if(area.current == 101) {
		// 870为右侧边界
		var move_main = document.getElementsByClassName('move_main')[0]
		if(current.ele.offsetLeft + current.ele.offsetWidth + move_main.offsetLeft > 870) {
			move_main.style.left = move_main.offsetLeft - (adp[1].offsetWidth + 16) + 'px'
		}
	}
}

pageControl.moveUp = function(){
	var nextEle = fnGetNextEleIndex('up');
	if(nextEle == -1){
		return false;
	}
	if(nextEle>=100){
		fnRemoveEleClass(area[100].ele[area[100].currentIndex],'focusx');
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
		fnAddEleClass(area[100].ele[area[100].currentIndex],'focusx');
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
		// var url=current.ele.dataset['url'];
		// window.location=url;
	} else if(area.current == 101){
		if(current.index == 0){
			window.location.href = 'special_3.html'
		}
		
		sessionStorage.setItem("gopage", currentPage);
		sessionStorage.setItem("gonum", area[101].currentIndex);
		sessionStorage.setItem("goidLN", area[100].ele[area[100].currentIndex].dataset['id']);
        var url=current.ele.dataset['url'];
        window.location=url;
	} else if (area.current == 102){
        var url=current.ele.dataset['url'];
        window.location=url;
	}else if (area.current == 103){
        var url=current.ele.dataset['url'];
        window.location=url;
	}
	else if(area.current == 104) {
		if(current.index == 0) {
			// 上一页
			var index = area[101].currentIndex;
			currentPage = area[101].ele[0].dataset['currentpage'];
		    if (currentPage > 1) {
		        currentPage--;
		        changeProgramForPagination(area[101].ele[0].dataset['categoryid'],currentPage);
		        if(index == 0){
		    		nextEle = 4
		    		sessionStorage.setItem("gonum", 4);
		        }else {
		        	nextEle = 9
		        	sessionStorage.setItem("gonum", 9);
		        }
			}
		} else {
			// 下一页
			var index = area[101].currentIndex;
			currentPage = area[101].ele[0].dataset['currentpage'];
		    if(currentPage == totalPage) {
		    	return
		    }
		    currentPage++;
		    changeProgramForPagination(area[101].ele[0].dataset['categoryid'],currentPage);
		    if(index == 4){
		    	area[101].currentIndex = 0;
		    	sessionStorage.setItem("gonum", 0);
		    }else {
		    	area[101].currentIndex = 5;
		    	sessionStorage.setItem("gonum", 5);
		    }	
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
}

        //获得地址参数
        function fnGetUrlPara(name) {
            var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"))
            if (result == null || result.length < 1) {
                return ""
            }
            return result[1]
        }
