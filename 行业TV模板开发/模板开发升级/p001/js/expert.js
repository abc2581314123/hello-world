var domC = document.querySelectorAll('.move');



pageControls = {
    ele: domC[0],
    index: 0,
    moveDir: '',
    leaved: function(){
    },
    entered: function(){
    },
    keyok:function(){
        
        var index = this.ele.getAttribute('data-num');
        sessionStorage.setItem("index3", index);
        var categoryid = this.ele.getAttribute("categoryid");
    	window.location.href = "program_video.jsp?categoryid="+categoryid+"&iaspuserid="+iaspuserid+"&providerid="+providerid+"&backUrlEpg="+backUrlEpg;
   
    },
    keyback:function(){
       
    	window.location.href = backUrl;
    }
}

setTimeout(function(){

    if(sessionStorage.getItem("index3")==null){
        pageControls.ele= domC[0];
        pageControls.index = 0;
    }else{
        pageControls.ele= domC[sessionStorage.getItem("index3")];
        pageControls.index = sessionStorage.getItem("index3");
    }

    bytueTools.fnAddEleClass(pageControls.ele, 'focus');

    var obj = document.getElementsByClassName("move");
    var length = document.getElementsByClassName("move").length;

    for(var i = 0;i<length;i++){
        if(i==0){
            obj[i].setAttribute("categoryid",categories[3]);
        }else if(i==1){
            obj[i].setAttribute("categoryid",categories[4]);
        }
       
    }
},100)

function $(id){
	return document.getElementById(id);
}