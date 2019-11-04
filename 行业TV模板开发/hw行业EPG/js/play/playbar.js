var playBarContainer=document.getElementById('playBarContainer')
var playState=playBarContainer.getElementsByClassName('playstate')[0]
var playTime=playBarContainer.getElementsByClassName('playtime')[0]
var playBar=playBarContainer.getElementsByClassName('playbar')[0]
var playBarState=-1//默认隐藏
var playBarTimer
var playStateTimer
var moveLength=1090
var moveTime=30*60//30分钟
var moveTimeUnit=10//每次快进快退时间
var currentTime=moveTime
var moveUnit=moveLength/moveTime

function fnOperatePlayBar(cmd){
	if(playBarState==-1){
		fnRemoveEleClass(playBarContainer,'dn')
		playBarState=0
	}else{
		//计算当前时间
		fnCalculateTime(cmd)
		if(currentTime>=0&&currentTime<=moveTime){	
			var pscn=playState.className.split(' ')
			if(pscn.length>2&&pscn[2]!='playstate-'+cmd){
				fnRemoveEleClass(playState,pscn[2])
			}
			fnAddEleClass(playState,'playstate-'+cmd)
			//改变进度条
			fnMoveBar()
			//将播放状态改为播放
			fnBackToPlayState('playstate-'+cmd)
		}
	}
	//隐藏播放进度层
	fnHidePlayBar()
}

function fnPause(){
	if(playBarState==-1){//进度条层没显示时，暂停
		fnRemoveEleClass(playBarContainer,'dn')
		playBarState=0
		fnAddEleClass(playState,'playstate-pause')
	}else{//进度条层显示时
		if(playState.className.indexOf('playstate-pause')===-1){//进度条显示，但不是暂停状态，暂停
			fnAddEleClass(playState,'playstate-pause')
			clearTimeout(playBarTimer)
		}else{//暂停状态下，继续播放
			fnAddEleClass(playBarContainer,'dn')
			playBarState=-1
			fnRemoveEleClass(playState,'playstate-pause')
			layer=-1
		}
	}
}

function fnCalculateTime(type){
	if(type=='back'){
		currentTime-=moveTimeUnit
	}else{
		currentTime+=moveTimeUnit
	}
	currentTime=Math.min(Math.max(currentTime,0),moveTime)
	playTime.innerHTML=fnFormatPlayTime(currentTime)
}

function fnFormatPlayTime(secs){
	var min=Math.floor(secs/60)
	var sec=secs%60
	min=min<10?'0'+min:min
	sec=sec<10?'0'+sec:sec
	return min+':'+sec
}
function fnMoveBar(){
	var currentLength=currentTime*moveUnit
	console.log(currentLength)
	fnUpdateEleStyle(playBar,'width',currentLength+'px')
}
function fnBackToPlayState(state){
	playStateTimer&&clearTimeout(playStateTimer)
	playStateTimer=setTimeout(function(){
		fnRemoveEleClass(playState,state)
	},500)
}
function fnHidePlayBar(){
	playBarTimer&&clearTimeout(playBarTimer)
	playBarTimer=setTimeout(function(){
		fnAddEleClass(playBarContainer,'dn')
		playBarState=-1
		layer=-1
	},2000)
}
function fnInitPlayBar(){
	playTime.innerHTML=fnFormatPlayTime(moveTime)
}