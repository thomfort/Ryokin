class Rate < ActiveRecord::Base
  belongs_to :bank
  has_one :category_rate_type
  has_one :rate_type, :through => :category_rate_type
  has_one :category, :through => :category_rate_type
  
  validates_presence_of :percent_rate
  
end
