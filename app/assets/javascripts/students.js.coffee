ready =->
  if $('#student_dob').length
    $('#student_dob').datepicker
      format: "dd-mm-yyyy"

  $('#student_ic').blur ->
    if $('#student_ic').val().length == 12
      re = /^[0-9]{12}/i

      ic = $('#student_ic').val()
      if ic.match(re)
        date = ic[4] + ic[5] + '/' + ic[2] + ic[3] + '/20' + ic[0] + ic[1]
        $('#student_dob').datepicker 'setDate', date

    return

$(document).ready(ready)
$(document).on('page:load', ready)
