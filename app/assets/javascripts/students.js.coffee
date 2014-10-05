ready =->
  if $('#student_dob').length
    $('#student_dob').datepicker
      format: "dd-mm-yyyy"

$(document).ready(ready)
$(document).on('page:load', ready)
