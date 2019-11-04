
(function(){
  // bytueTools命名空间
  if(!window.bytueTools){
    window['bytueTools'] = {}
  }

	function getCenterDis(dom1, dom2){
		// 获取dom1元素的中心点坐标
		let dom1CX = dom1.offsetLeft + dom1.offsetWidth / 2;
		let dom1CY = dom1.offsetTop + dom1.offsetHeight / 2;

		// 获取dom1元素的中心点坐标
		let dom2CX = dom2.offsetLeft + dom2.offsetWidth / 2;
		let dom2CY = dom2.offsetTop + dom2.offsetHeight / 2;

		let x2 = (dom1CX * 1 - dom2CX * 1) * (dom1CX * 1 - dom2CX * 1);
		let y2 = (dom1CY * 1 - dom2CY * 1) * (dom1CY * 1 - dom2CY * 1);
		return Math.sqrt(x2 + y2);
	}
	window['bytueTools']['getCenterDis'] = getCenterDis;

	//移除元素样式
	function fnRemoveEleClass (ele,className){
		var classNames=ele.className
		if(classNames.indexOf(className)==0){

			ele.className=classNames.replace(className,'')
		}
		if(classNames.indexOf(className)>0){
			ele.className=classNames.replace(' '+className,'')
		}
	}
	window['bytueTools']['fnRemoveEleClass'] = fnRemoveEleClass;


	//添加元素样式
	function fnAddEleClass(ele,className){
		if(ele.className.indexOf(className)>=0){
			return
		}
		ele.className+=' '+className
	}
	window['bytueTools']['fnAddEleClass'] = fnAddEleClass;

	//计算元素的绝对定位位置
	function getPos(ele){
		var posL = 0, posT = 0;
		while(ele.parentNode.tagName !== 'BODY') {
			let styleP = window.getComputedStyle(ele, null).getPropertyValue("position");
			if(styleP == 'relative' || styleP == 'static'|| styleP == 'absolute'){
				posL += (ele.offsetLeft * 1);
				posT += (ele.offsetTop * 1);
			}
			ele = ele.parentNode;
		}
		return {
			aL: posL,
			aT: posT
		}
	}
	window['bytueTools']['getPos'] = getPos;
})()