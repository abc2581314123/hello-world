// 定义工具类
bytueTools = {

};
// 获取量元素中心点距离
bytueTools.getCenterDis = function(dom1, dom2){
	// 屏幕外元素直接抛出
	if(this.getPos(dom2).aL < 0 || (dom2.dataset['il'] == 0 && dom2.dataset['ir'] == 0)) {
		return;
	}
	// 获取dom1元素的中心点坐标
	var dom1CX = this.getPos(dom1).aL + dom1.offsetWidth / 2;
	var dom1CY = this.getPos(dom1).aT + dom1.offsetHeight / 2;
	// 获取dom1元素的中心点坐标
	var dom2CX = this.getPos(dom2).aL + dom2.offsetWidth / 2;
	var dom2CY = this.getPos(dom2).aT + dom2.offsetHeight / 2;
	var x2 = (dom1CX * 1 - dom2CX * 1) * (dom1CX * 1 - dom2CX * 1);
	var y2 = (dom1CY * 1 - dom2CY * 1) * (dom1CY * 1 - dom2CY * 1);
	return Math.sqrt(x2 + y2);
}


//移除元素样式
bytueTools.fnRemoveEleClass = function(ele,className){
	var classNames=ele.className;
	if(classNames.indexOf(className)==0){

		ele.className=classNames.replace(className,'');
	}
	if(classNames.indexOf(className)>0){
		ele.className=classNames.replace(' '+className,'');
	}
}
//添加元素样式
bytueTools.fnAddEleClass = function(ele,className){
	if(ele.className.indexOf(className)>=0){
		return;
	}
	ele.className+=' '+className;
}

//计算元素的绝对定位位置
bytueTools.getPos = function(ele){
	// var posL = 0, posT = 0;
	// while(ele.tagName !== 'BODY') {
	// 	var styleP = window.getComputedStyle(ele, null).getPropertyValue("position");
	// 	if(styleP == 'relative' || styleP == 'static'|| styleP == 'absolute'){
	// 		console.log(ele, ele.offsetTop)
	// 		posL += (ele.offsetLeft * 1);
	// 		posT += (ele.offsetTop * 1);
	// 	}
	// 	ele = ele.parentNode;
	// }
	return {
		aL: parseInt(ele.getBoundingClientRect().left),
		aT: parseInt(ele.getBoundingClientRect().top)
	}
}
//横向滑动
bytueTools.MoveH = function(ele,mul){
	ele.style.transform = 'translate3d('+ mul +'px,0,0)';
    ele.style.webkitTransform = 'translate3d('+ mul +'px,0,0)';
    ele.addEventListener("webkitTransitionEnd", this.getPosd());
}

//竖向滑动
bytueTools.MoveV = function(ele,mul, callback){
	ele.style.transform = 'translate3d(0,'+ mul +'px,0)';
    ele.style.webkitTransform = 'translate3d(0,'+ mul +'px,0)';
    ele.addEventListener("webkitTransitionEnd", this.getPosd());
}

bytueTools.getPosd = function(){
	for(var i = 0, len = domC.length; i < len; i++){
		var aLT = this.getPos(domC[i])
		var aL = aLT.aL;
		var aT = aLT.aT;
		var iL = aL;
		var iR = aL + domC[i].offsetWidth;
		var iU = aT;
		var iD = aT + domC[i].offsetHeight;

		domC[i].dataset['il'] = iL;
		domC[i].dataset['ir'] = iR;
		domC[i].dataset['it'] = iU;
		domC[i].dataset['idd'] = iD;
		domC[i].dataset['num'] = i;
		//表明自身所在父级区域
		domC[i].dataset['area'] = bytueTools.findMparaentNode(domC[i]).dataset['area'];
	}
}


HTMLElement.prototype.__setStyle=function(member,value){
	this.style[member]=value;
	return this;
}

isAnimat=false
//一个元素动画
bytueTools.fnEleAnimat = function(ele,styleName,current,des,mul,callback,callbackParas){
	isAnimat=true;
	animat();
	function animat(){
		current+=mul;
		if(moveEnd()){
			current=des;
			ele.__setStyle(styleName,current+'px');
			callback&&callback(callbackParas);
			isAnimat=false;
			return;
		}
		ele.__setStyle(styleName,current+'px');
		if(window.requestAnimationFrame){
			requestAnimationFrame(animat);
		}else{
			setTimeout(animat,20);
		}
	}
	function moveEnd(){
		return mul>0?current>=des:current<=des;
	}
}

// 检测dom元素是否有指定样式
bytueTools.hasClassFun = function( element, cls){
	return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
}

// 轮播函数
var timer = null
bytueTools.loopPic = function(parent) {
    var aLis = parent.getElementsByTagName('ul')[0].getElementsByTagName('li');
    var oUl = parent.getElementsByTagName('ul')[0];
    var oOl = parent.getElementsByTagName('ol')[0];
    oUl.style.width = aLis.length * aLis[0].offsetWidth + 'px';
    var num = 0;
    timer = setInterval(function() {
        num++;
        oUl.style.left = -(num * aLis[0].offsetWidth) + 'px';
        for(var l = 0, len = 4; l < len; l++) {
            oOl.getElementsByTagName('li')[l].style.background = '#fff';
        }
        if(oUl.offsetLeft == -2220) {;
            num=0;
            oUl.style.left = 0;
        }
        oOl.getElementsByTagName('li')[num].style.background = 'yellow';
    }, 2000)
}

// 找到目标父元素
bytueTools.findMparaentNode = function(ele) {
	var parentNode = ele.parentNode;
	while(!parentNode.dataset['area']) {
		parentNode = parentNode.parentNode;
	}
	return parentNode
}

// 获取网址参数

bytueTools.fnGetUrlPara = function(name) {
    var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"))
    if (result == null || result.length < 1) {
        return ""
    }
    return result[1]
}

// 返回当前元素在数组的索引
bytueTools.searchInArray = function(arr,dst){
    var i = arr.length;
    while(i-=1){
        if (arr[i] == dst){
           return i;
        }
    }
    return 0;
}

bytueTools.delHtmlTag = function (str)
{
	return str.replace(/<[^>]+>/g,"");  //正则去掉所有的html标记
}