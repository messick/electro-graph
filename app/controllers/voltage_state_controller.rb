class VoltageStateController < ApplicationController
  def index
    cells = ['Cell1', 'Cell2', 'Cell3', 'Cell4', 'Cell5']
    results = {}
    cur_time = Time.now.to_f * 1000

    cells.each do |c|
      tmp = [cur_time, rand(0..100)]
      results[c] = tmp.to_json
    end

    render :json => results
  end
end
