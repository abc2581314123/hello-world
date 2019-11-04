var log={};
log.write=(function(){
	//创建div
	function createNewPannel(){
		var logPannel;
		logPannel=document.createElement('div');
		logPannel.id='logPannel';
		logPannel.style.position='absolute';
		logPannel.style.left='0';
		logPannel.style.top='0';
		logPannel.style.zIndex='999';
		logPannel.style.width='100%';
		logPannel.style.height='100%';
		logPannel.style.backgroundColor='rgba(0,0,0,.8)';
		logPannel.style.color='#ed8';
		logPannel.style.fontSize='21px';
		logPannel.style.padding='50px';
		document.body.appendChild(logPannel);
		return logPannel;
	}
	//该不该创建div
	function getSingleton(fn){
		var logPannel
		return function(){
			if(!logPannel){
				logPannel=fn.apply(this,arguments);
			}
			return logPannel;
		}
	}
	var createPannel=getSingleton(createNewPannel);
	return function(info){
		var logPannel=createPannel();
		var p=document.createElement('p');
		p.style.margin='10px 0';
		p.innerText=info;
		logPannel.appendChild(p);
	}
})();


