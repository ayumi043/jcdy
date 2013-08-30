class Movie
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::MultiParameterAttributes 
  include Redis::Objects
  
  field :name
  field :pic
  # mount_uploader :cover, ImageUploader
  field :actor
  field :area
  field :intro
  field :release
  field :beizhu
  field :pinyin
  field :status
  field :language
  counter :hits, :default => 0
  # field :published_on, :type => Date
  embeds_many :baiduvideos, cascade_callbacks: true
  embeds_many :kuaibovideos
  has_and_belongs_to_many :categories, index: true


  accepts_nested_attributes_for :baiduvideos, :categories, allow_destroy: true, reject_if: :all_blank
  
  # validates :name, :presence => true

  # index({ created_at: -1 })
  index :created_at => -1,:_id => -1, :actor => -1

  protected

end
