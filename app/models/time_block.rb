class TimeBlock < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  attr_accessible :end_time, :start_time
end
