// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

$(document).ready(function(){
	$(".ajax_loader").hide();
	var $container = $('#masonry');
	// initialize
	$container.masonry({
	  itemSelector: '.tile',
	  "gutter": 10
	});

	$('li.title').on('click', function() {
		month = $(this).text();
		$.ajax({
		type: "GET",
		dataType : 'script',
	    url: '/tweets/index',
	    data: {month: month}, 
	    beforeSend: function(){
	       $('.container').hide();
	       $(".ajax_loader").show();
        },
		complete: function(){
		       $('.container').show();
		       $(".ajax_loader").hide();
		  }
		});
	});

	$('select#handle').on('change', function() {
		handle = $('#handle :selected').text();
		$.ajax({
		type: "GET",
		dataType : 'script',
	    url: '/tweets/index',
	    data: {handle: handle}, 
	    beforeSend: function(){
	       $('.container').hide();
	       $(".ajax_loader").show();
        },
		complete: function(){
		       $('.container').show();
		       $(".ajax_loader").hide();
		  }
		});
	});
});
