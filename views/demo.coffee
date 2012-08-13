# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

initRequestData = ->
  requestData();

requestData = (timestamp) ->
  
  if typeof timestamp is 'undefined'
    path = "api/total_results/"
  else
    path = "api/total_results/#{timestamp}"
    
    
  $.getJSON path, (results) ->
    console.log('starting')
    
    # add the point
    parseLogResult(item) for item in results
    chart.redraw()
    window.nick = chart.series
    last_timestamp = chart.series[0].points[chart.series[0].points.length-1].x
    #console.log last_timestamp
    # call it again after one second
    setTimeout ->
      requestData(last_timestamp)
    , 5000
  a = 1
parseLogResult = (result) ->
  series = chart.series[0]
  shift = series.data.length > 20 # shift if the series is longer than 20
  
  addGraphPoint(result.timestamp, cell, shift, i) for cell, i in result.cells
  console.log(result.timestamp)
addGraphPoint = (timestamp, cell, shift, i) ->
  chart.series[i].addPoint([Date.parse(new Date(timestamp)), cell.voltage], false, shift)
  
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
        load: initRequestData
        
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
