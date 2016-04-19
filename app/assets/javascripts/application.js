// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap.min
//= require_tree .

$(document).ready(function(){
	bindListeners();

	//--------------------------------------------
	// This function autoresizes textareas that
	// have id="post_content" when the user either
	// clicks on the area or adds a line to the
	// bottom of it. Could be made more abstract
	// to handle any textarea
	//--------------------------------------------
	jQuery.each(jQuery('textarea#post_content'), function() {
		if (jQuery(this).data('autoresizeAttached')) return;

		var offset = this.offsetHeight - this.clientHeight;

		var resizeTextArea = function(el) {
			jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
		};
		jQuery(this).on('keyup input', function() {
			resizeTextArea(this);
		}).data('autoresizeAttached', true);
		jQuery(this).on('click', function() {
			resizeTextArea(this);
		}).data('autoresizeAttached', true);
	});
	$(".media").on('ajax:success', function(e, data, status, xhr){
		console.log("this:" + this);
	});
});

//-------------------------------------------
// All listeners bound together
//-------------------------------------------
var bindListeners = function(){
	commentDeleteButtonListener();
	commentCreateButtonListener();
};

var commentDeleteButtonListener = function(){
	$('.container').on('click', '.del-btn', function(e){
		e.preventDefault();
		console.log("in the listener")
		var userConfirm = getConfirmation();
		if (userConfirm === true){
			deleteComment(this)
			console.log("user confirmed deletion.  this = " + this)
		} else {

		};
	});
};

var commentCreateButtonListener = function(){
	$('.container').on('click', '.crt-btn', function(e){
		e.preventDefault();
		console.log("got create button");
		var form = $('form#new_comment');
		createComment(form);
	});
};

//--------------------------------------------
// Functions
//--------------------------------------------
var getConfirmation = function(){
	return confirm("This will permanently delete this comment.  Continue?");
};

var deleteComment = function(path){
	$.ajax({
		method: "DELETE",
		url: path,
		dataType: 'json'
	}).done(function(response){
		console.log("response from server: " + response.comment_number)
		$("#comment-" + response.comment_number).remove();
	}).fail(function(response){
		console.log("AJAX delete call failed: " + response)
	});
};

var createComment = function(form){
	$.ajax({
		method: "POST",
		url: form.attr('action'),
		data: form.serialize(),
	}).done(function(response){
		console.log("server says:" + response);
		$('.com-container').append(response);
		$('.crt-btn').removeClass('btn:focus');
		$('#comment_body').val('');
	})
};
