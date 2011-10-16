//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

$(".view_comment").bind('click', function() {
	$(this, '.advisor_comments').next().slideToggle('slow');
});