class Kuaibovideo
  include Mongoid::Document
  field :name
  field :link
  embedded_in :movie, :inverse_of => :kuaibovideos
end
