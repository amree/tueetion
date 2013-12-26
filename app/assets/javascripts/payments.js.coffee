ready =->
  $('#payment_paid_at').datepicker
    todayBtn: "linked"
    format: "dd/mm/yyyy"

$(document).ready(ready)
$(document).on('page:load', ready)
