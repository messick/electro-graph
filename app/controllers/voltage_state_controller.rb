class VoltageStateController < ApplicationController
  def index
    cur_time = Time.now.to_f * 1000
    rand_num = rand(0..100)
    results = [cur_time, rand_num]
    
    render :json => results
  end
end
