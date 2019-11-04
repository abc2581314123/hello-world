//dom原型扩展
HTMLElement.prototype.addClass=function(className){
	if(this.className.indexOf(className)>=0){
		return this;
	}
	if(this.className.length>0){
		className=' '+className;
	}
	this.className+=className;
	return this;
};
HTMLElement.prototype.removeClass=function(className){
	if(this.className.length==0){
		return this;
	}
	var reg=new RegExp('\s'+className+'|'+className+'\s'+'|'+className);
	this.className=this.className.replace(reg,'');
	return this;
};
HTMLElement.prototype.modifyClass=function(className,newClassName){
	if(this.className.indexOf(className)<0){
		return this;
	}
	this.className=this.className.replace(className,newClassName);
	return this;
};
HTMLElement.prototype.setStyle=function(member,value){
	this.style[member]=value;
	return this;
};
HTMLElement.prototype.getStyle=function(member){
	return this.style[member];
};
//js原型扩展
!String.prototype.trim&&(String.prototype.trim=function(){
	return this.replace(/(^\s*)|(\s*$)/g,'');
});
function getDom(selector){
	var regS=/^(#|.)([A-Za-z0-9_-]*$)/.exec(selector)
	   ,dom=null
	if(regS===null){
		return null
	}
	switch(regS[1]){
		case '.':
			dom=document.getElementsByClassName(regS[2])
			dom.length===0?null:dom
			break
		case '#':
			dom=document.getElementById(regS[2])
			break
		default:
			break
	}
	return dom
};