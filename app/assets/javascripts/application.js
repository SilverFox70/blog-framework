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
});

//-------------------------------------------
// All listeners bound together
//-------------------------------------------
var bindListeners = function(){
	commentDeleteButtonListener();
};

var commentDeleteButtonListener = function(){
	$('.container').on('click', '.del-btn', function(e){
		e.preventDefault();
		console.log("in the listener")
		var userConfirm = getConfirmation();
		if (userConfirm === true){
			// deleteComment(this)
			console.log("user confirmed deletion.  this = " + this)
		} else {

		};
	});
};

//--------------------------------------------
// Functions
//--------------------------------------------
var getConfirmation = function(){
	return confirm("This will permanently delete this comment.  Continue?");
};

var deleteComment = function(){
	$.ajax({
		method: "DELETE",
		url: path
	}).done(function(response){
		$('.container').html(response);
	}).fail(function(response){
		console.log("AJAX delete call failed: " + response)
	});
};
