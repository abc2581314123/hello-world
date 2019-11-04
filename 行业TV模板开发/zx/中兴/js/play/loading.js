var ll=getDom('#loadingLayer')
var frameIndex=0
function loading(){
	if(frameIndex===11){
		frameIndex=0
	}else{
		frameIndex++
	}
	ll.setStyle('background-position-x',-frameIndex*100+'px')
	setTimeout(function(){
		requestAnimationFrame(loading)
	},100)

}
requestAnimationFrame(loading)
setTimeout(function(){
	ll.addClass('dn')
},2000)