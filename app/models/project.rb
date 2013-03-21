class Project < ActiveRecord::Base
  has_many :time_blocks

  attr_accessible :name
  
  validates_presence_of :name
end
