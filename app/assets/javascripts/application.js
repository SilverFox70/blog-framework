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
	console.log("document ready...")
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
