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

    	console.log(this.ele);
        //0是内科系1是外科系
        var index = this.ele.getAttribute('data-num');

        sessionStorage.setItem("index2", index);
        var categoryid = this.ele.getAttribute("categoryid");
        window.location.href ="list.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&backUrlEpg="+backUrlEpg+"&index="+index;
     
    },
    keyback:function(){
    	window.location.href = backUrl;
    }
}


setTimeout(function(){


    if(sessionStorage.getItem("index2")==null){
        pageControls.ele= domC[0];
        pageControls.index = 0;
    }else{
        pageControls.ele= domC[sessionStorage.getItem("index2")];
        pageControls.index = sessionStorage.getItem("index2");
    }

    bytueTools.fnAddEleClass(pageControls.ele, 'focus');
   	var obj = document.getElementsByClassName("move");
    var length = document.getElementsByClassName("move").length;

    for(var i = 0;i<length;i++){
        if(i==0){
            obj[i].setAttribute("categoryid",categories[1]);
        }else if(i==1){
            obj[i].setAttribute("categoryid",categories[2]);
        }
       
    }
},100)


function $(id){
	return document.getElementById(id);
}