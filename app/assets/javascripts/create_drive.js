var driveready = function(){
  $('.datepicker').datepicker();
  $('#create_drive').hide()
  $('#create_drive_link').on('click', function(event) {
     event.preventDefault();
     $('#create_drive').show();
     $("#close_modal").on('click', function(event){
        $('#create_drive').hide();
     })
  });

  $('#myTabs a').click(function (e) {
    console.log("clicked");
    // console.log(this);
    // console.log(this.tab);
    e.preventDefault()
    $(this).tab('show')
  })
};

$(document).ready(driveready);
$(document).on("page:load", driveready);