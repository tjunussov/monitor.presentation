$(function() {
    
    var counter = 0;
    var plength = $('.appearing').length;
    var rep;
    var interval;
    var INTERVAL_TIME = Number(localStorage.getItem('INTERVAL_TIME'))||15000;
    
    NProgress.configure({trickle:false/*, trickleRate: 0.05, trickleSpeed: 1000*/, showSpinner: false, speed: 1000,minimum: 0.01});
    
    function loadNextReport(){
    	if(counter == plength) counter = 0;
    	
    	if(rep) {
    		$(rep).hide();
    		$('#button_'+$(rep).attr('report')).removeClass('selected');
    	}
    	
    	rep = $('.appearing').get(counter++);
    	$(rep).show();
    	$('#button_'+$(rep).attr('report')).addClass('selected');
    	
    	console.log('presenting report ' + $(rep).attr('id'),counter);
    	window[$(rep).attr('id')]();
    }
    
    var progress_increment = 0;
    var pinterval = null;
    
    // Прогресс бар
    function startProgress(time){
    	
    	NProgress.start();
    	//loadNextReport();
    	
    	localStorage.setItem('INTERVAL_TIME',time);
    	
    	if(pinterval)  window.clearInterval(pinterval);
    	
    	pinterval = window.setInterval(function(){
    		if(++progress_increment == 100){
    			progress_increment = 0;
    			NProgress.set(0);
    			loadNextReport();
    		} else {
    			NProgress.set(progress_increment/100);
    		}
    		//console.log('progress',progress_increment);
    	},time/100);
    	
    }
    
    // Выставляем время из меню
    $('.reports-menu .first-menu a').click(function(){
        var current_button = $(this);
        var temp;
        var temp_rep;
        $('.reports-menu .first-menu a').each(function(){
            temp=$(this);
            if(temp.attr('class')=='selected'){
                temp_rep = $('.appearing').get(Number($(this).text())-1);
                $(temp_rep).hide();
                $(temp).removeClass('selected');
            }   
        });
        current_button.addClass('selected');
        counter = Number(current_button.text());
        rep = $('.appearing').get(counter-1);
        $(rep).show();
        window[$(rep).attr('id')]();
    });

    $('.reports-menu .second-menu a').click(function(){
        var z = $(this).text();
        if(z=='||'){
            NProgress.set(0);
            if(pinterval)  window.clearInterval(pinterval);
            progress_increment = 0;
            $(this).html('►');
        }else if(z=='►'){
            $(this).html('||');
            startProgress(INTERVAL_TIME);
        }else{
            setTimeFromMenu();
            $("#play_pause").html('||');
            $(this).addClass('selected');
            INTERVAL_TIME = Number($(this).text())*1000;
            startProgress(INTERVAL_TIME);
        }
    });
    
    function setTimeFromMenu(){
        $('.reports-menu .second-menu a').each(function(){
            $(this).removeClass('selected');
        });
    }
    
    // Начать презентацию
    //showWithInterval(INTERVAL_TIME);
    //startProgress(INTERVAL_TIME);
    startProgress(60000);
    loadNextReport();
    
});


/***********************************/
var _STATUS = false;
function checkIfModified(){ 
  $.ajax({
    url : "/presentation/index.xhtml", // URL for touching file
    dataType : "text",
    ifModified : true,
    success : function(data, textStatus) {
      if (textStatus != "notmodified" && _STATUS) {
        console.log("File changed, need to refresh "+textStatus);
        window.setTimeout(function(){location.reload();},1000);
      }
      _STATUS = true;
    }
  });
}
window.setInterval(checkIfModified, 60000);

/***********************************/

function spanValue(name,value){
	if(value) {
		$('span[name="'+name+'"]').append(' '+value).show();
	}
}

function getOut(){
    $(location).attr('href','https://monitor.kazpost.kz/');
}