var volValue=0
var volMaxValue=20
var unitDeg=360/20
var volBarLeft=document.getElementById('volBarLeft')
var volBarRight=document.getElementById('volBarRight')
var leftContainer=document.getElementById('leftContainer')
var volLayer=document.getElementById('volLayer')
var icoVol=document.getElementById('icoVol')
var volTimer
function keyVolUp(){
// function keyBack(){
	fnShowVolLayer()
	if(volValue==volMaxValue){
		return
	}
	//修改静音图标为有声图标
	if(volValue==0){
		fnRemoveEleClass(icoVol,'bar-center-nosound')
	}
	volValue++
	if(unitDeg*volValue>=180){
		//右侧条全部显示
		fnRemoveEleClass(volBarRight,'vh')
		//左侧遮挡层去掉
		fnAddEleClass(leftContainer,'vh')
	}
	volBarLeft.style.transform='rotateZ('+unitDeg*volValue+'deg)'
	volBarLeft.style.webkitTransform='rotateZ('+unitDeg*volValue+'deg)'
}

function keyVolDown(){
// function keyOk(){
	fnShowVolLayer()
	if(volValue==0){
		return
	}
	volValue--
	//修改有声图标为静音图标
	if(volValue==0){
		fnAddEleClass(icoVol,'bar-center-nosound')
	}
	if(unitDeg*volValue<180){
		//右侧条全部隐藏
		fnAddEleClass(volBarRight,'vh')
		//左侧遮挡层
		fnRemoveEleClass(leftContainer,'vh')
	}
	volBarLeft.style.transform='rotateZ('+unitDeg*volValue+'deg)'
	volBarLeft.style.webkitTransform='rotateZ('+unitDeg*volValue+'deg)'
}

function fnIniVol(){
	//修改有声图标为静音图标
	if(volValue==0){
		fnAddEleClass(icoVol,'bar-center-nosound')
	}
	if(unitDeg*volValue>=180){
		//右侧条全部显示
		fnRemoveEleClass(volBarRight,'vh')
		//左侧遮挡层去掉
		fnAddEleClass(leftContainer,'vh')
	}

	volBarLeft.style.transform='rotateZ('+unitDeg*volValue+'deg)'
	volBarLeft.style.webkitTransform='rotateZ('+unitDeg*volValue+'deg)'
}

function fnShowVolLayer(){
	volTimer&&clearTimeout(volTimer)
	fnRemoveEleClass(volLayer,'dn')
	volTimer=setTimeout(function(){
		fnAddEleClass(volLayer,'dn')
	},2000)
}

// window.onload=function(){
// 	fnIniVol()
// }