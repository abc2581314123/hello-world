/**
2019.04.11专题修改
*/
var isSpecial = false;
var isSpecser = false;
var specialBox = document.getElementsByClassName('specialBox');
var specialNum = 0;
var leaveNum = 0;

var specialPos = [{
    'up': -1,
    'right': 1,
    'down': 3,
    'left': -1
},
{
    'up': -1,
    'right': 2,
    'down': 5,
    'left': 0
},
{
    'up': -1,
    'right': 3,
    'down': 7,
    'left': 1
},
{
    'up': 0,
    'right': 4,
    'down': 8,
    'left': -1
},
{
    'up': 0,
    'right': 5,
    'down': 9,
    'left': 3
},
{
    'up': 1,
    'right': 6,
    'down': 10,
    'left': 4
},
{
    'up': 1,
    'right': 7,
    'down': 11,
    'left': 5
},
{
    'up': 2,
    'right': 8,
    'down': 12,
    'left': 6
},

{
    'up': 3,
    'right': 9,
    'down': 13,
    'left': -1
},
{
    'up': 4,
    'right': 10,
    'down': 14,
    'left': 8
},
{
    'up': 5,
    'right': 11,
    'down': 15,
    'left': 9
},
{
    'up': 6,
    'right': 12,
    'down': 16,
    'left': 10
},
{
    'up': 7,
    'right': 13,
    'down': 17,
    'left': 11
},

{
    'up': 8,
    'right': 14,
    'down': -1,
    'left': -1
},
{
    'up': 9,
    'right': 15,
    'down': -1,
    'left': 13
},
{
    'up': 10,
    'right': 16,
    'down': -1,
    'left': 14
},
{
    'up': 11,
    'right': 17,
    'down': -1,
    'left': 15
},
{
    'up': 12,
    'right': -1,
    'down': -1,
    'left': 16
}]

var menu={}
   ,xxNum = 0
   ,program={}
   ,current={}
   ,programLists=[]
   ,intervalTimer=20
   ,programListOutDesPos={top:-652,bottom:652}
   ,moveUnit=180
   ,menuHint=document.getElementsByClassName('menu-hint')[0]
   ,isAnimate
   ,arrowUp=document.getElementById("arrowUp")
   ,arrowDown=document.getElementById("arrowDown");
var timerMenu = null;
//var currentMenuListEleIndex=0;//菜单光标位置
function keyLeft(){
	if(isAnimate){
		return
	}
	
//	if(menu.state==-1){
//		//光标在节目列表最左侧，呼出所属专题菜单（左提示+专题菜单），光标进入专题菜单
//		if(program.current.colIndex==0){
//			//去掉节目选中效果
//			fnRemoveCurrentStyle()
//			//改变菜单状态标识为显示专题菜单
//			menu.current=0
//			//为当前菜单添加背景色
//			fnAddEleClass(menu.menus[menu.state].ele,'menu-list-container-sel')
//			fnAddEleClass(document.getElementById('search'),'search-sel')
//			fnAddEleClass(menu.menus[menu.state].subEles[menu.menus[menu.state].selIndex],'menu-list-content-sel')
//			fnRemoveEleClass(menu.menus[menu.state].subEles[menu.menus[menu.state].selIndex],'menu-list-content-current')
//		}else{//在节目列表移动光标
//			fnRemoveCurrentStyle()
//			fnIniProgramCurrent(program.current.listIndex,program.current.rowIndex,program.current.colIndex-1)
//			fnAddCurrentStyle()
//		}
//	}
//	
	
    if (isSpecser) {
        return
    }

    //没有菜单
    if (menu.state == -1) {

        if (isSpecial) {
            if (specialPos[specialNum].left == -1) {
                menu.state = 1;
                currentMenuListEleIndex = 1;
                //为当前菜单添加背景色
                //fnAddEleClass(menu.menus[menu.state].ele,'menu-list-container-sel');
                var oldS = specialBox[specialNum];
                fnRemoveEleClass(oldS, 'spFocus');
                var currentMenuList = menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
                fnRemoveEleClass(currentMenuList, 'dn');
                var currentMenuListEles = currentMenuList.getElementsByTagName('li');
                fnAddEleClass(currentMenuListEles[currentMenuListEleIndex], 'menu-list-content-sel');
                //添加跑马灯
                fnAddMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
                return
            }
            var oldS = specialBox[specialNum];
            fnRemoveEleClass(oldS, 'spFocus');
            specialNum = specialPos[specialNum].left;
            var nowS = specialBox[specialNum];
            fnAddEleClass(nowS, 'spFocus');
            return;
        }

        //当前节目在最左侧，呼出所属专题菜单（左提示+1层）
        //文字列表光标左移
        if (listtype == "common") {
            if (getCookie("dblastleftindex") == null || getCookie("dblastleftindex") == "") {
                currentMenuListEleIndex = 0;
            } else {
                currentMenuListEleIndex = getCookie("dblastleftindex");
            }
            fnRemoveEleClass(table.eles[tableSelIndex], 'menu-list-content-sel')
            //隐藏←层
            fnAddEleClass(menuHint, 'dn');
            //显示←层
            fnRemoveEleClass(menuHint, 'dn');
            //改变菜单状态标识为显示专题菜单
            menu.state = 1;
            //为当前菜单添加背景色
            fnAddEleClass(menu.menus[menu.state].ele, 'menu-list-container-sel');
            var currentMenuList = menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
            fnRemoveEleClass(currentMenuList, 'dn');
            var currentMenuListEles = currentMenuList.getElementsByTagName('li');
            fnAddEleClass(currentMenuListEles[currentMenuListEleIndex], 'menu-list-content-sel');
            //添加跑马灯
            fnAddMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
        } else {
            if (program.current.colIndex == 0) {
                currentMenuListEleIndex = menu.menus[1].selIndex;
                //当页面为二级页面时
                if (location.href.indexOf("thisdz=1") > 0) {
                    if (getCookie("dblastleftindex") == null || getCookie("dblastleftindex") == "") {
                        //					currentMenuListEleIndex=0;
                    } else {
                        currentMenuListEleIndex = getCookie("dblastleftindex");

                    }
                }
                //页面为一级页面时
                else {
                    if (getCookie("dboneleftindex") == null || getCookie("dboneleftindex") == "") {
                        //					currentMenuListEleIndex=0;
                    } else {
                        currentMenuListEleIndex = getCookie("dboneleftindex");

                    }
                }

			fnRemoveCurrentStyle();
			//隐藏←层
			fnAddEleClass(menuHint,'dn');
			//显示←层
			fnRemoveEleClass(menuHint,'dn');
			//改变菜单状态标识为显示专题菜单
			menu.state=1;
			//为当前菜单添加背景色
			//fnAddEleClass(menu.menus[menu.state].ele,'menu-list-container-sel');
			
			var currentMenuList=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
			fnRemoveEleClass(currentMenuList,'dn');
			var currentMenuListEles=currentMenuList.getElementsByTagName('li');
			fnAddEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');
			//添加跑马灯
			fnAddMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
		}else{
			fnRemoveCurrentStyle();
			fnIniProgramCurrent(program.current.listIndex,program.current.rowIndex,program.current.colIndex-1);
			fnAddCurrentStyle();
		}
		}
	}else{//有菜单，显示类型菜单
//		if(menu.state==1){
//			//去掉上一个当前菜单背景色
//			fnRemoveEleClass(menu.menus[menu.state].ele,'menu-list-container-sel');
//			fnRemoveEleClass(menu.menus[menu.state].ele.getElementsByTagName('li')[menu.menus[menu.state].selIndex],'menu-list-content-sel');
//			fnAddEleClass(menu.menus[menu.state].ele.getElementsByTagName('li')[menu.menus[menu.state].selIndex],'menu-list-content-current');
//			//隐藏←层
//			fnAddEleClass(menuHint,'dn');
//			//移出类型菜单（改变菜单大容器margin-left）
//			fnTransform(menu.container,'margin-left',-100,0,60,function(){
//				//改变菜单状态标识为显示专题菜单（要在数据加载完成的回调函数里执行）
//				menu.state=0;
//				//为当前菜单添加背景色
//				fnAddEleClass(menu.menus[menu.state].ele,'menu-list-container-sel');
//				var currentMenuList=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
//				fnRemoveEleClass(currentMenuList,'dn');
//				var currentMenuListEles=currentMenuList.getElementsByTagName('li');
//				fnAddEleClass(currentMenuListEles[menu.menus[menu.state].selIndex],'menu-list-content-sel');
//			});
//		}
	}
}
function keyRight(){
	if(isAnimate){
		return
	}
    if (isSpecser) {
        return
    }
	//没有菜单
	if(menu.state==-1){
        if (isSpecial) {
            if (specialPos[specialNum].right == -1) {
                return
            }
            var oldS = specialBox[specialNum];
            fnRemoveEleClass(oldS, 'spFocus');
            specialNum = specialPos[specialNum].right;
            var nowS = specialBox[specialNum];
            fnAddEleClass(nowS, 'spFocus');
            return;
        }
		if(fnCalculateIndex()===program.total-1){
			return
		}
		//屏幕最后一列，换行
		if(program.current.colIndex==4){
			//屏幕最后一行换屏
			if(program.current.rowIndex==1){
				//最后一屏
				if(program.current.listIndex==program.programLists.length-1){
					return
				}
				//移除选中节目
				fnRemoveCurrentStyle();
				//下一屏的第一个节目
				fnIniProgramCurrent(program.current.listIndex+1,0,0);
				//滑入下一节目单
				fnRemoveEleClass(program.programLists[program.current.listIndex].ele,'dn');
				fnMoveProgramList(program.programLists[program.current.listIndex-1].ele,'top',0,programListOutDesPos.top,program.programLists[program.current.listIndex].ele,'top',programListOutDesPos.bottom,0,-moveUnit,function(){
					fnAddCurrentStyle();
					fnLoadData();
				});
				return
			}
			fnRemoveCurrentStyle();
			//转到下一行的第一个
			fnIniProgramCurrent(program.current.listIndex,program.current.rowIndex+1,0);
			fnAddCurrentStyle();
			return
		}
		fnRemoveCurrentStyle();
		//选中右侧节目
		fnIniProgramCurrent(program.current.listIndex,program.current.rowIndex,program.current.colIndex+1);
		fnAddCurrentStyle();
	}else{//有菜单
		
		if(menu.state==0){//显示专题菜单
			//去掉上一个当前菜单背景色
			fnRemoveEleClass(menu.menus[menu.state].ele,'menu-list-container-sel');
			//移出类型菜单（改变菜单大容器margin-left）
			fnTransform(menu.container,'margin-left',0,-100,-60,function(){
				//显示←提示层
				fnRemoveEleClass(menuHint,'dn');
				//将类型菜单数据隐藏
				var currentMenuList=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
				fnAddEleClass(currentMenuList,'dn');
				//改变菜单状态标识为显示专题菜单
				menu.state=1;
				//为当前菜单添加背景色
				fnRemoveEleClass(menu.menus[menu.state].ele.getElementsByTagName('li')[menu.menus[menu.state].selIndex],'menu-list-content-current');
				fnAddEleClass(menu.menus[menu.state].ele.getElementsByTagName('li')[menu.menus[menu.state].selIndex],'menu-list-content-sel');
				//移出跑马灯
				fnRemoveMenuMarquee(menu.menus[menu.state].ele.getElementsByTagName('li')[menu.menus[menu.state].selIndex]);
				fnAddEleClass(menu.menus[menu.state].ele,'menu-list-container-sel');
				fnAddMarquee(menu.menus[menu.state].ele.getElementsByTagName('li')[menu.menus[menu.state].selIndex]);
			});
		}else{//隐藏菜单
			//当前菜单
			var currentMenuList=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
			//当前菜单元素
			var currentMenuListEles=currentMenuList.getElementsByTagName('li');
			//当前选中元素索引
			var currentMenuListEleIndex=menu.menus[menu.state].selIndex;
			fnRemoveEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');
			fnAddEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-selS');
			//移出跑马灯
			fnRemoveMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
			menu.state=-1;
			//文字列表光标右移
			if(listtype=="common"){
				fnAddEleClass(table.eles[tableSelIndex],'menu-list-content-sel')	
			}else{
                if (isSpecial) {
                    var nowS = specialBox[specialNum];
                    fnAddEleClass(nowS, 'spFocus');
                } else {
                    fnAddCurrentStyle(); //海报显示焦点	
                }
            }

        }
    }
}
function keyUp(){

	if(isAnimate){
		return
	}
	if (menu.state==-1) {
        if (isSpecial) {
            if (specialPos[specialNum].up == -1) {
                isSpecser = true;
                var oldS = specialBox[specialNum];
                leaveNum = specialNum;
                fnRemoveEleClass(oldS, 'spFocus');
                document.getElementById('specSear').innerHTML = '<img src="education/img/search_s.png">'
                return
            }
            var oldS = specialBox[specialNum];
            if (oldS.dataset['scroll'] == 'up') {
                var specialOver = document.getElementById('specialOver');
               // fnEleAnimat(specialOver, 'top', -680, 0, 30)
                       specialOver.style.top = '0px';
                       document.getElementById('currentPagezt').innerHTML = '1'
            }
            fnRemoveEleClass(oldS, 'spFocus');
            specialNum = specialPos[specialNum].up;
            var nowS = specialBox[specialNum];
            fnAddEleClass(nowS, 'spFocus');
            return;
        }
		//文字列表光标上移
		if(listtype=="common"){
			if(tableSelIndex==0 ){
				//文字翻页
				var flag = OnKeyPgUpCommon();
				if (!flag) {
					return;
				}
			}
			//tableSelIndex=table.selIndex;
			fnRemoveEleClass(table.eles[tableSelIndex],'menu-list-content-sel')
			tableSelIndex--
			table.selIndexInScreen--
//			table.selIndexInScreen = 0
			fnAddEleClass(table.eles[tableSelIndex],'menu-list-content-sel')
			return
		}
		//海报列表光标下移
		else{
		//滑动到上一菜单
		if(program.current.rowIndex==0){
                //第一屏
                var currentPage = document.getElementById('currentPage').innerHTML
			if(program.current.listIndex==0){
                    if(currentPage == 1) {
                        fnRemoveCurrentStyle();
                        isSpecser = true;
                        document.getElementById('specSear').innerHTML = '<img src="education/img/search_s.png">'
                        return
                    }
				var flag = OnKeyPgUp();
				if (!flag) {
					return;
				}
			}
			//移除选中节目
			fnRemoveCurrentStyle();
			// //移除当前节目单
			// fnUpdateEleStyle(program.programLists[program.current.listIndex].ele,'top','720px')
			// fnAddEleClass(program.programLists[program.current.listIndex].ele,'dn')
			//更新选中节目索引
			fnIniProgramCurrent(program.current.listIndex-1,1,program.current.colIndex);
			var imgSel=arrowUp.getAttribute('data-src');
			var imgUnSel=arrowUp.getAttribute('src');
			arrowUp.setAttribute('src',imgSel);
			//滑入上一节目单
			fnRemoveEleClass(program.programLists[program.current.listIndex].ele,'dn');
			fnMoveProgramList(program.programLists[program.current.listIndex].ele,'top',programListOutDesPos.top,0,program.programLists[program.current.listIndex+1].ele,'top',0,programListOutDesPos.bottom,moveUnit,function(){
				arrowUp.setAttribute('src',imgUnSel);
				arrowUp.setAttribute('data-src',imgSel);
				fnAddCurrentStyle();
				fnLoadData();
			});
			return
		}
		fnRemoveCurrentStyle();
		fnIniProgramCurrent(program.current.listIndex,program.current.rowIndex-1,program.current.colIndex);
		fnAddCurrentStyle();
		}
	}else{//有菜单，菜单光标上移

		//当前菜单
		var currentMenuList=menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
		//当前菜单元素
		var currentMenuListEles=currentMenuList.getElementsByTagName('li');
		//当前选中元素索引
		//var currentMenuListEleIndex=menu.menus[menu.state].selIndex;
		if(currentMenuListEleIndex>0){
			//当选中元素在屏幕内的索引到达边界但没到达列表边界时，滚动
			//上边界
		//var currentMenuListEleIndex12 =	getCookie('currentMenuListEleIndex1');
          //   if(currentMenuListEleIndex12!=null){
			//  menu.menus[1].selIndexInScreen = currentMenuListEleIndex12;
			  //}
			 
			  if(currentMenuListEleIndex12!=100){
             menu.menus[1].selIndexInScreen = currentMenuListEleIndex12;
             
			  }
			
			if(menu.menus[1].selIndexInScreen==0&&menu.menus[1].selIndex>0){
				menu.menus[1].ele.getElementsByClassName('menu-list')[0].style.marginTop=parseInt(menu.menus[1].ele.getElementsByClassName('menu-list')[0].style.marginTop.split("px")[0])+72;
			}

			//移除当前选中元素的选中效果
			fnRemoveEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');
			//移出跑马灯
			fnRemoveMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
			//改变选中列表元素索引
			currentMenuListEleIndex--;
			//改变选中列表元素在屏幕内索引
			menu.menus[1].selIndexInScreen>0&&menu.menus[1].selIndexInScreen--;
	
            currentMenuListEleIndex12 =100;
			//添加新选中元素的选中效果
			fnAddEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');			
			menu.menus[menu.state].selIndex=currentMenuListEleIndex;
            /**
			* 2019.04.11专题修改
			*/
            if (currentMenuListEles[currentMenuListEleIndex].innerHTML == '专题') {
                document.getElementsByClassName('area-main')[0].style.display = 'none';
                document.getElementById('specialOver').style.display = 'block';
                document.getElementById('specSear').style.display = 'block';
                isSpecial = true;
                return;
            } else {
                document.getElementsByClassName('area-main')[0].style.display = 'block';
                document.getElementById('specialOver').style.display = 'none';
                document.getElementById('specSear').style.display = 'block';
                isSpecial = false;
            }
			onKeyMenuUp();
			//添加跑马灯
			fnAddMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
			//当页面为二级页面时
			if(location.href.indexOf("thisdz=1")>0){
				setCookie("dblastleftindex",currentMenuListEleIndex);//清除菜单光标位置的cookie
				currentMenuListEleIndex=menu.menus[1].selIndex;
			}
			else{
				setCookie("dblastleftindex",currentMenuListEleIndex);
				setCookie("dboneleftindex","");
				currentMenuListEleIndex=menu.menus[1].selIndex;
			}
			//更改菜单，节目数据，如果是类型菜单需更新专题菜单和影片，如果是专题菜单更新影片
			clearTimeout(timerMenu);
			timerMenu=setTimeout(function(){
				clearTimeout(timerMenu);
				var parent_id = currentMenuListEles[currentMenuListEleIndex].dataset["parent_id"];
				var category_id = currentMenuListEles[currentMenuListEleIndex].dataset["category_id"];
				if (category_id == undefined || category_id == null || category_id == "") {
					category_id = document.getElementById("category_id").value;
				}
				//check 为false左侧菜单刷新  为true重新构建页面   用来判断是否显示光标
				var check=false;
				if(category_id=="1026003005"||category_id=="1026003006"||category_id=="1026003007"||category_id=="1026003008"||category_id=="1026003009"||(category_id!="1026004"&&category_id.indexOf("1026004")>=0)||(category_id!="1026006"&&category_id.indexOf("1026006")>=0)||(category_id!="1026007"&&category_id.indexOf("1026007")>=0)||(category_id!="1026008"&&category_id.indexOf("1026008")>=0))
				{
				listtype="common";
				reconstructionListCommon(parent_id,category_id,timerMenu,0,check);
				}else{
				listtype="poster";
				reconstructionList(parent_id,category_id,timerMenu,0,check);	
				}
				return;
			},1000);
		}
	}
	fnUpdateArraw();
}
function keyDown(){

	if(isAnimate){
		return
	}
    if (isSpecser) {
        isSpecser = false;
        document.getElementById('specSear').innerHTML = '<img src="education/img/search_c.png">'
        fnAddCurrentStyle();
        var nowS = specialBox[leaveNum];
        fnAddEleClass(nowS, 'spFocus');
        return;
    }
	//没有菜单，选中节目
	if(menu.state==-1){
        if (isSpecial) {
            if (specialPos[specialNum].down == -1) {
                return
            }

            var oldS = specialBox[specialNum];
            if (oldS.dataset['scroll'] == 'down') {
                var specialOver = document.getElementById('specialOver');
                specialOver.style.top = '-680px';
                document.getElementById('currentPagezt').innerHTML = '2'
                // specialOver.style.top = '-680px';
         //       fnEleAnimat(specialOver, 'top', 0, -680, -80)
         //       
            }
            fnRemoveEleClass(oldS, 'spFocus');
            specialNum = specialPos[specialNum].down;
            var nowS = specialBox[specialNum];
            fnAddEleClass(nowS, 'spFocus');
            return;
        }
		//文字列表光标下移
		if(listtype=="common"){
			//文字翻页
			if(tableSelIndex>=table.eles.length-1 ){
			
				var flag = OnKeyPgDnCommon();
				if (!flag) {
					return;
				}
			}
			//tableSelIndex=table.selIndex;
			fnRemoveEleClass(table.eles[tableSelIndex],'menu-list-content-sel')
			tableSelIndex++
			table.selIndexInScreen++
			table.selIndexInScreen = Math.max(table.selIndexInScreen,table.lengthInScreen-1)
			fnAddEleClass(table.eles[tableSelIndex],'menu-list-content-sel')
			return
		}
		//海报列表光标下移
		else{

            if (fnCalculateIndex() + 5 >= program.total - 1) {

                var flag = OnKeyPgDn();
                if (!flag) {
                    return;
                }
            }
            //滑动到下一菜单
            if (program.current.rowIndex == 1) {

                //最后一屏
                if (program.current.listIndex == program.programLists.length - 1) {
                    return
                }
                //移除选中节目
                fnRemoveCurrentStyle();
                // //移除当前节目单
                // fnUpdateEleStyle(program.programLists[program.current.listIndex].ele,'top','-706px')
                // fnAddEleClass(program.programLists[program.current.listIndex].ele,'dn')
                //更新选中节目索引
                fnIniProgramCurrent(program.current.listIndex + 1, 0, program.current.colIndex);
                //滑入下一节目单
                fnRemoveEleClass(program.programLists[program.current.listIndex].ele, 'dn');
                var imgSel = arrowDown.getAttribute('data-src');
                var imgUnSel = arrowDown.getAttribute('src');
                arrowDown.setAttribute('src', imgSel);
                fnMoveProgramList(program.programLists[program.current.listIndex - 1].ele, 'top', 0, programListOutDesPos.top, program.programLists[program.current.listIndex].ele, 'top', programListOutDesPos.bottom, 0, -moveUnit,
                function() {
                    arrowDown.setAttribute('src', imgUnSel);
                    arrowDown.setAttribute('data-src', imgSel);
                    fnAddCurrentStyle();
                    fnLoadData();
                });
                return
            }
            fnRemoveCurrentStyle();
            fnIniProgramCurrent(program.current.listIndex, program.current.rowIndex + 1, program.current.colIndex);
            fnAddCurrentStyle();
        }
    } else { //有菜单，菜单光标下移
        //当前菜单
        var currentMenuList = menu.menus[menu.state].ele.getElementsByClassName('menu-list')[0];
        //当前菜单元素
        var currentMenuListEles = currentMenuList.getElementsByTagName('li');
        //当前选中元素索引
        //var currentMenuListEleIndex=menu.menus[menu.state].selIndex;
        if (currentMenuListEleIndex < currentMenuListEles.length - 1) {



			
			//当选中元素在屏幕内的索引到达边界但没到达列表边界时，滚动
			//下边界，不是列表最后的元素
			//	var currentMenuListEleIndex12 =	getCookie('currentMenuListEleIndex1');
            if(currentMenuListEleIndex12!=100){
			  menu.menus[1].selIndexInScreen = currentMenuListEleIndex12;
			  }
			 
			
			if(menu.menus[1].selIndexInScreen==menu.lengthInScreen-1&&menu.menus[1].selIndex<currentMenuListEles.length-1){
				menu.menus[1].ele.getElementsByClassName('menu-list')[0].style.marginTop=menu.menus[1].ele.getElementsByClassName('menu-list')[0].style.marginTop.split("px")[0]-72;
			}
			
			//移除当前选中元素的选中效果
			fnRemoveEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');
			//移出跑马灯
			fnRemoveMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
			//改变选中列表元素索引
			currentMenuListEleIndex++;
			//改变选中列表元素在屏幕内索引
			menu.menus[1].selIndexInScreen<menu.lengthInScreen-1&&menu.menus[1].selIndexInScreen++;
		//document.getElementById("text1").innerHTML=	menu.menus[1].ele.getElementsByClassName('menu-list')[0].offsetTop;
           currentMenuListEleIndex12 =100;
			//添加新选中元素的选中效果
			fnAddEleClass(currentMenuListEles[currentMenuListEleIndex],'menu-list-content-sel');			
			menu.menus[menu.state].selIndex=currentMenuListEleIndex;
            /**
			* 2019.04.11专题修改
			*/
            if (currentMenuListEles[currentMenuListEleIndex].innerHTML == '专题') {
                document.getElementsByClassName('area-main')[0].style.display = 'none';
                document.getElementById('specialOver').style.display = 'block';
                document.getElementById('specSear').style.display = 'block';
                isSpecial = true;
                return;
            } else {
                document.getElementsByClassName('area-main')[0].style.display = 'block';
                document.getElementById('specialOver').style.display = 'none';
                document.getElementById('specSear').style.display = 'block';
                isSpecial = false;
            }
			onKeyMenu();
			//添加跑马灯
			fnAddMenuMarquee(currentMenuListEles[currentMenuListEleIndex]);
			//当页面为二级页面时
			if(location.href.indexOf("thisdz=1")>0){
				setCookie("dblastleftindex",currentMenuListEleIndex);
				currentMenuListEleIndex=menu.menus[1].selIndex;
			}
			else{
				setCookie("dblastleftindex",currentMenuListEleIndex);
				setCookie("dboneleftindex","");
				currentMenuListEleIndex=menu.menus[1].selIndex;
			}
			//更改菜单，节目数据，如果是类型菜单需更新专题菜单和影片，如果是专题菜单更新影片
			clearTimeout(timerMenu);
			timerMenu=setTimeout(function(){
				clearTimeout(timerMenu);
				var parent_id = currentMenuListEles[currentMenuListEleIndex].dataset["parent_id"];
				var category_id = currentMenuListEles[currentMenuListEleIndex].dataset["category_id"];
				if (category_id == undefined || category_id == null || category_id == "") {
					category_id = document.getElementById("category_id").value;
				}
				//check 为false左侧菜单刷新  为true重新构建页面   用来判断是否显示光标
				var check=false;
				if(category_id=="1026003005"||category_id=="1026003006"||category_id=="1026003007"||category_id=="1026003008"||category_id=="1026003009"||(category_id!="1026004"&&category_id.indexOf("1026004")>=0)||(category_id!="1026006"&&category_id.indexOf("1026006")>=0)||(category_id!="1026007"&&category_id.indexOf("1026007")>=0)||(category_id!="1026008"&&category_id.indexOf("1026008")>=0))
					{
					listtype="common";
					reconstructionListCommon(parent_id,category_id,timerMenu,0,check);
					}else{
					listtype="poster";
					reconstructionList(parent_id,category_id,timerMenu,0,check);	
					}
				return;
			},1000);
		}



	}
	fnUpdateArraw();
}
function fnCalculateIndex(){
	return program.current.listIndex*10+program.current.rowIndex*5+program.current.colIndex;
}

function fnUpdateProgramNav(menuContent){
	var content=menuContent;
	var nav=['cateNav','programNav'];
	if(menuContent.indexOf('<img')>=0){
		//content=''
		return;
	}
	
	document.getElementById(nav[menu.state]).innerHTML=content;
}

function fnLoadData(ele){
    document.getElementById('currentPage').innerHTML=program.current.listIndex+1;
}

function fnRemoveData(ele){
}
			
//获得菜单的dom结构
function fnIniParas(){
    var leftI = (getCookie('dblastleftindex') && !!fnGetUrlPara('currentMenuListEleIndex12')) ? getCookie('dblastleftindex'):0;
    var leftI = fnGetUrlPara('ztPosition')=='ztPosition' ? getCookie('dblastleftindex'):0;
	var mls=document.getElementsByClassName('menu-list-container');
	menu.state=-1;
	menu.lengthInScreen=8;
	menu.container=document.getElementsByClassName('area-menu')[0];
	menu.menus=[];
	for(var i=0;i<mls.length;i++){
		var menuInfo={};
		menuInfo.ele=mls[i];
		//------在加载数据时候用到--------
        //设置选中行索引
        if (currentMenuListEleIndex12 ==1) {
            document.getElementsByClassName('area-main')[0].style.display = 'none';
            document.getElementById('specialOver').style.display = 'block';
            document.getElementById('specSear').style.display = 'block';
            isSpecial = true;
            menuInfo.selIndex = currentMenuListEleIndex12;
            fnAddEleClass(specialBox[getCookie("dblastrightindex") ? getCookie("dblastrightindex") : 0], 'spFocus');
            // return;
  }else{
	  if(currentMenuListEleIndex>7){
   menuInfo.selIndex=currentMenuListEleIndex;
	  }else{
	     menuInfo.selIndex=currentMenuListEleIndex;
	  }
  }
		
		
        //设置当前播放节目索引
        menuInfo.currentIndex = currentMenuListEleIndex = leftI;
		//设置选中元素在屏幕内的索引
	if(currentMenuListEleIndex12!=100){
			menuInfo.selIndexInScreen=currentMenuListEleIndex12;
	}else{
  if(currentMenuListEleIndex>7){
	menuInfo.selIndexInScreen=7;
  }else{
    menuInfo.selIndexInScreen=currentMenuListEleIndex;
  }
	}
		menu.menus.push(menuInfo);
	}

	//文字列表页面初始化
	if(listtype=="common")
		{
		
		table={}
		table.container = document.getElementById('menuList');//容器
		table.eles = document.getElementsByClassName('menu-ele');//元素
		tableSelIndex = 0;
		table.selIndexInScreen = 0;
		table.lengthInScreen = 10;
		}
	//初始海报列表
	else{
		var pls=document.getElementsByClassName('program-list');
		//用于存放节目单dom缓存
		program.programLists=[];
		program.current={};
		program.total=0;
		//遍历节目单
		for(var j=0;j<pls.length;j++){
			var pl=pls[j];
			//节目单中的所有节目
			var ps=pl.getElementsByClassName('program');
			program.total+=ps.length;
			//节目单dom缓存
			var plEle={};
			plEle.ele=pl;
			//用于存放节目单每行节目dom缓存
			plEle.rows=[[],[]];
			var currentRowIndex=0;
			//将节目分别缓存到rows数组中
			for(var pi=0;pi<ps.length;pi++){
				//每节目单两行，每行5个节目
				var ri=pi>=5?1:0;
				plEle.rows[ri].push(ps[pi]);
			}
			program.programLists.push(plEle);
		}
		fnIniProgramCurrent(0,0,0);
	}

	var currentMenuList=menu.menus[1].ele.getElementsByClassName('menu-list')[0];
	var currentMenuListEles=currentMenuList.getElementsByTagName('li');
	
	//var leftI = fnGetUrlPara('currentMenuListEleIndex12')?fnGetUrlPara('currentMenuListEleIndex12'):0;
	

    //var leftI = getCookie('currentMenuListEleIndex12')?getCookie('currentMenuListEleIndex12'):0;
	
fnAddEleClass(currentMenuListEles[leftI], 'menu-list-content-selS');  




}
//设置current对象
function fnIniProgramCurrent(li,ri,ci){
	program.current.listIndex=li;
	program.current.rowIndex=ri;
	program.current.colIndex=ci;
	program.current.ele=fnCacheCurrentEle();
}
//获得当前节目元素
function fnCacheCurrentEle(){
	return program.programLists[program.current.listIndex].rows[program.current.rowIndex][program.current.colIndex];
}
function fnIniLayout(){
	//文字列表光标初始化
	if(listtype=="common"){
	fnAddEleClass(table.eles[tableSelIndex],'menu-list-content-sel')
	}
	else{
        if (!isSpecial) {
            fnAddCurrentStyle();
		for(var i=1;i<program.programLists.length;i++){
			fnUpdateEleStyle(program.programLists[i].ele,'top','720px');
			fnAddEleClass(program.programLists[i].ele,'dn');
		}	
	}
    }
}
window.onload=function(){
    if(fnGetUrlPara('ztPosition') == ''){
        setCookie('dblastrightindex', 0)
    }
    console.log(fnGetUrlPara('ztPosition') == '')
	fnIniParas();
fnIniLayout();
getmarginTop();

//	for(var i=0;i<Number(downidnex);i++){
//		 keyDown2();
//	}
//	初始光标位置

	if(listtype=='poster'){
	initmove();
    }
    //菜单上下箭头
    if (!isSpecial) {
	fnUpdateArraw();
    }
    if(fnGetUrlPara('ztPosition') == ''){
        var specialOver = document.getElementById('specialOver');
        specialOver.style.top = '0px';
        document.getElementById('currentPagezt').innerHTML = '1'
    }
};

function getmarginTop(){
	   if(currentMenuListEleIndex>7){
		    document.getElementById('searchID').style.marginTop = -(currentMenuListEleIndex-8)*72+'px';
 

   }else{
     document.getElementById('searchID').style.marginTop = "72px";
   }
}
function fnUpdateArraw(){
	document.getElementById('downimg').style.display='none'			
	document.getElementById('upimg').style.display='none'

var cm=menu.menus[1]
	var currentMenuList=menu.menus[1].ele.getElementsByClassName('menu-list')[0];
	var currentMenuListEles=currentMenuList.getElementsByTagName('li');
	//menu.lengthInScreen  允许左侧菜单的数量
if(currentMenuListEles.length-menu.lengthInScreen<=0){
return
}
if(cm.selIndex-cm.selIndexInScreen>0){
document.getElementById('upimg').style.display=''
}

if(cm.selIndex-cm.selIndexInScreen<currentMenuListEles.length-menu.lengthInScreen){
	//cm.selIndex-cm.selIndexInScreen<cm.subEles.length-menu.lengthInScreen
document.getElementById('downimg').style.display=''		
}
}

function initmove(){
	 var ref = '';  
	 if (document.referrer.length > 0) {  
	  ref = document.referrer;  
	 }  
	 try {  
	  if (ref.length == 0 && opener.location.href.length > 0) {  
	   ref = opener.location.href;  
	  }  
	 } catch (e) {} 
	if(ref.indexOf("thisdz=1")>=0){//如果是二级页面时
		var dbonemenu = getCookie("dbonerightindex");
		  for(var i=0;i<Number(dbonemenu);i++){
			 keyRight();
			 isAnimat = false;
		  }
	   initmove2();
	}else{
		var dbonemenu = getCookie("dblastrightindex");
        if( Number(dbonemenu) > 7) {
            var specialOver = document.getElementById('specialOver');
            specialOver.style.top = '-680px';
            document.getElementById('currentPagezt').innerHTML = '2'
        }
		  for(var i=0;i<Number(dbonemenu);i++){
			 keyRight();
			 isAnimat = false;
		  }
	   initmove3();
	}
}
function initmove2(){
		  isAnimat = false;
		  var dbonedown = getCookie("dbonedownindex");
		  for(var j=0;j<Number(dbonedown);j++){
			  keyDown();
			  isAnimat = false;
		  }
}
function initmove3(){
	  isAnimat = false;
	  var dbonedown = getCookie("dblastdownindex");
	  for(var j=0;j<Number(dbonedown);j++){
		  keyDown();
		  isAnimat = false;
	  }
}
function fnMoveProgramList(lastEle,lastStyleName,lastOri,lastDes,ele,styleName,ori,des,transformUnit,callbackFunc,callbackFuncParas){
	isAnimate=true;
	var current=ori;
	var lastCurrent=lastOri;
	var timer=setInterval(function(){
		current+=transformUnit;
		lastCurrent+=transformUnit;
		if(moveEnd()){
			clearInterval(timer);
			fnUpdateEleStyle(lastEle,lastStyleName,lastDes+'px');
			fnUpdateEleStyle(ele,styleName,des+'px');
			callbackFunc&&callbackFunc(callbackFuncParas);
			isAnimate=false;
			return
		}
		fnUpdateEleStyle(ele,styleName,current+'px');
		fnUpdateEleStyle(lastEle,lastStyleName,lastCurrent+'px');
	},intervalTimer);
	function moveEnd(){
		return transformUnit>0?current>=des:current<=des;
	}
}

function fnTransform(ele,styleName,ori,des,transformUnit,callbackFunc,callbackFuncParas){
	isAnimate=true;
	var current=ori;
	var timer=setInterval(function(){
		current+=transformUnit;
		if(moveEnd()){
			clearInterval(timer);
			fnUpdateEleStyle(ele,styleName,des+'px');
			callbackFunc&&callbackFunc(callbackFuncParas);
			isAnimate=false;
			return
		}
		fnUpdateEleStyle(ele,styleName,current+'px');
	},intervalTimer);
	function moveEnd(){
		return transformUnit>0?current>=des:current<=des;
	}
}
function fnUpdateEleStyle(ele,styleName,styleValue){
	ele.style[styleName]=styleValue;
}


//moveUnit负数，元素向←移动;正数，元素向→移动
function fnMove(ele,oriPos,desPos,moveUnit,callbackFunc,callbackFuncParas){
	isAnimate=true;
	//var infocontainer=document.getElementById('info')
	var end=new Date().getTime();
	var currentPos=oriPos;
	var maxInterval=intervalTimer*2;
	var timer=setInterval(function(){
		var start=new Date().getTime();
		var inervaltime=start-end;
		//infocontainer.innerHTML+=inervaltime+';'
		if(inervaltime>maxInterval){//间隔时间太长直接移到目标位置
			currentPos+=moveUnit;
			// currentPos=desPos
		}else{
			currentPos+=moveUnit;
		}
		if(moveEnd()){
			clearInterval(timer);
			fnUpdateEleLeft(ele,desPos);
			callbackFunc&&callbackFunc(callbackFuncParas);
			isAnimate=false;
			end=new Date().getTime();
			//infocontainer.innerHTML+='|'
			return
		}
		fnUpdateEleLeft(ele,currentPos);
		end=new Date().getTime();
	},intervalTimer);
	function moveEnd(){
		return moveUnit>0?currentPos>=desPos:currentPos<=desPos;
	}
}
function fnUpdateEleLeft(ele,pos){
	ele.style.top=pos+'px';
	// ele.style.transform='translateX('+pos+')';
	// ele.style.webkitTransform='translateX('+pos+')';
}
//移除当前节目效果
function fnRemoveCurrentStyle(){
	fnRemoveMarquee(program.current.ele);
	fnAddEleClass(program.current.ele.getElementsByClassName('program-sel')[0],'dn');
}
//添加当前节目效果
function fnAddCurrentStyle(){
	fnAddMarquee(program.current.ele);
	fnRemoveEleClass(program.current.ele.getElementsByClassName('program-sel')[0],'dn');
}
//移除元素样式
function fnRemoveEleClass(ele,className){
	var classNames=ele.className;
	if(classNames.indexOf(className)==0){

		ele.className=classNames.replace(className,'');
	}
	if(classNames.indexOf(className)>0){
		ele.className=classNames.replace(' '+className,'');
	}
}
//添加元素样式
function fnAddEleClass(ele,className){
	if(ele.className.indexOf(className)>=0){
		return
	}
	ele.className+=' '+className;
}
//修改元素样式
function fnModifyEleClass(ele,oldClassName,newClassName){
	if(ele.className.indexOf(oldClassName)>=0){
		fnRemoveEleClass(ele,oldClassName);
	}
	fnAddEleClass(ele,newClassName);
}

function fnAddMarquee(p){
	var mind=p.getElementsByClassName('program-sel-mind')[0];
	if(mind){
		var mindText=mind.innerText.trim();
		if(mindText&&mindText.length>7){
			if(mind.innerHTML.indexOf('<marquee>')===-1){//不存在marquee
				mind.innerHTML='';
				var ma=document.createElement('marquee');
				ma.innerText=mindText;
				mind.appendChild(ma);
			}
		}
	}
}
function fnRemoveMarquee(p){
	var mind=p.getElementsByClassName('program-sel-mind')[0];
	if(mind){
		if(mind.innerHTML.indexOf('<marquee>')>=0){//存在marquee
			var mindText=mind.innerText.trim();
			mind.innerHTML=mindText;
		}
	}
}

function fnAddMenuMarquee(p){
	var mind=p;
	if(mind){
		var mindText=p.dataset['name'];
		if(mindText&&mindText.length>4){
			p.dataset['name'] = mind.innerText.trim();
			if(mind.innerHTML.indexOf('<marquee>')===-1){//不存在marquee
				mind.innerHTML='';
				var ma=document.createElement('marquee');
				ma.innerText=mindText;
				mind.appendChild(ma);
			}
		}
	}
}
function fnRemoveMenuMarquee(p){
	var mind=p;
	if(mind){
		if(mind.innerHTML.indexOf('<marquee>')>=0){//存在marquee
			var mindText=mind.innerText.trim();
			mind.innerHTML=p.dataset['name'];
			p.dataset['name'] = mindText;
		}
	}
}


//重构右侧list数据
function reconstructionList(_parent_id,_category_id,timerMenu,_pageid,check){
	
	clearTimeout(timerMenu);
	if (_parent_id != "" && _parent_id != "null" && _parent_id != null) {
		var time = document.getElementById("time").value;
		var riddle = document.getElementById("riddle").value;
		if (_pageid == 0 || _pageid == "" || _pageid == null) {
			_pageid = 1;
		} 
		pageid=_pageid//记录当前页数
		//var newurl=pathConstant+"programIptvPro_searchByCategory.do?time=" + time +"&riddle=" + riddle + "&vo.parentid="+_category_id + "&vo.pageid=" + _pageid +"&vo.pagecount=10&vo.providerid="+providerid;
		
		var newurl=pathConstant+"programIptvPro_searchByCategoryForSeries.do?time=" + time +"&riddle=" + riddle + "&vo.category_id="+_category_id + "&vo.providerid="+providerid+"&vo.pagecount=10&vo.pageid="+ _pageid ;
			XMLHttpRequestObject.open("GET",newurl );
			XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			XMLHttpRequestObject.onreadystatechange = function() {
	
				if (XMLHttpRequestObject.readyState == 4 && (XMLHttpRequestObject.status == 200 )) {
					
					var dataValue = XMLHttpRequestObject.responseText;
                    var dataObj = "";
 					
 					if(dataValue != null && dataValue != "") {
 						dataObj = JSON.parse(dataValue);
					}else{
						dataValue=XMLHttpRequestObject.responseText;
						if(dataValue!=null&&dataValue!=""){
							dataObj = JSON.parse(dataValue);
						}
					}
					var list = dataObj["list"];
					var count = dataObj["count"];
					//当count为0或者不存在时 直接调用节目信息
					//if(count=="0"||count==null)
					//	{
						getnewInfo(_parent_id,_category_id,timerMenu,_pageid,check);
						return;
					//	}
					document.getElementById("listmenu").innerHTML = "";	
					document.getElementById("listmenu").innerHTML="<div class='part-list' id='programList'></div>";
					if (list != null && list != '' && list != 'null') {
						var html = "<div class='program-list'>";
						
						for (var i = 0 ; i < list.length ; i ++) {
							html += "";
							html += "<div class='program' data-url='TV_page_hhb.jsp?categoryid="+ list[i]["primaryid"]+"&thisdz=1&providerid="+providerid+"' data-category_id="+list[i]["primaryid"]+" data-parent_id="+list[i]["parentid"]+">";
							var name = list[i]["name"];
							if (name.length > 7) {
								name = name.substr(0,6) + "...";
							}
							
							html +=	"<img src='"+list[i]["fileurl"]+"' width='160px' height='240px' alt=''/>" +
									"<div class='program-mind'>" + name +"</div>" +
									"<div class='program-sel dn'>" +
									"<img src='"+ list[i]["fileurl"]+"' width='176px' height='265px' alt=''/>" +
									"<div class='program-sel-mind'>" + list[i]["name"] +"</div>" +
									"</div>"+
									"</div>";
						}
						html += "</div>";
						
						document.getElementById("programList").innerHTML = "";
						document.getElementById("programList").innerHTML = html;
						document.getElementById("countID").innerHTML = count;
						document.getElementById("pageNum").innerHTML = Math.ceil(count/10);
						document.getElementById("category_id_for_display").value = _category_id;
						document.getElementById("parent_id_for_display").value = _parent_id;
						document.getElementById("pid").value = _pageid;
						document.getElementById("currentPage").innerHTML = _pageid;
						
						//初始化节目单
						var pls=document.getElementsByClassName('program-list');
						//用于存放节目单dom缓存
						program.programLists=[];
						program.total=0;
						//遍历节目单
						for(var j=0;j<pls.length;j++){
							var pl=pls[j];
							//节目单中的所有节目
							var ps=pl.getElementsByClassName('program');
							program.total+=ps.length;
							//节目单dom缓存
							var plEle={};
							plEle.ele=pl;
							//用于存放节目单每行节目dom缓存
							plEle.rows=[[],[]];
							//将节目分别缓存到rows数组中
							for(var pi=0;pi<ps.length;pi++){
								//每节目单两行，每行5个节目
								var ri=pi>=5?1:0;
								plEle.rows[ri].push(ps[pi]);
							}
							program.programLists.push(plEle);
						}
						program.current.listIndex=1;
						fnIniProgramCurrent(0,0,0);
						if(check)
							{
						fnAddCurrentStyle();
							}
					}
				}
			};
			XMLHttpRequestObject.send(null);
	}
	
	clearTimeout(timerMenu);
	return;
}
//直接获取节目信息
function getnewInfo(_parent_id,_category_id,timerMenu,_pageid,check){
	
	clearTimeout(timerMenu);
	if (_parent_id != "" && _parent_id != "null" && _parent_id != null) {
		var time = document.getElementById("time").value;
		var riddle = document.getElementById("riddle").value;
		if (_pageid == 0 || _pageid == "" || _pageid == null) {
			_pageid = 1;
		} 
		var newurl=pathConstant+"programIptvPro_searchByCategoryForSeries.do?time=" + time +"&riddle=" + riddle + "&vo.category_id="+_category_id + "&vo.pageid=" + _pageid +"&vo.pagecount=10&vo.providerid="+providerid;
		XMLHttpRequestObject.open("GET",newurl );
			XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			XMLHttpRequestObject.onreadystatechange = function() {
				if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
					var dataValue = XMLHttpRequestObject.responseText;
                    var dataObj = "";
 					
 					if(dataValue != null && dataValue != "") {
 						dataObj = JSON.parse(dataValue);
					}else{
						dataValue=XMLHttpRequestObject.responseText;
						if(dataValue!=null&&dataValue!=""){
							dataObj = JSON.parse(dataValue);
						}
					}
					var list = dataObj["list"];
					var count = dataObj["count"];
					document.getElementById("listmenu").innerHTML = "";	
					document.getElementById("listmenu").innerHTML="<div class='part-list' id='programList'></div>";
					if (list != null && list != '' && list != 'null') {
						var html = "<div class='program-list'>";
						
						for (var i = 0 ; i < list.length ; i ++) {
							html += "";
							html += "<div class='program' data-url='tv_zpage_one_hd.jsp?category_id=" + list[i]["category_id"] + "&code=" + list[i]["code"] + "&pageid="+pageid+"&providerid="+providerid+"&lntvlspid="+list[i]["cpid"]+"'>";
							
							var name = list[i]["name"];
							if (name.length > 7) {
								name = name.substr(0,6) + "...";
							}
							
							html +=	"<img src='"+list[i]["fileurl"]+"' width='160px' height='240px' alt=''/>" +
									"<div class='program-mind'>" + name +"</div>";
									if(list[i]["isFree"]==1)
									{
							html +=	"<div class='charge'>会员</div>";
							        }
							html +=	"<div class='program-sel dn'>" +
									"<img src='"+ list[i]["fileurl"]+"' width='176px' height='265px' alt=''/>" +
									"<div class='program-sel-mind'>" + list[i]["name"] +"</div>";
									if(list[i]["isFree"]==1)
									{
							html +=	"<div class='charge-sel'>会员</div>"
									}
							html +=	"</div>"+
									"</div>";
						}
						html += "</div>";
						
						
						document.getElementById("programList").innerHTML = html;
						document.getElementById("countID").innerHTML = count;
						document.getElementById("pageNum").innerHTML = Math.ceil(count/10);
						document.getElementById("category_id_for_display").value = _category_id;
						document.getElementById("parent_id_for_display").value = _parent_id;
						document.getElementById("pid").value = _pageid;
						document.getElementById("currentPage").innerHTML = _pageid;
						
						//初始化节目单
						var pls=document.getElementsByClassName('program-list');
						//用于存放节目单dom缓存
						program.programLists=[];
						program.current={};
						program.total=0;
						//遍历节目单
						for(var j=0;j<pls.length;j++){
							var pl=pls[j];
							//节目单中的所有节目
							var ps=pl.getElementsByClassName('program');
							program.total+=ps.length;
							//节目单dom缓存
							var plEle={};
							plEle.ele=pl;
							//用于存放节目单每行节目dom缓存
							plEle.rows=[[],[]];
							//将节目分别缓存到rows数组中
							for(var pi=0;pi<ps.length;pi++){
								//每节目单两行，每行5个节目
								var ri=pi>=5?1:0;
								plEle.rows[ri].push(ps[pi]);
							}
							program.programLists.push(plEle);
						}
						program.current.listIndex=1;
						fnIniProgramCurrent(0,0,0);
						if(check){
						fnAddCurrentStyle();
						}
					}
				}
			};
			XMLHttpRequestObject.send(null);
	}
	
	clearTimeout(timerMenu);
	return;
}



//重构右侧文字list数据
function reconstructionListCommon(_parent_id,_category_id,timerMenu,_pageid,check){
	clearTimeout(timerMenu);
	if (_parent_id != "" && _parent_id != "null" && _parent_id != null) {
		var time = document.getElementById("time").value;
		var riddle = document.getElementById("riddle").value;
		if (_pageid == 0 || _pageid == "" || _pageid == null) {
			_pageid = 1;
		} 
		pageid=_pageid//记录当前页数
		var newurl=pathConstant+"programIptvPro_searchByCategoryForSeries.do?time=" + time +"&riddle=" + riddle + "&vo.category_id="+_category_id + "&vo.pageid=" + _pageid +"&vo.pagecount=10&vo.providerid="+providerid;
		//var newurl="http://202.97.183.28:9090/cms/programIptvPro_searchByCategoryForSeries.do?time=" + time +"&riddle=" + riddle + "&vo.category_id="+_category_id + "&vo.pageid=" + _pageid +"&vo.pagecount=10&vo.providerid="+providerid;

		XMLHttpRequestObject.open("GET",newurl );
			XMLHttpRequestObject.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			XMLHttpRequestObject.onreadystatechange = function() {
				if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
					var dataValue = XMLHttpRequestObject.responseText;
                    var dataObj = "";
 					
 					if(dataValue != null && dataValue != "") {
 						dataObj = JSON.parse(dataValue);
					}else{
						dataValue=XMLHttpRequestObject.responseText;
						if(dataValue!=null&&dataValue!=""){
							dataObj = JSON.parse(dataValue);
						}
					}
					var list = dataObj["list"];
					var count = dataObj["count"];
					document.getElementById("listmenu").innerHTML = "";	
					document.getElementById("listmenu").innerHTML="<div class='part-list' id='menuList'></div>";
					if (list != null && list != '' && list != 'null') {
						var html = "<ul class='menu-list'>";
						
						for (var i = 0 ; i < list.length ; i ++) {
							html += "";
							html += "<li class='menu-ele' style='text-align: left; height: 55px; line-height:65px;padding-left:20px;'  data-url='jq.jsp?categoryid=" + list[i]["category_id"] + "&code=" + list[i]["code"] + "&pageid="+pageid+"&providerid="+providerid+"'>"+list[i]["name"]+"</li>";
						}

						html += "</ul>";
					
						document.getElementById("menuList").innerHTML = "";
						document.getElementById("menuList").innerHTML = html;
						document.getElementById("countID").innerHTML = count;
						document.getElementById("pageNum").innerHTML = Math.ceil(count/10);
						document.getElementById("category_id_for_display").value = _category_id;
						document.getElementById("parent_id_for_display").value = _parent_id;
						document.getElementById("pid").value = _pageid;
						document.getElementById("currentPage").innerHTML = _pageid;
						//重新初始化文字列表
						table={}
						table.container = document.getElementById('menuList');//容器
						table.eles = document.getElementsByClassName('menu-ele');//元素
						tableSelIndex = 0;
						table.selIndexInScreen = 0;	
						table.lengthInScreen = 10;
//						program.current.listIndex=1;
//						fnIniProgramCurrent(0,0,0);
//						fnAddCurrentStyle();
						if(check){
						fnAddEleClass(table.eles[tableSelIndex],'menu-list-content-sel');
						}
					}
				}
			};
			XMLHttpRequestObject.send(null);
	}
	
	clearTimeout(timerMenu);
	return;
}






function setCookie(name,value)
{
	//document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
	document.cookie = name + "="+ escape (value) + ";expires=";
}
function getCookie(name)
{
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
	return unescape(arr[2]);
		else	return null;
}




//获得地址参数
function fnGetUrlPara(name) {
    var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"))
    if (result == null || result.length < 1) {
        return ""
    }
    return result[1]
}