var compready = function(){
  // $('.datepicker').datepicker();
  $('#create_company').hide()
  $('#create_company_link').on('click', function(event) {
     console.log("loaded");
     event.preventDefault();
     $('#create_company').show();
     $("#close_modal").on('click', function(event){
        $('#create_company').hide();
     })
  });

  // $('#myTabs a').click(function (e) {
  //   console.log("clicked");
  //   // console.log(this);
  //   // console.log(this.tab);
  //   e.preventDefault()
  //   $(this).tab('show')
  // })
};

$(document).ready(compready);
$(document).on("page:load", compready);