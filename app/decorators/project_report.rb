class ProjectReport
  attr_reader :seconds_worked_for, :time_blocks, :users
  
  def initialize(attrs)
    @project_id, @start_time, @end_time = attrs[:project_id], attrs[:start_time], attrs[:end_time]
    query!
    determine_users!
    calculate_seconds_for_users!
  end
    
  private
  
  def query!
    @time_blocks = Project.find(@project_id).time_blocks.includes(:user).where(['? <= start_time and end_time <= ?', @start_time, @end_time]).all
  end
  
  def determine_users!
    @users = @time_blocks.collect{|tb| tb.user}.uniq
  end
  
  def calculate_seconds_for_users!
    @seconds_worked_for = {}
    @users.each do |user|
      @seconds_worked_for[user.id] = @time_blocks.find_all{|tb| tb.user_id == user.id}.inject(0){|sum, tb| sum + tb.seconds_worked}
    end
  end
end