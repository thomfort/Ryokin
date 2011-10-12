class Advisor < ActiveRecord::Base
  belongs_to :bank
  belongs_to :advisor_type
  #has_and_belongs_to_many :advisor_qualities
  acts_as_commentable
  acts_as_rateable

  validates_presence_of :lastname
  validates_presence_of :firstname
  
end

