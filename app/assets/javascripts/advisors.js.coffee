# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
	
$('#createComments').live 'ajax:sucess', (evt, data, status, xhr) =>
	console.log "Success => #{data}"

$('#createComments').live 'ajax:failure', (evt, data, status, xhr) =>
	console.log data
	console.log xhr