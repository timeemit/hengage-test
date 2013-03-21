class TimeBlock < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  attr_accessible :end_time, :start_time, :project_id, :user_id
  
  validates_presence_of :user_id
  validates_presence_of :project_id
  validates_presence_of :start_time
  validates_presence_of :end_time
  validate :sequence_of_times
  validate :against_overlapping
  
  def other_time_blocks
    otb = TimeBlock.where(:project_id => project_id).where(:user_id => user_id)
    otb = otb.where('id <> ?', id) if persisted?
    otb
  end
  
  def includes?(time)
    start_time <= time and time <= end_time ? true : false
  end
  
  private
  
  def sequence_of_times
    if start_time.is_a? Time and end_time.is_a? Time and start_time >= end_time
      errors.add(:end_time, 'must be after the start time')
    end
  end
  
  def against_overlapping
    if start_time.is_a? Time and end_time.is_a? Time and project_id.present? and user_id.present?
      # Iterate through other time blocks of the same user and project
      otbs = other_time_blocks
      unless otbs.empty?
        other_time_block = otbs.pop
        while other_time_block and errors.blank?
          if other_time_block.includes?(start_time) or other_time_block.includes?(end_time) or
            includes?(other_time_block.start_time) or includes?(other_time_block.end_time)
            self.errors[:base] << 'this time overlaps with other time blocks'
          end
          other_time_block = otbs.pop
        end
      end
    end
  end
end
