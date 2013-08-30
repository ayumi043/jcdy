class Baiduvideo
  include Mongoid::Document
  field :name, type: String
  field :link, type: String
  embedded_in :movie, :inverse_of => :baiduvideos
end
