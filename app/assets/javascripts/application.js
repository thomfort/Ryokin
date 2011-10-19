//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .
	
$(".view_comment").bind('click', function() {
	$(this, '.advisor_comments').next().slideToggle('slow');
});

$('.btnAddComment').click(function(e) {
	var adv_id = $(this).attr('id');
	
	adv_id = adv_id.substring(14);
	
	$('#commentable_id').val(adv_id);

	$('#commentform').modal();
	return false;
});
