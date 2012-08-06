# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

requestData = ->
  $.getJSON 'voltage_state', (point) ->
    series = chart.series[0]
    shift = series.data.length > 20 # shift if the series is longer than 20

    # add the point
    chart.series[0].addPoint(eval(point), true, shift)

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
      name: 'Random data',
      data: []
    ]
