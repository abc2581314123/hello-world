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
    	//window.location.href = "nav.html";
    	
    	var categoryid = this.ele.getAttribute('categoryid');
    	console.log(this.ele.getAttribute('data-num'));

    	var index = this.ele.getAttribute('data-num');
        console.log("backUrlEpg====="+backUrlEpg);


        
        sessionStorage.setItem("index1", index);
        //如果导航菜单选中不是科室导航和专家直接跳转播放页
    	if(index!=1&& index!=2&& index!=3 && index!=5 ){
    		window.location.href = "program_video.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&backUrlEpg="+backUrlEpg;
    	}
        //跳转列表选择页
        else{
            if(index ==1){
                window.location.href ="depart.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&backUrl="+backUrlEpg;
            }

            if(index ==2){
               sessionStorage.setItem("item",0);
                window.location.href ="department.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&backUrlEpg="+backUrlEpg;
            }
            if(index ==3){
                window.location.href ="expert.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&backUrl="+backUrlEpg;
            }
            //资讯
            if(index ==5){
                window.location.href ="list2.jsp?categoryid="+categoryid+"&providerid="+providerid+"&iaspuserid="+iaspuserid+"&backUrlEpg="+backUrlEpg;
            }
        }
    },
    keyback:function(){



        sessionStorage.setItem("index1",0);
    	window.location.href = backUrl;
    }
}


setTimeout(function(){

     if(sessionStorage.getItem("index1")==null){
        pageControls.ele= domC[0];
        pageControls.index = 0;
    }else{
        pageControls.ele= domC[sessionStorage.getItem("index1")];
        pageControls.index = sessionStorage.getItem("index1");
    }


    bytueTools.fnAddEleClass(pageControls.ele, 'focus');
   	var lis = document.getElementsByTagName('li');
    var li_len = lis.length;
    for(var i =0;i<li_len;i++){
    	if(i==1||i==3){
    		continue;
    	}
        else if(i==5){
            lis[i].setAttribute("categoryid",categories[i+2]);
            continue
        }else{
            lis[i].setAttribute("categoryid",categories[i]);
        }
    
    }
},100)


function $(id){
	return document.getElementById(id);
}