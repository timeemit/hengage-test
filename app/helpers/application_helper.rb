module ApplicationHelper
  def display_time(time)
    time.strftime('%b %d, %Y @ %H:%M:%S')
  end
  
end
