ready = ->
  # Build the chart
  if $("#reports-packages-chart").length > 0
    $("#reports-packages-chart").highcharts
      chart:
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: false

      title:
        text: "Package Enrollment in " + $('#reports-packages-chart').data('year')

      tooltip:
        pointFormat: "{series.name}: <b>{point.percentage:.1f}%</b>"

      plotOptions:
        pie:
          allowPointSelect: true
          cursor: "pointer"
          dataLabels:
            enabled: false

          showInLegend: true

      series: [
        type: "pie"
        name: "Enrollment"
        data: $('#reports-packages-chart').data('values')
      ]

$(document).ready(ready)
$(document).on('page:load', ready)
