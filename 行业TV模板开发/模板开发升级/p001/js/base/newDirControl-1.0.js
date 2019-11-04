/**
* @Author: bytue
* @Date:   2019-03-26
* @Last Modified by:   bytue
* @description: 自动处理位置移动逻辑-----就近原则
**/	



/** 简要逻辑说明：
* 用于记录距离最小的元素索引
* 先查看当前元素是否手动定义了下一个元素的索引有则直接返回目标索引值并更新相关内容
* 1. 初步找到目标元素组 原则如 按右键 则目标元素的左边距应大于当前元素的右边距 或 按上键 则目标元素的下边距应该小于当前元素的上边距
* 2. 如果初步筛选发现没有可选元素说明本区域内已经达到边界值 在 整体查元素找到 其他区域距离最近的元素
* 2. 从初步筛选数组中找到距离最近的元素数组
* 3. 判断二次筛选数组的元素个数 如果只有一个元素则直接返回目标索引值并更新相关内容
* 4. 如二次筛选数组出现多个元素则先判断是否有同列或者同行元素有则直接返回目标索引值并更新相关内容
* 5. 通过计算两元素中心店距离计算出距离当前元素最近的目标元素并返回标索引值并更新相关内容
**/

window.onload = function(){
	bytueTools.getPosd();
}
// 获取所有可获取焦点元素距离屏幕左上角的绝对位置并赋予自身

// 获取上下左右最近元素
function Nearest() {
	this.dom = pageControls.ele;
}


Nearest.prototype.rightN = function(){
	// 判断是否有手动固定移动位置
	if(pageControls.ele.dataset['goright']){
		if(pageControls.ele.dataset['goright'] == '-1') {
			return pageControls.index;
		} else {
			pageControls.index = pageControls.ele.dataset['goright'];
			return pageControls.ele.dataset['goright'];
		}
		
	}
	var minR = 0;
	var minRValue = 100000;
	var minArray = [];
	var domR = pageControls.ele.dataset['ir'];
	if(bytueTools.findMparaentNode(pageControls.ele).dataset['rarea'] || pageControls.ele.dataset['rarea']) {
		var rarea = bytueTools.findMparaentNode(pageControls.ele).dataset['rarea'] || pageControls.ele.dataset['rarea'];
		var domS = document.getElementById(rarea).dataset['areaindex']  || document.getElementById(rarea).getElementsByClassName('move')[0].dataset['num'];
		pageControls.index = domS;
		return domS;
	} else {
		for(var i = 0, len = domC.length; i < len; i++){
			var il = domC[i].dataset['il'];
			if((il * 1) >= (domR * 1) && domC[i].dataset['area'] == pageControls.ele.dataset['area']){	
				if(il * 1 <= minRValue){
					minRValue = domC[i].dataset['il'] * 1;
				}
			}
		}
	}
	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(minRValue == domC[p].dataset['il']){
			minArray.push(p);
		}
	}
	// 判断边界值
	if(minRValue == 100000){
		this.areaRight();
		return pageControls.index;
	}
	if(minArray.length > 1){
		// 判断是否在一行
		for(var k = 0, len3 = minArray.length; k < len3; k++){
			if(domC[minArray[k]].dataset['it'] == pageControls.ele.dataset['it'] || domC[minArray[k]].dataset['idd'] == pageControls.ele.dataset['idd']){
				pageControls.index = minArray[k];
				return minArray[k];	
			}
		}
		var minRValue2 = 100000;

		// 判断中心点自小值
		for(var j = 0, len2 = minArray.length; j < len2; j++){
			var iCDis = bytueTools.getCenterDis(pageControls.ele, domC[minArray[j]]);
			if(iCDis < minRValue2){
				minRValue2 = iCDis;
				minR = minArray[j];
			}
		}
		pageControls.index = minR;
		return minR;	
	}else {
		pageControls.index = minArray[0];
		return minArray[0];
	}
}


Nearest.prototype.leftN = function(){
	// 判断是否有手动固定移动位置
	if(pageControls.ele.dataset['goleft']){
		if(pageControls.ele.dataset['goleft'] == '-1') {
			return pageControls.index;
		} else {
			pageControls.index = pageControls.ele.dataset['goleft'];
			return pageControls.ele.dataset['goleft'];
		}
		
	}

	var maxL = 0;
	var maxLValue = 0;
	var maxArray = [];
	var domL = pageControls.ele.dataset['il'];
	if(bytueTools.findMparaentNode(pageControls.ele).dataset['larea'] || pageControls.ele.dataset['larea']) {;
		var larea = bytueTools.findMparaentNode(pageControls.ele).dataset['larea'] || pageControls.ele.dataset['larea'];
		var domS = document.getElementById(larea).dataset['areaindex']  || document.getElementById(larea).getElementsByClassName('move')[0].dataset['num'];
		pageControls.index = domS;
		return domS;
	} else {
		for(var i = 0, len = domC.length; i < len; i++){
			var ir = domC[i].dataset['ir'];
			if((ir * 1) <= (domL * 1) && domC[i].dataset['area'] == pageControls.ele.dataset['area']){
				if(ir * 1 >= maxLValue){
					maxLValue = domC[i].dataset['ir'] * 1;
				}
			}
		}
	}
	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(maxLValue == domC[p].dataset['ir']){
			maxArray.push(p);
		}
	}
	// 判断边界值
	if(maxLValue == 0){
		this.areaLeft();
		return pageControls.index;
	}
	if(maxArray.length > 1){
		for(var k = 0, len3 = maxArray.length; k < len3; k++){
			if(domC[maxArray[k]].dataset['it'] == pageControls.ele.dataset['it'] || domC[maxArray[k]].dataset['idd'] == pageControls.ele.dataset['idd']){
				pageControls.index = maxArray[k];
				return maxArray[k];	
			}
		}

		var maxLValue2 = 100000;

		// 判断中心点自小值
		for(var j = 0, len2 = maxArray.length; j < len2; j++){
			var iCDis = bytueTools.getCenterDis(pageControls.ele, domC[maxArray[j]]);
			if(iCDis < maxLValue2){
				maxLValue2 = iCDis;
				maxL = maxArray[j]
			}
		}

		pageControls.index = maxL;
		return maxL;	
	}else {
		pageControls.index = maxArray[0];
		return maxArray[0];
	}
}


Nearest.prototype.downN = function(){
	// 判断是否有手动固定移动位置
	if(pageControls.ele.dataset['godown']){
		if(pageControls.ele.dataset['godown'] == '-1') {
			return pageControls.index;
		} else {
			pageControls.index = pageControls.ele.dataset['godown'];
			return pageControls.ele.dataset['godown'];
		}
	}

	var minD = 0;
	var minDValue = 100000;
	var minArray = [];
	var domD = pageControls.ele.dataset['idd'];
	if(bytueTools.findMparaentNode(pageControls.ele).dataset['darea'] || pageControls.ele.dataset['darea']) {
		var darea = bytueTools.findMparaentNode(pageControls.ele).dataset['darea'] || pageControls.ele.dataset['darea'];
		var domS = document.getElementById(darea).dataset['areaindex']  || document.getElementById(darea).getElementsByClassName('move')[0].dataset['num'];
		pageControls.index = domS;
		return domS;
	} else {
		for(var i = 0, len = domC.length; i < len; i++){
			var it = domC[i].dataset['it'];
			if((it * 1) >= (domD * 1) && domC[i].dataset['area'] == pageControls.ele.dataset['area']){
				if(it * 1 < minDValue){
					minDValue = domC[i].dataset['it'] * 1;
				}
			}
		}
	}

	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(minDValue == domC[p].dataset['it']){
			minArray.push(p)
		}
	}
	// 判断边界值
	if(minDValue == 100000){
		this.areaDown();
		return pageControls.index;
	}
	// 判断是否在一列
	if(minArray.length > 1){
		for(var k = 0, len3 = minArray.length; k < len3; k++){
			if(domC[minArray[k]].dataset['il'] == pageControls.ele.dataset['il']){
				if(domC[minArray[k]].dataset['ir'] == pageControls.ele.dataset['ir']){
					pageControls.index = minArray[k];
					return minArray[k];
				}
			}
		}

		var minDValue2 = 100000;

		// 判断中心点自小值
		for(var j = 0, len2 = minArray.length; j < len2; j++){
			var iCDis = bytueTools.getCenterDis(pageControls.ele, domC[minArray[j]]);
			if(iCDis < minDValue2){
				minDValue2 = iCDis;
				minD = minArray[j]
			}
		}
		pageControls.index = minD;
		return minD;	
	}else {
		pageControls.index = minArray[0];
		return minArray[0];
	}
}



Nearest.prototype.upN = function(){
	// 判断是否有手动固定移动位置
	if(pageControls.ele.dataset['goup']){
		if(pageControls.ele.dataset['goup'] == '-1') {
			return pageControls.index;
		} else {
			pageControls.index = pageControls.ele.dataset['goup'];
			return pageControls.ele.dataset['goup'];
		}
		
	}

	var maxD = 0;
	var maxDValue = 0;
	var maxArray = [];
	var domT = pageControls.ele.dataset['it'];
	for(var i = 0, len = domC.length; i < len; i++){
		var idd = domC[i].dataset['idd'];
		if(bytueTools.findMparaentNode(pageControls.ele).dataset['uarea'] || pageControls.ele.dataset['uarea']) {
			var uarea = bytueTools.findMparaentNode(pageControls.ele).dataset['uarea'] || pageControls.ele.dataset['uarea'];
			var domS = document.getElementById(uarea).dataset['areaindex']  || document.getElementById(uarea).getElementsByClassName('move')[0].dataset['num'];
			pageControls.index = domS;
			return domS;
		} else {
			if((idd * 1) <= (domT * 1) && domC[i].dataset['area'] == pageControls.ele.dataset['area']){
				if(idd * 1 >= maxDValue){
					maxDValue = domC[i].dataset['idd'] * 1;
				}
			}
		}
	}
	// 找到所有满足条件的索引
	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(maxDValue == domC[p].dataset['idd']){
			maxArray.push(p);
		}
	}
	// 判断边界值
	if(maxDValue == 0){
		this.areaUp();
		return pageControls.index;
	}
	if(maxArray.length > 1){
		var maxDValue2 = 100000;

		// 判断是否在一列
		for(var k = 0, len3 = maxArray.length; k < len3; k++){
			if(domC[maxArray[k]].dataset['il'] == pageControls.ele.dataset['il']){
				if(domC[maxArray[k]].dataset['ir'] == pageControls.ele.dataset['ir']){
					pageControls.index = maxArray[k];
					return maxArray[k];
				}
				
			}
		}

		// 判断中心点自小值
		for(var j = 0, len2 = maxArray.length; j < len2; j++){

			var iCDis = bytueTools.getCenterDis(pageControls.ele, domC[maxArray[j]]);
			if(iCDis < maxDValue2){
				maxDValue2 = iCDis;
				maxD = maxArray[j];
			}
		}

		pageControls.index = maxD;
		return maxD;	
	}else {
		pageControls.index = maxArray[0];
		return maxArray[0];
	}
}

Nearest.prototype.areaUp = function(){
	// 
	var maxD = 0;
	var maxDValue = 0;
	var maxArray = [];
	var domT = pageControls.ele.dataset['it'];
	for(var i = 0, len = domC.length; i < len; i++){
		var idd = domC[i].dataset['idd'];
		if((idd * 1) < (domT * 1)){
			if(idd * 1 >= maxDValue){
				maxDValue = domC[i].dataset['idd'] * 1;
			}
		}
	}

	// 找到所有满足条件的索引
	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(maxDValue == domC[p].dataset['idd']){
			maxArray.push(p);
		}
	}
	if(maxArray.length >= 1){
		var maxDValue2 = 100000;
		
		// 判断是否在一列
		for(var k = 0, len3 = maxArray.length; k < len3; k++){

			if(domC[maxArray[k]].dataset['il'] == pageControls.ele.dataset['il']){
				if(domC[maxArray[k]].dataset['ir'] == pageControls.ele.dataset['ir']){
					pageControls.index = maxArray[k];

					return maxArray[k];
				}
			}
		}

		// 判断中心点自小值
		var iCDis
		for(var j = 0, len2 = maxArray.length; j < len2; j++){
			iCDis = bytueTools.getCenterDis(pageControls.ele, domC[maxArray[j]]);
			if(iCDis < maxDValue2){
				maxDValue2 = iCDis;
				maxD = maxArray[j];
			}
		}

		if(!iCDis) {
			return pageControls.index
		}

		if(bytueTools.findMparaentNode(domC[maxD]).dataset['areaindex']) {
			pageControls.index = bytueTools.findMparaentNode(domC[maxD]).dataset['areaindex'];
		}else {
			pageControls.index = maxD;	
		}
	}
	return pageControls.index;
}


Nearest.prototype.areaDown = function(){
	var minD = 0;
	var minDValue = 100000;
	var minArray = [];
	var domD = pageControls.ele.dataset['idd'];
	for(var i = 0, len = domC.length; i < len; i++){
		var it = domC[i].dataset['it'];
		if((it * 1) > (domD * 1)){
			if(it * 1 < minDValue){
				minDValue = domC[i].dataset['it'] * 1;
			}
		}
	}
	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(minDValue == domC[p].dataset['it']){
			minArray.push(p);
		}
	}
	if(minArray.length >= 1){
		for(var k = 0, len3 = minArray.length; k < len3; k++){
			if(domC[minArray[k]].dataset['il'] == pageControls.ele.dataset['il']){
				if(domC[minArray[k]].dataset['ir'] == pageControls.ele.dataset['ir']){
					pageControls.index = minArray[k];
					return minArray[k];
				}
			}
		}

		var minDValue2 = 100000;
		// 判断中心点自小值
		for(var j = 0, len2 = minArray.length; j < len2; j++){
			var iCDis = bytueTools.getCenterDis(pageControls.ele, domC[minArray[j]]);
			if(iCDis < minDValue2){
				minDValue2 = iCDis;
				minD = minArray[j]
			}
		}
		if(bytueTools.findMparaentNode(domC[minD]).dataset['areaindex']) {
			pageControls.index = bytueTools.findMparaentNode(domC[minD]).dataset['areaindex'];
		}else {
			pageControls.index = minD;
		}
		
	}
	return pageControls.index;
}



Nearest.prototype.areaLeft = function(){
	var maxL = 0;
	var maxLValue = 0;
	var maxArray = [];
	var domL = pageControls.ele.dataset['il'];
	for(var i = 0, len = domC.length; i < len; i++){
		var ir = domC[i].dataset['ir'];
		if((ir * 1) < (domL * 1)){
			if(ir * 1 >= maxLValue){
				maxLValue = domC[i].dataset['ir'] * 1;
			}
		}
	}
	if(maxLValue == 0) {
		return pageControls.index;
	}

	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(maxLValue == domC[p].dataset['ir']){
			maxArray.push(p);
		}
	}

	if(maxArray.length >= 1){
		// 判断是否在一行
		for(var k = 0, len3 = maxArray.length; k < len3; k++){
			if(domC[maxArray[k]].dataset['it'] == pageControls.ele.dataset['it']){
				if(domC[maxArray[k]].dataset['idd'] == pageControls.ele.dataset['idd']){
					pageControls.index = maxArray[k];
					return maxArray[k];
				}	
			}
		}
		var maxLValue2 = 100000;

		// 判断中心点自小值
		for(var j = 0, len2 = maxArray.length; j < len2; j++){
			var iCDis = bytueTools.getCenterDis(pageControls.ele, domC[maxArray[j]]);
			if(iCDis < maxLValue2){
				maxLValue2 = iCDis;
				maxL = maxArray[j];
			}
		}
		if(bytueTools.findMparaentNode(domC[maxL]).dataset['areaindex']) {
			pageControls.index = bytueTools.findMparaentNode(domC[maxL]).dataset['areaindex'];
		}else {
			pageControls.index = maxL;
		}
	}
	return pageControls.index;
}

Nearest.prototype.areaRight = function(){
	var minR = 0;
	var minRValue = 100000;
	var minArray = [];
	var domR = pageControls.ele.dataset['ir'];
	for(var i = 0, len = domC.length; i < len; i++){
		var il = domC[i].dataset['il'];
		if((il * 1) > (domR * 1)){
			if(il * 1 <= minRValue){
				minRValue = domC[i].dataset['il'] * 1;
			}
		}
	}
	for(var p = 0, len4 = domC.length; p < len4; p++){
		if(minRValue == domC[p].dataset['il']){
			minArray.push(p);
		}
	}

	// 判断边界值
	if(minRValue == 100000){
		return pageControls.index;
	}
	if(minArray.length >= 1){
		// 判断是否在一行
		for(var k = 0, len3 = minArray.length; k < len3; k++){
			if(domC[minArray[k]].dataset['it'] == pageControls.ele.dataset['it']){
				if(domC[minArray[k]].dataset['idd'] == pageControls.ele.dataset['idd']){
					pageControls.index = minArray[k];
					return minArray[k];
				}	
			}
		}

		var minRValue2 = 100000;

		// 判断中心点自小值
		for(var j = 0, len2 = minArray.length; j < len2; j++){
			var iCDis = bytueTools.getCenterDis(pageControls.ele, domC[minArray[j]]);
			if(iCDis < minRValue2){
				minRValue2 = iCDis;
				minR = minArray[j];
			}
		}
		if(bytueTools.findMparaentNode(domC[minR]).dataset['areaindex']) {
			pageControls.index = bytueTools.findMparaentNode(domC[minR]).dataset['areaindex'];
		}else {
			pageControls.index = minR;
		}
	}
	return pageControls.index;
}

var nearestClass =  new Nearest();