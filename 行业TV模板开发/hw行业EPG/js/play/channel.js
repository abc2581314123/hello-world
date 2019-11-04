function fnShowCurrentInfo(){
	isAnimat=true
	fnEleAnimat(document.getElementById('currentInfo'),'left',1280,820,-animatParas.moveUnit.long,function(){
		isAnimat=false
		currentInfoTimer&&clearTimeout(currentInfoTimer)
		currentInfoTimer=setTimeout(fnHideCurrentInfo,2000)
	})
}
function fnHideCurrentInfo(){
	fnEleAnimat(document.getElementById('currentInfo'),'left',820,1280,animatParas.moveUnit.long,function(){
		isAnimat=false
	})
}