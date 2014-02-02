ready = ->
  if $('#reports-yearly-payments-chart').length > 0
    $('#reports-yearly-payments-chart').highcharts
      chart:
        type: "column"

      title:
        text: "Payments received in " + $('#reports-yearly-payments-chart').data('year')

      xAxis:
        categories: $('#reports-yearly-payments-chart').data('categories')

      yAxis:
        min: 0
        title:
          enabled: false

      tooltip:
        pointFormat: "RM {point.y}"
        shared: true
        useHTML: true

      plotOptions:
        column:
          pointPadding: 0
          borderWidth: 2
          showInLegend: false

      series: [
        name: 'Students Registered',
        data: $('#reports-yearly-payments-chart').data('values')
        color: "#356AA0"
      ]

$(document).ready(ready)
$(document).on('page:load', ready)
