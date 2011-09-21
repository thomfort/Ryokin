class Advisor < ActiveRecord::Base
  belongs_to :bank
  belongs_to :advisor_type
  acts_as_rateable
end
