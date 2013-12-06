# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#dashboard-chart").highcharts
    chart:
      type: "column"

    title:
      text: "Total Payments Received (" + $('#dashboard-chart').data('month') + ")"

    xAxis:
      categories: $('#dashboard-chart').data('categories')

    yAxis:
      min: 0
      title:
        enabled: false
      labels:
        format: "{value:.2f}"

    tooltip:
      headerFormat: "<span style=\"font-size:10px\">{point.key} " + $('#dashboard-chart').data('month') + "</span><table>"
      pointFormat: "<tr><td style=\"padding:0\"><b>RM {point.y}</b></td></tr>"
      footerFormat: "</table>"
      shared: true
      useHTML: true

    plotOptions:
      column:
        pointPadding: 0
        borderWidth: 2
        showInLegend: false

    series: [
      name: 'Payments Received',
      data: $('#dashboard-chart').data('values')
      color: "#356AA0"
    ]
