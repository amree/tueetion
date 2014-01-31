ready = ->
  # Build the chart
  if $("#reports-subjects-chart").length > 0
    $("#reports-subjects-chart").highcharts
      chart:
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: false

      title:
        text: "Subject Enrollment in " + $('#reports-subjects-chart').data('year')

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
        data: $('#reports-subjects-chart').data('values')
      ]

$(document).ready(ready)
$(document).on('page:load', ready)
