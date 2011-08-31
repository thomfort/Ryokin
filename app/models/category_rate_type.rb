class CategoryRateType < ActiveRecord::Base
  has_many :rates
  belongs_to :category
  belongs_to :rate_type
end
