class Category
  include Mongoid::Document
  field :name, type: String
  field :sortid
  has_and_belongs_to_many :movies, index: true

	accepts_nested_attributes_for :movies, allow_destroy: true

end