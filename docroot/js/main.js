$(document).ready(function(){
	$(".loadmaskoption-left-box .aui-field-input, label.loadmaskoption-left-box").live("click",function(){	
			$(".loadmaskoption-right-box").toggleClass("hidden");
			$(".loadmaskoption-middle-box").toggleClass("hidden");
	});
});