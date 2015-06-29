var rideready = function(){
  $('#create_ride').hide()
  $('#create_ride_link').on('click', function(event) {
     event.preventDefault();
     $('#create_ride').show();
     $("#close_ride_modal").on('click', function(event){
        $('#create_ride').hide();
     })
  });
};

$(document).ready(rideready);
$(document).on("page:load", rideready);