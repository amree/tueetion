ready = ->
  if $('#reports-registrations-chart').length > 0
    $('#reports-registrations-chart').highcharts
      chart:
        type: "column"

      title:
        text: "Registrations"

      xAxis:
        categories: $('#reports-registrations-chart').data('categories')

      yAxis:
        min: 0
        title:
          enabled: false

      tooltip:
        pointFormat: "{point.y}"
        shared: true
        useHTML: true

      plotOptions:
        column:
          pointPadding: 0
          borderWidth: 2
          showInLegend: false

      series: [
        name: 'Students Registered',
        data: $('#reports-registrations-chart').data('values')
        color: "#356AA0"
      ]

$(document).ready(ready)
$(document).on('page:load', ready)
