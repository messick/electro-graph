require 'mongoid' 
require 'mongo'
require 'mongoid'
require 'json'
require_relative './models/cell'
require_relative './models/log_result'

Mongoid.load!("./config/mongoid.yml")

cells = ['cell1', 'cell2', 'cell3', 'cell4', 'cell5']

loop do
  log_result = LogResult.new
  log_result.timestamp =  (Time.now.to_i * 1000)

  cells.each do |c|
    cell = Cell.new
    cell.name = c
    cell.voltage = rand(0..100)
    log_result.cells.push(cell)
  end
  p log_result
  log_result.save!
  sleep (1)
end