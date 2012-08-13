class LogResult
  include Mongoid::Document
  embeds_many :cells
  field :timestamp, type: Fixnum
end
