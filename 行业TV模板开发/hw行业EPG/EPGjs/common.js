//一个元素动画
function fnEleAnimat(ele,styleName,current,des,mul,callback,callbackParas){
	isAnimat=true
	
	animat()
	function animat(){
		current+=mul
		if(moveEnd()){
			current=des
			fnUpdateEleStyle(ele,styleName,current+'px')
			callback&&callback(callbackParas)
			isAnimat=false
			return
		}
		fnUpdateEleStyle(ele,styleName,current+'px')
		setTimeout(animat,20)
	}
	function moveEnd(){
		return mul>0?current>=des:current<=des
	}
}
//两个元素同时动画
function fnElesAnimat(ele1,styleName1,current1,des1,mul1,ele2,styleName2,current2,des2,mul2,callback,callbackParas){
	isAnimat=true
	animat()
	function animat(){
		var ele1MoveEnd=false
		var ele2MoveEnd=false
		current1+=mul1
		current2+=mul2
		if(!ele1MoveEnd){
			if(moveEnd1()){
				current1=des1
				fnUpdateEleStyle(ele1,styleName1,current1+'px')
				ele1MoveEnd=true
			}else{
				fnUpdateEleStyle(ele1,styleName1,current1+'px')
			}
		}
		if(!ele2MoveEnd){
			if(moveEnd2()){
				current2=des2
				fnUpdateEleStyle(ele2,styleName2,current2+'px')
				ele2MoveEnd=true
			}else{
				fnUpdateEleStyle(ele2,styleName2,current2+'px')
			}
		}
		//两个动画都结束
		if(ele1MoveEnd&&ele2MoveEnd){
			callback&&callback(callbackParas)
			isAnimat=false
			return
		}
		setTimeout(animat,20)
	}
	function moveEnd1(){
		return mul1>0?current1>=des1:current1<=des1
	}
	function moveEnd2(){
		return mul2>0?current2>=des2:current2<=des2
	}
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
//移除当前节目效果
function fnRemoveCurrentStyle(){
	fnAddEleClass(program.current.ele.getElementsByClassName('program-sel')[0],'dn')
}
//添加当前节目效果
function fnAddCurrentStyle(){
	fnRemoveEleClass(program.current.ele.getElementsByClassName('program-sel')[0],'dn')
}
function fnGetQueryStringByName(name) {
    var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
    if (result == null || result.length < 1) {
        return "";
    }
    return result[1];
}

//nav添加移入样式
function changeUrlIn(ele){
	var src = ele.getElementsByTagName('img')[0].getAttribute('src')
	var imgName = src.slice(src.indexOf('/')+1,src.indexOf('.'))+'H';
	ele.getElementsByTagName('img')[0].setAttribute('src','images/'+imgName+'.png')
}

//nav添加移出样式
function changeUrlOut(ele){
	var src = ele.getElementsByTagName('img')[0].getAttribute('src')
	var imgName = src.slice(src.indexOf('/')+1,src.indexOf('.'));
	imgName=imgName.substring(0,imgName.length-1)	
	ele.getElementsByTagName('img')[0].setAttribute('src','images/'+imgName+'.png')
}

//动态插入电影海报焦点列表
function pushMMp(){
moiveMoveParas = [];
	
for(var i = 0; i < moveList.length; i++){	
	//不是最后一行  并且 不是最后一个元素  并且 第二行对应的位置还有元素
	if(Math.floor(i/5) < oUlNum-1 && i!=moveList.length-1 && i+5<moveList.length){
	
		moiveMoveParas.push({up:Math.floor(i/5)==0?-1:i-5,right:i+1,down:i+5,left:i-1});
		}
		
	//不是最后一行  并且 不是最后一个元素  并且 第二行没有对应的位置还有元素	
	if(Math.floor(i/5)< oUlNum-1 && i!=moveList.length-1 && i+5>=moveList.length){
		moiveMoveParas.push({up:Math.floor(i/5)==0?-1:i-5,right:i+1,down:moveList.length-1,left:i-1});
		}	
		
	//不是最后一行  并且 是最后一个元素  并且 第二行没有对应的位置还有元素	
	if(Math.floor(i/5) < oUlNum-1 && i==moveList.length-1 && i+5>=moveList.length){
		moiveMoveParas.push({up:Math.floor(i/5)==0?-1:i-5,right:-1,down:-1,left:i-1});
		}	
		
	//不是最后一行  并且 是最后一个元素  并且 第二行对应的位置还有元素	
	if(Math.floor(i/5) < oUlNum-1 && i==moveList.length-1 && i+5<moveList.length){
		moiveMoveParas.push({up:Math.floor(i/5)==0?-1:i-5,right:-1,down:i+5,left:i-1});
		}
		
			
			
	//在最后一行  并且 不是最后一个元素 
	if(Math.floor(i/5)==oUlNum-1 && i!=moveList.length-1 ){
		moiveMoveParas.push({up:i-5,right:i+1,down:-1,left:i-1});
		}
		
	//在最后一行  并且 是最后一个元素	
	if(Math.floor(i/5)==oUlNum-1 && i==moveList.length-1){
		moiveMoveParas.push({up:i-5,right:-1,down:-1,left:i-1});
		}	
	}
	
for(var i = 0; i < moveList.length; i++){
		
	if(i%5==0){
		moiveMoveParas[i].left = 100;
	}	
	if(i%5==4){
		moiveMoveParas[i].right = -1;
	}
}

}