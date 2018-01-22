// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets
//= require daterangepicker

//function for closing boxes
function close_box(value) {
  $('.'+value).remove();
}

//function for search form
function radio_button_switch(active,deactive){
  $("."+active).addClass("btn-activated");
  $("."+deactive).removeClass("btn-activated");
  if( active == "btn-ow" ){
    $("#search_flight_date_of_journey_return").prop("disabled",true);
  }
  else{
    $("#search_flight_date_of_journey_return").prop("disabled",false);
  }
}

function fare_desc(value){
  $(".fare_desc").hide();
  $("."+value).show();
}

function show_more_details(show_items){
  $("."+show_items).toggle();
}