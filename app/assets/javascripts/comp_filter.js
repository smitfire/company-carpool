var compFilterReady = function(){
  $("#comp_filter").keyup(function(){
    var searchVal = $(this).val();
    var myExp = new RegExp(searchVal, 'i');
    
    $("div.company_list div.panel").each(function(){
      var compVal = $(this).text();
      // console.log(compVal);
      if(myExp.test(compVal)){
        $(this).show();
      }else{
        $(this).hide();
      }
    });

  });
};

$(document).ready(compFilterReady);
$(document).on("page:load", compFilterReady);