class Category < ActiveRecord::Base
  has_many :category_rate_types
end
