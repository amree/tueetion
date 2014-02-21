ready =->
  if $('#payment_paid_at').length
    $('#payment_paid_at').datepicker
      todayBtn: "linked"
      todayHighlight: true
      format: "dd/mm/yyyy"

    $('#payment_paid_at').datepicker 'setDate', new Date()


$(document).ready(ready)
$(document).on('page:load', ready)
