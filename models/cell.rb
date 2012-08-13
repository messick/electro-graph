require 'mongoid'

class Cell
  include Mongoid::Document
  embedded_in :log_result
  field :name, type: String
  field :voltage, type: Integer
end
