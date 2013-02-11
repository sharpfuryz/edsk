$(document).ready(function(){
	$('#search_btn').on('click',function(){
	  var q = $('#search_query').val();
	  $.post('/nodes/search',{query: q}, function(data){
	     $('#main').html(data);
	  });
	});
});