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

        index = this.ele.getAttribute('data-num');
        sessionStorage.setItem("index", index);
        if(index == 0){
            window.location.href = "nav.jsp?iaspuserid="+iaspuserid+"&providerid="+providerid+"&backUrl="+backUrlEpg;
        }else{
            window.location.href = profession_url+"&backUrl="+backUrlEpg;
        }

    },
    keyback:function(){
    	
    }
}

setTimeout(function(){
    
    if(sessionStorage.getItem("index")==null){
        pageControls.ele= domC[0];
        pageControls.index = 0;
    }else{
        pageControls.ele= domC[sessionStorage.getItem("index")];
        pageControls.index = sessionStorage.getItem("index");
    }

    
    bytueTools.fnAddEleClass(pageControls.ele, 'focus');
    $("test").innerHTML = "index: "+ this.pageControls.index;
},100)

function $(id){
	return document.getElementById(id);
}