$(document).on('turbolinks:load',function(){
  $("#experience_calc_submit").on('click touch', function (e){
    $("#experience_calc_submit").addClass("hidden");
    $("#loading_spinner").removeClass("hidden");
    e.preventDefault();
    $.ajax({
      url: "/check_experience",
      method: 'post',
      data: jQuery.param({
        current_experience: $('#current_experience').val(),
        desired_level: $('#desired_level').val()
      }),
      contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
      success: function(data){
        if ( data != null ){
          $("#experience_calc_respons").removeClass("hidden")
          $("#experience_calc_submit").removeClass("hidden");
          $("#loading_spinner").addClass("hidden");
          $("#current_level").text(data[0])
          $("#gived_experience").text(data[1])
          $("#current_up").text(data[2])
          $("#next_up").text(data[3])
          $("#up_finish").text(data[4])
          $("#next_level").text(data[5])
          $("#level_finish").text(data[6])
          $("#money_this_up").text(data[7])
          $("#money_to_next_level").text(data[8])
          $("#money_this_level").text(data[9])
          $("#money_total").text(data[10])
          $("#increase_stats").text(data[11])
          $("#experience_to_desired_level").text(data[12])
        } else {
          $("#experience_calc_submit").removeClass("hidden");
          $("#loading_spinner").addClass("hidden");
          $('#current_experience').attr("placeholder", "Вы ввели неправильные данные!");
        }
      }
    })
  })
})
