function tabOnClick(value) {
  $('.templatemo-content').hide();
  $('.submenue-tabs').removeClass("submenue-tabs-active");
  $("."+value).addClass("submenue-tabs-active");
  $("#"+value).show();
  if(value == "templatemo-content-summary"){
    $("#show_summary_or_addon").hide();
  }
  else if(value == "templatemo-content-add-services"){
    $("#show_summary_or_addon").show();
  }
}

$(document).ready(function() {
  updateConfig();
  function updateConfig() {
    var options = {};
    $('#search_flight_date_of_journey').daterangepicker(options, function(start, end, label) { console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); });
  }
});

// Validate foem search date
function validate_date(){
    var date_onw = $("#search_flight_date_of_journey_onward").val();
    var date_rtn = $("#search_flight_date_of_journey_return").val();
    if( date_onw != "" && date_rtn != "" ){
        if(Date.parse(date_onw) > Date.parse(date_rtn)){
            alert("Onward date must less than or equal to return date");
            return true;
        }
    }
    return false;
}

function set_serach_places(id){
  if( $("#"+id).val().length > 2 ){
    $("#"+id).attr("list", "searchList");
  }
  else{
    $("#"+id).removeAttr("list", "searchList");
  }
}


$(document).on('click', 'input[type=submit]', function(error) {
    is_valid_date = validate_date();
    if(is_valid_date){
        erroe.preventDefault();
    }
});