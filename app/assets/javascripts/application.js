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
//= require masonry.pkgd.js
//= require_tree .

$(document).ready(function(){
var $container = $('#masonry');
$(".ajax_loader").hide();
// initialize
	$container.masonry({
	  itemSelector: '.tile',
	  "gutter": 10,
	  "transitionDuration": 0
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
      
		       $(".ajax_loader").hide();
		  }
		});
	});

function element_in_scroll(elem)
{
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();
 
    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();
    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
}

$(document).scroll(function(e){
    if (element_in_scroll(".ajax_loader")) {
    	last_id = $("#last_id").val();
    	handle = $('#handle :selected').text();
            $.ajax({
				type: "GET",
				dataType : 'script',
				data: {last_id: last_id, current_handle: handle},
			    url: '/tweets/index', 
			    beforeSend: function(){
			       $(".ajax_loader").show();
		        },
				complete: function(){
				       $(".ajax_loader").hide();
				  }
			});
        };
});
});
