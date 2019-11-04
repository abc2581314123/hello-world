var canBeMove = true
function keyMove(dir){
	if(!canBeMove) {
		return
	}
	setTimeout(function(){
		canBeMove = true
	},100)
	canBeMove = false
	pageControls.moveDir = dir
	bytueTools.fnRemoveEleClass(pageControls.ele, 'focus');
	pageControls.leaved ? pageControls.leaved() : function(){};
	bytueTools.findMparaentNode(pageControls.ele).dataset['areaindex'] = pageControls.index;
	var disN = dir+'N';
	pageControls.ele = domC[nearestClass[disN]()];
	pageControls.entered ? pageControls.entered() : function(){};
	bytueTools.fnAddEleClass(pageControls.ele, 'focus');
	bytueTools.findMparaentNode(pageControls.ele).dataset['areaindex'] = pageControls.index;
}

function keyRight(){
	keyMove('right');
}

function keyLeft(){
	keyMove('left');
}

function keyUp(){
	keyMove('up');
}

function keyDown(){
	keyMove('down');
}

function keyOk(){
	pageControls.keyok()
	// console.log(pageControls.index);
}
function keyBack(){
	pageControls.keyback()
}
