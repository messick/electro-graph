# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

requestData = ->
  $.getJSON 'voltage_state', (results) ->
    series = chart.series[0]
    shift = series.data.length > 20 # shift if the series is longer than 20

    # add the point
    chart.series[0].addPoint(eval(results.Cell1), true, shift)
    chart.series[1].addPoint(eval(results.Cell2), true, shift)
    chart.series[2].addPoint(eval(results.Cell3), true, shift)
    chart.series[3].addPoint(eval(results.Cell4), true, shift)
    chart.series[4].addPoint(eval(results.Cell5), true, shift)

    # call it again after one second
    setTimeout ->
      requestData()
    , 1000

$ ->
  Highcharts.setOptions = 
    global:
  	  useUTC: false    
  
  window.chart = new Highcharts.Chart
    chart:
      renderTo: 'demo_container',
      type: 'spline',
      marginRight: 10,
      events:
        load: requestData
        
    title:
      text: 'Electro Graph'
        
    xAxis:
      type: 'datetime',
      tickPixelInterval: 150

    yAxis:
      title:
        text: 'Value'
      plotLines: [
        value: 0, 
        width: 1,
        color: '#808080'
      ]

    tooltip:
      formatter: ->
        '<b>' + 
        this.series.name + 
        '</b><br/>' + 
        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +
        '<br/>' + Highcharts.numberFormat(this.y, 2)

    exporting:
      enabled: false

    series: [
      {
        name: 'Cell 1'
        data: []
      }
      {
        name: 'Cell 2'
        data: []
      }
      {
        name: 'Cell 3'
        data: []
      }
      {
        name: 'Cell 4'
        data: []
      }
      {
        name: 'Cell 5'
        data: []
      }
    ]
