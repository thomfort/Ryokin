class CategoryRateType < ActiveRecord::Base
  belongs_to :rate
  has_one :category
  has_one :rate_type
end
