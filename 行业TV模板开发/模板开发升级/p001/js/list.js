document.onkeydown = grabEvent;
document.onkeydown = grabEvent;

function grabEvent(event)
{   
    //var keycode = event.which;
    var keycode = event.keyCode;
    switch(keycode)
    {
        case  8 :keyBack() ;return 0;break;
        case 270:keyBack() ;return 0;break;
   
        default:
            //return 0 ;
            //break ;
    }
    
}


function keyBack(){



    
    sessionStorage.setItem("item",0);
   
    window.location.href = backUrlEpg;
}