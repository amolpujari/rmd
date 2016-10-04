// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require chosen-jquery
//= require underscore
//= require_tree .
//= require turbolinks


(function(){
    $(document).ajaxStart(function() {
      showSpinner();

    }).ajaxStop(function() {
      hideSpinner();
    });

    $('[data-search]').off('click keydown keyup keypress');

    
    $('input[data-search]').keyup(_.debounce(function(){
        rmdSearch()
    } , 500));

    $('button[data-search]').on('click', function(e){
        rmdSearch(e);
    });


})();


function hideSpinner(){
    $("#spinner").hide().css({'display':'none'});    
}

function showSpinner(){
    $("#spinner").width( $(document).width() ).height( $(document).height() ).show().css({'display':'table'});
    $("#spinner img").css({'margin-top': ( $(window).scrollTop()+200 )+'px', 'postion': 'fixed' });
}