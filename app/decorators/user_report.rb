class UserReport
  attr_reader :seconds_worked_for, :time_blocks, :projects
  
  def initialize(attrs)
    @user_id, @start_time, @end_time = attrs[:user_id], attrs[:start_time], attrs[:end_time]
    query!
    determine_projects!
    calculate_seconds_for_users!
  end
    
  private
  
  def query!
    @time_blocks = User.find(@user_id).time_blocks.includes(:project).where(['? <= start_time and end_time <= ?', @start_time, @end_time]).all
  end
  
  def determine_projects!
    @projects = @time_blocks.collect{|tb| tb.project}.uniq
  end
  
  def calculate_seconds_for_users!
    @seconds_worked_for = {}
    @projects.each do |project|
      @seconds_worked_for[project.id] = @time_blocks.find_all{|tb| tb.project_id == project.id}.inject(0){|sum, tb| sum + tb.seconds_worked}
    end
  end
end