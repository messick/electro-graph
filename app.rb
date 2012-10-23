require 'coffee-script'
require 'haml'
require 'json'
require_relative './models/cell'
require_relative './models/log_result'
require 'mongoid'
require 'sinatra'
require "sinatra/reloader" if development?
require 'time'

Mongoid.load!("./config/mongoid.yml")

get '/' do
  redirect '/demo'
end

get '/demo' do
  haml :demo
end

get '/javascripts/demo.js' do
  coffee :demo
end

get '/api/total_results/:start_time?' do
    content_type :json
    
    start_time = params[:start_time] || 1
    results = LogResult.where(:timestamp.gt => start_time).limit(20)
    results.to_json
end